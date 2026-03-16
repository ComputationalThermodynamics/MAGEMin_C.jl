# MAGEMin_C Li partitioning, fractional melting

## Table of contents
- [1. Create a new script](#1-create-a-new-script)
- [2. Use partitioning_batch_melting.jl as starting point](#2-use-partitioning_batch_meltingjl-as-starting-point)
- [3. Fractional melting](#3-fractional-melting)
- [Exercises](#exercises)
    - [E.1. Lithium partitioning](#e1-lithium-partitioning)
    - [E.2. Visualization](#e2-visualization)
    - [E.3. Role of partition coefficient set and pressure](#e3-role-of-partition-coefficient-set-and-pressure)

- The objective of this tutorial is to build upon the batch melting lithium partitioning example and update it to model fractional melting.

### 1. Create a new script

```shell
code MAGEMin_C_Li_partitioning_fractional_melting.jl
```

### 2. Use partitioning_batch_melting.jl as starting point

- Copy and paste the partition batch melting model definition part:

```julia
using MAGEMin_C, Plots, ProgressMeter
include("functions.jl")

dtb         = "mp"
KD_set      = "KO" #or "BA"
data        =  Initialize_MAGEMin(dtb, verbose=false);

X           = [0.5922, 0.1813, 0.006, 0.0223, 0.0633, 0.0365, 0.0127, 0.0084, 0.0016, 0.0007, 0.075]
Xoxides     = ["SiO2", "Al2O3", "CaO", "MgO", "FeO", "K2O", "Na2O", "TiO2", "O", "MnO", "H2O"]
sys_unit    = "wt"

P           = 5.0
T_step      = 2.0
T           = [600:T_step:1000;]
n_calc      = length(T)

Out_XY      = Vector{out_struct}(undef,n_calc)
Out_TE_XY   = Vector{out_TE_struct}(undef,n_calc)


el          = ["Li"]
ph          = ["afs", "amp", "bi", "cpx", "cd", "g", "hem", "ilm", "ky", "mt", "mu", "opx", "pl", "q", "ru", "sill"]

if KD_set == "KO"
    KDs     = ["0.01";  "1e-4";  "1.67"; "1e-4";  "0.44"; "1e-4"; "1e-4"; "1e-4";  "1e-4"; "1e-4"; "0.82"; "1e-4";  "0.02"; "1e-4"; "1e-4"; "1e-4"]
elseif KD_set == "BA"
    KDs     = ["1e-4"; "1e-4"; "0.55"; "1e-4"; "1.10"; "0.09"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "0.11"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"]
end

C_te        = [400.0]       #starting mass fraction of elements in ppm (ug/g)
KDs_dtb     = create_custom_KDs_database(el, ph, KDs)
```

### 3. Fractional melting

- Add the fractional melting block from `MAGEMin_C_Li_partitioning_batch_melting.m` section 5 (Tracking the evolution of the system mass):

```julia
MCT             = 0.07

M_system        = 1.0                      # track mass relative to original
extracted_M_wt  = zeros(Float64, n_calc)
M_system_evol   = zeros(Float64, n_calc)

residual_comp_wt = copy(X)
 #= TO BE COMPLETED =#
@showprogress for i in 1:n_calc
    Out_XY[i]       = single_point_minimization(P, T[i], data, X=residual_comp_wt, Xoxides=Xoxides, sys_in=sys_unit, name_solvus = true, scp=1)
    #= TO BE COMPLETED =#

    # mass per unit volume of each sub-system
    m_M     = Out_XY[i].rho_M * Out_XY[i].frac_M_vol
    m_S     = Out_XY[i].rho_S * Out_XY[i].frac_S_vol
    m_total = m_M + m_S

    if Out_XY[i].frac_M_vol > MCT
        m_M_retained     = Out_XY[i].rho_M * MCT
        m_extracted      = Out_XY[i].rho_M * (Out_XY[i].frac_M_vol - MCT)

        # extracted melt as fraction of original system mass
        extracted_M_wt[i] = (m_extracted / m_total) * M_system

        # update remaining system mass
        M_system -= extracted_M_wt[i]

        # residual = retained melt + solid
        residual_comp_wt = m_M_retained .* Out_XY[i].bulk_M_wt .+ m_S .* Out_XY[i].bulk_S_wt
        #= TO BE COMPLETED =#

    else
        residual_comp_wt = m_M .* Out_XY[i].bulk_M_wt .+ m_S .* Out_XY[i].bulk_S_wt
        #= TO BE COMPLETED =#
    end

    M_system_evol[i] = M_system
    Xoxides          = Out_XY[i].oxides
end
```

- While the previous block handles fractional melting when melt fraction reaches the melt connectivity threshold (MCT), Li partitioning is not yet accounted for.

## Exercises

### E.1. Lithium partitioning

- Add Li partitioning to the fractional melting calculation:
    - Define `residual_TE_comp = copy(C_te)` before the iteration loop
    - After `single_point_minimization()` add `Out_TE_XY[i]    = TE_prediction(Out_XY[i], residual_TE_comp, KDs_dtb, dtb)`
    - Add to the `if, else` statement the update of the `residual_TE_comp` in a similar way as for the bulk-rock composition (do not normalize here!)

- Perform calculation using MCT = 0.07, KO Li partition coefficient set and display melt Li enrichment. 
    This gives:

```@raw html
<p align="center">
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/2026_Beijing_pictures/Li_frac_melting.png?raw=true" alt="Julia REPL" width="500">
</p>
```

- How does that compare with the batch melting experiment?

### E.2. Visualization

- Using the function from batch melting partitioning example, plot the evolution of the lithium enrichment of melt, biotite, plagioclase, cordierite, and muscovite. This should give something similar to:

```@raw html
<p align="center">
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/2026_Beijing_pictures/Li_frac_melting_phases.png?raw=true" alt="Julia REPL" width="500">
</p>
```

### E.3. Role of partition coefficient set and pressure

- Perform the calculation using both BA and KO sets of partition coefficients at different pressures. How different are the results compared to the batch melting experiments?


### 4. Non-linear partition coefficient model
- While using constant partition coefficients is helpful to investigate the first order evolution of the Li mass fraction during partial melting, this is certainly a strong simplification as partition coefficient are known to be pressure, temperature as well as composition dependent.

- For Lithium partitioning a recently published study (Beard et al., 2026; in press) has provided a new temperature and composition-dependent model for Li partitioning between biotite and melt:

```@raw html
<p align="center">
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/2026_Beijing_pictures/Beard_bi.png?raw=true" alt="Julia REPL" width="500">
</p>
```

where $X^{T}_{Si}$ is the fraction of $Si^{4+}$ cation on biotite site $T$ and $T_K$ is temperature in Kelvin.

- MAGEMin_C allows the user to provide expressions for non-linear partition coefficient models. For instance starting from the definition of the partition coefficients as in tutorial `MAGEMin_C_Li_partitionig.jl`:

```julia
el      = ["Li"]
ph      = ["afs", "amp", "bi", "cpx", "cd", "g", "hem", "ilm", "ky", "mt", "mu", "opx", "pl", "q", "ru", "sill"]
KDs     = ["0.01";  "1e-4";  "1.67"; "1e-4";  "0.44"; "1e-4"; "1e-4"; "1e-4";  "1e-4"; "1e-4"; "0.82"; "1e-4";  "0.02"; "1e-4"; "1e-4"; "1e-4"]
```

When wanting to update the partition coefficient expression for `bi` one would need to replace the `".67` entry in the KDs `Vector{String}` to:

```julia
KDs     = ["0.01";  "1e-4";  bi_exp; "1e-4";  "0.44"; "1e-4"; "1e-4"; "1e-4";  "1e-4"; "1e-4"; "0.82"; "1e-4";  "0.02"; "1e-4"; "1e-4"; "1e-4"]
```

where:

```julia
bi_exp  = "y = [:bi].compVariables[3];f = [:bi].compVariables[4]; bi_xSiT = 0.5-f/2.0 - y/2.0;bi_SiT  = (2.0 * bi_xSiT)+2.0; ln_D_Li = (-22.359) + (5.592*bi_SiT) + (10000*0.67*1/(T_C+273.15)); exp(ln_D_Li)"
```      

- Notice that the site fraction $X^{T}_{Si}$ is computed using the composition variables `y` and `f` from biotite (see THERMOCALC formulation for more details)
- Moreover, the formula will be evaluated and turned into a function at compilation time, hence will not decrease the performances of the calculation.

## Exercises

### E.1. Non-linear biotite partition coefficient model
- Using previous expression for the partition coefficient model between biotite and melt for Lithium, update your fractional melting code to use it.

- Perform the calculations using the non-linear $D_{Li}^{bi/melt}$ for both Koopmans (2024) and Ballouard (2023) sets of partition coefficients

- How much control does the non-linear $D_{Li}^{bi/melt}$ model have on the maximum Li enrichment?

