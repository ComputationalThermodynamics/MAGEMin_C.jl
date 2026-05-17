
# Thermodynamic modelling of Li enrichment during partial melting: the importance of partition coefficients {#Thermodynamic-modelling-of-Li-enrichment-during-partial-melting:-the-importance-of-partition-coefficients}
<img src="../assets/Figure_MM-71-PH_T.png" alt="Density evolution" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">


This section accompanies **Riel et al. (2026, Geochemistry, Geophysics, Geosystems)** and provides fully reproducible tutorial scripts for modelling lithium (Li) enrichment during partial melting of pelitic rocks. All calculations use `MAGEMin_C.jl` for thermodynamic equilibrium and a custom trace-element partitioning engine built on top of it.

## Scientific context {#Scientific-context}

When crustal rocks partially melt, Li is redistributed between minerals and the melt. This section explores how Li concentrations in granitic melts depend on:
- Pressure and water content of the source rock (P–H₂O space)
  
- The number and size of successive melt extraction events (fractional melting)
  
- The natural variability of pelite bulk compositions (Forshaw &amp; Pattison 2023 database)
  

## Tutorial overview {#Tutorial-overview}

The tutorials are organized from single-condition diagnostics to large multi-sample sweeps:

::: tip Info
- [1. P–H₂O systematics](TUTORIAL_compute_PH2O_systematics.md)
  
- [2. P–T extraction curves](TUTORIAL_compute_PT_curves.md)
  
- [3. Stepwise batch melting](TUTORIAL_compute_plot_stepwise_batch_melting.md)
  
- [4. Biotite Li profiles](TUTORIAL_compute_bi_Li_profiles.md)
  
- [5. Phase stability](TUTORIAL_compute_plot_phase_stability.md)
  
- [6. Solidus across pelites](TUTORIAL_compute_solidus_FS.md)
  
- [7. Li systematics across pelites](TUTORIAL_compute_systematics_FS.md)
  

:::

::: tip Tip

Tutorials 1–4 work on a single representative pelite composition and are good starting points. Tutorials 6–7 require the Forshaw &amp; Pattison (2023) database and are computationally heavier (multi-threaded, ~600 samples).

:::

## Getting started {#Getting-started}

### 1 — Download the files {#1-—-Download-the-files}

Download all scripts into a single directory on your machine (the shared helper files must be in the same folder as the main scripts).

### 2 — Set up the Julia environment {#2-—-Set-up-the-Julia-environment}

The project ships with a `Project.toml` that pins all required packages. To install them:

```julia
# In the Julia REPL, navigate to the directory containing the scripts
julia> using Pkg
julia> Pkg.activate(".")        # activate the project environment
julia> Pkg.instantiate()        # download and precompile all dependencies
```


Or equivalently from the terminal:

```bash
cd /path/to/scripts
julia --project=. -e "using Pkg; Pkg.instantiate()"
```


### 3 — Run a tutorial script {#3-—-Run-a-tutorial-script}

```bash
# single-threaded scripts (Tutorials 2–4)
julia --project=. compute_PT_curves.jl

# multi-threaded scripts (Tutorials 1, 6–7) — use as many threads as your machine has cores
julia --project=. --threads 8 compute_P-H2O_systematics.jl
```


::: tip Note

Tutorials 6 and 7 sweep ~600 pelite compositions and benefit significantly from multi-threading. Set `--threads` to the number of physical cores available (check with `Sys.CPU_THREADS` in Julia).

:::

## Script files {#Script-files}

All scripts are available for download below. The shared helper files (`TE_functions.jl`, `TE_fractional.jl`, `plot_figures.jl`) are required by most of the main scripts and should be placed in the same directory.

### Main scripts {#Main-scripts}

|                                                                                                                                                                                                                                 Script |   Tutorial |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:| ----------:|
|                     &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_P-H2O_systematics.jl&quot; download&gt;`compute_P-H2O_systematics.jl`&lt;/a&gt; | Tutorial 1 |
|                                     &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_PT_curves.jl&quot; download&gt;`compute_PT_curves.jl`&lt;/a&gt; | Tutorial 2 |
| &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_plot_stepwise_batch_melting.jl&quot; download&gt;`compute_plot_stepwise_batch_melting.jl`&lt;/a&gt; | Tutorial 3 |
|                           &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_bi_Li_profiles.jl&quot; download&gt;`compute_bi_Li_profiles.jl`&lt;/a&gt; | Tutorial 4 |
|               &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_plot_phase_stability.jl&quot; download&gt;`compute_plot_phase_stability.jl`&lt;/a&gt; | Tutorial 5 |
|                                   &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_solidus_FS.jl&quot; download&gt;`compute_solidus_FS.jl`&lt;/a&gt; | Tutorial 6 |
|                           &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/compute_systematics_FS.jl&quot; download&gt;`compute_systematics_FS.jl`&lt;/a&gt; | Tutorial 7 |


### Shared helper files {#Shared-helper-files}

|                                                                                                                                                                                         Script |                                                                     Role |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:| ------------------------------------------------------------------------:|
|       &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/TE_functions.jl&quot; download&gt;`TE_functions.jl`&lt;/a&gt; | Core trace-element functions (KD setup, water saturation, batch melting) |
| &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/TE_functions_FS.jl&quot; download&gt;`TE_functions_FS.jl`&lt;/a&gt; |   Forshaw–Pattison-specific helpers (mol bulk conversion, threaded loop) |
|     &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/TE_fractional.jl&quot; download&gt;`TE_fractional.jl`&lt;/a&gt; |                                       Threaded fractional melting engine |
|       &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/plot_figures.jl&quot; download&gt;`plot_figures.jl`&lt;/a&gt; |                                                  Shared plotting helpers |
| &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/plot_figures_FS.jl&quot; download&gt;`plot_figures_FS.jl`&lt;/a&gt; |                           Forshaw–Pattison scatter and FS-specific plots |
|       &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/plot_bulk_FS.jl&quot; download&gt;`plot_bulk_FS.jl`&lt;/a&gt; |                              Herron diagram and IDW heatmap (Tutorial 6) |


### Environment file {#Environment-file}

|                                                                                                                                                                               File |                                                                                    Description |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:| ----------------------------------------------------------------------------------------------:|
| &lt;a href=&quot;https://raw.githubusercontent.com/ComputationalThermodynamics/MAGEMin_C.jl/main/docs/src/Riel_2026_gcubed/Project.toml&quot; download&gt;`Project.toml`&lt;/a&gt; | Julia package environment — lists all dependencies (MAGEMin_C, Plots, PlotlyJS, DataFrames, …) |

