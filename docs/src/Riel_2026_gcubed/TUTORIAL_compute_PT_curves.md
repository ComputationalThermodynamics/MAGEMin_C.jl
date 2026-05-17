# Tutorial: `compute_PT_curves.jl`

## What This Script Does — The Big Picture

> *At what temperatures do successive melt extraction events occur, and how does that change with pressure along a water-saturated pelite solidus?*

This script computes **P–T curves of melt extraction events** — the temperatures at which each successive pulse of melt is extracted from the rock, traced from 2 to 16 kbar along the wet solidus. Rather than mapping a 2D grid or sweeping bulk compositions, it runs **one fractional melting path per pressure point** along the water-saturation curve, then collects the extraction temperatures to reconstruct the P–T trajectory of each melting episode.

The output is a P–T diagram with up to 15 curves, each one tracing the temperature of the 1st, 2nd, ... 15th melt extraction event as a function of pressure.

---

## File Structure

```
compute_PT_curves.jl     ← standalone script
TE_functions.jl          ← norm2one, get_Kds, perform_threaded_calc_EE, water_saturation_curve_FS
TE_functions_FS.jl       ← water_saturation_curve_FS (per-thread, per-sample water saturation)
TE_fractional.jl         ← threaded_frac_melting (fractional melting engine)
plot_figures.jl          ← retrieve_outputs (not used here, but included)
```

---

## Key Concepts Before Diving In

### One Dimension: Pressure

Unlike the P–H₂O script (2D grid) and the FS script (bulk composition sweep), this script has a **single loop axis: pressure**. For each of the `np = 100` pressure points between 2 and 16 kbar, one complete fractional melting simulation is run at the water-saturated condition for that pressure.

### What Is an "Extraction Curve"?

Each fractional melting simulation produces up to `n_ee = 15` extraction events. Each event has a temperature — the temperature at which the melt volume fraction first reaches `e1_liq = 7%`. After collecting all 100 pressure points, we have:

```
              Extraction event #
              1st   2nd   3rd  ...  15th
P = 2  kbar [ T₁,   T₂,   T₃, ..., T₁₅ ]
P = 2.14 kbar[ T₁,   T₂,   T₃, ..., T₁₅ ]
...
P = 16 kbar [ T₁,   T₂,   T₃, ..., T₁₅ ]
```

Plotting column 1 vs. pressure gives the P–T curve of "when does the first melt pulse form?", column 2 gives the second pulse, and so on. Together these 15 curves show how melting progresses through P–T space as the rock heats up.

---

## Step 1 — Setup and Parameters

```julia
model       = "MM"
Li_content  = 100.0       # ppm
Pin         = [2.0, 16.0] # kbar
e1_liq      = 7.0         # vol% melt to trigger extraction
e1_remain   = 1.0         # vol% melt left behind after extraction
np          = 100          # number of pressure points
n_ee        = 15           # max extraction events per pressure
Ex_H2O_sat  = 0.03        # excess H₂O above saturation
```

The bulk composition is the dry Forshaw & Pattison median pelite (H₂O = 0.0 initially). Water is added automatically per pressure point by `perform_threaded_calc_EE()` using the water-saturation logic.

```julia
P = collect(range(2.0, 16.0, 100))   # 100 equally spaced pressures
T = [600.0, 1000.0]                  # temperature bounds for bisection
```

`T` here is just a bracket for the internal bisection — not a grid axis.

---

## Step 2 — Threaded Calculation via `perform_threaded_calc_EE()`

**File:** `TE_functions.jl`, lines 426–485

This is the threaded dispatcher used specifically for the **extraction-event** (EE) mode, where each pressure point gets its own water content computed on-the-fly:

```julia
Out_all = perform_threaded_calc_EE(
    Out_all, data, dtb, P, T, np,
    model,
    e1_liq, e1_remain, sys_in, bulk, Xoxides;
    n_ee       = 15,
    Ex_H2O_sat = 0.03,
    Li_content = Li_content,
    norm_TE    = true )
```

### How Threading Works Here

```
@threads :static for i = 1:np   (np = 100 pressure points)
    │
    ├── get_data_thread(data)               → thread-local MAGEMin state
    ├── water_saturation_curve_FS(...)      → H_ (saturation H₂O at P[i])
    └── threaded_frac_melting(...)          → Li_infos with up to 15 events
```

This is a **1D parallel loop** over pressure, identical in structure to the FS script's loop over bulk compositions. Each thread gets a contiguous block of pressure points. No synchronization needed since each thread writes to a unique index of `Out_all`.

### Water Saturation Per Pressure Point

For each pressure, `water_saturation_curve_FS()` computes the H₂O content at which the rock just saturates, then adds `Ex_H2O_sat = 0.03` mol fraction of excess. This is the same per-thread, per-sample saturation logic used in the FS script, but here the variable is pressure (not bulk composition).

### What `perform_threaded_calc_EE()` Returns vs. `perform_threaded_calc()`

| | `perform_threaded_calc()` (P–H₂O script) | `perform_threaded_calc_EE()` (this script) |
|---|---|---|
| Loop axis | 1D over flattened P×H grid | 1D over P |
| Water content | Passed from precomputed PCHIP interpolant | Computed from scratch per thread |
| KD database | Passed in | Created inside the loop from `model` string |
| Filter | Skip cells far from saturation | No filter — all points are on the saturation curve |

---

## Step 3 — Extracting Extraction Temperatures

After the threaded calculation, the `Out_all[np]` array holds one `Li_infos` struct per pressure point. Each struct contains up to 15 pairs of MAGEMin outputs (pre- and post-extraction). The post-processing loop reads out the temperature of each extraction event:

```julia
for i = 1:np
    # Count how many valid extraction steps were stored
    nval_points = 0
    for o = 2:length(Out_all[i].ext_out_te)
        if !isassigned(Out_all[i].ext_out_te, o)
            break
        else
            nval_points = o
        end
    end

    if nval_points >= 2
        T = [Out_all[i].ext_out[k].T_C for k = 2:2:nval_points]
        push!(Extract_events, T)
    else
        push!(Extract_events, NaN)
    end
end
```

The even-indexed steps (`k = 2, 4, 6, ...`) are the extraction snapshots (odd indices are the post-extraction residual states — see the fractional melting engine tutorial). `T_C` is the temperature in °C at the moment of extraction.

`Extract_events` ends up as a vector of vectors — one inner vector per pressure, each holding up to 15 temperatures:

```
Extract_events[1]  = [T₁, T₂, T₃, ..., T₁₅]   ← P = 2.0 kbar
Extract_events[2]  = [T₁, T₂, T₃, ..., T₁₄]   ← P = 2.14 kbar (only 14 events converged)
Extract_events[50] = [T₁, T₂, T₃, ..., T₁₀]   ← P = 9.0 kbar (fewer events possible)
...
```

---

## Step 4 — Assembling the `T_curves` Matrix

The jagged vector of vectors is packed into a rectangular matrix for easy plotting:

```julia
max_len  = maximum(length.(Extract_events))   # find longest event list
T_curves = fill(NaN, np, max_len)             # pre-fill with NaN

for i in 1:np
    nl = length(Extract_events[i])
    T_curves[i, 1:nl] = Extract_events[i]    # fill only the valid entries
end
```

The result is an `np × max_len` matrix where:
- **Rows** = pressure points (2 to 16 kbar)
- **Columns** = extraction event number (1st, 2nd, ..., up to 15th)
- **Values** = extraction temperature in °C, or `NaN` where that event did not occur

```
              col 1   col 2   col 3  ...  col 15
row 1  (2 kbar) [ 735,    762,    791, ...,  NaN ]
row 2  (2.14 kbar)[ 737,    765,    793, ...,  NaN ]
...
row 50 (9 kbar) [ 698,    722,    748, ...,  NaN ]
...
row 100(16 kbar)[ 672,    694,    718, ...,  892 ]
```

NaN entries at higher event numbers reflect pressure points where the melting sequence exhausted biotite or stalled before reaching 15 events.

---

## Step 5 — Plotting

```julia
plot(T_curves[:,1],  P)
plot!(T_curves[:,2], P)
...
plot!(T_curves[:,15], P)

plot!(xlabel="T (°C)", ylabel="P (GPa)",
      ylims=(2, 16), xlims=(650, 1000),
      legend=:topright, dpi=300)

savefig("wat_phase_stability_EE-T_+0.03.svg")
```

Each column of `T_curves` is a curve in P–T space. Column 1 is the **wet solidus curve** (the temperature at which the first 7% melt forms), column 2 is the second extraction threshold, and so on. NaN values cause automatic gaps in the curves where events didn't converge.

### What the Plot Looks Like

```
P (kbar)
  │
16│      ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  │     ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
12│    ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  │   ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
 8│  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  │ ·  ·  ·  ·  ·  ·  ·  ·  ·
 4│·  ·  ·  ·  ·  ·
  │
  └────────────────────────────── T (°C)
   650        750        850        1000
   ↑           ↑
   wet         curves fan out to the right
   solidus     as successive events require
   (col 1)     progressively more heating
```

Each curve shifts to the right (higher temperature) because after each melt extraction, the residual bulk is depleted in fusible components and needs more heat to generate the next 7% melt.

---

## Data Flow Summary

```
Setup
│
├── norm2one(bulk)               → dry pelite bulk (H₂O = 0)
├── Initialize_MAGEMin()         → threaded MAGEMin data
├── Out_all[np]                  → pre-allocated output array
│
└── perform_threaded_calc_EE()   → Out_all[np]
      │
      └── @threads :static for i = 1:np
            ├── get_data_thread(data)
            ├── water_saturation_curve_FS(P[i], bulk) → H_ (saturation H₂O at this P)
            └── threaded_frac_melting(P[i], H_, n_ee=15) → Li_infos
                  └── up to 15 extraction events, each with T_C stored

Post-processing
│
├── for i = 1:np:
│     count valid extraction steps
│     T = [ext_out[2].T_C, ext_out[4].T_C, ..., ext_out[2n].T_C]
│     push!(Extract_events, T)
│
└── pack into T_curves[np, max_len]   (NaN where events absent)

Plotting
└── for col = 1:15: plot(T_curves[:,col], P)
    → wat_phase_stability_EE-T_+0.03.svg
```

---

## Connection to the Other Scripts

| Script | Uses `threaded_frac_melting`? | What varies | Purpose |
|--------|------------------------------|-------------|---------|
| `compute_P-H2O_systematics.jl` | Yes | P × H₂O grid | Map Li enrichment in P–H₂O space |
| `compute_systematics_FS.jl` | Yes | Real bulk compositions | Map Li enrichment vs. rock chemistry |
| `compute_PT_curves.jl` | Yes | Pressure along saturation curve | Map P–T positions of extraction events |
| `compute_bi_Li_profiles.jl` | No | P × T grid | Visualize biotite KD variation |

This script shares the same fractional melting engine as the two main scripts, but uses `perform_threaded_calc_EE()` — the variant that recomputes water saturation per thread rather than reading from a precomputed interpolant.

---

## Running the Script

```bash
julia --threads 8 compute_PT_curves.jl
```

Output is saved as `wat_phase_stability_EE-T_+0.03.svg` in the working directory. The `+0.03` in the filename reflects the `Ex_H2O_sat = 0.03` excess water parameter — rerunning with different values produces comparable files without overwriting.
