
# MAGEMin_C.jl: Output structures: {#MAGEMin_C.jl:-Output-structures:}

This part decribes the content of the output structure of `MAGEMin_C`. These structures save the results of the phase equilibrium prediction. The first one `MAGEMin_C gmin_struct` stores the result of the minimization while the second one `MAGEMin_C.out_tepm` stores the results of the trace-element partitioning model.

Both of the structures can be (and should be) pre-allocated when performing multiple minimizations. Pre-allocation of the output structures is achieved as:

```julia
Out_XY      = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef,n_calc)
Out_TE_XY   = Vector{MAGEMin_C.out_tepm}(undef,n_calc)
```


where `n_calc` is the number of calculations you want to perform (e.g., the number of steps of a fractional crystallization experiment).

In the most simple form (where we don&#39;t pre-allocate), the output structure `out` is simply returned when the `single_point_minimization()` function is called:

```julia
using MAGEMin_C
data    = Initialize_MAGEMin("ig", verbose=false);
P,T     = 10.0, 1100.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
```


## How to navitage the (nested) structures? {#How-to-navitage-the-nested-structures?}

The content of the output structure `out` can be accessed as any `Julia` structure:

```julia
julia> out.
G_system        Gamma           MAGEMin_ver     M_sys           PP_syms         PP_vec          P_kbar          SS_syms         SS_vec          T_C             V
Vp              Vp_S            Vs              Vs_S            X               aAl2O3          aFeO            aH2O            aMgO            aSiO2           aTiO2
alpha           buffer          buffer_n        bulk            bulkMod         bulkModulus_M   bulkModulus_S   bulk_F          bulk_F_wt       bulk_M          bulk_M_wt
bulk_S          bulk_S_wt       bulk_res_norm   bulk_wt         dQFM            database        dataset         elements        enthalpy        entropy         fO2
frac_F          frac_F_vol      frac_F_wt       frac_M          frac_M_vol      frac_M_wt       frac_S          frac_S_vol      frac_S_wt       iter            mSS_vec
n_PP            n_SS            n_mSS           oxides          ph              ph_frac         ph_frac_1at     ph_frac_vol     ph_frac_wt      ph_id           ph_id_db
ph_type         rho             rho_F           rho_M           rho_S           s_cp            shearMod        shearModulus_S  sol_name        status          time_ms
```


::: tip Note
- To display the content of the structure in a `julia` terminal after perform the calculation simply type `out.` and then hit `TAB` key. This will display the content of the structure as shown above.
  

:::

The system oxides are stored in `out.oxides`:

```julia
julia> out.oxides
11-element Vector{String}:
"SiO2"
"Al2O3"
"CaO"
"MgO"
"FeO"
"K2O"
"Na2O"
"TiO2"
"O"
"Cr2O3"
"H2O"
```


The list of stable phases can be accessed as:

```julia
julia> out.ph
4-element Vector{String}:
 "ol"
 "spl"
 "cpx"
 "opx"
```


The phase fraction in weight fraction:

```julia
julia> out.ph_frac_wt
4-element Vector{Float64}:
 0.5828145797692089
 0.0329389249905903
 0.1489250586188556
 0.23532143662134522
```


and for instance the content of the solution phase `ol` (olivine) nested strucure as:

```julia
julia> out.SS_vec[1].
Comp                Comp_apfu           Comp_wt             G                   V                   Vp
Vs                  alpha               bulkMod             compVariables       compVariablesNames  cp
deltaG              emChemPot           emComp              emComp_apfu         emComp_wt           emFrac
emFrac_wt           emNames             enthalpy            entropy             f                   rho
shearMod            siteFractions       siteFractionsNames
```


where `[1]` is the index of olivine in the `out.SS_vec` structure. The composition of olivine in weight fraction can be retrieved using:

```julia
julia> out.SS_vec[1].Comp_wt
11-element Vector{Float64}:
 0.40825577403516533
 0.0
 0.00019320141395582851
 0.4913560738016318
 0.10019495074924696
 0.0
 0.0
 0.0
 0.0
 0.0
 0.0
```


The index of a solution-phase can be retrieved using:

```julia
id_ol = nothing
if haskey(out.SS_syms, :ol)
    id_ol = out.SS_syms[:ol]
end
```


and for a pure-phase

```julia
id_ru = nothing
if haskey(id_ru, :ru)
    id_ru = out.PP_syms[:ru]
end
```


were `out.SS_syms` and `out.PP_syms` are symbol dictionaries, linking a phase name to its proper structure index. 

::: tip Note
- In the latter case `ru`(rutile) is not stable, therefore `id_ru = nothing`.
  
- Accessing the phase structure using symbols can be useful for instance when extracting specific phases composition and/or to ease vizualisation.
  

:::

(...)

The list of all entries is presented below and can be accessed (and used) in a similar manner.

Note that you can define the `out` structure as vector or a matrix (or any n-D array). In such cases the information of individual points can be accessed using their index:

```julia
julia> out[i].
```


or

```julia
julia> out[i,j].
```


where `i` and `j` are indices.

## MAGEMin_C gmin_struct {#MAGEMinC-gminstruct}

The main structure stores the properties of the system.

```julia
├─ MAGEMin_ver :: String        # [-]       MAGEMin version 
├─ dataset :: String            # [-]       Used thermodynamic dataset
├─ database :: String           # [-]       Acronym of the thermodynamic database
├─ buffer :: String             # [-]       Used oxygen/activity buffer
├─ buffer_n :: Float64          # [RTlog]   oxygen fugacity offset
├─ G_system :: Float64          # [kJ]      Gibbs energy of the system    
├─ Gamma :: Vector{Float64}     # [kJ]      Chemical potential of system components (oxides e.g, SiO2, Al2O3 etc.)
├─ P_kbar :: Float64            # [kbar]    pressure
├─ T_C :: Float64               # [°C]      temperature
├─ X :: Vector{Float64}         # 0 -> 1    x coordinate used when computing T-X, P-X or PT-X diagrams
├─ M_sys :: Float64             # [g/mol]   normalized molar mass of the bulk rock composition
├─ bulk :: Vector{Float64}      # [mol_i]   bulk rock composition   
├─ bulk_M :: Vector{Float64}    # [mol_i]   bulk mole composition of melt part
├─ bulk_S :: Vector{Float64}    # [mol_i]   bulk mole composition of solid part
├─ bulk_F :: Vector{Float64}    # [mol_i]   bulk mole composition of fluid part
├─ bulk_wt :: Vector{Float64}   # [wt_i]    bulk rock composition  
├─ bulk_M_wt :: Vector{Float64} # [wt_i]    bulk weight composition of melt part
├─ bulk_S_wt :: Vector{Float64} # [wt_i]    bulk weight composition of solid par
├─ bulk_F_wt :: Vector{Float64} # [wt_i]    bulk weight composition of fluid part
├─ frac_M :: Float64            # [mol_i]   melt mole fraction
├─ frac_S :: Float64            # [mol_i]   solid mole fraction
├─ frac_F :: Float64            # [mol_i]   fluid/H2O mole fraction
├─ frac_M_wt :: Float64         # [wt_i]    melt weight fraction
├─ frac_S_wt :: Float64         # [wt_i]    solid weight fraction
├─ frac_F_wt :: Float64         # [wt_i]    fluid/H2O weight fraction
├─ frac_M_vol :: Float64        # [vol_i]   melt volume fraction
├─ frac_S_vol :: Float64        # [vol_i]   solid volume fraction
├─ frac_F_vol :: Float64        # [vol_i]   fluid volume fraction
├─ alpha :: Vector{Float64}     # [1/K]     thermal expansivity
├─ V :: Float64                 # [cm^3/mol]system volume
├─ s_cp :: Vector{Float64}      # [kJ/K/kg] specific heat capacity
├─ rho :: Float64               # [kg/m^3]  system density
├─ rho_M :: Float64             # [kg/m^3]  melt density
├─ rho_S :: Float64             # [kg/m^3]  solid density
├─ rho_F :: Float64             # [kg/m^3]  fluid/H2O density
├─ fO2 :: Float64               # [-]       oxygen fugacity
├─ dQFM :: Float64              # [-]       oxygen fugacity offset from QFM buffer
├─ aH2O :: Float64              # [-]       system H2O activity
├─ aSiO2 :: Float64             # [-]       system SiO2 activity
├─ aTiO2 :: Float64             # [-]       system TiO2 activity
├─ aAl2O3 :: Float64            # [-]       system Al2O3 activity
├─ aMgO :: Float64              # [-]       system MgO activity
├─ aFeO :: Float64              # [-]       system FeO activity
├─ n_PP :: Int64                # [-]       number of stable pure phases
├─ n_SS :: Int64                # [-]       number of stables solution phases
├─ n_mSS :: Int64               # [-]       number of metastable phases (used for initial guess)
├─ ph_frac :: Vector{Float64}   # [mol_i]   phases mole fraction
├─ ph_frac_wt :: Vector{Float64}    # [wt_i]    phases weight fraction
├─ ph_frac_1at :: Vector{Float64}   # [mol_i 1at]   phase mole fraction on a 1 atom basis
├─ ph_frac_vol :: Vector{Float64}   # [vol_i]   phase volume fraction
├─ ph_type :: Vector{Int64}     # [0,1]     phase type: 0 -> pure phase, 1 -> solution phase
├─ ph_id :: Vector{Int64}       # [0-n]     phase id 
├─ ph_id_db :: Vector{Int64}    # [0-m]     phase id as in the C code
├─ ph :: Vector{String}         # [-]       acronym of the stable phases
├─ sol_name :: Vector{String}   # [-]       stable solution phases acronym with version
├─ SS_syms :: Dict{Symbol, Int64}   # [-]       symbol list for stable solution phases, returns the ph_id number of corresponding solution phase
├─ PP_syms :: Dict{Symbol, Int64}   # [-]       symbol list for stable pure phases, returns the ph_id number of corresponding pure phase
├─ SS_vec :: Vector{MAGEMin_C.LibMAGEMin.SS_data}   # [-] vector of solution phase structures, storing the informations related to solution phases
├─ mSS_vec :: Vector{MAGEMin_C.LibMAGEMin.mSS_data} # [-] vector of metastable phase structures, storing the informations related to metastable solution phases
├─ PP_vec :: Vector{MAGEMin_C.LibMAGEMin.PP_data}   # [-] vector of pure phase structures, storing the informations related to pures phases
├─ oxides :: Vector{String}     # [-]       list of oxides names
├─ elements :: Vector{String}   # [-]       list of elements
├─ Vp :: Float64                # [km/s]    P-wave system velocity
├─ Vs :: Float64                # [km/s]    S-wave system velocity
├─ Vp_S :: Float64              # [km/s]    P-wave solid velocity
├─ Vs_S :: Float64              # [km/s]    S-wave solid velocity
├─ bulkMod :: Float64           # [GPa]     system bulk modulus
├─ shearMod :: Float64          # [GPa]     system shear modulus
├─ bulkModulus_M :: Float64     # [GPa]     melt bulk modulus
├─ bulkModulus_S :: Float64     # [GPa]     solid bulk modulus
├─ shearModulus_S :: Float64    # [GPa]     solid shear modulus
├─ entropy :: Float64           # [J/K]     system entropy
├─ enthalpy :: Float64          # [J]       system enthalpy
├─ iter :: Int64                # [-]       number of iterations to reach convergence
├─ bulk_res_norm :: Float64     # [-]       bulk rock composition residual
├─ time_ms :: Float64           # [ms]      solution time
├─ status :: Int64              # [-]       status of the minimization (Success,Relaxed1,Relaxed2,Failure)
```


### SS_vec {#SS_vec}

This sub-structure stores the properties of the stable solution phases.

```julia
├─ SS_vec :: Vector{MAGEMin_C.LibMAGEMin.SS_data}
    ├─ f :: Float64             # [-]       normalization factor to convert from mole to mole on 1 atom basis
    ├─ G :: Float64             # [kJ/f]    Gibbs energy, has to be multiplied by f (normalization factor) to be in [kJ]
    ├─ deltaG :: Float64        # [kJ]      driving force (distance from the Gibbs hyperplane)
    ├─ V :: Float64             # [cm^3/mol]volume
    ├─ alpha :: Float64         # [1/K]     thermal expansivity
    ├─ entropy :: Float64       # [J/K]     entropy
    ├─ enthalpy :: Float64      # [J]       enthalpy
    ├─ cp :: Float64            # [kJ/K/Kg] specific heat capacity
    ├─ rho :: Float64           # [kg/m^3]  density
    ├─ bulkMod :: Float64       # [GPa]     bulk modulus
    ├─ shearMod :: Float64      # [GPa]     bulk modulus
    ├─ Vp :: Float64            # [km/s]    P-wave system velocity
    ├─ Vs :: Float64            # [km/s]    S-wave system velocity
    ├─ Comp :: Vector{Float64}          # [mol_i]    composition in mole fracton
    ├─ Comp_wt :: Vector{Float64}       # [wt_i]     composition in weight fraction
    ├─ Comp_apfu :: Vector{Float64}     # [apfu]     composition in atim per formula unit
    ├─ compVariables :: Vector{Float64}         # [-]       compositional variables as described in THERMOCALC (https://hpxeosandthermocalc.org/the-thermocalc-software/)
    ├─ compVariablesNames :: Vector{String}     # [-]       compositional names
    ├─ siteFractions :: Vector{Float64}         # [-]       site fractions
    ├─ siteFractionsNames :: Vector{String}     # [-]       site fractions names
    ├─ emNames :: Vector{String}                # [-]       names of the end-members
    ├─ emFrac :: Vector{Float64}                # [mol_i]   end-members fraction in mole
    ├─ emFrac_wt :: Vector{Float64}             # [wt_i]    end-members fraction in weight
    ├─ emChemPot :: Vector{Float64}             # [kJ]      driving force (distance from the Gibbs hyperplane)
    ├─ emComp :: Vector{Vector{Float64}}        # [mol_i]   composition of the endmembers in mole fracton
    ├─ emComp_wt :: Vector{Vector{Float64}}     # [wt_i]    composition of the endmembers in weight fracton
    ├─ emComp_apfu :: Vector{Vector{Float64}}   # [-]       composition of the endmembers in atom per formula unit
```


### PP_vec {#PP_vec}

This sub-structure stores the properties of the stable pure phases.

```julia
├─ PP_vec :: Vector{MAGEMin_C.LibMAGEMin.PP_data}
    ├─ f :: Float64         # [-]       normalization factor to convert from mole to mole on 1 atom basis
    ├─ G :: Float64         # [kJ/f]    Gibbs energy, has to be multiplied by f (normalization factor) to be in [kJ]
    ├─ deltaG :: Float64    # [kJ]      distance from the Gibbs hyperplane
    ├─ V :: Float64         # [cm^3/mol]volume
    ├─ alpha :: Float64     # [1/K]     thermal expansivity
    ├─ entropy :: Float64   # [J/K]     entropy
    ├─ enthalpy :: Float64  # [J]       enthalpy
    ├─ cp :: Float64        # [kJ/K/Kg] specific heat capacity
    ├─ rho :: Float64       # [kg/m^3]  density
    ├─ bulkMod :: Float64   # [GPa]     bulk modulus
    ├─ shearMod :: Float64  # [GPa]     bulk modulus
    ├─ Vp :: Float64        # [km/s]    P-wave system velocity
    ├─ Vs :: Float64        # [km/s]    S-wave system velocity
    ├─ Comp :: Vector{Float64}          # [mol_i]    composition in mole fracton
    ├─ Comp_wt :: Vector{Float64}       # [wt_i]     composition in weight fraction
    ├─ Comp_apfu :: Vector{Float64}     # [apfu]     composition in atim per formula unit
```


### mSS_vec {#mSS_vec}

This sub-structure stores the properties of the metastable assemblage i.e., the informations of the phases not far from the Gibbs hyperplane.

```julia
├─ mSS_vec :: Vector{MAGEMin_C.LibMAGEMin.mSS_data}
    ├─ ph_name :: String            # [-]       name of the phases
    ├─ ph_type :: String            # [-]       type of the phase "ss" or "pp"
    ├─ info :: String               # [-]       origin of the phase in terms of minimization stage
    ├─ ph_id :: Int32               # [-]       id of the phase in the C code
    ├─ em_id :: Int32               # [-]       if end-member, id of the end-member
    ├─ n_xeos :: Int32              # [-]       number of compositional variables
    ├─ n_em :: Int32                # [-]       number of endmembers (n_xeos +1)
    ├─ G_Ppc :: Float64             # [-]       Gibbs energy of the pseudocompound
    ├─ DF_Ppc :: Float64            # [-]       driving force of the pseudocompound (distance from the Gibbs hyperplane)
    ├─ comp_Ppc :: Vector{Float64}  # [mol_i]   composition of the pseudocompound
    ├─ p_Ppc :: Vector{Float64}     # [mol_i]   end-member fractions of the pseudocompound
    ├─ mu_Ppc :: Vector{Float64}    # [kJ/f]    chemical potentials of the end-members
    ├─ xeos_Ppc :: Vector{Float64}  # [-]       compositional variables
```


## MAGEMin_C.out_tepm {#MAGEMinC.outtepm}

This sub-structure stores the properties of the trace elements and accessory minerals.

```julia
├─ elements :: Union{Nothing, Vector{String}}       # [-]       trace-elements names
├─ C0 :: Union{Nothing, Vector{Float64}}            # [ug/g]    trace-elements concentration
├─ Cliq :: Union{Nothing, Vector{Float64}}          # [ug/g]    trace-elements concentration in the melt
├─ Csol :: Union{Nothing, Vector{Float64}}          # [ug/g]    trace-elements concentration in the solid
├─ Cmin :: Union{Nothing, Matrix{Float64}}          # [ug/g]    trace-elements concentration in the stable phases
├─ ph_TE :: Union{Nothing, Vector{String}}          # [-]       names of the trace-elements-bearing phases (defined when settings the KDs)
├─ ph_wt_norm :: Union{Nothing, Vector{Float64}}    # [wt_i]    normalized weight fraction of the trace-elements-bearing phases (renormalized as KDs are not necessarily given for all phases)
├─ liq_wt_norm :: Union{Nothing, Float64}           # [wt_i]    normalized weight melt fraction
├─ Cliq_Zr :: Union{Nothing, Float64}               # [ug/g]    zirconium concentration in the liq (if Zr provided)
├─ Sat_zr_liq :: Union{Nothing, Float64}            # [ug/g]    zirconium saturation of the melt (computed using several saturation models)
├─ zrc_wt :: Union{Nothing, Float64}                # [wt%]     calculated zircon weight%
├─ bulk_cor_wt :: Union{Nothing, Vector{Float64}}   # [wt_i]    corrected bulk rock composition after zircon crystallization
```

