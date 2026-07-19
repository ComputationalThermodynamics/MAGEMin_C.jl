---
---

# Tutorial: `compute_solidus_FS.jl` {#Tutorial:-compute_solidus_FS.jl}

## What This Script Does — The Big Picture {#What-This-Script-Does-—-The-Big-Picture}
> 
> _At the exact moment the first melt forms, what is the mineral assemblage across all natural pelite compositions, and how does it vary with bulk chemistry?_
> 


This script is a **solidus-snapshot diagnostic**. Rather than tracking Li enrichment through multiple extraction events, it runs `n_ee = 1` extraction event per sample — just enough to capture the equilibrium state at the first melt threshold — and then plots the resulting mineral volume fractions (quartz, plagioclase, alkali feldspar, biotite, muscovite, cordierite, garnet, ilmenite, sillimanite) against bulk composition in Herron chemical space.

The key output is a Herron diagram colored by the combined Q+A+P (quartz + alkali feldspar + plagioclase) volume fraction at the solidus — showing which pelite compositions are most felsic at the onset of melting.


---


## File Structure {#File-Structure}

```
compute_solidus_FS.jl     ← main entry point
TE_functions.jl           ← norm2one, retrieve_solidus, get_Kds, get_data_thread
TE_functions_FS.jl        ← water_saturation_curve_FS, get_mol_bulks
TE_fractional.jl          ← threaded_frac_melting engine (referenced but logic inlined here)
plot_figures.jl           ← shared helpers
plot_figures_FS.jl        ← retrieve_outputs_FS and FS scatter plots
plot_bulk_FS.jl           ← plot_bulk_FS(), create_heatmap_data_scattered()  ← NEW
```


The only new file relative to `compute_systematics_FS.jl` is `plot_bulk_FS.jl`, which handles the Herron diagram and IDW-interpolated heatmap.


---


## Key Difference from `compute_systematics_FS.jl` {#Key-Difference-from-compute_systematics_FS.jl}

|                   |                   `compute_systematics_FS.jl` |                       `compute_solidus_FS.jl` |
| -----------------:| ---------------------------------------------:| ---------------------------------------------:|
|            `n_ee` |                     10 — full melting history |                 **1** — solidus snapshot only |
|      `Ex_H2O_sat` |                 0.03 — slight over-saturation |                    **0.0** — exact saturation |
| Melting stored in | `Li_infos` struct via `threaded_frac_melting` |                 `ext_out[i]` directly, inline |
|   Post-processing |                       `retrieve_outputs_FS()` |     Custom inline loop, then `plot_bulk_FS()` |
|            Output |                 Li enrichment vs. composition | Mineral assemblage at solidus vs. composition |


Setting `n_ee = 1` and `Ex_H2O_sat = 0.0` means: _find the exact water-saturated solidus for each sample, run one equilibrium calculation there, and record the phase assemblage._ No melt extraction actually happens; the loop runs once and exits.


---


## Step 1 — Parameters {#Step-1-—-Parameters}

```julia
model       = "MM"
P           = 8.0       # kbar — single fixed pressure
Ex_H2O_sat  = 0.0       # no excess water — exact saturation
n_ee        = 1         # one event only → solidus snapshot
e1_liq      = 7.0       # vol% melt threshold (used in bisection)
e1_remain   = 1.0       # retained melt (irrelevant for n_ee=1)
```


`P = 8.0` kbar fixes the depth. All ~600 Forshaw pelite samples are run at this single pressure but each at its own saturation water content.


---


## Step 2 — `main()` Function {#Step-2-—-main-Function}

**File:** `compute_solidus_FS.jl`, lines 39–265

### Stage A — Load Database {#Stage-A-—-Load-Database}

```julia
bulk_db  = load_Forshaw_mp()
FS_bulks = get_mol_bulks(bulk_db)    # np × 11 matrix, mol fractions
np       = size(FS_bulks, 1)
```


Identical to the FS script: Excel → DataFrame → wt% → mol fractions → normalized.

### Stage B — Pre-allocate Output Flat Vectors {#Stage-B-—-Pre-allocate-Output-Flat-Vectors}

Unlike `compute_systematics_FS.jl` which packs everything into `Li_infos` structs, here the MAGEMin outputs are stored directly in flat vectors:

```julia
ext_out    = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef, np)
ext_out_te = Vector{MAGEMin_C.out_tepm}(undef, np)
```


One MAGEMin output struct per sample — no wrapping in `Li_infos`. This is intentional: since only one extraction event is needed, the extra nesting of `Li_infos` is unnecessary overhead.

### Stage C — Threaded Loop (Inline Melting Engine) {#Stage-C-—-Threaded-Loop-Inline-Melting-Engine}

The melting logic that is normally delegated to `threaded_frac_melting()` is **written inline** inside the `@threads` loop here. This gives the developer direct access to intermediate variables without unpacking the `Li_infos` struct:

```julia
@threads :static for i = 1:np
    data_thread = get_data_thread(data)
    bulk        = FS_bulks[i, :]

    # 1. Compute water saturation for this sample at P
    H = water_saturation_curve_FS(data_thread, P, bulk, Xoxides, dtb, Ex_H2O_sat)
    bulk[id_h] = H
    gv = define_bulk_rock(gv, bulk, Xoxides, sys_in, dtb)

    # 2. Initialize Li trace element budget
    C0 = adjust_chemical_system(KDs_database, [Li_content], ["Li"])

    # 3. Find the solidus temperature by bisection
    Tsol = retrieve_solidus(P, gv, z_b, DB, splx_data)

    # 4. Run MAGEMin at the solidus
    out    = point_wise_minimization(P, Tsol, ...)
    out_TE = TE_prediction(out, C0, KDs_database, dtb; ...)

    # 5. Bisect to find T at 7% melt (one event only)
    # ... bisection loop ...

    # 6. Save the result directly
    ext_out[i]    = out
    ext_out_te[i] = out_TE
end
```


The bisection inside the loop (steps 5–6) is the same algorithm as in `threaded_frac_melting()` — it narrows the temperature bracket until `out.frac_M_vol ≈ e1_liq/100`. Since `n_ee = 1`, the outer `for ee = 1:n_ee` loop executes exactly once and then exits.

### Threading Structure {#Threading-Structure}

```
@threads :static for i = 1:np   (np ≈ 600 samples)
  │
  ├── Thread k reads  FS_bulks[i, :]          → unique row
  ├── Thread k calls  water_saturation_curve_FS → H_ for this sample
  ├── Thread k calls  retrieve_solidus          → T_sol for this sample
  ├── Thread k runs   bisection loop            → T at 7% melt
  └── Thread k writes ext_out[i], ext_out_te[i] → unique indices
```


No shared mutable state — each thread operates on its own MAGEMin instance and writes to distinct array positions.

### Return Values {#Return-Values}

```julia
return ext_out, ext_out_te, np, KDs_database, FS_bulks
```


The flat `ext_out[np]` array is returned directly to the caller (no `Li_infos` wrapping). `FS_bulks` is also returned — its H₂O column has been updated with the per-sample saturation values during the loop.


---


## Step 3 — Plotting: `plot_bulk_FS()` {#Step-3-—-Plotting:-plot_bulk_FS}

**File:** `plot_bulk_FS.jl`, lines 36–337

Called at line 296:

```julia
plot_bulk_FS(ext_out, P, np, FS_bulks, n_ee)
```


This function does two things: extracts mineral volumes from `ext_out`, then plots them on Herron diagrams.

### Stage A — Extract Mineral Volumes {#Stage-A-—-Extract-Mineral-Volumes}

For each of 8 phases (q, pl, afs, sill, g, bi, mu, cd, ilm), the function loops over all samples and reads the volume fraction from `ext_out[i].ph_frac_vol`:

```julia
q_vol = zeros(np)
for i = 1:np
    if isassigned(ext_out, i)          # guard against uninitialized entries
        if "q" in ext_out[i].ph
            id = findfirst(ext_out[i].ph .== "q")
            q_vol[i] = ext_out[i].ph_frac_vol[id]
        end                            # else stays 0.0
    end
end
```


The `isassigned()` check is essential — samples that failed to converge leave `ext_out[i]` uninitialized, and accessing them would crash. The same pattern is repeated for all 8 minerals.

Then the three felsic phases are combined:

```julia
pl_vol = afs_vol .+ pl_vol .+ q_vol    # Q + A + P total felsic fraction
```


### Stage B — Compute Herron Coordinates {#Stage-B-—-Compute-Herron-Coordinates}

The Herron classification uses log-ratio chemistry:

```julia
# Convert mol fractions back to wt% for the Herron axes
mol_bulk = hcat([mol2wt(FS_bulks[i,:], Xoxides) for i in 1:n]...)

S = mol_bulk[1,:]   # SiO₂ wt%
A = mol_bulk[2,:]   # Al₂O₃ wt%
F = mol_bulk[5,:]   # FeO wt%
K = mol_bulk[6,:]   # K₂O wt%

x_vals = log10.(S ./ A)   # x-axis: silica maturity
y_vals = log10.(F ./ K)   # y-axis: iron enrichment
```


The Herron diagram divides sedimentary rocks into five fields using hardcoded boundary lines (`t`, `t2`, `t3`, `t4`, `t5`):

```
log10(FeO/K2O)
    │
0.6 ├────────────────────────────── Fe Sand
    │         │
    │  Shale  │  Wacke  │ Sublit. │ Litharenite
    │         │         │         │
0.0 ├─────────┴─────────┴─────────┴──────────── log10(SiO2/Al2O3)
              0.55     0.71      1.04
```


### Stage C — Scatter Plot (Q+A+P colored) {#Stage-C-—-Scatter-Plot-QAP-colored}

```julia
scatter_plot = PlotlyJS.scatter(
    x = x_vals,
    y = y_vals,
    marker = attr(
        color      = pl_vol .* 100.0,      # Q+A+P vol% as color
        colorscale = "RdBu",
        cmin       = pl_vol_mean - pl_vol_std,
        cmax       = pl_vol_mean + pl_vol_std,
    ))
```


The color scale is centered on the mean Q+A+P fraction and spans ±1 standard deviation, so the diverging colormap highlights samples that are unusually felsic (red) or unusually poor in Q+A+P (blue) at the solidus.

Output: `1e_8.0_kbar_pl.png` (filename encodes `n_ee` and `P`).

### Stage D — IDW Interpolated Heatmap {#Stage-D-—-IDW-Interpolated-Heatmap}

Because the ~600 samples are **scattered irregularly** in Herron space (not on a regular grid), a simple heatmap cannot be made directly. Instead, `create_heatmap_data_scattered()` interpolates the scattered points onto a regular 64×64 grid using **Inverse Distance Weighting (IDW)**:

```julia
x_grid, y_grid, z_grid = create_heatmap_data_scattered(x_vals, y_vals, pl_vol.*100.0, 64)
```


#### How IDW Works {#How-IDW-Works}

For each node `(xi, yi)` on the regular grid, the interpolated value is a weighted average of all data points, where the weight of each point decays with distance:

```
         Σ (z_k / d_k²)
z(xi,yi) = ──────────────
           Σ (1 / d_k²)

where d_k = distance from (xi,yi) to sample point k
```


```
Scattered samples          Regular 64×64 grid
(irregular spacing)        (uniform spacing)

   ·  ·                      + + + + + + +
      ·   ·       IDW →      + + + + + + +
  ·        ·                 + + + + + + +
     ·   ·                   + + + + + + +
  ·     ·                    + + + + + + +
```


The power parameter is 2 (distance squared in the denominator), which is the standard choice: it gives strong influence to nearby points while allowing distant points to contribute smoothly. A small epsilon (`1e-10`) prevents division by zero when a grid node coincides exactly with a data point.

The resulting `z_grid[64, 64]` is plotted as a `PlotlyJS.heatmap()` with the same Herron boundary lines overlaid.

Output: `1e_8.0_kbar_pl_heatmap.png`.


---


## Data Flow Summary {#Data-Flow-Summary}

```
Setup
│
├── load_Forshaw_mp()           → DataFrame (~600 pelites)
├── get_mol_bulks()             → FS_bulks[np, 11] (mol fractions, H₂O = 0)
├── Initialize_MAGEMin()        → threaded MAGEMin data
├── ext_out[np]                 → flat output vector (one entry per sample)
│
└── @threads :static for i = 1:np
      ├── water_saturation_curve_FS(P, bulk[i])   → H_ at exact saturation
      ├── retrieve_solidus(P)                      → T_solidus by bisection
      ├── bisect T until frac_M_vol = 7%           → T_extraction
      ├── point_wise_minimization(P, T_extraction) → equilibrium assemblage
      └── ext_out[i] = out                         → store phase assemblage

Post-processing (in plot_bulk_FS)
│
├── extract q_vol, pl_vol, afs_vol, bi_vol, mu_vol, cd_vol, g_vol, ...
├── pl_vol = q_vol + afs_vol + pl_vol    (Q+A+P combined)
├── compute Herron axes: log10(SiO2/Al2O3), log10(FeO/K2O)
│
├── PlotlyJS scatter  → 1e_8.0_kbar_pl.png          (sample points)
└── IDW interpolation → 1e_8.0_kbar_pl_heatmap.png  (smooth field)
```



---


## Connection to the Other Scripts {#Connection-to-the-Other-Scripts}

This script occupies a specific diagnostic role in the project:

|                                                                  Question |                         Script |
| -------------------------------------------------------------------------:| ------------------------------:|
|                               How does Li enrichment vary in P–H₂O space? | `compute_P-H2O_systematics.jl` |
|                    Which bulk compositions produce the most Li-rich melt? |    `compute_systematics_FS.jl` |
|                   At which P–T conditions do successive melt pulses form? |         `compute_PT_curves.jl` |
| **What mineral assemblage exists at the solidus across natural pelites?** |    **`compute_solidus_FS.jl`** |
|                                How does the biotite KD vary with T and P? |    `compute_bi_Li_profiles.jl` |



---


## Running the Script {#Running-the-Script}

```bash
julia --threads 8 compute_solidus_FS.jl
```


Outputs are saved in the working directory:
- `1e_8.0_kbar_pl.png` — Herron scatter, colored by Q+A+P vol%
  
- `1e_8.0_kbar_pl_heatmap.png` — IDW-smoothed version of the same field
  

To run at a different pressure, change `P = 8.0` at line 275. The filename automatically encodes the pressure and `n_ee`, so multiple runs do not overwrite each other.
