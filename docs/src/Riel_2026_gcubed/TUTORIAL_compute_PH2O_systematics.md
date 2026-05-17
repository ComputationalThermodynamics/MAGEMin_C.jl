# Tutorial: `compute_P-H2O_systematics.jl`

## What This Script Does — The Big Picture

This script answers the question:

> *For a metapelite rock at a given pressure and water content, how much does Lithium (Li) get concentrated in the melt when partial melting occurs?*

It sweeps a 2D grid of **pressure (P)** × **H₂O content** conditions, runs thermodynamic equilibrium calculations at each point, simulates repeated episodes of melt extraction (fractional melting), tracks Li through each episode using mineral–melt partition coefficients (KDs), and finally maps the results as heatmaps.

The script combines:
- **MAGEMin_C** — a Gibbs free energy minimizer that gives mineral assemblages and melt fractions
- **Li trace-element partitioning** — how Li distributes between minerals and melt
- **Julia multithreading** — parallel computation over the P–H₂O grid

---

## File Structure

```
compute_P-H2O_systematics.jl   ← main entry point (this file)
TE_functions.jl                ← utility functions: KDs, water saturation, threading dispatcher
TE_fractional.jl               ← core physics: the fractional melting loop
plot_figures.jl                ← heatmap plotting helpers
```

---

## Key Concepts Before Diving In

### The P–H₂O Grid

The computation sweeps a 2D grid of `np × np` = 150 × 150 = **22,500 independent thermodynamic calculations**. The two axes are:

- **Rows (i)** — pressure `P[i]`, ranging from 2 to 16 kbar (crustal depth)
- **Columns (j)** — H₂O content `H[j]`, ranging from ~1 to 12 mol%

Each cell `[i, j]` is one complete fractional melting simulation at a fixed (P, H₂O) condition.

```
          H₂O content (mol%)
          1%    3%    5%    7%    9%   11%
          │     │     │     │     │     │
16 kbar ──┼─────┼─────┼─────┼─────┼─────┼──
          │     │     │  ●  │     │     │      ● = cell [i=1, j=3]
14 kbar ──┼─────┼─────┼─────┼─────┼─────┼──        one MAGEMin run
          │     │     │     │     │     │
12 kbar ──┼─────┼─────┼─────┼─────┼─────┼──
          │     │     │     │     │     │
 8 kbar ──┼─────┼─────┼─────┼─────┼─────┼──
          │     │     │     │  ★  │     │      ★ = cell [i=4, j=4]
 4 kbar ──┼─────┼─────┼─────┼─────┼─────┼──        another MAGEMin run
          │     │     │     │     │     │
 2 kbar ──┼─────┼─────┼─────┼─────┼─────┼──
```

**Crucially, most cells are never computed.** Only a narrow strip of cells lying within ±0.03 mol% of the **water saturation curve** (the curve that separates water-undersaturated from water-saturated conditions) is active. This reduces the effective computation to a thin diagonal band across the grid — which is also exactly where the geologically interesting melting behavior occurs.

```
          H₂O content (mol%)
          1%    3%    5%    7%    9%

16 kbar   ·     ·     ·     ·  ╱╱╱
14 kbar   ·     ·     ·  ╱╱╱   ·        ╱╱╱ = computed cells
12 kbar   ·     ·  ╱╱╱   ·     ·              (near H₂O saturation)
 8 kbar   ·  ╱╱╱   ·     ·     ·         ·   = skipped (set to NaN)
 4 kbar ╱╱╱   ·     ·     ·     ·
 2 kbar   ·     ·     ·     ·     ·
```

The saturation curve shifts to higher H₂O content at lower pressures: rocks at shallow depths need more water to become saturated than rocks under high pressure.

### Fractional Melting vs. Batch Melting

In **batch melting**, all melt stays in contact with the rock until it is extracted at once. In **fractional melting**, small melt batches are extracted repeatedly as temperature rises. This script uses fractional melting: each "extraction event" removes a pulse of melt from the system, leaving an evolved residual bulk composition for the next event.

### What Is a KD?

A partition coefficient KD = C_mineral / C_melt. A KD > 1 means the mineral concentrates Li relative to the melt (e.g., biotite with KD ≈ 1.67 in Koopmans' model). A KD < 1 means Li prefers the melt.

---

## Step 1 — Entry Point and Parameter Setup

**File:** `compute_P-H2O_systematics.jl`, lines 155–190

```julia
all_model   = ["MM"]
FC          = false
np          = 150
Pin         = [2.0, 16.0]
Li_content  = 100.0     # ppm
e1_liq      = [14.0]    # vol% melt at each extraction event
e1_remain   = [7.0]     # vol% melt left behind after extraction
```

Key parameters explained:

| Parameter | Meaning |
|-----------|---------|
| `np` | Grid resolution — `np×np` total calculations |
| `Pin` | Pressure range in kbar (e.g., 2–16 kbar) |
| `Li_content` | Starting Li concentration in the bulk rock (ppm) |
| `e1_liq` | Volume % of melt at which extraction is triggered |
| `e1_remain` | Volume % of melt retained in the rock after each extraction |
| `model` | Which KD dataset to use (see below) |
| `b` | Bulk composition: `"FS"` = Forshaw & Pattison 2023 pelite, `"K"` = Knoll et al. 2023 |

The outer loop iterates over model variants and calls `main()` for each.

---

## Step 2 — `main()` Function

**File:** `compute_P-H2O_systematics.jl`, lines 24–153

This orchestrates the entire workflow in six stages:

### Stage A: Bulk Rock Setup

```julia
bulk = norm2one([0.67153, 0.12111, 0.00729, ...])
```

`norm2one()` normalizes the oxide vector to sum to 1.0. The oxides are:
`[SiO₂, Al₂O₃, CaO, MgO, FeO, K₂O, Na₂O, TiO₂, O, MnO, H₂O]`

H₂O is initially set to 0 — it will be varied across the H axis of the grid.

### Stage B: Water Saturation Curve

```julia
pChip_wat = water_saturation_curve(P, bulk, Xoxides, dtb, 0.0)
```

This computes, for each pressure on the P-axis, the exact H₂O mol fraction at which the rock becomes water-saturated just below the solidus. The result is stored as a **PCHIP interpolant** (a smooth spline). This curve is the most expensive part to compute and is cached to a `.jld2` file so it is only computed once.

The curve is used to filter the grid: only cells near the saturation curve (within ±0.03 mol fraction) are computed — the rest are set to `nothing`.

### Stage C: KD Database

```julia
KDs_database = get_Kds(; model = model)
```

Loads the mineral–melt partition coefficients for Li into MAGEMin's internal format. (See Step 4 for a detailed explanation.)

### Stage D: MAGEMin Initialization

```julia
data = Initialize_MAGEMin(dtb, verbose=-1; solver=0)
```

Creates one MAGEMin instance **per thread**. This is the thread-safe structure that holds the Gibbs minimizer state for each CPU core.

### Stage E: Threaded Calculation

```julia
Out_all, Out_all_FC = perform_threaded_calc(pChip_wat, Out_all, ...)
```

This is where all the work happens. See Step 5.

### Stage F: Post-processing and Plotting

```julia
point_infos, Cliq_max, Extract_epi, ... = retrieve_outputs(Out_all, np)
plot_output("Li", ...)
```

Extracts scalar fields from the results (maximum Li concentration, extraction event index, temperature, mineral vol% changes) and saves heatmaps.

---

## Step 3 — The Water Saturation Curve

**File:** `TE_functions.jl`, `water_saturation_curve()` and `get_wat_sat_function()`, lines 193–317

### Why This Exists

The water content at which a rock is exactly saturated in H₂O changes with pressure. At higher pressures, minerals can store more H₂O, so the saturation threshold shifts. This function maps out that boundary.

### How It Works (Bisection on the Solidus)

For each pressure point:

1. **Find the solidus temperature** — using a bisection algorithm that brackets the temperature at which "liq" first appears in the stable phase assemblage. The loop halves the temperature interval `[a, b]` until convergence within `tolerance = 1e-4 °C`.

2. **Remove excess free water** — at the solidus, compute the equilibrium assemblage. If a free water phase (`H2O` or `fl`) is stable, subtract its contribution from the bulk.

3. **Record the saturation H₂O value** — the water content remaining in the anhydrous-normalized bulk is the saturation value at that pressure.

```
For each pressure P_i:
    Bisect T until liq appears  →  T_solidus
    Run MAGEMin at T_solidus
    Strip out free-water phase
    Record H2O_sat(P_i)

Fit smooth PCHIP spline over all P_i  →  pChip_wat(P)
```

The interpolant `pChip_wat` can then be called as a function: `pChip_wat(8.5)` returns the saturation H₂O at 8.5 kbar.

---

## Step 4 — Partition Coefficient Models

**File:** `TE_functions.jl`, `get_Kds()` and `get_Kds_data()`, lines 74–187

Several published KD datasets are implemented as named models:

| Model key | Source | Notes |
|-----------|--------|-------|
| `"MM"` | Morris & Beard (2024) | **Default.** Biotite KD is temperature- and composition-dependent (expression string) |
| `"KM"` | Koopmans et al. (2022) | Fixed KDs, includes garnet near zero |
| `"BA"` | Ballouard et al. (2023) | Different mineral set |
| `"HO"` | Horányi et al. (2025) | Includes staurolite |
| `"MM_F"` | Morris & Beard (fake bi) | Biotite KD = 32.8 — extreme sensitivity test |

The **biotite KD in model "MM"** is notably encoded as an **expression string**:

```julia
bi_exp = "c9 = -7.01; c10 = -4.29; c11 = 4.18; c12 = 0.407;
          XMFe3p = [:bi].siteFractions[4];
          NaK_Almelt = ([:liq].Comp_apfu[6] + [:liq].Comp_apfu[7]) / [:liq].Comp_apfu[2];
          ln_D_Li = c9 + c10*XMFe3p + c11*(NaK_Almelt) + c12*1e4/(T_C+273.15);
          exp(ln_D_Li)"
```

This means MAGEMin evaluates a thermodynamic expression at runtime, using the current biotite Fe³⁺ site fraction and the melt Na+K/Al ratio and temperature. This captures the strong compositional and temperature dependence of Li in biotite.

The function `get_Kds()` creates the KD database in MAGEMin's internal format; `get_Kds_data()` just returns the raw strings (used for sensitivity analysis).

---

## Step 5 — Threading Architecture

**File:** `TE_functions.jl`, `perform_threaded_calc()`, lines 366–422

This is the heart of the parallel computation. Understanding it requires understanding Julia's threading model.

### The Problem: 22,500 Independent Calculations

The P × H grid has `np × np` cells. Each cell is completely independent of the others — there is no data dependency between them. This is a perfect candidate for parallelism.

### The Solution: Static Thread Scheduling

```julia
@threads :static for k = 1:nt
    i, j = get_coordinates(k, np)
    ...
end
```

Julia's `@threads :static` divides the loop iterations evenly among available threads at compile time. If Julia is started with `JULIA_NUM_THREADS=8`, each thread gets approximately `22500 / 8 ≈ 2812` iterations.

### Thread-Local MAGEMin State

MAGEMin is not thread-safe when sharing state. The solution is that `Initialize_MAGEMin()` creates one copy of the database per thread:

```julia
data = Initialize_MAGEMin(dtb, verbose=-1; solver=0)
# data.gv      → Vector, one entry per thread
# data.z_b     → Vector, one entry per thread
# data.DB      → Vector, one entry per thread
# data.splx_data → Vector, one entry per thread
```

Each thread retrieves its own copy via:

```julia
function get_data_thread(MAGEMin_db)
    id = Threads.threadid()
    gv          = MAGEMin_db.gv[id]
    z_b         = MAGEMin_db.z_b[id]
    DB          = MAGEMin_db.DB[id]
    splx_data   = MAGEMin_db.splx_data[id]
    return (gv, z_b, DB, splx_data)
end
```

`Threads.threadid()` returns an integer (1, 2, 3, ...) identifying the current thread, which is used as an index into the per-thread arrays. This means threads never share MAGEMin state, eliminating race conditions.

### The Grid Index Mapping

The 1D loop index `k` maps to 2D grid indices `(i, j)` via:

```julia
function get_coordinates(k::Int, np::Int)
    i = div(k - 1, np) + 1   # pressure index (row)
    j = mod(k - 1, np) + 1   # H₂O index (column)
    return i, j
end
```

This is a simple row-major mapping: `k = (i-1)*np + j`.

### The Saturation Filter

Not every cell in the P–H₂O grid is physically meaningful. The code only runs the expensive melting simulation for cells near the water saturation curve:

```julia
H_sat_ = pChip_wat(P_)

if H_ < H_sat_ + 0.03 && H_ > H_sat_ - 0.03 && H_ > 0.0
    Out_all[i,j] = threaded_frac_melting(...)
else
    Out_all[i,j] = Li_infos(nothing, nothing)
end
```

This ±0.03 mol fraction window around the saturation curve is where the interesting melting behavior occurs (near-solidus, water-saturated conditions). Cells far from this strip are skipped — this dramatically reduces the total computation time.

### Thread Safety of Writes

`Out_all` is a pre-allocated `np × np` matrix of `Li_infos` structs. Each thread writes to a unique cell `[i,j]`, so there are no write conflicts. Julia arrays support concurrent writes to distinct indices without locks.

### Visualizing the Threading

```
Thread 1: k=1,2,3,...        →  cells [1,1], [1,2], [1,3], ...
Thread 2: k=2813,2814,...    →  cells [19,63], [19,64], ...
Thread 3: k=5625,5626,...    →  cells [38,25], [38,26], ...
...
Thread 8: k=19689,...        →  cells [132,39], ...

All threads write to distinct cells of Out_all[np,np]
No locking needed
```

---

## Step 6 — The Fractional Melting Engine

**File:** `TE_fractional.jl`, `threaded_frac_melting()`, lines 1–150

This is called once per active grid cell, within each thread. It runs the fractional melting loop for one (P, H₂O) condition.

### Overview

```
Input:  P (kbar), H (mol fraction H₂O), T range, bulk composition, KDs
Output: Li_infos struct containing MAGEMin outputs at each extraction step
```

### Step-by-Step

#### 6.1 — Set Bulk Composition

```julia
bulk[id_h] = H          # set H₂O to this cell's water content
gv = define_bulk_rock(gv, bulk, Xoxides, sys_in, dtb)
```

The H₂O slot in the bulk vector is overwritten with the current grid value `H`, then the bulk is registered with MAGEMin.

#### 6.2 — Set Initial Trace Element

```julia
C0 = adjust_chemical_system(KDs_database, bulk_TE, elem_TE)
```

`C0` is initialized to `Li_content` (e.g., 100 ppm). This value will be updated after each extraction event to track the evolving residual concentration.

#### 6.3 — Find the Solidus

```julia
Tsol = retrieve_solidus(P, gv, z_b, DB, splx_data)
```

A bisection method (the same algorithm as in the water saturation curve) finds the temperature at which melt first appears. This is the starting temperature for the extraction loop.

#### 6.4 — Extraction Event Loop

The loop runs up to `n_ee` times (default 10). Each iteration is one extraction episode.

**Inside each extraction event:**

**a) Find the extraction temperature** — bisect temperature until the melt volume fraction equals `e1_liq / 100`:

```julia
result = out.frac_M_vol - e1_liq/100.0
```

The bisection narrows `[a, b]` until the melt volume matches the target (e.g., 14%). Several relaxed tolerances are tried before giving up.

**b) Compute trace element concentrations** — once the extraction temperature is found:

```julia
out_TE = TE_prediction(out, C0, KDs_database, dtb; ZrSat_model="CB", norm_TE=norm_TE)
```

This computes `Cliq` (Li concentration in the melt) using the partition coefficients and the current mineral assemblage from MAGEMin.

**c) Extract the melt** — remove the melt from the system, keeping only `e1_remain` vol% behind:

```julia
ratio  = (out.frac_M_vol - e1_remain/100.0) / out.frac_M_vol
bulk   = out.bulk .- out.SS_vec[id_liq].Comp .* (out.frac_M * ratio)
C0     = C0 .- out_TE.Cliq[1] .* (out_TE.liq_wt_norm * ratio)
```

The bulk composition is updated by subtracting the extracted melt composition. The trace element budget `C0` is similarly reduced. The next event starts from this residual.

**d) Save results** — both the pre-extraction and post-extraction states are stored:

```julia
ext_out[ee*2]    = out      # at extraction temperature
ext_out[ee*2+1]  = out      # after melt removal (start of next step)
```

This odd/even indexing stores the full path through P–T space for each extraction episode.

#### 6.5 — Early Exit Conditions

The loop breaks if:
- Convergence fails (system cannot reach the target melt fraction)
- The melt has zero H₂O (anhydrous melt — Li systematics change fundamentally)
- The bisection hits iteration limit and residual is too large

#### 6.6 — Return

```julia
return Li_infos(ext_out, ext_out_te)
```

`Li_infos` is a simple struct holding two vectors — the MAGEMin outputs and the trace element outputs — one entry per sub-step of the extraction history.

---

## Step 7 — Post-Processing: `retrieve_outputs()`

**File:** `plot_figures.jl`, lines 555–673

After the threaded loop finishes, this function extracts scalar summary fields from the full `Out_all[np, np]` array.

For each grid cell `[i, j]`:

1. **Find the maximum Li concentration** — loop over all even-indexed steps (extraction events), find the one with the highest `Cliq`:
   ```julia
   Cliq = [Out_all[i,j].ext_out_te[k].Cliq[1] for k = 2:2:nval_points]
   max_Cliq, index_Cliq = findmax(Cliq)
   ```

2. **Record the extraction event index** — which episode produced the peak Li enrichment.

3. **Record the temperature** at peak enrichment.

4. **Compute mineral vol% changes** — for biotite, cordierite, muscovite, and staurolite, the change in volume fraction between the pre-extraction and post-extraction states:
   ```julia
   Δbi[i,j] = bi_end - bi_start
   ```
   This tells whether a mineral grew or was consumed during the melt extraction step.

5. **Handle missing data** — cells that were skipped (outside the saturation window) are set to `NaN`.

Output matrices `Cliq_max`, `Extract_epi`, `Extract_T`, `Δbi`, `Δcd`, `Δmu`, `Δst`, `eta_M` are all `np × np` and ready for plotting.

---

## Step 8 — Plotting: `plot_output()`

**File:** `plot_figures.jl`, `plot_output()`, lines 763–916

Each output matrix is plotted as a 2D heatmap with:
- **X-axis**: H₂O content in mol%
- **Y-axis**: Pressure in kbar
- **Color**: the field value (Li enrichment, temperature, mineral change, etc.)

Three reference curves are overlaid:
- Thick black line: the water saturation curve `pChip_wat(P)`
- Thin black lines: ±0.03 mol% offset (the bandwidth of the computation strip)

```julia
h = pChip_wat.(P)           # saturation curve
plot!(h.*100, P, linewidth=4, linecolor=:black)
```

The `Li` field is normalized to the initial content (`mat ./= Li_content`), so values > 1 indicate enrichment relative to the starting bulk.

---

## Step 9 — Custom Biotite Margules Parameters

**File:** `TE_functions.jl`, `custom_bi_Ws()`, lines 13–43

When `fake_F_bi = true`, the biotite mixing parameters (Margules W terms) in MAGEMin are replaced with modified values. Several interaction energies are scaled by a small factor `x = 0.1`, which changes the stability and composition of biotite in the phase diagram. This is a sensitivity test to explore how overstabilized biotite due to high fluorine content affects Li partitioning.

The `W_data` struct is passed to `point_wise_minimization()` via the `W = Ws` keyword argument.

---

## Data Flow Summary

```
main()
│
├── norm2one(bulk)              → normalized dry bulk
├── water_saturation_curve()    → pChip_wat (PCHIP interpolant, P→H₂O_sat)
│     └── bisection on T        → find solidus at each P
│     └── strip free water      → compute saturation H₂O
│
├── get_Kds(model)              → KDs_database (MAGEMin format)
├── Initialize_MAGEMin()        → data (one struct per thread)
│
├── perform_threaded_calc()     → Out_all[np, np]
│     └── @threads :static for k = 1:np²
│           ├── get_coordinates(k, np)        → (i, j)
│           ├── get_data_thread(data)          → thread-local MAGEMin state
│           ├── filter: |H - H_sat| < 0.03
│           └── threaded_frac_melting()       → Li_infos
│                 ├── set bulk H₂O
│                 ├── retrieve_solidus()       → T_solidus (bisection)
│                 └── for ee = 1:n_ee
│                       ├── bisect T → melt volume = e1_liq %
│                       ├── TE_prediction()   → Cliq, Csol
│                       └── remove melt → update bulk, C0
│
├── retrieve_outputs(Out_all)   → Cliq_max, Extract_epi, Δbi, Δcd, Δmu, ...
│
└── plot_output(field, ...)     → PNG heatmaps
```

---

## Running the Script

```bash
# Start Julia with multiple threads
julia --threads 8 compute_P-H2O_systematics.jl
```

First run at a given bulk composition will compute and cache the water saturation curve (slow, ~minutes). Subsequent runs reuse the `.jld2` cache and go straight to the threaded calculations.

To change the number of extraction events, melt fraction thresholds, or pressure range, edit the parameters at the bottom of `compute_P-H2O_systematics.jl` (lines 155–190) before running.

Output figures are saved under `./output_Li_v0.1/<model>/<simu>/`.
