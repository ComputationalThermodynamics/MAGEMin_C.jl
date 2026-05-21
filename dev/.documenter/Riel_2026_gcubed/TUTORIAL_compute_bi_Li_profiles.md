
# Tutorial: `compute_bi_Li_profiles.jl` {#Tutorial:-compute_bi_Li_profiles.jl}

## What This Script Does — The Big Picture {#What-This-Script-Does-—-The-Big-Picture}
> 
> _How does the biotite–melt partition coefficient for Li vary with temperature and pressure along a realistic P–T path in a pelite?_
> 


This is a focused diagnostic script. It does not run the full fractional melting pipeline. Instead, it sweeps a grid of **pressure × temperature** conditions, runs a single equilibrium calculation at each point, and directly evaluates the **Morris & Beard (2024) expression** for the biotite–melt Li partition coefficient (D_bi). The output is a set of curves showing how D_bi evolves with temperature at several crustal pressures — a key input to understanding the sensitivity of Li enrichment predictions to the KD model.


---


## File Structure {#File-Structure}

```
compute_bi_Li_profiles.jl    ← standalone script, no includes needed
```


Unlike the other scripts in this project, this one has **no includes** and does not use the threaded pipeline. It uses the simpler `single_point_minimization()` interface from MAGEMin_C directly.


---


## Key Concept: The Biotite KD Expression {#Key-Concept:-The-Biotite-KD-Expression}

In the `"MM"` model used by the main scripts, biotite's Li partition coefficient is not a fixed number — it is a **thermodynamic expression** that depends on three quantities evaluated at each P–T point:

|     Variable |                                Meaning |                              Source |
| ------------:| --------------------------------------:| -----------------------------------:|
|        `T_C` |                      Temperature in °C |                       Loop variable |
|     `XMFe3p` | Fe³⁺ fraction on the M-site of biotite | Biotite site fractions from MAGEMin |
| `NaK_Almelt` | (Na + K) / Al ratio in the melt (apfu) |       Melt composition from MAGEMin |


The full expression (Morris & Beard, 2024):

```
ln(D_bi) = c9 + c10 × XMFe3p + c11 × (NaK/Al)_melt + c12 × 10⁴ / (T + 273.15)
```


with fitted constants:

```
c9  = -7.01   (intercept)
c10 = -4.29   (Fe³⁺ site effect — higher Fe³⁺ → lower D_bi)
c11 =  4.18   (melt peralkalinity effect — more Na+K/Al → higher D_bi)
c12 =  0.407  (temperature effect — higher T → lower D_bi)
```


`D_bi = exp(ln_D_Li)` gives the final partition coefficient.

The key insight this script reveals is that **D_bi is not a constant**. It changes as the rock heats up (because the melt composition and biotite Fe³⁺ content evolve), and it differs between pressures (because the stable mineral assemblage changes). This script makes that variation visible.


---


## Step 1 — Setup {#Step-1-—-Setup}

```julia
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"]
bulk    = norm2one([0.67153, 0.12111, 0.00729, 0.03762, 0.05998, 0.02638, 0.01401,
                    0.00717, 0.0069, 0.00071, 0.2])
```


The bulk composition is the Forshaw & Pattison (2023) world-median pelite in mol fractions, normalized to sum to 1. Note that **H₂O is set to 0.2** (20 mol%), which is intentionally high to ensure the rock is water-saturated and biotite coexists with melt across the entire temperature range explored.

```julia
P  = [4.0, 8.0, 12.0]   # kbar
np = 32
T  = collect(range(650.0, 850.0, np))   # °C
```


Three pressures are tested (shallow, mid-crust, deep crust), spanning a temperature range of 650–850 °C in 32 steps.

```julia
data = Initialize_MAGEMin("mp", verbose=-1, solver=0)
```


A single MAGEMin instance is initialized (no threading needed here — the calculation is small).

```julia
D_bi = fill(NaN, length(P), length(T))
```


The output array is pre-filled with `NaN` so that cells where biotite and melt do not coexist remain blank in the plot rather than showing a spurious zero.


---


## Step 2 — The P–T Loop {#Step-2-—-The-P–T-Loop}

```julia
for i = 1:length(P)
    for j = 1:length(T)
        out = single_point_minimization(P[i], T[j], data,
                    X=bulk, Xoxides=Xoxides, sys_in=sys_in)
```


`single_point_minimization()` is the simpler, single-threaded MAGEMin entry point (as opposed to `point_wise_minimization()` used in the threaded pipeline). For each (P, T) cell it returns the full equilibrium phase assemblage, mineral compositions, and melt composition.

### Coexistence Check {#Coexistence-Check}

```julia
if :bi in keys(out.SS_syms) && :liq in keys(out.SS_syms)
```


The KD expression only makes physical sense when **both biotite and melt are present simultaneously**. If either is absent (e.g., below the solidus where there is no melt, or at very high temperatures where biotite has broken down), the cell stays `NaN` and is skipped.

The `out.SS_syms` dictionary maps phase abbreviations to their index in the solution-phase vector — checking `keys()` is a clean way to test phase presence.

### Evaluating the KD Expression {#Evaluating-the-KD-Expression}

```julia
bi          = out.SS_syms[:bi]
liq         = out.SS_syms[:liq]

XMFe3p      = out.SS_vec[bi].siteFractions[4]
NaK_Almelt  = (out.SS_vec[liq].Comp_apfu[6] + out.SS_vec[liq].Comp_apfu[7]) /
               out.SS_vec[liq].Comp_apfu[2]

ln_D_Li  = c9 + c10*XMFe3p + c11*NaK_Almelt + c12*1e4/(T_C+273.15)
D_bi[i,j] = exp(ln_D_Li)
```


`bi` and `liq` are integer indices into `out.SS_vec`. The relevant quantities are extracted directly from MAGEMin's output structs:
- `siteFractions[4]` — the 4th site in the biotite model corresponds to the Fe³⁺ M-site fraction
  
- `Comp_apfu[6]` and `[7]` — Na and K in atoms per formula unit in the melt
  
- `Comp_apfu[2]` — Al in atoms per formula unit in the melt
  


---


## Step 3 — What the Grid Looks Like {#Step-3-—-What-the-Grid-Looks-Like}

```
  Temperature →  650°C   700°C   750°C   800°C   850°C
                   │       │       │       │       │
  P = 4 kbar  ──  NaN    NaN    D_bi   D_bi   D_bi   ← solidus crossed ~725°C
  P = 8 kbar  ──  NaN    D_bi   D_bi   D_bi   D_bi   ← solidus crossed ~680°C
  P = 12 kbar ──  D_bi   D_bi   D_bi   D_bi   D_bi   ← solidus crossed <650°C
```


Each non-NaN cell holds `exp(ln_D_Li)` computed from MAGEMin's equilibrium assemblage at that (P, T). The NaN cells below the solidus (no melt) or above biotite stability are simply not plotted.


---


## Step 4 — Plotting {#Step-4-—-Plotting}

```julia
plt = plot(xlabel="Temperature [°C]",
           ylabel=L"D^{\mathrm{bi/melt}}_{\mathrm{Li}}",
           legend=:topright, dpi=300)

for i in eachindex(P)
    plot!(plt, T, D_bi[i, :], label="P = $(P[i]) kbar", linewidth=2.)
end

savefig(plt, "D_Li_Bi_Beard.png")
```


One curve per pressure is plotted. The y-axis label uses a LaTeX string (`L"..."`) for the proper symbol D^{bi/melt}_{Li}. NaN values in `D_bi` are automatically skipped by Plots.jl, so each curve only appears where both biotite and melt coexist.

The resulting figure shows three curves that together reveal:
- **How much D_bi changes with temperature** (cooling melt becomes more peraluminous, raising D_bi)
  
- **Whether pressure shifts the D_bi curves** (via its effect on the melt composition and biotite Fe³⁺)
  


---


## Data Flow Summary {#Data-Flow-Summary}

```
Setup
│
├── norm2one(bulk)          → normalized pelite composition (20 mol% H₂O)
├── Initialize_MAGEMin()    → single-thread MAGEMin instance
├── D_bi[3, 32] = NaN       → output array, pre-filled with NaN
│
└── for P_i in [4, 8, 12] kbar:
      for T_j in [650 → 850 °C]:
        │
        ├── single_point_minimization(P_i, T_j)
        │       → equilibrium assemblage at (P, T)
        │
        ├── check: :bi AND :liq both present?
        │       → if not, skip (leave NaN)
        │
        ├── extract XMFe3p  from biotite site fractions
        ├── extract NaK/Al  from melt apfu composition
        ├── evaluate: ln_D_Li = c9 + c10·XMFe3p + c11·NaK_Al + c12·1e4/(T+273)
        └── D_bi[i,j] = exp(ln_D_Li)

Plot
└── one curve per pressure → D_Li_Bi_Beard.png
```



---


## Connection to the Main Scripts {#Connection-to-the-Main-Scripts}

This script exists to **validate and visualize** the biotite KD that is used internally by the `"MM"` model in `compute_P-H2O_systematics.jl` and `compute_systematics_FS.jl`. In those scripts, the same expression is encoded as a string and evaluated at runtime by MAGEMin's trace-element engine. Here it is computed explicitly in Julia for transparency and plotting.

The main scripts retrieve `Dbi[i]` in `retrieve_outputs_FS()` via:

```julia
expr   = KDs_database.KDs_expr[2]
Dbi[i] = Base.invokelatest(expr, out)
```


This is computing the exact same formula — but `compute_bi_Li_profiles.jl` does it by hand, making the individual terms (`XMFe3p`, `NaK_Almelt`, `T_C`) directly visible and interpretable.


---


## Running the Script {#Running-the-Script}

```bash
julia compute_bi_Li_profiles.jl
```


No threading flags needed. The script runs in seconds (3 pressures × 32 temperatures = 96 MAGEMin calls). Output is saved as `D_Li_Bi_Beard.png` in the working directory.
