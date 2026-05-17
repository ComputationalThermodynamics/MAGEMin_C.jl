
# Tutorial: `compute_plot_phase_stability.jl` {#Tutorial:-compute_plot_phase_stability.jl}

## What This Script Does — The Big Picture {#What-This-Script-Does-—-The-Big-Picture}
> 
> _Over what temperature range is each mineral stable, and how does that stability window shift with pressure along the water-saturated pelite solidus?_
> 


This script computes **mineral stability fields in P–T space** for the average Forshaw &amp; Pattison pelite. For each pressure step along the wet solidus (2 to 16 kbar), it runs a dense temperature sweep from the solidus up to 1000 °C, records at which temperatures each mineral (muscovite, biotite, cordierite, quartz, plagioclase, alkali feldspar, paragonite) is stable, and reduces that to a `[T_min, T_max]` stability window. The result is a P–T diagram where each mineral appears as a **filled stability polygon** — the geologist&#39;s equivalent of a pseudosection slice.

A secondary output is a 2D matrix `Z[pressure, temperature]` counting how many melt extraction events have occurred at each (P, T) point, showing where in P–T space cumulative melt extraction progresses.


---


## File Structure {#File-Structure}

```
compute_plot_phase_stability.jl       ← main script
TE_functions.jl                       ← norm2one, retrieve_solidus, get_Kds, etc.
TE_fractional.jl                      ← TE_prediction (used in the T-sweep loop)
plot_figures.jl                       ← shared helpers
plot_phase_stability_functions.jl     ← get_mu_poly, get_bi_poly, get_cd_poly, get_pat_poly
                                         (note: this file is included at line 297 but does
                                          not yet exist — it must be created separately)
```



---


## Key Difference from All Other Scripts {#Key-Difference-from-All-Other-Scripts}

Every other script in this project uses **bisection** to find specific temperatures (solidus, extraction threshold). This script instead runs a **dense forward temperature sweep**: it steps through `n_max = 2048` equally spaced temperatures from solidus to 1000 °C and evaluates the full equilibrium assemblage at each step. This is the **batch melting** equivalent — the rock stays closed while temperature rises, melt is extracted when it hits the 7% threshold, and the sweep continues on the residual bulk.

```
Other scripts:           This script:
bisect → find T          sweep T = [Tsol, Tsol+δ, Tsol+2δ, ..., 1000°C]
one point per event      2048 equilibrium calculations per pressure
fast, targeted           exhaustive, reveals full mineral evolution
```



---


## Step 1 — Parameters {#Step-1-—-Parameters}

```julia
main_fct(; model = "MM", Prange = [2.0, 16.0], Pstep = 0.2)
```


| Parameter |               Value |                                Meaning |
| ---------:| -------------------:| --------------------------------------:|
|  `Prange` |  `[2.0, 16.0]` kbar |                         Pressure range |
|   `Pstep` |          `0.2` kbar |     Pressure step → 71 pressure slices |
|   `n_max` |              `2048` |   Temperature steps per pressure slice |
|  `e1_liq` |          `7.0` vol% | Melt fraction threshold for extraction |
|    `H_ex` | `0.03` mol fraction |            Excess H₂O above saturation |


Total equilibrium calculations: 71 pressures × 2048 temperatures = **~145,000 MAGEMin calls**. This runs on a single thread (no `@threads`) — it is the most compute-intensive script in the project, but outputs the richest picture of mineral stability.


---


## Step 2 — Water Saturation from Cache {#Step-2-—-Water-Saturation-from-Cache}

```julia
pChip_wat, pChip_T = load("pChip_wat.jld2", "pChip_wat", "pChip_T")
```


Rather than recomputing the saturation curve, the script **reads the cached PCHIP interpolant** written by `compute_P-H2O_systematics.jl`. This is the same `pChip_wat(P)` function used to filter the P–H₂O grid. Here it is called once per pressure step:

```julia
H = pChip_wat(P)
bulk[id_h] = H + H_ex     # saturation water + 0.03 excess
```



---


## Step 3 — The Temperature Sweep Loop {#Step-3-—-The-Temperature-Sweep-Loop}

**File:** `compute_plot_phase_stability.jl`, lines 94–269

For each pressure `P` from 2 to 16 kbar in steps of 0.2:

### Step 3a — Find Solidus and Build Temperature Axis {#Step-3a-—-Find-Solidus-and-Build-Temperature-Axis}

```julia
Tsol = retrieve_solidus(P, gv, z_b, DB, splx_data)
Tall = collect(range(Tsol, 1000.0, length=n_max))   # 2048 equally spaced T steps
```


The solidus is found by bisection (same function used in all other scripts). The 2048 temperature points are then spaced uniformly between the solidus and 1000 °C.

### Step 3b — Forward Temperature Sweep with Inline Extraction {#Step-3b-—-Forward-Temperature-Sweep-with-Inline-Extraction}

```julia
ee = 0    # extraction event counter
@showprogress for i = 1:n_max

    # run equilibrium at this T
    ext_out2[i]    = point_wise_minimization(P, Tall[i], ...)
    ext_out_te2[i] = TE_prediction(ext_out2[i], C0, ...)

    # check if melt volume reached threshold
    if "liq" in ext_out2[i].ph
        if ext_out2[i].ph_frac_vol[id_liq] >= e1_liq/100.0

            # extract melt: update bulk and Li budget
            ratio = (frac_M_vol - e1_remain/100.0) / frac_M_vol
            bulk  = bulk .- liq_comp .* (frac_M * ratio)
            C0    = C0   .- Cliq     .* (liq_wt_norm * ratio)
            gv    = define_bulk_rock(gv, bulk, ...)

            ee += 1    # increment extraction counter
        end
    end

    ext_event[i] = ee    # record how many extractions have happened by this T
end
```


This is fundamentally different from `threaded_frac_melting()`: rather than bisecting for the exact extraction temperature, the sweep simply detects when melt volume **crosses** the threshold during the continuous temperature scan and extracts immediately. The extraction counter `ee` increments each time 7% melt is reached, giving a running tally at every temperature step.

### Step 3c — Extract Phase Volumes Along the Sweep {#Step-3c-—-Extract-Phase-Volumes-Along-the-Sweep}

For each mineral, the volume fraction is read from every temperature step using the `SS_syms` and `PP_syms` dictionaries:

```julia
afs_vol = []
for i = 1:n_max
    if haskey(ext_out2[i].SS_syms, :afs)
        push!(afs_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:afs]])
    else
        push!(afs_vol, 0.0)
    end
end
```


Note the distinction:
- **Solution phases** (bi, mu, cd, pl, afs, pat) — accessed via `SS_syms` (solid solution index)
  
- **Pure phases** (q = quartz) — accessed via `PP_syms` and offset by `n_SS`:
  
  ```julia
  push!(q_vol, ext_out2[i].ph_frac_vol[ext_out2[i].PP_syms[:q] + ext_out2[i].n_SS])
  ```
  
  The `+ n_SS` offset is needed because MAGEMin stores pure phases after all solution phases in the `ph_frac_vol` array.
  

### Step 3d — Find Stability Windows {#Step-3d-—-Find-Stability-Windows}

For each mineral, the temperature range where it is present (vol &gt; 0) is reduced to `[T_min, T_max]`:

```julia
mu_T_range = Tall[mu_vol .> 0.0]        # Boolean mask → temperatures where mu exists
mu_T       = [minimum(mu_T_range), maximum(mu_T_range)]   # stability window
```


If a mineral is absent at all temperatures, `[NaN, NaN]` is stored — this propagates cleanly as a gap in the P–T plot.

### Step 3e — Accumulate Across Pressures {#Step-3e-—-Accumulate-Across-Pressures}

All stability windows and temperature vectors are appended to growing lists:

```julia
push!(mu_T_all,  mu_T)    # [T_min, T_max] for muscovite at this P
push!(bi_T_all,  bi_T)
push!(cd_T_all,  cd_T)
...
push!(Pall,  P)
push!(Tall2, Tall)         # full 2048-point temperature axis for this P
```


After the pressure loop, `mu_T_all[k]` holds the muscovite stability window at `Pall[k]`.


---


## Step 4 — The Extraction Event Matrix {#Step-4-—-The-Extraction-Event-Matrix}

After `main_fct()` returns, the extraction event counter arrays are packed into a 2D matrix:

```julia
nP = length(Pall)           # 71 pressure slices
nT = length(Tall2[1])       # 2048 temperature steps

Z = zeros(nP, nT)
for i = 1:nP
    Z[i, :] .= ext_event_all[i][1:nT]
end
```


`Z[i, j]` = how many melt extraction events have occurred by temperature step `j` at pressure `i`. This matrix can be visualized as a heatmap showing how many cumulative extraction pulses have happened across P–T space — a 2D picture of the fractional melting history.

```
P (kbar)
  │
16│  0  0  0  1  1  2  2  3  3  4  ...
  │  0  0  0  1  1  2  2  3  4  5  ...
12│  0  0  1  1  2  3  3  4  5  6  ...
  │  0  0  1  2  3  4  5  6  7  8  ...
 8│  0  1  2  3  4  5  6  7  8  9  ...
  │  0  1  2  3  4  5  6  8  9 10  ...
 4│  0  1  3  4  5  6  7  9 10 11  ...
  └──────────────────────────────────── T (°C)
     Tsol                           1000
```



---


## Step 5 — Stability Polygon Plotting {#Step-5-—-Stability-Polygon-Plotting}

**File:** `plot_phase_stability_functions.jl` _(to be created)_

After the main calculation, the script includes the polygon helper file and draws one filled shape per mineral:

```julia
include("plot_phase_stability_functions.jl")

x_poly, y_poly = get_mu_poly(mu_T_all, Pall)
plot(x_poly, y_poly, seriestype=:shape, alpha=0.3, label="muscovite")

x_poly, y_poly = get_bi_poly(bi_T_all, Pall)
plot!(x_poly, y_poly, seriestype=:shape, alpha=0.3, label="biotite")
...
```


Each `get_XX_poly()` function converts the list of `[T_min, T_max]` windows across all pressures into a closed polygon path that Plots.jl can fill. The expected structure is:

```
Input:  mu_T_all = [[700, 820], [705, 835], [710, 848], ..., [NaN, NaN], ...]
        Pall     = [2.0, 2.2, 2.4, ..., 16.0]

Output: x_poly = [700, 705, 710, ..., ..., 848, 835, 820, 700]   ← T_min left side + T_max right side reversed
        y_poly = [2.0, 2.2, 2.4, ..., ...,  16, ...,  2.0, 2.0] ← P going up then back down
```


Tracing the left edge (T_min at each P going up) then the right edge (T_max at each P going back down) closes the polygon:

```
P
│      ┌────────────────────────────────────┐
16 kbar│ ← T_min (left edge, going up)      │ T_max (right edge, going down) →
│      │                                    │
│      │     MUSCOVITE STABILITY FIELD      │
│      │                                    │
 2 kbar└────────────────────────────────────┘
        700°C                           850°C    T
```


The `seriestype=:shape` in Plots.jl fills the enclosed polygon with the chosen color and `alpha=0.3` transparency, so multiple overlapping stability fields remain readable.


---


## Data Flow Summary {#Data-Flow-Summary}

```
main_fct(model="MM", Prange=[2,16], Pstep=0.2)
│
├── load("pChip_wat.jld2")         → pChip_wat (P → H₂O saturation interpolant)
├── Initialize_MAGEMin()           → single-thread MAGEMin state
│
└── for P = 2.0 : 0.2 : 16.0      (71 pressure slices)
      │
      ├── H = pChip_wat(P) + 0.03  → water content for this pressure
      ├── retrieve_solidus(P)      → Tsol by bisection
      ├── Tall = [Tsol → 1000°C, 2048 steps]
      │
      └── for i = 1:2048           (temperature sweep)
            ├── point_wise_minimization(P, Tall[i])  → equilibrium
            ├── TE_prediction()                      → Li in melt
            ├── if melt vol ≥ 7%: extract → update bulk, C0, ee++
            ├── record ext_event[i] = ee
            └── accumulate afs_vol, pl_vol, bi_vol, mu_vol, cd_vol, q_vol, pat_vol

      ├── for each mineral: find [T_min, T_max] from vol > 0 mask
      └── push!(mu_T_all, ...) etc.

Post-processing
│
├── Z[nP, nT] = extraction event matrix (heatmap-ready)
│
└── include("plot_phase_stability_functions.jl")
      ├── get_mu_poly(mu_T_all, Pall)  → closed polygon for muscovite
      ├── get_bi_poly(bi_T_all, Pall)  → closed polygon for biotite
      ├── get_cd_poly(cd_T_all, Pall)  → closed polygon for cordierite
      └── get_pat_poly(pat_T_all, Pall)→ closed polygon for paragonite
      
      plot(:shape) for each mineral → wat_phase_stability_+0.03.svg
```



---


## Connection to the Other Scripts {#Connection-to-the-Other-Scripts}

|                                Script |                      Approach |                           What it reveals |
| -------------------------------------:| -----------------------------:| -----------------------------------------:|
|        `compute_P-H2O_systematics.jl` |     Bisection on extraction T |              Li enrichment in P–H₂O space |
|                `compute_PT_curves.jl` |     Bisection on extraction T |             P–T curves of each melt pulse |
| **`compute_plot_phase_stability.jl`** |             **Dense T sweep** | **Mineral stability fields in P–T space** |
|           `compute_bi_Li_profiles.jl` | Dense T sweep (no extraction) |         Biotite KD variation with T and P |


This is the only script that uses a **dense forward sweep** rather than targeted bisection. The trade-off is 145,000 MAGEMin calls vs. ~100 for `compute_PT_curves.jl`, but it reveals the full evolution of every mineral across the melting interval — information that bisection-based scripts never compute.


---


## Running the Script {#Running-the-Script}

```bash
julia compute_plot_phase_stability.jl
```


**Prerequisites:** the `.jld2` cache files `pChip_wat.jld2` must exist (produced by running `compute_P-H2O_systematics.jl` first). The script will error on line 57 if the cache is missing.

Output: `wat_phase_stability_+0.03.svg` in the working directory. The `+0.03` in the filename encodes the `H_ex = 0.03` excess water parameter.
> 
> **Note:** `plot_phase_stability_functions.jl` (included at line 297) does not currently exist in the repository. The `get_mu_poly`, `get_bi_poly`, `get_cd_poly`, and `get_pat_poly` functions must be defined there before the plotting section can run.
> 

