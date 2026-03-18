
# API {#API}
<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR_data' href='#MAGEMin_C.AMR_data'><span class="jlbinding">MAGEMin_C.AMR_data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
AMR_data
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/AMR.jl#L15-L17" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_Data' href='#MAGEMin_C.MAGEMin_Data'><span class="jlbinding">MAGEMin_C.MAGEMin_Data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
MAGEMin_Data{TypeGV, TypeZB, TypeDB, TypeSplxData}

Mutable structure holding the MAGEMin databases and required structures for every thread.

Fields
------
db : String
    Database name.
gv : TypeGV
    Global variables (one per thread).
z_b : TypeZB
    Bulk info structures (one per thread).
DB : TypeDB
    Database structures (one per thread).
splx_data : TypeSplxData
    Simplex data structures (one per thread).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L489-L506" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.W_data' href='#MAGEMin_C.W_data'><span class="jlbinding">MAGEMin_C.W_data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
W_data{T, I}

Mutable structure holding overriding Margules (Ws) parameters.

Database mapping: 0 = "mp", 1 = "mb", 11 = "mbe", 2 = "ig", 3 = "igad", 4 = "um", 5 = "ume", 6 = "mtl", 7 = "mpe", 8 = "sb11", 9 = "sb21", 10 = "sb24".

Fields
------
dtb : I
    Database identifier.
ss_ids : I
    Solution phase identifier.
n_Ws : I
    Number of Margules parameters.
Ws : Matrix{T}
    Margules parameters matrix (S, T, P × n_Ws).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L515-L532" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.custom_KDs_database' href='#MAGEMin_C.custom_KDs_database'><span class="jlbinding">MAGEMin_C.custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds the partitioning coefficient database
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L154-L156" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.db_infos' href='#MAGEMin_C.db_infos'><span class="jlbinding">MAGEMin_C.db_infos</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
db_infos

Mutable structure holding general information about the thermodynamic database.

Fields
------
db_name : String
    Database short name.
db_info : String
    Database description.
db_dataset : Int64
    Dataset identifier.
dataset_opt : Union{Nothing, Int64, NTuple{5,Int64}, NTuple{4,Int64}}
    Available dataset options.
data_ss : Array{ss_infos}
    Solution phase information array.
ss_name : Array{String}
    Solution phase names.
data_pp : Array{String}
    Pure phase names.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L456-L477" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.gmin_struct' href='#MAGEMin_C.gmin_struct'><span class="jlbinding">MAGEMin_C.gmin_struct</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
gmin_struct{T, I}

Structure that holds the result of the pointwise Gibbs energy minimization.

Fields
------
MAGEMin_ver : String
    MAGEMin version string.
dataset : String
    Dataset name.
database : String
    Database name.
buffer : String
    Buffer type.
buffer_n : T
    Buffer value.
G_system : T
    Gibbs free energy of the system.
Gamma : Vector{T}
    Chemical potentials of oxides.
P_kbar : T
    Pressure [kbar].
T_C : T
    Temperature [°C].
X : Vector{T}
    Compositional variable(s).
M_sys : T
    Molar mass of the system.
bulk : Vector{T}
    Bulk rock composition [mol].
bulk_M : Vector{T}
    Bulk melt composition [mol].
bulk_S : Vector{T}
    Bulk solid composition [mol].
bulk_F : Vector{T}
    Bulk fluid composition [mol].
bulk_wt : Vector{T}
    Bulk rock composition [wt].
bulk_M_wt : Vector{T}
    Bulk melt composition [wt].
bulk_S_wt : Vector{T}
    Bulk solid composition [wt].
bulk_F_wt : Vector{T}
    Bulk fluid composition [wt].
frac_M : T
    Melt fraction [mol].
frac_S : T
    Solid fraction [mol].
frac_F : T
    Fluid fraction [mol].
frac_M_wt : T
    Melt fraction [wt].
frac_S_wt : T
    Solid fraction [wt].
frac_F_wt : T
    Fluid fraction [wt].
frac_M_vol : T
    Melt fraction [vol].
frac_S_vol : T
    Solid fraction [vol].
frac_F_vol : T
    Fluid fraction [vol].
alpha : Vector{T}
    Thermal expansivity.
V : T
    Volume.
s_cp : Vector{T}
    Heat capacity.
rho : T
    System density [kg/m³].
rho_M : T
    Melt density [kg/m³].
rho_S : T
    Solid density [kg/m³].
rho_F : T
    Fluid density [kg/m³].
eta_M : T
    Melt viscosity [Pa·s].
fO2 : T
    Oxygen fugacity.
dQFM : T
    Delta QFM buffer.
aH2O : T
    Activity of H2O.
aSiO2 : T
    Activity of SiO2.
aTiO2 : T
    Activity of TiO2.
aAl2O3 : T
    Activity of Al2O3.
aMgO : T
    Activity of MgO.
aFeO : T
    Activity of FeO.
n_PP : Int64
    Number of pure phases.
n_SS : Int64
    Number of solution phases.
n_mSS : Int64
    Number of metastable solution phases.
ph_frac : Vector{T}
    Phase fractions [mol].
ph_frac_wt : Vector{T}
    Phase fractions [wt].
ph_frac_1at : Vector{T}
    Phase fractions [mol, 1 atom basis].
ph_frac_vol : Vector{T}
    Phase fractions [vol].
ph_type : Vector{I}
    Type of phase (SS or PP).
ph_id : Vector{I}
    Phase identifier.
ph_id_db : Vector{I}
    Phase identifier in database.
ph : Vector{String}
    Phase names.
sol_name : Vector{String}
    Solution phase names.
SS_syms : Dict{Symbol, Int64}
    Symbol-to-index mapping for solution phases.
PP_syms : Dict{Symbol, Int64}
    Symbol-to-index mapping for pure phases.
SS_vec : Vector{LibMAGEMin.SS_data}
    Solution phase data.
mSS_vec : Vector{LibMAGEMin.mSS_data}
    Metastable solution phase data.
PP_vec : Vector{LibMAGEMin.PP_data}
    Pure phase data.
oxides : Vector{String}
    Oxide names.
elements : Vector{String}
    Element names.
Vp : T
    P-wave velocity [km/s].
Vs : T
    S-wave velocity [km/s].
Vp_S : T
    P-wave velocity of solid aggregate [km/s].
Vs_S : T
    S-wave velocity of solid aggregate [km/s].
bulkMod : T
    Elastic bulk modulus [GPa].
shearMod : T
    Elastic shear modulus [GPa].
bulkModulus_M : T
    Bulk modulus of melt [GPa].
bulkModulus_S : T
    Bulk modulus of solid [GPa].
shearModulus_S : T
    Shear modulus of solid [GPa].
entropy : Vector{T}
    Entropy [J/K].
enthalpy : Vector{T}
    Enthalpy [J].
iter : I
    Number of iterations required.
bulk_res_norm : T
    Bulk residual norm.
time_ms : T
    Computational time [ms].
status : I
    Status of calculations (0 = converged, 5 = not converged).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L126-L289" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.out_tepm' href='#MAGEMin_C.out_tepm'><span class="jlbinding">MAGEMin_C.out_tepm</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds the output of the TE partitioning routine
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L126-L128" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.ss_infos' href='#MAGEMin_C.ss_infos'><span class="jlbinding">MAGEMin_C.ss_infos</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
ss_infos

Mutable structure holding general information about a solution phase.

Fields
------
ss_fName : String
    Full name of the solution phase.
ss_name : String
    Short name of the solution phase.
n_em : Int64
    Number of endmembers.
n_xeos : Int64
    Number of compositional variables.
n_sf : Int64
    Number of site fractions.
ss_em : Vector{String}
    Endmember names.
ss_xeos : Vector{String}
    Compositional variable names.
ss_sf : Vector{String}
    Site fraction names.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L421-L444" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR-Tuple{Any}' href='#MAGEMin_C.AMR-Tuple{Any}'><span class="jlbinding">MAGEMin_C.AMR</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
AMR(data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/AMR.jl#L135-L137" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR_minimization-Union{Tuple{T1}, Tuple{Int64, Int64, Union{Tuple{T1, T1}, T1}, Union{Tuple{T1, T1}, T1}, MAGEMin_Data}} where T1<:Float64' href='#MAGEMin_C.AMR_minimization-Union{Tuple{T1}, Tuple{Int64, Int64, Union{Tuple{T1, T1}, T1}, Union{Tuple{T1, T1}, T1}, MAGEMin_Data}} where T1<:Float64'><span class="jlbinding">MAGEMin_C.AMR_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
AMR_minimization(init_sub, ref_lvl, Prange, Trange, MAGEMin_db; test=0, X=nothing, B=0.0, scp=0, dT=2.0, iguess=false, rm_list=nothing, W=nothing, Xoxides=Vector{String}, sys_in="mol", rg="tc", progressbar=true)

Perform an Adaptive Mesh Refinement (AMR) minimization for a range of points as a function of pressure, temperature and/or composition.

Parameters
----------
init_sub : Int64
    Initial number of subdivisions.
ref_lvl : Int64
    Number of refinement levels.
Prange : Union{Float64, NTuple{2, Float64}}
    Pressure range [kbar] as a tuple (Pmin, Pmax) or single value.
Trange : Union{Float64, NTuple{2, Float64}}
    Temperature range [°C] as a tuple (Tmin, Tmax) or single value.
MAGEMin_db : MAGEMin_Data
    Initialized MAGEMin data structure.
test : Int64, optional
    Build-in test case number (default: 0).
X : VecOrMat, optional
    Bulk rock composition(s) (default: nothing).
B : Union{Nothing, Float64, Vector{Float64}}, optional
    Buffer value(s) (default: 0.0).
scp : Int64, optional
    Sub-solidus computation parameter (default: 0).
dT : Float64, optional
    Temperature increment for sub-solidus detection (default: 2.0).
iguess : Union{Vector{Bool}, Bool}, optional
    Whether to use initial guess (default: false).
rm_list : Union{Nothing, Vector{Int64}}, optional
    List of phase indexes to remove (default: nothing).
W : Union{Nothing, Vector{W_data{Float64, Int64}}}, optional
    Overriding Margules parameters (default: nothing).
Xoxides : Vector{String}
    Oxide names corresponding to `X`.
sys_in : String, optional
    Input system units, "mol" or "wt" (default: "mol").
rg : String, optional
    Research group, "tc" or "sb" (default: "tc").
progressbar : Bool, optional
    Show progress bar (default: true).

Returns
-------
Out_XY : Vector{gmin_struct{Float64, Int64}}
    Vector of minimization results for each refined P-T point.

Examples
--------
```julia
data        = Initialize_MAGEMin("mp", verbose=-1, solver=0);
init_sub    =  1
ref_lvl     =  2
Prange      = (1.0,10.0)
Trange      = (400.0,800.0)
Xoxides     = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","MnO","H2O"]
X           = [70.999,12.805,0.771,3.978,6.342,2.7895,1.481,0.758,0.72933,0.075,30.0]
sys_in      = "mol"
out         = AMR_minimization(init_sub, ref_lvl, Prange, Trange, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1124-L1184" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.FeO2Fe_O!-Tuple{AbstractVector{Float64}, AbstractVector{String}}' href='#MAGEMin_C.FeO2Fe_O!-Tuple{AbstractVector{Float64}, AbstractVector{String}}'><span class="jlbinding">MAGEMin_C.FeO2Fe_O!</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
FeO2Fe_O!(bulk_mol, bulk_ox)

Convert bulk-rock composition from FeO + extra oxygen to total Fe + total O (used for SB24). Modifies `bulk_mol` and `bulk_ox` in place.

Parameters
----------
bulk_mol : AbstractVector{Float64}
    Bulk rock composition in molar fraction (modified in place).
bulk_ox : AbstractVector{String}
    Oxide names corresponding to `bulk_mol` (modified in place).

Returns
-------
bulk_mol : AbstractVector{Float64}
    Updated bulk rock composition with Fe and O instead of FeO.
bulk_ox : AbstractVector{String}
    Updated oxide names with "Fe" and "O" replacing "FeO".
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1476-L1494" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.Finalize_MAGEMin-Tuple{MAGEMin_Data}' href='#MAGEMin_C.Finalize_MAGEMin-Tuple{MAGEMin_Data}'><span class="jlbinding">MAGEMin_C.Finalize_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Finalize_MAGEMin(dat)

Finalize MAGEMin and free all allocated memory.

Parameters
----------
dat : MAGEMin_Data
    MAGEMin data structure to finalize.

Returns
-------
nothing
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L712-L725" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.Initialize_MAGEMin' href='#MAGEMin_C.Initialize_MAGEMin'><span class="jlbinding">MAGEMin_C.Initialize_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
Initialize_MAGEMin(db="ig"; verbose=0, dataset=nothing, limitCaOpx=0, CaOpxLim=0.0, mbCpx=1, mbIlm=0, mpSp=0, mpIlm=0, ig_ed=0, buffer="NONE", solver=0)

Initialize MAGEMin on one or more threads for the specified database.

Parameters
----------
db : String, optional
    Database name (default: "ig"). Options: "mp", "mb", "mbe", "ig", "igad", "um", "ume", "mtl", "mpe", "sb11", "sb21", "sb24".
verbose : Union{Int64, Bool}, optional
    Verbosity level (default: 0). `false` or `-1` suppresses output, `true` or `0` gives a brief summary, `1` gives detailed output.
dataset : Union{Nothing, Int64}, optional
    Dataset identifier (default: nothing). Must be in `available_TC_ds` if specified.
limitCaOpx : Int64, optional
    Flag to limit Ca in orthopyroxene (default: 0).
CaOpxLim : Float64, optional
    Ca limit value for orthopyroxene (default: 0.0).
mbCpx : Int64, optional
    Metabasite clinopyroxene model flag (default: 1).
mbIlm : Int64, optional
    Metabasite ilmenite model flag (default: 0).
mpSp : Int64, optional
    Metapelite spinel model flag (default: 0).
mpIlm : Int64, optional
    Metapelite ilmenite model flag (default: 0).
ig_ed : Int64, optional
    Igneous extended database flag (default: 0).
buffer : String, optional
    Buffer type (default: "NONE").
solver : Int64, optional
    Solver type (default: 0).

Returns
-------
data : MAGEMin_Data
    Initialized MAGEMin data structure containing per-thread databases and variables.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L614-L650" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_data2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}' href='#MAGEMin_C.MAGEMin_data2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_data2dataframe</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



MAGEMin_data2dataframe( out:: Union{Vector{MAGEMin_C.gmin_struct{Float64, Int64}}, MAGEMin_C.gmin_struct{Float64, Int64}})

```
Transform MAGEMin output into a dataframe for quick(ish) save
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/export2CSV.jl#L174-L179" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_data2dataframe_inlined-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}' href='#MAGEMin_C.MAGEMin_data2dataframe_inlined-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_data2dataframe_inlined</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



MAGEMin_data2dataframe( out:: Union{Vector{MAGEMin_C.gmin_struct{Float64, Int64}}, MAGEMin_C.gmin_struct{Float64, Int64}})

```
Transform MAGEMin output into a dataframe for quick(ish) save
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/export2CSV.jl#L427-L432" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_dataTE2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Union{MAGEMin_C.out_tepm, Vector{MAGEMin_C.out_tepm}}, Any, Any}' href='#MAGEMin_C.MAGEMin_dataTE2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Union{MAGEMin_C.out_tepm, Vector{MAGEMin_C.out_tepm}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_dataTE2dataframe</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



MAGEMin_dataTE2dataframe( out:: Union{Vector{out_tepm}, out_tepm},dtb,fileout)

```
Transform MAGEMin trace-element output into a dataframe for quick(ish) save
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/export2CSV.jl#L12-L17" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.TE_prediction-NTuple{4, Any}' href='#MAGEMin_C.TE_prediction-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.TE_prediction</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out_TE = TE_prediction(  out, C0, KDs_database, dtb;
                ZrSat_model   :: String = "CB",
                SSat_model    :: String = "1000ppm",)
```


Perform TE partitioning and zircon saturation calculation.

This function computes the partitioning of elements into different phases based on the provided KDs database and the initial composition C0. It also checks for zircon saturation and adjusts the composition if necessary.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L522-L531" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.all_identical-Tuple{Vector{UInt64}}' href='#MAGEMin_C.all_identical-Tuple{Vector{UInt64}}'><span class="jlbinding">MAGEMin_C.all_identical</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
all_identical(arr::Vector{UInt64})
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/AMR.jl#L83-L86" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.allocate_output-Tuple{Int64}' href='#MAGEMin_C.allocate_output-Tuple{Int64}'><span class="jlbinding">MAGEMin_C.allocate_output</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
allocate_output(n)

Allocate memory for the output vector of minimization results.

Parameters
----------
n : Int64
    Number of output structures to allocate.

Returns
-------
output : Vector{gmin_struct{Float64, Int64}}
    Uninitialized vector of `gmin_struct` with length `n`.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L70-L84" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.anhydrous_renormalization-Tuple{Vector{Float64}, Vector{String}}' href='#MAGEMin_C.anhydrous_renormalization-Tuple{Vector{Float64}, Vector{String}}'><span class="jlbinding">MAGEMin_C.anhydrous_renormalization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
anhydrous_renormalization(bulk, oxide)

Renormalize the bulk rock composition to remove water (H2O) if present.

Parameters
----------
bulk : Vector{Float64}
    Bulk rock composition vector.
oxide : Vector{String}
    List of oxide names corresponding to `bulk`.

Returns
-------
bulk_dry : Vector{Float64}
    Renormalized anhydrous bulk rock composition.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L93-L109" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_P2O5_sat_n_part-Tuple{out_struct, MAGEMin_C.custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_P2O5_sat_n_part-Tuple{out_struct, MAGEMin_C.custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_P2O5_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_P_sat_n_part(           out         :: MAGEMin_C.gmin_struct{Float64, Int64},
                                KDs_database:: custom_KDs_database,
                                Cliq, Csol, Cmin, ph_TE, ph_wt_norm, liq_wt_norm, bulk_D, bulk_cor_wt,
                                C0          :: Vector{Float64},
                                ph          :: Vector{String},
                                ph_wt       :: Vector{Float64}, 
                                liq_wt      :: Float64,
                                sol_wt      :: Float64;
                                P2O5Sat_model  :: String = "Klein26",
                                norm_TE     :: Bool = true)
```


Compute phosphate saturation and adjust bulk composition if necessary.

This function checks if the P2O5 content in the liquid phase exceeds the saturation limit. If it does, it adjusts the bulk composition by removing the excess P2O5 and adds a new phase for fapt.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L469-L485" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_S_sat_n_part-Tuple{out_struct, MAGEMin_C.custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_S_sat_n_part-Tuple{out_struct, MAGEMin_C.custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_S_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_S_sat_n_part(           out         :: MAGEMin_C.gmin_struct{Float64, Int64},
                                KDs_database:: custom_KDs_database,
                                Cliq, Csol, Cmin, ph_TE, ph_wt_norm, liq_wt_norm, bulk_D, bulk_cor_wt,
                                C0          :: Vector{Float64},
                                ph          :: Vector{String},
                                ph_wt       :: Vector{Float64}, 
                                liq_wt      :: Float64,
                                sol_wt      :: Float64;
                                SSat_model  :: String = "1000ppm",
                                norm_TE     :: Bool = true)
```


Compute sulfur saturation and adjust bulk composition if necessary.

This function checks if the sulfur content in the liquid phase exceeds the saturation limit. If it does, it adjusts the bulk composition by removing the excess sulfur and adds a new phase for FeS.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L413-L429" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_TE_partitioning-Tuple{MAGEMin_C.custom_KDs_database, out_struct, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}' href='#MAGEMin_C.compute_TE_partitioning-Tuple{MAGEMin_C.custom_KDs_database, out_struct, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}'><span class="jlbinding">MAGEMin_C.compute_TE_partitioning</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_TE_partitioning(    KDs_database:: custom_KDs_database,
                            C0          :: Vector{Float64},
                            ph          :: Vector{String},
                            ph_wt       :: Vector{Float64}, 
                            liq_wt      :: Float64,
                            sol_wt      :: Float64)
```


Compute the partitioning of elements into different phases based on the provided KDs database and the initial composition C0.

This function partitions the elements into liquid, solid, and other phases based on the provided KDs database and the initial composition C0. It returns the partitioned compositions along with normalized phase weights.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L315-L327" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_Zr_sat_n_part-Tuple{out_struct, MAGEMin_C.custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_Zr_sat_n_part-Tuple{out_struct, MAGEMin_C.custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_Zr_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_Zr_sat_n_part(          out         :: MAGEMin_C.gmin_struct{Float64, Int64},
                                KDs_database:: custom_KDs_database,
                                Cliq,
                                C0          :: Vector{Float64},
                                ph          :: Vector{String},
                                ph_wt       :: Vector{Float64}, 
                                liq_wt      :: Float64,
                                sol_wt      :: Float64;
                                ZrSat_model :: String = "CB")
```


Compute zircon saturation and adjust bulk composition if necessary.

This function checks if the zirconium content in the liquid phase exceeds the saturation limit. If it does, it adjusts the bulk composition by removing the excess zirconium and adds a new phase for zircon.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L360-L375" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_index-Tuple{Any, Any, Any}' href='#MAGEMin_C.compute_index-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.compute_index</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_index(value, min_value, delta)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/AMR.jl#L32-L34" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_melt_viscosity_G08-Tuple{Any, Any, Any}' href='#MAGEMin_C.compute_melt_viscosity_G08-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.compute_melt_viscosity_G08</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_melt_viscosity_G08(oxides, M_mol, T_C; A = -4.55)

Takes as input arguments:
    oxides :: Vector{String}    -> oxide list of the melt composition
    M_mol  :: Vector{Float64}   -> melt composition in mol
    T_C    :: Float64           -> temperature in °C

returns melt viscosity in Pa.s

Formulation after Giordano et al., 2008
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/External_routines.jl#L19-L30" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.convertBulk4MAGEMin-Union{Tuple{T1}, Tuple{T1, Vector{String}, String, String}} where T1<:AbstractVector{Float64}' href='#MAGEMin_C.convertBulk4MAGEMin-Union{Tuple{T1}, Tuple{T1, Vector{String}, String, String}} where T1<:AbstractVector{Float64}'><span class="jlbinding">MAGEMin_C.convertBulk4MAGEMin</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
convertBulk4MAGEMin(bulk_in, bulk_in_ox, sys_in, db)

Convert a bulk-rock composition (in mol or wt fraction) and its associated oxide list into the format expected by MAGEMin.

Parameters
----------
bulk_in : AbstractVector{Float64}
    Input bulk rock composition.
bulk_in_ox : Vector{String}
    Oxide names corresponding to `bulk_in`.
sys_in : String
    Input system units, "mol" or "wt".
db : String
    Database identifier, e.g. "ig", "mp", "mb", "sb24".

Returns
-------
MAGEMin_bulk : Vector{Float64}
    Bulk rock composition converted and normalized for MAGEMin (summing to 100).
MAGEMin_ox : Vector{String}
    Oxide names in the order expected by MAGEMin for the given database.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1518-L1540" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}, Vector{String}, VecOrMat{String}}' href='#MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}, Vector{String}, VecOrMat{String}}'><span class="jlbinding">MAGEMin_C.create_custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
KDs_database = custom_KDs_database(infos::String, 
                    element_name::Vector{String}, 
                    phase_name::Vector{String}, 
                    KDs_expr::Matrix{Expr})
```


Create a custom KDs database from the given information.

returns a custom_KDs_database object that can be used in the TE_partitioning.jl module.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L201-L211" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_gmin_struct-Tuple{Any, Any, Any}' href='#MAGEMin_C.create_gmin_struct-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.create_gmin_struct</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_gmin_struct(DB, gv, time; name_solvus=false)

Extract the output of a pointwise MAGEMin optimization into a Julia structure.

Parameters
----------
DB : LibMAGEMin.Database
    Database structure.
gv : LibMAGEMin.global_variables
    Global variables structure.
time : Float64
    Elapsed computation time [s].
name_solvus : Bool, optional
    Resolve solvus naming (default: false).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the full minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2236-L2256" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_light_gmin_struct-Tuple{Any, Any}' href='#MAGEMin_C.create_light_gmin_struct-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.create_light_gmin_struct</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_light_gmin_struct(DB, gv)

Extract a lightweight output of a pointwise MAGEMin optimization into a Julia structure (Float32/Int8 types).

Parameters
----------
DB : LibMAGEMin.Database
    Database structure.
gv : LibMAGEMin.global_variables
    Global variables structure.

Returns
-------
out : light_gmin_struct{Float32, Int8}
    Lightweight structure containing essential minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2410-L2426" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.define_bulk_rock-NTuple{5, Any}' href='#MAGEMin_C.define_bulk_rock-NTuple{5, Any}'><span class="jlbinding">MAGEMin_C.define_bulk_rock</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
define_bulk_rock(gv, bulk_in, bulk_in_ox, sys_in, db)

Define the bulk-rock composition in the global variables structure, converting it to the appropriate format for MAGEMin.

Parameters
----------
gv : LibMAGEMin.global_variables
    Global variables structure.
bulk_in : AbstractVector{Float64}
    Input bulk rock composition.
bulk_in_ox : Vector{String}
    Oxide names corresponding to `bulk_in`.
sys_in : String
    Input system units, "mol" or "wt".
db : String
    Database identifier, e.g. "ig", "mp", "mb".

Returns
-------
gv : LibMAGEMin.global_variables
    Updated global variables with normalized bulk rock composition.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1365-L1387" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.finalize_MAGEMin-Tuple{Any, Any, Any}' href='#MAGEMin_C.finalize_MAGEMin-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.finalize_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
finalize_MAGEMin(gv, DB, z_b)

Free the memory allocated by `init_MAGEMin`.

Parameters
----------
gv : global_variables
    Global variables structure.
DB : Database
    Thermodynamic database structure.
z_b : bulk_infos
    Bulk rock information structure.

Returns
-------
nothing
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L879-L896" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_TE_database' href='#MAGEMin_C.get_TE_database'><span class="jlbinding">MAGEMin_C.get_TE_database</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
This routine stores the TE partitioning coefficients
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L16-L18" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_all_stable_phases-Tuple{Union{out_struct, Vector{out_struct}}}' href='#MAGEMin_C.get_all_stable_phases-Tuple{Union{out_struct, Vector{out_struct}}}'><span class="jlbinding">MAGEMin_C.get_all_stable_phases</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_all_stable_phases(out:: Union{Vector{gmin_struct{Float64, Int64}}, gmin_struct{Float64, Int64}})
return ph_name

The function receives as an input a single/Vector of MAGEMin_C output structure and returns the list (Vector{String}) of unique stable phases
    - Note that first the sorted solution phase names are provided, followed by the sorted pure phase names
      e.g., ["amp", "bi", "chl", "cpx", "ep", "fl", "fsp", "liq", "opx", "sph"]
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/export2CSV.jl#L390-L397" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_molar_mass-Tuple{String}' href='#MAGEMin_C.get_molar_mass-Tuple{String}'><span class="jlbinding">MAGEMin_C.get_molar_mass</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_molar_mass(oxide)

Retrieve the molar mass of a given oxide.

Parameters
----------
oxide : String
    Name of the oxide (e.g., "SiO2", "Al2O3").

Returns
-------
molar_mass : Float64
    Molar mass of the specified oxide [g/mol].
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L45-L59" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_ss_from_mineral-Tuple{Any, Any, Any}' href='#MAGEMin_C.get_ss_from_mineral-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.get_ss_from_mineral</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
This function returns the solution phase name given the mineral name (handling solvus -> solution phase)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/name_solvus.jl#L101-L103" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.init_MAGEMin' href='#MAGEMin_C.init_MAGEMin'><span class="jlbinding">MAGEMin_C.init_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
init_MAGEMin(db="ig"; verbose=0, dataset=nothing, mbCpx=0, mbIlm=0, mpSp=0, mpIlm=0, ig_ed=0, limitCaOpx=0, CaOpxLim=1.0, buffer="NONE", solver=0)

Initialize MAGEMin (including setting global options) and load the database for a single thread.

Parameters
----------
db : String, optional
    Database name (default: "ig").
verbose : Union{Int64, Bool}, optional
    Verbosity level (default: 0).
dataset : Union{Nothing, Int}, optional
    Dataset identifier (default: nothing).
mbCpx : Int64, optional
    Metabasite clinopyroxene model flag (default: 0).
mbIlm : Int64, optional
    Metabasite ilmenite model flag (default: 0).
mpSp : Int64, optional
    Metapelite spinel model flag (default: 0).
mpIlm : Int64, optional
    Metapelite ilmenite model flag (default: 0).
ig_ed : Int64, optional
    Igneous extended database flag (default: 0).
limitCaOpx : Int64, optional
    Flag to limit Ca in orthopyroxene (default: 0).
CaOpxLim : Float64, optional
    Ca limit value for orthopyroxene (default: 1.0).
buffer : String, optional
    Buffer type (default: "NONE").
solver : Int64, optional
    Solver type (default: 0).

Returns
-------
gv : global_variables
    Global variables structure.
z_b : bulk_infos
    Bulk rock information structure.
DB : Database
    Thermodynamic database structure.
splx_data : simplex_data
    Simplex data structure.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L735-L777" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.initialize_AMR-Tuple{Any, Any, Any}' href='#MAGEMin_C.initialize_AMR-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.initialize_AMR</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_hash_map(data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/AMR.jl#L40-L42" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.mineral_classification-Tuple{out_struct, String}' href='#MAGEMin_C.mineral_classification-Tuple{out_struct, String}'><span class="jlbinding">MAGEMin_C.mineral_classification</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Classify the mineral output from MAGEMin to be able to be compared with partitioning coefficient database
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/TE_partitioning.jl#L31-L33" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.mol2wt-Tuple{AbstractVector{Float64}, AbstractVector{String}}' href='#MAGEMin_C.mol2wt-Tuple{AbstractVector{Float64}, AbstractVector{String}}'><span class="jlbinding">MAGEMin_C.mol2wt</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
mol2wt(bulk_mol, bulk_ox)

Convert bulk-rock composition from molar fraction to weight fraction.

Parameters
----------
bulk_mol : AbstractVector{Float64}
    Bulk rock composition in molar fraction.
bulk_ox : AbstractVector{String}
    Oxide names corresponding to `bulk_mol`.

Returns
-------
bulk_wt : Vector{Float64}
    Bulk rock composition in weight fraction (normalized to 100).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1440-L1456" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.multi_point_minimization-Union{Tuple{T2}, Tuple{T1}, Tuple{T2, T2, MAGEMin_Data}} where {T1<:Float64, T2<:AbstractVector{Float64}}' href='#MAGEMin_C.multi_point_minimization-Union{Tuple{T2}, Tuple{T1}, Tuple{T2, T2, MAGEMin_Data}} where {T1<:Float64, T2<:AbstractVector{Float64}}'><span class="jlbinding">MAGEMin_C.multi_point_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
multi_point_minimization(P, T, MAGEMin_db; light=false, name_solvus=false, fixed_bulk=false, test=0, X=nothing, B=nothing, G=nothing, scp=0, dT=2.0, iguess=false, rm_list=nothing, W=nothing, Xoxides=Vector{String}, sys_in="mol", rg="tc", progressbar=true, callback_fn=nothing, callback_int=1)

Perform (parallel) MAGEMin calculations for a range of points as a function of pressure, temperature and/or composition.

The bulk-rock composition can either be set to be one of the pre-defined build-in test cases, or can be specified specifically by passing `X`, `Xoxides` and `sys_in`.

Parameters
----------
P : AbstractVector{Float64}
    Pressure vector [kbar].
T : AbstractVector{Float64}
    Temperature vector [°C].
MAGEMin_db : MAGEMin_Data
    Initialized MAGEMin data structure.
light : Bool, optional
    If true, return a light output structure (default: false).
name_solvus : Bool, optional
    If true, rename phases with solvus names (default: false).
fixed_bulk : Bool, optional
    If true, use fixed bulk composition (default: false).
test : Int64, optional
    Build-in test case number (default: 0).
X : VecOrMat, optional
    Bulk rock composition(s). Single vector for all points, or vector of vectors for per-point composition (default: nothing).
B : Union{Nothing, Vector{Float64}}, optional
    Buffer values per point (default: nothing).
G : Union{Nothing, Vector{LibMAGEMin.mSS_data}, Vector{Vector{LibMAGEMin.mSS_data}}}, optional
    Initial guess data (default: nothing).
scp : Int64, optional
    Sub-solidus computation parameter (default: 0).
dT : Float64, optional
    Temperature increment for sub-solidus detection (default: 2.0).
iguess : Union{Vector{Bool}, Bool}, optional
    Whether to use initial guess (default: false).
rm_list : Union{Nothing, Vector{Int64}}, optional
    List of phase indexes to remove (default: nothing).
W : Union{Nothing, Vector{W_data{Float64, Int64}}}, optional
    Overriding Margules parameters (default: nothing).
Xoxides : Vector{String}
    Oxide names corresponding to `X`.
sys_in : String, optional
    Input system units, "mol" or "wt" (default: "mol").
rg : String, optional
    Research group, "tc" or "sb" (default: "tc").
progressbar : Bool, optional
    Show progress bar (default: true).
callback_fn : Union{Nothing, Function}, optional
    Callback function called periodically (default: nothing).
callback_int : Int64, optional
    Callback interval in number of points (default: 1).

Returns
-------
Out_PT : Vector{gmin_struct{Float64, Int64}} or Vector{light_gmin_struct{Float32, Int8}}
    Vector of minimization results for each P-T point.

Examples
--------
```julia
data = Initialize_MAGEMin("ig", verbose=false);
n = 10
P = rand(8:40.0,n)
T = rand(800:1500.0,n)
out = multi_point_minimization(P, T, data, test=0)
Finalize_MAGEMin(data)
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L958-L1025" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_metastability-Tuple{out_struct, Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_metastability-Tuple{out_struct, Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_metastability</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
point_wise_metastability(out, P, T, gv, z_b, DB, splx_data)

Compute the metastability of the solution phases from a previous minimization result at new pressure and temperature conditions.

Parameters
----------
out : gmin_struct{Float64, Int64}
    Output structure from a previous MAGEMin minimization.
P : Float64
    Pressure [kbar].
T : Float64
    Temperature [°C].
gv : LibMAGEMin.global_variables
    Global variables structure.
z_b : LibMAGEMin.bulk_infos
    Bulk rock information structure.
DB : LibMAGEMin.Database
    Database structure.
splx_data : LibMAGEMin.simplex_datas
    Simplex data structure.

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the metastability results at the new P-T conditions.

Examples
--------
```julia
using MAGEMin_C
data    = Initialize_MAGEMin("mp", verbose=-1; solver=0);
P, T    = 6.0, 630.0
Xoxides = ["SiO2"; "TiO2"; "Al2O3"; "FeO"; "MnO"; "MgO"; "CaO"; "Na2O"; "K2O"; "H2O"; "O"];
X       = [58.509, 1.022, 14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
Pmeta, Tmeta = 6.0, 500.0
out2    = point_wise_metastability(out, Pmeta, Tmeta, data)
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2854-L2894" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization-Tuple{Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_minimization-Tuple{Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
point_wise_minimization(P, T, gv, z_b, DB, splx_data; light=false, name_solvus=false, fixed_bulk=false, buffer_n=0.0, Gi=nothing, scp=0, dT=2.0, iguess=false, rm_list=nothing, W=nothing)

Compute the stable mineral assemblage at given pressure and temperature for a specified bulk rock composition.

Parameters
----------
P : Float64
    Pressure [kbar].
T : Float64
    Temperature [°C].
gv : LibMAGEMin.global_variables
    Global variables structure (must have bulk rock composition set).
z_b : LibMAGEMin.bulk_infos
    Bulk rock information structure.
DB : LibMAGEMin.Database
    Database structure.
splx_data : LibMAGEMin.simplex_datas
    Simplex data structure.
light : Bool, optional
    Return a lightweight output structure (default: false).
name_solvus : Bool, optional
    Resolve solvus naming (default: false).
fixed_bulk : Bool, optional
    Use fixed bulk composition (default: false).
buffer_n : Float64, optional
    Buffer value (default: 0.0).
Gi : Union{Nothing, Vector{LibMAGEMin.mSS_data}}, optional
    Initial guess from previous minimization (default: nothing).
scp : Int64, optional
    Sub-solidus computation parameter (default: 0).
dT : Float64, optional
    Temperature increment for sub-solidus detection (default: 2.0).
iguess : Bool, optional
    Whether to use initial guess (default: false).
rm_list : Union{Nothing, Vector{Int64}}, optional
    List of phase indexes to remove (default: nothing).
W : Union{Nothing, Vector{W_data{Float64, Int64}}}, optional
    Overriding Margules parameters (default: nothing).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the minimization results (stable phases, fractions, thermodynamic properties, etc.).

Examples
--------
Using a predefined bulk rock composition:
```julia
db          = "ig"
gv, z_b, DB, splx_data = init_MAGEMin(db);
test        = 0;
sys_in      = "mol"
gv          = use_predefined_bulk_rock(gv, test, db)
P           = 8.0;
T           = 800.0;
gv.verbose  = -1;
out         = point_wise_minimization(P, T, gv, z_b, DB, splx_data, sys_in)
```

Using a custom bulk rock composition:
```julia
db          = "ig"
gv, z_b, DB, splx_data = init_MAGEMin(db);
bulk_in_ox  = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
bulk_in     = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in      = "wt"
gv          = define_bulk_rock(gv, bulk_in, bulk_in_ox, sys_in, db);
P, T        = 10.0, 1100.0;
gv.verbose  = -1;
out         = point_wise_minimization(P, T, gv, z_b, DB, splx_data, sys_in)
finalize_MAGEMin(gv, DB)
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1679-L1752" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization-Tuple{Number, Number, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_minimization-Tuple{Number, Number, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
point_wise_minimization(P, T, data::MAGEMin_Data)

Perform a point-wise Gibbs energy minimization for a given pressure and temperature using the `MAGEMin_Data` structure.

Parameters
----------
P : Number
    Pressure [kbar].
T : Number
    Temperature [°C].
data : MAGEMin_Data
    Initialized MAGEMin data structure (composition must be set beforehand).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2067-L2085" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization_with_guess-Tuple{Vector{MAGEMin_C.LibMAGEMin.mSS_data}, Float64, Float64, MAGEMin_C.LibMAGEMin.global_variables, MAGEMin_C.LibMAGEMin.bulk_infos, MAGEMin_C.LibMAGEMin.Database, MAGEMin_C.LibMAGEMin.simplex_datas}' href='#MAGEMin_C.point_wise_minimization_with_guess-Tuple{Vector{MAGEMin_C.LibMAGEMin.mSS_data}, Float64, Float64, MAGEMin_C.LibMAGEMin.global_variables, MAGEMin_C.LibMAGEMin.bulk_infos, MAGEMin_C.LibMAGEMin.Database, MAGEMin_C.LibMAGEMin.simplex_datas}'><span class="jlbinding">MAGEMin_C.point_wise_minimization_with_guess</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
point_wise_minimization_with_guess(mSS_vec, P, T, gv, z_b, DB, splx_data)

Perform a point-wise Gibbs energy minimization using an initial guess from metastable solution phase data.

Parameters
----------
mSS_vec : Vector{LibMAGEMin.mSS_data}
    Vector of metastable solution phase data used as initial guess.
P : Float64
    Pressure [kbar].
T : Float64
    Temperature [°C].
gv : LibMAGEMin.global_variables
    Global variables structure.
z_b : LibMAGEMin.bulk_infos
    Bulk rock information structure.
DB : LibMAGEMin.Database
    Database structure.
splx_data : LibMAGEMin.simplex_datas
    Simplex data structure.

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2712-L2738" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.print_info-Tuple{MAGEMin_C.gmin_struct}' href='#MAGEMin_C.print_info-Tuple{MAGEMin_C.gmin_struct}'><span class="jlbinding">MAGEMin_C.print_info</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
print_info(g::gmin_struct)

Print an extensive overview of the minimization results, including stable phases, compositions, thermodynamic properties, and numerics.

Parameters
----------
g : gmin_struct
    Output structure from a MAGEMin minimization.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2489-L2498" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.pwm_init-Tuple{Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.pwm_init-Tuple{Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.pwm_init</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
pwm_init(P, T, gv, z_b, DB, splx_data; G0=true)

Initialize a single point minimization and optionally compute G0 and Margules (W) parameters. Intended for thermodynamic database inversion/calibration workflows.

Parameters
----------
P : Float64
    Pressure [kbar].
T : Float64
    Temperature [°C].
gv : LibMAGEMin.global_variables
    Global variables structure.
z_b : LibMAGEMin.bulk_infos
    Bulk rock information structure.
DB : LibMAGEMin.Database
    Database structure.
splx_data : LibMAGEMin.simplex_datas
    Simplex data structure.
G0 : Bool, optional
    Whether to compute G0 (default: true).

Returns
-------
gv : LibMAGEMin.global_variables
    Updated global variables.
z_b : LibMAGEMin.bulk_infos
    Updated bulk rock information.
DB : LibMAGEMin.Database
    Updated database.
splx_data : LibMAGEMin.simplex_datas
    Updated simplex data.

Examples
--------
```julia
dtb     = "mp"
gv, z_b, DB, splx_data = init_MAGEMin(dtb);
Xoxides = ["SiO2"; "TiO2"; "Al2O3"; "FeO"; "MnO"; "MgO"; "CaO"; "Na2O"; "K2O"; "H2O"; "O"];
X       = [58.509, 1.022, 14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.0];
sys_in  = "wt"
gv      = define_bulk_rock(gv, X, Xoxides, sys_in, dtb);
P, T    = 6.0, 500.0
gv, z_b, DB, splx_data = pwm_init(P, T, gv, z_b, DB, splx_data);
out     = pwm_run(gv, z_b, DB, splx_data);
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L2136-L2182" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.remove_phases-Tuple{Union{Nothing, Vector{String}}, String}' href='#MAGEMin_C.remove_phases-Tuple{Union{Nothing, Vector{String}}, String}'><span class="jlbinding">MAGEMin_C.remove_phases</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
remove_phases(list, dtb)

Retrieve the list of indexes of the solution phases to be removed from the minimization.

Parameters
----------
list : Union{Nothing, Vector{String}}
    List of phase names to remove, or `nothing` to remove none.
dtb : String
    Database name (e.g., "mp", "ig").

Returns
-------
rm_list : Union{Nothing, Vector{Int64}}
    Vector of phase indexes to remove (negative for pure phases), or `nothing` if no phases to remove.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L565-L581" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.retrieve_solution_phase_information-Tuple{Any}' href='#MAGEMin_C.retrieve_solution_phase_information-Tuple{Any}'><span class="jlbinding">MAGEMin_C.retrieve_solution_phase_information</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
retrieve_solution_phase_information(dtb)

Retrieve the general information of the thermodynamic databases (solution phases, endmembers, pure phases).

Parameters
----------
dtb : String
    Database name (e.g., "mp", "mb", "ig", "igad", "um", "ume", "mtl", "mpe", "sb11", "sb21", "sb24").

Returns
-------
db_inf : db_infos
    Structure containing database information (solution phases, pure phases, endmembers).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L541-L555" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.split_and_keep-Tuple{Any, Any}' href='#MAGEMin_C.split_and_keep-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.split_and_keep</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
split_and_keep(data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/AMR.jl#L91-L94" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.use_predefined_bulk_rock' href='#MAGEMin_C.use_predefined_bulk_rock'><span class="jlbinding">MAGEMin_C.use_predefined_bulk_rock</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
use_predefined_bulk_rock(gv, test=0, db="ig")

Return the pre-defined bulk rock composition for a given built-in test case.

Parameters
----------
gv : LibMAGEMin.global_variables
    Global variables structure.
test : Int64, optional
    Built-in test case number (default: 0).
db : String, optional
    Database identifier, e.g. "ig", "mp", "mb" (default: "ig").

Returns
-------
gv : LibMAGEMin.global_variables
    Updated global variables with bulk rock composition set.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1264-L1282" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.use_predefined_bulk_rock-2' href='#MAGEMin_C.use_predefined_bulk_rock-2'><span class="jlbinding">MAGEMin_C.use_predefined_bulk_rock</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
use_predefined_bulk_rock(data::MAGEMin_Data, test=0)

Return the pre-defined bulk rock composition for a given built-in test case (multi-threaded version).

Parameters
----------
data : MAGEMin_Data
    Initialized MAGEMin data structure.
test : Int64, optional
    Built-in test case number (default: 0).

Returns
-------
data : MAGEMin_Data
    Updated MAGEMin data structure with bulk rock composition set for all threads.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1340-L1356" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.wt2mol-Tuple{AbstractVector{Float64}, AbstractVector{String}}' href='#MAGEMin_C.wt2mol-Tuple{AbstractVector{Float64}, AbstractVector{String}}'><span class="jlbinding">MAGEMin_C.wt2mol</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
wt2mol(bulk_wt, bulk_ox)

Convert bulk-rock composition from weight fraction to molar fraction.

Parameters
----------
bulk_wt : AbstractVector{Float64}
    Bulk rock composition in weight fraction.
bulk_ox : AbstractVector{String}
    Oxide names corresponding to `bulk_wt`.

Returns
-------
bulk_mol : Vector{Float64}
    Bulk rock composition in molar fraction (normalized to 100).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/d4f61dc1daaf66628866f27e6069ff85bd3f5634/julia/MAGEMin_wrappers.jl#L1403-L1419" target="_blank" rel="noreferrer">source</a></Badge>

</details>

