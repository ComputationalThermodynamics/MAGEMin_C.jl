
# Tutorial: `compute_systematics_FS.jl` {#Tutorial:-compute_systematics_FS.jl}

## What This Script Does — The Big Picture {#What-This-Script-Does-—-The-Big-Picture}
> 
> _Given the full geochemical diversity of natural pelite rocks, which bulk compositions produce the strongest Li enrichment in the melt, and why?_
> 


While `compute_P-H2O_systematics.jl` sweeps a synthetic 2D grid of (pressure, H₂O) conditions for a **single average pelite**, this script takes the opposite approach: it fixes pressure and uses **hundreds of real pelite bulk compositions** from the Forshaw &amp; Pattison (2023) natural database. Each rock sample is an independent fractional melting simulation. The result is a cloud of data points in geochemical composition space, colored by Li enrichment — showing which rock chemistries are most prone to producing Li-rich granites.

The script is the computational backbone of:
> 
> Riel et al., 2026, _Thermodynamic modelling of lithium enrichment during partial melting_, G³
> 



---


## File Structure {#File-Structure}

```
compute_systematics_FS.jl       ← main entry point (this file)
TE_functions.jl                 ← shared utilities: KDs, norm2one, get_data_thread, etc.
TE_functions_FS.jl              ← FS-specific threading: per-sample water saturation + threaded loop
TE_fractional.jl                ← core physics: the fractional melting engine (shared)
plot_figures.jl                 ← shared plotting helpers
plot_figures_FS.jl              ← FS-specific plots: scatter, ternary, Herron diagrams, statistics
```



---


## Key Conceptual Difference from the P–H₂O Script {#Key-Conceptual-Difference-from-the-P–HO-Script}

|                  | `compute_P-H2O_systematics.jl` |                        `compute_systematics_FS.jl` |
| ----------------:| ------------------------------:| --------------------------------------------------:|
|  **What varies** |       Pressure × H₂O on a grid |             Real bulk compositions from a database |
|    **Dimension** |            2D grid (`np × np`) |                            1D array (`np` samples) |
|    **Bulk rock** |       One fixed average pelite |               ~hundreds of natural pelite analyses |
|  **H₂O content** |              Axis of variation | Computed per-sample, on-the-fly inside each thread |
| **Output space** |         Heatmap in P–H₂O space |     Scatter plots in geochemical composition space |



---


## Key Concepts Before Diving In {#Key-Concepts-Before-Diving-In}

### The Forshaw &amp; Pattison (2023) Database {#The-Forshaw-and-Pattison-2023-Database}

This is a published compilation of major-element geochemistry from natural pelitic rocks. Each row in the database is one rock sample with its full oxide composition (SiO₂, Al₂O₃, CaO, MgO, FeO, K₂O, Na₂O, TiO₂, O, MnO). The database is stored as an Excel file and read at runtime.

### Why Vary Bulk Composition? {#Why-Vary-Bulk-Composition?}

Bulk chemistry controls the mineral assemblage, which in turn controls how Li is distributed. A K-rich pelite will have more muscovite and biotite (high Li KDs), while a Mg-rich one may stabilize cordierite instead. By running all ~hundreds of natural samples, the script maps out which geochemical traits lead to the highest Li enrichment.

### Water Saturation Per Sample {#Water-Saturation-Per-Sample}

Unlike the P–H₂O script where a single interpolant `pChip_wat(P)` serves the entire grid, here **each rock sample has its own saturation water content** because every bulk composition saturates at a different H₂O level. This saturation is computed from scratch **inside the thread** for each sample.


---


## Step 1 — Entry Point and Parameters {#Step-1-—-Entry-Point-and-Parameters}

**File:** `compute_systematics_FS.jl`, lines 140–172

```julia
model       = "MM"
P           = [4.0, 8.0]      # kbar — run at each pressure
Ex_H2O_sat  = 0.03            # excess H₂O above saturation (mol fraction)
Li_content  = 100.0           # ppm
e1_liq      = 7.0             # vol% melt triggering extraction
e1_remain   = 1.0             # vol% melt left behind after extraction
n_ee        = 10              # maximum number of extraction events
```


The outer loop runs `main()` once per pressure:

```julia
for Pin in P
    Out_all, np, KDs_database, FS_bulks = main(; P = Pin, ...)
end
```


Key differences from the P–H₂O script:

|    Parameter |                      P–H₂O script |                                    FS script |
| ------------:| ---------------------------------:| --------------------------------------------:|
|          `P` |       Vector defining a grid axis |                   A single value (or looped) |
|         `np` | Fixed grid resolution (e.g., 150) |                  Determined by database size |
| `Ex_H2O_sat` |                          Not used | Excess H₂O above saturation added per sample |
|          `H` |                 Axis of variation |            Computed per-sample automatically |



---


## Step 2 — `main()` Function {#Step-2-—-main-Function}

**File:** `compute_systematics_FS.jl`, lines 38–137

### Stage A: KD Color Limits {#Stage-A:-KD-Color-Limits}

```julia
if model == "MM"
    clim = (2.0, 6.0)
elseif model == "KM"
    clim = (2.0, 10.0)
...
```


Each model has different expected Li enrichment ranges, used to fix color scales consistently across plots.

### Stage B: Load the Forshaw Database {#Stage-B:-Load-the-Forshaw-Database}

```julia
bulk_db  = load_Forshaw_mp()
FS_bulks = get_mol_bulks(bulk_db)
np       = size(FS_bulks, 1)
```


`load_Forshaw_mp()` reads the Excel file into a DataFrame. `get_mol_bulks()` converts wt% oxides to mol fractions and normalizes each row to sum to 1. The result is an `np × 11` matrix where row `i` is one pelite sample and columns are oxide mol fractions.

If `test = true`, only every 50th sample is used (`FS_bulks[1:50:end,:]`) — useful for quick validation runs.

### Stage C: Threading Setup {#Stage-C:-Threading-Setup}

```julia
data         = Initialize_MAGEMin(dtb, verbose=-1; solver=0)
KDs_database = get_Kds(model = model)
```


Same as the P–H₂O script: one MAGEMin state per thread, one shared KD database.

### Stage D: Threaded Calculation {#Stage-D:-Threaded-Calculation}

```julia
Out_all, Out_all_FC, FS_bulks = perform_threaded_calc_FS(
    Out_all, Out_all_FC, data, dtb, P, T, np, ...)
```


The H₂O column of `FS_bulks` is written back after each calculation — this records the actual saturation water content used for each sample.

### Stage E: Post-processing and Plotting {#Stage-E:-Post-processing-and-Plotting}

```julia
point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, eta_M, Dbi, afs, pl =
    retrieve_outputs_FS(Out_all, np, KDs_database, output)

plot_all_oxides(FS_bulks, Li_content, Xoxides, ...)
plot_custom_oxides(FS_bulks, Li_content, Xoxides, ...)
```


Two families of plots are generated — see Step 6.


---


## Step 3 — Loading and Converting the Database {#Step-3-—-Loading-and-Converting-the-Database}

**File:** `TE_functions_FS.jl`, `get_mol_bulks()`, lines 187–210

```julia
function get_mol_bulks(data)
    for i = 1:nb
        FS_bulks[i, :] = wt2mol(FS_bulks[i, :], Xoxides)
        FS_bulks[i, :] = norm2one(FS_bulks[i, :])
    end
    return FS_bulks
end
```


Each sample is:
1. **Converted from wt% to mol fractions** using atomic weights (`wt2mol()`)
  
2. **Normalized to sum to 1** (`norm2one()`)
  
3. **H₂O set to 0** initially — it is computed per-sample later
  

The oxide order is fixed: `[SiO₂, Al₂O₃, CaO, MgO, FeO, K₂O, Na₂O, TiO₂, O, MnO, H₂O]`.


---


## Step 4 — Threading Architecture {#Step-4-—-Threading-Architecture}

**File:** `TE_functions_FS.jl`, `perform_threaded_calc_FS()`, lines 118–184

### The 1D Loop {#The-1D-Loop}

Unlike the P–H₂O script (which flattens a 2D grid into a 1D loop), here each iteration `i` is simply one rock sample:

```julia
@threads :static for i = 1:np
    data_thread = get_data_thread(data)        # thread-local MAGEMin state
    bulk_       = FS_bulks[i, :]              # this sample's oxide composition
    ...
end
```


```
Thread 1: i=1, 2, 3, ...         →  sample 1, 2, 3, ...
Thread 2: i=np/8+1, np/8+2, ...  →  sample ~200, 201, ...
Thread 3: i=2*np/8+1, ...        →  sample ~400, 401, ...
...
```


Each thread reads a unique row of `FS_bulks` and writes to a unique index of `Out_all`. No locking needed.

### Per-Sample Water Saturation — Computed Inside the Thread {#Per-Sample-Water-Saturation-—-Computed-Inside-the-Thread}

This is the key architectural difference. Rather than calling a precomputed interpolant, each thread runs a full bisection to find the solidus temperature of its sample&#39;s bulk composition, then extracts the saturation H₂O:

```julia
H_ = water_saturation_curve_FS(
    data_thread,   # ← uses this thread's MAGEMin instance
    P_,
    bulk_,         # ← this sample's composition
    Xoxides,
    dtb,
    Ex_H2O_sat )   # ← excess H₂O to add above saturation
```


The result `H_` is the water content at (or slightly above) saturation for this specific rock at this pressure. Then:

```julia
FS_bulks[i, id_h] = H_   # record actual H₂O used for this sample
```


This saves the computed water content back into the bulk matrix so it can be used in plots.

### Why Per-Thread and Not Pre-Computed? {#Why-Per-Thread-and-Not-Pre-Computed?}

In the P–H₂O script, pressure is an axis of the grid, so the saturation curve can be computed once over the pressure range and interpolated. Here, **every sample has a different bulk composition**, so the saturation curve is unique to each sample — it must be computed fresh each time, within the thread that holds the right MAGEMin state.


---


## Step 5 — Per-Sample Water Saturation: `water_saturation_curve_FS()` {#Step-5-—-Per-Sample-Water-Saturation:-water_saturation_curve_FS}

**File:** `TE_functions_FS.jl`, lines 6–115

This is the per-thread, per-sample version of the saturation computation. The logic mirrors `get_wat_sat_function()` from `TE_functions.jl`, with two key differences:
1. **It receives `data_thread`** (already-initialized MAGEMin state) instead of creating a new one
  
2. **Tolerance is relaxed** to 0.01 °C (vs. 1e-4 in the global version) for speed
  

### Algorithm {#Algorithm}

```
Input: thread's MAGEMin state, P, bulk composition, excess H₂O

1. Set H₂O to 0.4 mol fraction (force water saturation)
2. Normalize bulk
3. Bisect T in [500, 2200 °C] until "liq" appears in phase list
   → finds T_solidus for this bulk at this P
4. Run MAGEMin at T_solidus
5. Strip excess free-water phase (H2O or fl) from equilibrium bulk
6. Add excess H₂O (Ex_H2O_sat) above the stripped saturation value
7. Normalize on anhydrous basis
8. Return the H₂O mol fraction
```


The `Ex_H2O_sat = 0.03` parameter adds a small deliberate excess above the saturation threshold — this ensures the rock is slightly over-saturated, which is the geologically relevant condition for partial melting near the wet solidus.


---


## Step 6 — Post-Processing: `retrieve_outputs_FS()` {#Step-6-—-Post-Processing:-retrieve_outputs_FS}

**File:** `plot_figures_FS.jl`, lines 1415–1568

The post-processing loop is 1D (`for i = 1:np`) rather than 2D. For each sample `i`:
1. **Find the extraction event with peak Li** — same logic as the P–H₂O script
  
2. **Require `Cliq > 100 ppm`** — a minimum enrichment threshold filters samples that barely melted
  
3. **Extract mineral changes**: Δbi, Δcd, Δmu (same as P–H₂O script)
  
4. **Additional fields** not present in the P–H₂O script:
  - `afs[i]` — alkali feldspar volume fraction at peak extraction
    
  - `pl[i]` — plagioclase volume fraction at peak extraction
    
  - `Dbi[i]` — the **effective biotite KD at the extraction point**, evaluated by calling the expression from the KD database:
    
    ```julia
    expr  = KDs_database.KDs_expr[2]           # biotite expression
    Dbi[i] = Base.invokelatest(expr, out)       # evaluate at this P-T-X
    ```
    
    This gives the actual KD value that biotite had for each rock sample, which varies because the MM model&#39;s biotite KD depends on composition and temperature.
    
  
5. **Saves everything to a JLD2 file**: `out_struct.jld2` — including the full MAGEMin outputs for later analysis.
  


---


## Step 7 — Statistical Analysis (inside `plot_custom_oxides()`) {#Step-7-—-Statistical-Analysis-inside-plot_custom_oxides}

**File:** `plot_figures_FS.jl`, lines 1144–1201

After running all samples, the Li enrichment distribution is analyzed statistically. Samples are divided into three groups based on the distribution of `Cliq_max`:

```
  Distribution of Li enrichment across all ~600 samples
  ───────────────────────────────────────────────────────

  Count
    │
    │          ╭───╮
    │        ╭─╯   ╰─╮
    │      ╭─╯         ╰─╮
    │   ╭──╯               ╰──╮
    │ ╭─╯                      ╰────╮
    └──┬──────────┬──────┬──────────┬────── Li enrichment
       │          │      │          │
    median-std  median  mean    median+std
       │                              │
       ▼                              ▼
  ┌────────────┐  ┌────────────┐  ┌────────────┐
  │  id_min    │  │  id_mean   │  │   id_max   │
  │ "low Li"   │  │  "typical" │  │ "high Li"  │
  │            │  │            │  │            │
  │ Li < med   │  │ med-std ≤  │  │ Li > med   │
  │   - std    │  │ Li ≤ mean  │  │   + std    │
  │            │  │   + std    │  │            │
  └────────────┘  └────────────┘  └────────────┘
       ↓                ↓               ↓
  mean bulk          mean bulk      mean bulk
  mean T             mean T         mean T
  mean Δbi           mean Δbi       mean Δbi
  mean Δcd           mean Δcd       mean Δcd
  mean Δmu           mean Δmu       mean Δmu
```


For each group, the **mean bulk composition, mean Li enrichment, mean temperature, mean extraction episode, and mean mineral changes** are computed and saved:

```julia
@save "$(output)Li_enrichment_stats.jld2" mean_mean mean_max mean_min
```


This tells you: &quot;what does a typical high-Li pelite look like chemically, compared to a typical low-Li one?&quot;


---


## Step 8 — Plotting {#Step-8-—-Plotting}

**Files:** `plot_figures_FS.jl`, `plot_figures.jl`

Two plotting functions are called:

### `plot_all_oxides()` — Full Oxide Matrix {#plot_all_oxides-—-Full-Oxide-Matrix}

Creates an `n × n` scatter matrix where every oxide is plotted against every other oxide, colored by Li enrichment. With 10 oxides this gives a 10×10 panel figure (100 subplots), saved as `Oxides_vs_oxides.png`. This is a comprehensive view of which oxide ratios correlate with high Li enrichment.

### `plot_custom_oxides()` — Targeted Diagnostic Plots {#plot_custom_oxides-—-Targeted-Diagnostic-Plots}

Generates a curated set of figures:

|                               File |                                                                  What it shows |
| ----------------------------------:| ------------------------------------------------------------------------------:|
|                     `Li_FK_SA.png` | Li enrichment in log(SiO₂/Al₂O₃) vs log(FeO/K₂O) space (Herron classification) |
| `Li_SiO2-MgO_vs_Al2O3-CaO-H2O.png` |                                          Pelite-specific oxide contrasts vs Li |
|             `Li_Al2O3_vs_SiO2.png` |                                         Al₂O₃ vs SiO₂ colored by Li enrichment |
|                       `ASM_Li.png` |                               SiO₂–Al₂O₃–MgO ternary, colored by Li enrichment |
|                      `Δcd_vol.png` |                                          Cordierite vol% change on ASM ternary |
|                      `Δbi_vol.png` |                                             Biotite vol% change on ASM ternary |
|                      `Δmu_vol.png` |                                           Muscovite vol% change on ASM ternary |
|                      `afs_vol.png` |                              Alkali feldspar vol% at extraction on ASM ternary |
|                       `pl_vol.png` |                                  Plagioclase vol% at extraction on ASM ternary |
|             `ASM_T_extraction.png` |                                          Extraction temperature on ASM ternary |
|       `ASM_Extraction_episode.png` |                                        Which extraction event # on ASM ternary |
|               `ASM_Kd_biotite.png` |                                            Effective biotite KD on ASM ternary |
|        `Herron_classification.png` |                                 PlotlyJS Herron diagram with full sample cloud |


The **ASM ternary plots** (SiO₂–Al₂O₃–MgO) are produced with PlotlyJS, using `scatterternary()` with color-coded markers. The ternary corner labels are:
- **S** = SiO₂ — maturity / silica content
  
- **A** = Al₂O₃ — aluminosity (controls muscovite/biotite stability)
  
- **M** = MgO — maficity (controls biotite vs. cordierite)
  

### The Herron Diagram {#The-Herron-Diagram}

The **Herron classification** plots log₁₀(SiO₂/Al₂O₃) on the x-axis vs log₁₀(Fe₂O₃/K₂O) on the y-axis, dividing the space into sedimentary rock types (Shale, Wacke, Litharenite, Fe Sand, Sublitharenite). The boundary lines are hardcoded as PlotlyJS scatter traces. Each sample is a dot colored by Li enrichment, letting you read off &quot;which sedimentary rock type melts to produce the most Li-rich granites.&quot;


---


## Data Flow Summary {#Data-Flow-Summary}

```
compute_systematics_FS.jl
│
├── for Pin in P:
│
│   main(P = Pin, model = "MM", ...)
│   │
│   ├── load_Forshaw_mp()              → DataFrame (wt% oxides, ~600 samples)
│   ├── get_mol_bulks()                → FS_bulks[np, 11] (mol fractions)
│   ├── get_Kds(model)                 → KDs_database
│   ├── Initialize_MAGEMin()           → data (one state per thread)
│   │
│   ├── perform_threaded_calc_FS()     → Out_all[np]
│   │     └── @threads :static for i = 1:np
│   │           ├── get_data_thread(data)             → thread-local MAGEMin
│   │           ├── bulk_ = FS_bulks[i,:]             → this sample's composition
│   │           ├── water_saturation_curve_FS()       → H_ (per-sample, in-thread)
│   │           │     └── bisect T → solidus
│   │           │     └── strip free water
│   │           │     └── add Ex_H2O_sat excess
│   │           ├── threaded_frac_melting()           → Li_infos
│   │           │     └── (same engine as P-H2O script)
│   │           └── FS_bulks[i, id_h] = H_            → record water used
│   │
│   ├── retrieve_outputs_FS()          → Cliq_max, Δbi, Δcd, Δmu, Dbi, afs, pl, ...
│   │     └── find peak Li per sample
│   │     └── evaluate biotite KD expression
│   │     └── statistical grouping (low/mean/high Li)
│   │     └── @save out_struct.jld2
│   │
│   ├── plot_all_oxides()              → Oxides_vs_oxides.png
│   └── plot_custom_oxides()           → ASM ternaries, Herron, scatter plots
```



---


## Comparison: FS Script vs P–H₂O Script {#Comparison:-FS-Script-vs-P–HO-Script}

```
P–H₂O script                          FS script
──────────────────────────────────     ──────────────────────────────────
Question: how does P and H₂O           Question: how does bulk chemistry
          affect Li enrichment?                   affect Li enrichment?

Grid: np × np = 22,500 cells           Array: np ≈ 600 samples

Water saturation:                      Water saturation:
  precomputed once as PCHIP spline       computed per-sample, in-thread
  pChip_wat(P) called at runtime         water_saturation_curve_FS()

Threading: 1D loop k=1:np²             Threading: 1D loop i=1:np
  get_coordinates(k,np) → (i,j)          each i is one rock sample

Output space: heatmap in P–H₂O plane  Output space: scatter in composition
                                         space (ASM ternary, Herron, etc.)

Post-processing: 2D matrices           Post-processing: 1D vectors
  Cliq_max[np,np]                        Cliq_max[np]
```



---


## Running the Script {#Running-the-Script}

```bash
julia --threads 8 compute_systematics_FS.jl
```


No cached `.jld2` files are needed upfront — the water saturation is computed fresh per sample inside the threads. The Excel database file must be present at `./Forshaw_bulk_db/G50542_SuppData.xlsx` (default path in `load_Forshaw_mp()`).

Outputs are saved under `./output_Li_v0.1/<model>/FS_dtb_<model>_P<P>kbar_H<Ex_H2O_sat>_e<e1_liq>_r<e1_remain>/`.

To test on a small subset before a full run, set `test = true` at the bottom of the script — this downsamples to every 50th rock sample.
