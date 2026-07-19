---
---

# Tutorial: `compute_plot_stepwise_batch_melting.jl` {#Tutorial:-compute_plot_stepwise_batch_melting.jl}

## What This Script Does — The Big Picture {#What-This-Script-Does-—-The-Big-Picture}
> 
> _As temperature rises at a single fixed P–H₂O condition, how do Li concentrations in the melt and in each mineral evolve, how do mineral volumes change, and how does the bulk partition coefficient shift?_
> 


This is the **single-path diagnostic** of the project. All other scripts sweep across many conditions (pressure, H₂O, bulk compositions). This script fixes everything — one pressure, one water content, one bulk rock — and watches the system evolve continuously from the solidus to 1000 °C through 1024 temperature steps. It produces a three-panel figure showing:
2. **Li concentration vs T** — in the melt and in every mineral simultaneously
  
3. **Phase volumes vs T** — how each mineral grows and shrinks during heating
  
4. **Bulk partition coefficient D_Li vs T** — the system-wide effective KD in log scale
  

This is the script you run to understand and debug a specific P–T path before or after running the large grid calculations.


---


## File Structure {#File-Structure}

```
compute_plot_stepwise_batch_melting.jl   ← standalone script, no includes beyond shared utils
TE_functions.jl                          ← norm2one, get_Kds, pChip cache loading
TE_fractional.jl                         ← TE_prediction
plot_figures.jl                          ← shared helpers
```



---


## Key Difference from All Other Scripts {#Key-Difference-from-All-Other-Scripts}

|                    |                      Other scripts |                           This script |
| ------------------:| ----------------------------------:| -------------------------------------:|
|           **Axis** | Pressure, H₂O, or bulk composition |            Fixed — one (P, H₂O) point |
|    **Temperature** |                 Found by bisection |      Swept as a dense 1024-step array |
|     **Extraction** |                  Tracked per event |   Triggered inline when melt vol ≥ 7% |
|         **Output** |       Scalar summary per grid cell |    Full time-series of every variable |
|      **Threading** |     `@threads` over the sweep axis |                  None — single thread |
| **Trace elements** |                        `Cliq` only | **`Cliq` + `Cmin` for every mineral** |


`Cmin` (Li in each solid phase) is the key quantity this script adds. The other scripts only record the melt concentration; this one shows the full mineral-by-mineral Li budget at every temperature step.


---


## Step 1 — Setup {#Step-1-—-Setup}

```julia
P       = 4.0       # kbar — single fixed pressure
H_ex    = 0.0       # no excess water beyond saturation
n_ee    = 15        # max extraction events (used as context, not in loop)
e1_liq  = 7.0       # vol% melt threshold for extraction
e1_remain = 1.0     # vol% melt retained after extraction
n_max   = 1024      # temperature steps in the sweep
max_T   = 1000      # maximum temperature (°C)
```


### Water Content from Cache {#Water-Content-from-Cache}

```julia
pChip_wat, pChip_T = load("pChip_wat.jld2", "pChip_wat", "pChip_T")
H = pChip_wat(P)
bulk[id_h] = H      # set water to exact saturation value at P = 4 kbar
```


Unlike `compute_plot_phase_stability.jl` which adds `H_ex = 0.03`, here `H_ex = 0.0` — exact saturation, no excess. The solidus temperature also comes from the interpolant directly:

```julia
Tsol = pChip_T(P) + 1   # +1°C to sit just above the solidus
```


This is a shortcut — instead of running the bisection (`retrieve_solidus()`), the cached `pChip_T` interpolant gives the solidus temperature instantly.

### Temperature Axis {#Temperature-Axis}

```julia
Tall = collect(range(Tsol, max_T, length=n_max))   # 1024 steps, Tsol → 1000°C
```



---


## Step 2 — The Forward Sweep with Inline Extraction {#Step-2-—-The-Forward-Sweep-with-Inline-Extraction}

```julia
@showprogress for i = 1:n_max

    ext_out2[i]    = point_wise_minimization(P, Tall[i], ...)
    ext_out_te2[i] = TE_prediction(ext_out2[i], C0, KDs_database, ...)

    if "liq" in ext_out2[i].ph
        id_liq = findfirst(ext_out2[i].ph .== "liq")
        if ext_out2[i].ph_frac_vol[id_liq] >= e1_liq/100.0

            ratio = (frac_M_vol - e1_remain/100.0) / frac_M_vol
            bulk  = bulk .- liq_comp .* (frac_M * ratio)
            C0    = C0   .- Cliq     .* (liq_wt_norm * ratio)
            gv    = define_bulk_rock(gv, bulk, ...)
        end
    end
end
```


This is structurally identical to `compute_plot_phase_stability.jl` — a forward temperature sweep that triggers extraction when the 7% threshold is crossed and immediately updates the bulk composition. The difference is that here the loop runs at a **single fixed pressure**, so every detail of the evolution is captured.

The key visual consequence: when an extraction event fires, the next temperature step will show a **discontinuity** in `Li`, `liq_vol`, and mineral volumes because the bulk composition has changed. These jumps are the signature of fractional melting and are visible in the output plots.


---


## Step 3 — Extracting Phase Volumes {#Step-3-—-Extracting-Phase-Volumes}

Phase volumes are read from `ext_out2` using the same `SS_syms`/`PP_syms` pattern as in `compute_plot_phase_stability.jl`:

```julia
# Solution phases (bi, mu, cd, pl, afs) → via SS_syms
bi_vol = [haskey(ext_out2[i].SS_syms, :bi) ?
          ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:bi]] : 0.0
          for i = 1:n_max]

# Pure phase (quartz) → via PP_syms with n_SS offset
q_vol  = [haskey(ext_out2[i].PP_syms, :q) ?
          ext_out2[i].ph_frac_vol[ext_out2[i].PP_syms[:q] + ext_out2[i].n_SS] : 0.0
          for i = 1:n_max]
```


The capped melt volume line in `compute_plot_phase_stability.jl` (`liq_vol[liq_vol .> 0.07] .= 0.07`) is commented out here — the uncapped melt fraction is plotted directly so that the extraction jumps remain visible.


---


## Step 4 — Extracting Li in Each Mineral (`Cmin`) {#Step-4-—-Extracting-Li-in-Each-Mineral-Cmin}

This is the **unique feature** of this script. `TE_prediction()` computes not only `Cliq` (Li in the melt) but also `Cmin` — the Li concentration in each solid phase. This is read from `ext_out_te2[i]`:

```julia
bi_Li = []
for i = 1:n_max
    if "bi" in ext_out_te2[i].ph_TE          # check phase present in TE output
        id_bi = findfirst(ext_out_te2[i].ph_TE .== "bi")
        push!(bi_Li, ext_out_te2[i].Cmin[id_bi])   # Li ppm in biotite
    else
        push!(bi_Li, 0.0)
    end
end
```


The same pattern is repeated for `pl`, `afs`, `mu`, `cd`, `q`. Then zeros are replaced with `NaN` so absent phases leave gaps in the curves rather than dropping to zero:

```julia
bi_Li[bi_Li .== 0.0] .= NaN
mu_Li[mu_Li .== 0.0] .= NaN
...
```


This is important for readability: when biotite breaks down at high temperature, its curve simply ends rather than collapsing to zero and cluttering the plot.


---


## Step 5 — Evaluating Individual Mineral KDs {#Step-5-—-Evaluating-Individual-Mineral-KDs}

Beyond plotting `Cliq` and `Cmin`, the script also evaluates the actual KD expressions from the database for biotite, muscovite, and cordierite at each temperature step:

```julia
Dbi = []
for k = 1:n_max
    if "bi" in ext_out2[k].ph
        expr = KDs_database.KDs_expr[2]          # biotite expression (index 2)
        push!(Dbi, Base.invokelatest(expr, ext_out2[k]))
    else
        push!(Dbi, NaN)
    end
end
```


`KDs_database.KDs_expr` holds the compiled Julia functions for each phase's KD expression — the same expressions encoded as strings in `get_Kds()`. `Base.invokelatest()` calls them safely after runtime compilation. The index mapping is:
- `KDs_expr[1]` → muscovite (Dms)
  
- `KDs_expr[2]` → biotite (Dbi)
  
- `KDs_expr[3]` → cordierite (Dcd)
  

These arrays are computed but not plotted in the current version — they are available for further analysis or can be added to the figure.


---


## Step 6 — Three-Panel Figure {#Step-6-—-Three-Panel-Figure}

```julia
plots = []

# Panel 1: Li concentration in melt and all minerals vs T
fig = plot(T, Li, ...)                         # melt
fig = plot!(T, pl_Li, ...)                     # plagioclase
fig = plot!(T, afs_Li, ...)                    # alkali feldspar
fig = plot!(T, bi_Li, ...)                     # biotite
fig = plot!(T, mu_Li, ...)                     # muscovite
fig = plot!(T, q_Li, ...)                      # quartz
push!(plots, fig)

# Panel 2: Phase volumes vs T
fig = plot(T, liq_vol.*100.0, ...)             # melt vol%
fig = plot!(T, afs_vol.*100.0, ...)
fig = plot!(T, pl_vol.*100.0, ...)
...
push!(plots, fig)

# Panel 3: Bulk partition coefficient (log scale)
fig = plot(T, bulk_D, yscale=:log10, ...)
push!(plots, fig)

plt = plot(plots..., layout=grid(3,1), size=(600, 1350))
savefig(plt, "P4kbar_MM_71.svg")
```


The three panels are stacked vertically (`grid(3,1)`) into a tall 600×1350 figure:

```
┌─────────────────────────────────┐
│  Panel 1: Li [µg/g] vs T        │
│  ── melt  ── bi  ── mu  ── pl   │
│     (NaN gaps where phase absent)│
├─────────────────────────────────┤
│  Panel 2: Phase vol% vs T        │
│  ── melt  ── bi  ── mu          │
│  ── afs   ── pl  ── q           │
│     (jumps at extraction events) │
├─────────────────────────────────┤
│  Panel 3: bulk D_Li vs T (log)   │
│  (composite KD of whole system)  │
└─────────────────────────────────┘
           650°C           1000°C
```


`bulk_D` is the bulk partition coefficient — a single number that tells you how strongly the whole mineral assemblage buffers Li relative to the melt. Values &gt; 1 mean the solid holds more Li than the melt; values &lt; 1 mean the melt is enriched. Its log-scale plot reveals the order-of-magnitude changes that occur when biotite breaks down.


---


## Data Flow Summary {#Data-Flow-Summary}

```
Setup
│
├── load("pChip_wat.jld2")          → pChip_wat(P), pChip_T(P) (cached interpolants)
├── H = pChip_wat(4.0)              → saturation H₂O at 4 kbar
├── Tsol = pChip_T(4.0) + 1        → solidus temperature (from cache)
├── Tall = [Tsol → 1000°C, 1024 steps]
│
└── for i = 1:1024   (temperature sweep, single thread)
      ├── point_wise_minimization(4.0, Tall[i])  → equilibrium assemblage
      ├── TE_prediction()                         → Cliq, Cmin (Li in every phase)
      └── if liq vol ≥ 7%:
            extract melt → update bulk, C0        ← discontinuity in all arrays

Post-processing
│
├── Li[1024]     = Cliq at each step
├── liq_vol[1024]= melt volume fraction
├── XX_vol[1024] = mineral volume fractions (afs, pl, mu, bi, cd, q)
├── XX_Li[1024]  = Li in each mineral from Cmin (0 → NaN where absent)
├── bulk_D[1024] = bulk partition coefficient
├── Dbi, Dms, Dcd = individual KDs from KDs_expr evaluated at each step
│
└── plot(grid 3×1):
      Panel 1 → Li in melt + minerals vs T
      Panel 2 → phase volumes vs T
      Panel 3 → bulk D_Li vs T (log scale)
      → P4kbar_MM_71.svg
```



---


## Connection to the Other Scripts {#Connection-to-the-Other-Scripts}

This script is the **single-point zoom** that complements the large sweeps:

|                               Question |                                       Script |
| --------------------------------------:| --------------------------------------------:|
|       Li enrichment across P–H₂O space |               `compute_P-H2O_systematics.jl` |
| Li enrichment across bulk compositions |                  `compute_systematics_FS.jl` |
|     P–T positions of extraction events |                       `compute_PT_curves.jl` |
|  Mineral stability fields in P–T space |            `compute_plot_phase_stability.jl` |
|  **Full Li evolution at one P–T path** | **`compute_plot_stepwise_batch_melting.jl`** |
|              Biotite KD variation only |                  `compute_bi_Li_profiles.jl` |



---


## Running the Script {#Running-the-Script}

```bash
julia compute_plot_stepwise_batch_melting.jl
```


**Prerequisites:** `pChip_wat.jld2` must exist (produced by `compute_P-H2O_systematics.jl`).

To explore a different pressure, change `P = 4.0` at line 37. The output filename `P4kbar_MM_71.svg` is hardcoded — rename it manually when changing conditions. To switch KD models, change `model = "MM"` at line 24.
