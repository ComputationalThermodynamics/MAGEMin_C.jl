# MAGEMin_C.jl: MAGEMin_C output structures:

Full description of the content of `MAGEMin_C` output structures, for phase equilibrium calculations and trace element predictions modeling.

## MAGEMin_C gmin_struct

```julia
├─ MAGEMin_ver :: String
├─ dataset :: String
├─ database :: String
├─ buffer :: String
├─ buffer_n :: Float64
├─ G_system :: Float64
├─ Gamma :: Vector{Float64}
├─ P_kbar :: Float64
├─ T_C :: Float64
├─ X :: Vector{Float64}
├─ M_sys :: Float64
├─ bulk :: Vector{Float64}
├─ bulk_M :: Vector{Float64}
├─ bulk_S :: Vector{Float64}
├─ bulk_F :: Vector{Float64}
├─ bulk_wt :: Vector{Float64}
├─ bulk_M_wt :: Vector{Float64}
├─ bulk_S_wt :: Vector{Float64}
├─ bulk_F_wt :: Vector{Float64}
├─ frac_M :: Float64
├─ frac_S :: Float64
├─ frac_F :: Float64
├─ frac_M_wt :: Float64
├─ frac_S_wt :: Float64
├─ frac_F_wt :: Float64
├─ frac_M_vol :: Float64
├─ frac_S_vol :: Float64
├─ frac_F_vol :: Float64
├─ alpha :: Vector{Float64}
├─ V :: Float64
├─ s_cp :: Vector{Float64}
├─ rho :: Float64
├─ rho_M :: Float64
├─ rho_S :: Float64
├─ rho_F :: Float64
├─ fO2 :: Float64
├─ dQFM :: Float64
├─ aH2O :: Float64
├─ aSiO2 :: Float64
├─ aTiO2 :: Float64
├─ aAl2O3 :: Float64
├─ aMgO :: Float64
├─ aFeO :: Float64
├─ n_PP :: Int64
├─ n_SS :: Int64
├─ n_mSS :: Int64
├─ ph_frac :: Vector{Float64}
├─ ph_frac_wt :: Vector{Float64}
├─ ph_frac_1at :: Vector{Float64}
├─ ph_frac_vol :: Vector{Float64}
├─ ph_type :: Vector{Int64}
├─ ph_id :: Vector{Int64}
├─ ph_id_db :: Vector{Int64}
├─ ph :: Vector{String}
├─ sol_name :: Vector{String}
├─ SS_syms :: Dict{Symbol, Int64}
├─ PP_syms :: Dict{Symbol, Int64}
├─ SS_vec :: Vector{MAGEMin_C.LibMAGEMin.SS_data}
├─ mSS_vec :: Vector{MAGEMin_C.LibMAGEMin.mSS_data}
├─ PP_vec :: Vector{MAGEMin_C.LibMAGEMin.PP_data}
├─ oxides :: Vector{String}
├─ elements :: Vector{String}
├─ Vp :: Float64
├─ Vs :: Float64
├─ Vp_S :: Float64
├─ Vs_S :: Float64
├─ bulkMod :: Float64
├─ shearMod :: Float64
├─ bulkModulus_M :: Float64
├─ bulkModulus_S :: Float64
├─ shearModulus_S :: Float64
├─ entropy :: Float64
├─ enthalpy :: Float64
├─ iter :: Int64
├─ bulk_res_norm :: Float64
├─ time_ms :: Float64
├─ status :: Int64
```

### SS_vec

```julia
├─ SS_vec :: Vector{MAGEMin_C.LibMAGEMin.SS_data}
    ├─ f :: Float64
    ├─ G :: Float64
    ├─ deltaG :: Float64
    ├─ V :: Float64
    ├─ alpha :: Float64
    ├─ entropy :: Float64
    ├─ enthalpy :: Float64
    ├─ cp :: Float64
    ├─ rho :: Float64
    ├─ bulkMod :: Float64
    ├─ shearMod :: Float64
    ├─ Vp :: Float64
    ├─ Vs :: Float64
    ├─ Comp :: Vector{Float64}
    ├─ Comp_wt :: Vector{Float64}
    ├─ Comp_apfu :: Vector{Float64}
    ├─ compVariables :: Vector{Float64}
    ├─ compVariablesNames :: Vector{String}
    ├─ siteFractions :: Vector{Float64}
    ├─ siteFractionsNames :: Vector{String}
    ├─ emNames :: Vector{String}
    ├─ emFrac :: Vector{Float64}
    ├─ emFrac_wt :: Vector{Float64}
    ├─ emChemPot :: Vector{Float64}
    ├─ emComp :: Vector{Vector{Float64}}
    ├─ emComp_wt :: Vector{Vector{Float64}}
    ├─ emComp_apfu :: Vector{Vector{Float64}}
```

### PP_vec

```julia
├─ PP_vec :: Vector{MAGEMin_C.LibMAGEMin.PP_data}
    ├─ f :: Float64
    ├─ G :: Float64
    ├─ deltaG :: Float64
    ├─ V :: Float64
    ├─ alpha :: Float64
    ├─ entropy :: Float64
    ├─ enthalpy :: Float64
    ├─ cp :: Float64
    ├─ rho :: Float64
    ├─ bulkMod :: Float64
    ├─ shearMod :: Float64
    ├─ Vp :: Float64
    ├─ Vs :: Float64
    ├─ Comp :: Vector{Float64}
    ├─ Comp_wt :: Vector{Float64}
    ├─ Comp_apfu :: Vector{Float64}
```

### mSS_vec

```julia
├─ mSS_vec :: Vector{MAGEMin_C.LibMAGEMin.mSS_data}
    ├─ ph_name :: String
    ├─ ph_type :: String
    ├─ info :: String
    ├─ ph_id :: Int32
    ├─ em_id :: Int32
    ├─ n_xeos :: Int32
    ├─ n_em :: Int32
    ├─ G_Ppc :: Float64
    ├─ DF_Ppc :: Float64
    ├─ comp_Ppc :: Vector{Float64}
    ├─ p_Ppc :: Vector{Float64}
    ├─ mu_Ppc :: Vector{Float64}
    ├─ xeos_Ppc :: Vector{Float64}
```

## MAGEMin_C.out_tepm

```julia
├─ elements :: Union{Nothing, Vector{String}}
├─ C0 :: Union{Nothing, Vector{Float64}}
├─ Cliq :: Union{Nothing, Vector{Float64}}
├─ Csol :: Union{Nothing, Vector{Float64}}
├─ Cmin :: Union{Nothing, Matrix{Float64}}
├─ ph_TE :: Union{Nothing, Vector{String}}
├─ ph_wt_norm :: Union{Nothing, Vector{Float64}}
├─ liq_wt_norm :: Union{Nothing, Float64}
├─ Cliq_Zr :: Union{Nothing, Float64}
├─ Sat_zr_liq :: Union{Nothing, Float64}
├─ zrc_wt :: Union{Nothing, Float64}
├─ bulk_cor_wt :: Union{Nothing, Vector{Float64}}
```