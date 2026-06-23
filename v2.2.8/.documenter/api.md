
# API {#API}
<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR_data' href='#MAGEMin_C.AMR_data'><span class="jlbinding">MAGEMin_C.AMR_data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
AMR_data

Mutable structure holding the state of an Adaptive Mesh Refinement (AMR) grid.

Fields
------
cells : Vector{Vector{Int64}}
    Current quadrilateral cells, each defined by 4 point indices (counter-clockwise).
ncells : Vector{Vector{Int64}}
    Newly generated cells from the last refinement step.
points : Vector{Vector{Float64}}
    All grid point coordinates [X, Y].
npoints : Vector{Vector{Float64}}
    Newly generated point coordinates from the last refinement step.
npoints_ig : Vector{Tuple}
    Parent point index tuples for each new point (used for initial guess interpolation).
hash_map : Dict{Vector{Float64}, Int}
    Map from point coordinates to their index, used to avoid duplicate points.
bnd_cells : Vector{Tuple}
    Boundary information for kept cells: tuples of (cell_index, midpoint_indices...).
split_cell_list : Vector{Int64}
    Indices of cells to be split in the next refinement pass.
keep_cell_list : Vector{Int64}
    Indices of cells to be kept unchanged in the next refinement pass.
Xrange : Vector{Float64}
    X-axis bounds of the domain [Xmin, Xmax].
Yrange : Vector{Float64}
    Y-axis bounds of the domain [Ymin, Ymax].
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/AMR.jl#L15-L44" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L638-L655" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.SaturationConfig' href='#MAGEMin_C.SaturationConfig'><span class="jlbinding">MAGEMin_C.SaturationConfig</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
SaturationConfig

Configuration struct for saturation models used in `TE_prediction` and `solve_with_saturation`.
All fields default to `"none"` (disabled).

Fields
------
Zr   : String — zirconium saturation model. Options: "none", "CB", "WH", "B".
S    : String — sulfur saturation model. Options: "none", "Liu07", "Oneill21", "<N>ppm".
P2O5 : String — phosphate saturation model. Options: "none", "Klein26", "HWBea92", "Tollari06".
CO2  : String — CO₂ saturation model. Options: "none", "SY26".
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L163-L175" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L664-L681" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.custom_KDs_database' href='#MAGEMin_C.custom_KDs_database'><span class="jlbinding">MAGEMin_C.custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
custom_KDs_database

Structure holding a trace element partitioning coefficient (KD) database.

Fields
------
infos : String
    Description or citation for the database.
element_name : Vector{String}
    Names of the trace elements.
phase_name : Vector{String}
    Names of the mineral phases for which KDs are defined.
KDs_expr : Matrix{Function}
    Matrix of compiled KD functions (phases × elements). Each function takes a `gmin_struct` as input and returns a Float64.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L266-L281" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L605-L626" target="_blank" rel="noreferrer">source</a></Badge>

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
entropy_S : T
    Entropy of solid [J/K].
entropy_M : T
    Entropy of melt [J/K].
entropy_F : T
    Entropy of fluid [J/K].
alpha : Vector{T}
    Thermal expansivity.
V : T
    Volume [J/bar].
V_cm3 : T
    Volume [cm³].
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
Vp_cor : T
    Seismic-corrected P-wave velocity of solid aggregate [km/s] (melt + anelastic corrections; NaN if `seismic_cor=false`).
Vs_cor : T
    Seismic-corrected S-wave velocity of solid aggregate [km/s] (melt + anelastic corrections; NaN if `seismic_cor=false`).
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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L134-L309" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.light_gmin_struct' href='#MAGEMin_C.light_gmin_struct'><span class="jlbinding">MAGEMin_C.light_gmin_struct</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
light_gmin_struct{T, I, S}

Lightweight structure holding a reduced set of MAGEMin minimization outputs (Float32/Int8 types) for memory-efficient storage.

Fields
------
P_kbar : T
    Pressure [kbar].
T_C : T
    Temperature [°C].
ph_frac_wt : Vector{T}
    Phase fractions [wt].
ph_name : Vector{S}
    Phase names.
frac_S_wt : T
    Solid fraction [wt].
frac_F_wt : T
    Fluid fraction [wt].
frac_M_wt : T
    Melt fraction [wt].
bulk_S_wt : Vector{T}
    Bulk solid composition [wt].
bulk_F_wt : Vector{T}
    Bulk fluid composition [wt].
bulk_M_wt : Vector{T}
    Bulk melt composition [wt].
rho_S : T
    Solid density [kg/m³].
rho_F : T
    Fluid density [kg/m³].
rho_M : T
    Melt density [kg/m³].
eta_M : T
    Melt viscosity [Pa·s].
s_cp : Vector{T}
    Heat capacity.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L426-L463" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.light_gmin_struct_ig' href='#MAGEMin_C.light_gmin_struct_ig'><span class="jlbinding">MAGEMin_C.light_gmin_struct_ig</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
light_gmin_struct_ig{T, I, S}

Lightweight structure holding a reduced set of MAGEMin minimization outputs for igneous databases (Float32/Int8 types). Extends `light_gmin_struct` with volumetric fractions, metastable solution phase data, and convergence information.

Fields
------
P_kbar : T
    Pressure [kbar].
T_C : T
    Temperature [°C].
ph_frac_wt : Vector{T}
    Phase fractions [wt].
ph_name : Vector{S}
    Phase names.
frac_S_wt : T
    Solid fraction [wt].
frac_F_wt : T
    Fluid fraction [wt].
frac_M_wt : T
    Melt fraction [wt].
frac_S_vol : T
    Solid fraction [vol].
frac_F_vol : T
    Fluid fraction [vol].
frac_M_vol : T
    Melt fraction [vol].
bulk_S_wt : Vector{T}
    Bulk solid composition [wt].
bulk_F_wt : Vector{T}
    Bulk fluid composition [wt].
bulk_M_wt : Vector{T}
    Bulk melt composition [wt].
rho_S : T
    Solid density [kg/m³].
rho_F : T
    Fluid density [kg/m³].
rho_M : T
    Melt density [kg/m³].
eta_M : T
    Melt viscosity [Pa·s].
s_cp : Vector{T}
    Heat capacity.
mSS_vec : Vector{LibMAGEMin.mSS_data}
    Metastable solution phase data.
bulk_res_norm : T
    Bulk residual norm.
status : I
    Status of calculations (0 = converged, 5 = not converged).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L488-L537" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.out_tepm' href='#MAGEMin_C.out_tepm'><span class="jlbinding">MAGEMin_C.out_tepm</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
out_tepm

Structure holding the output of the trace element (TE) partitioning routine.

Fields
------
elements : Vector{String}
    Names of the trace elements.
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
Cliq : Vector{Float64}
    Trace element concentrations in the melt phase [ppm].
Csol : Vector{Float64}
    Trace element concentrations in the bulk solid [ppm].
Cmin : Matrix{Float64}
    Trace element concentrations in each individual mineral phase [ppm] (phases × elements).
ph_TE : Vector{String}
    Names of the phases included in the partitioning calculation.
ph_wt_norm : Vector{Float64}
    Normalized weight fractions of the solid phases.
liq_wt_norm : Float64
    Normalized weight fraction of the melt.
bulk_D : Float64
    Bulk partition coefficient.
bulk_cor_wt : Vector{Float64}
    Corrected bulk oxide weight fractions (accounting for saturation phases).
bulk_cor_mol : Vector{Float64}
    Corrected bulk oxide molar fractions.
Sat_Zr_liq : Float64
    Zirconium saturation concentration in the melt [ppm] (NaN if not computed).
zrc_wt : Float64
    Weight fraction of zircon precipitated (NaN if not computed).
Sat_S_liq : Float64
    Sulfur saturation concentration in the melt [ppm] (NaN if not computed).
sulf_wt : Float64
    Weight fraction of sulfide precipitated (NaN if not computed).
Sat_P2O5_liq : Float64
    P₂O₅ saturation concentration in the melt [ppm] (NaN if not computed).
fapt_wt : Float64
    Weight fraction of fluorapatite precipitated (NaN if not computed).
Sat_CO2_liq : Float64
    CO₂ saturation concentration in the melt [ppm] (NaN if not computed).
fl_CO2_wt : Float64
    Weight fraction of CO₂ fluid formed (NaN if not computed).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L192-L237" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L570-L593" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR-Tuple{Any}' href='#MAGEMin_C.AMR-Tuple{Any}'><span class="jlbinding">MAGEMin_C.AMR</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
AMR(data)

Perform one adaptive mesh refinement step on the quadrilateral grid.

Each cell in `data.split_cell_list` is subdivided into four child cells by
inserting five new points: one at the cell centroid and one at each edge
midpoint. Duplicate midpoints shared by adjacent cells are detected via
`data.hash_map` and reused rather than duplicated. Cells in
`data.keep_cell_list` are retained unchanged; their edge midpoints that were
created by neighbouring splits are recorded in `data.bnd_cells` for use in
the next `split_and_keep` call.

Parameters
----------
data : AMR_data
    AMR state structure. `data.cells`, `data.points`, `data.hash_map`,
    `data.split_cell_list`, and `data.keep_cell_list` are read and updated.

Returns
-------
data : AMR_data
    Updated AMR state with:
    - `data.cells`     — combined list of kept cells followed by new child cells.
    - `data.points`    — extended point list including all new midpoints.
    - `data.ncells`    — child cells generated in this step.
    - `data.npoints`   — new point coordinates generated in this step.
    - `data.npoints_ig`— parent-point index tuples for each new point, used for
                         initial-guess interpolation.
    - `data.bnd_cells` — boundary midpoint records for each kept cell.
    - `data.hash_map`  — updated coordinate-to-index map.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/AMR.jl#L231-L262" target="_blank" rel="noreferrer">source</a></Badge>

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
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1477-L1545" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.CO2_from_dissolved_H2O-Tuple{out_struct, Float64}' href='#MAGEMin_C.CO2_from_dissolved_H2O-Tuple{out_struct, Float64}'><span class="jlbinding">MAGEMin_C.CO2_from_dissolved_H2O</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
CO2_from_dissolved_H2O(out, S_H2O_wt; tol=1e-6)
```


Given a known dissolved H₂O content in the melt, compute the CO₂ saturation concentration using the M2Fluid model of Sun & Yao (2026).

Assumes a binary H₂O-CO₂ fluid so that P_CO₂ = P - P_H₂O.  P_H₂O is found by numerically inverting Eq. (7) via bisection on [0, P].

**Parameters**

out : MAGEMin_C.gmin_struct{Float64, Int64}     MAGEMin minimization output (must contain a melt phase). S_H2O_wt : Float64     Total dissolved H₂O content in the melt [wt%]. tol : Float64, optional     Convergence tolerance on P_H₂O (in bar; default 1e-6).

**Returns**

P_H2O : Float64     H₂O partial pressure [bar]. P_CO2 : Float64     CO₂ partial pressure (in bar; = P - P_H₂O). S_CO2 : Float64     CO₂ saturation in the melt [ppm], or NaN if P_CO₂ ≤ 0.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L658-L684" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.CO2_from_dissolved_H2O-Tuple{out_struct}' href='#MAGEMin_C.CO2_from_dissolved_H2O-Tuple{out_struct}'><span class="jlbinding">MAGEMin_C.CO2_from_dissolved_H2O</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
CO2_from_dissolved_H2O(out)
```


Convenience overload: reads dissolved H₂O directly from the melt phase of `out` (in wt%) and forwards to `CO2_from_dissolved_H2O(out, S_H2O_wt)`.

Returns `(NaN, NaN, NaN)` if no melt is present or the melt contains no H₂O.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L719-L726" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.D_amph-NTuple{4, Any}' href='#MAGEMin_C.D_amph-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.D_amph</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
D_amph(T, P, melt, min_wt)
```


Amphibole/melt partition coefficients after Tiepolo et al. (2007) and Dalpe & Baker (2000). Site fractions from hb_G16 (Green et al. 2016).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L755-L761" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.D_cpx-NTuple{4, Any}' href='#MAGEMin_C.D_cpx-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.D_cpx</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
D_cpx(T, P, melt, min_wt)
```


Clinopyroxene/melt partition coefficients after Blundy & Wood (1994), Sun & Liang (2012), Corgne et al. (2012), and Hill et al. (2011). Site fractions from cpx_G23 (Green et al., in prep).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L421-L427" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.D_gt-NTuple{4, Any}' href='#MAGEMin_C.D_gt-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.D_gt</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
D_gt(T, P, melt, min_wt)
```


Garnet/melt partition coefficients after van Westrenen & Draper (2007), and Sun & Liang (2013). Site fractions from g_G23 (Green et al., in prep).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L512-L518" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.D_ol-NTuple{4, Any}' href='#MAGEMin_C.D_ol-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.D_ol</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
D_ol(T, P, melt, min_wt)
```


Olivine/melt partition coefficients after Yao et al. (2012) and Bédard (2005). Site fractions from ol_H18 (Holland et al. 2018).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L697-L702" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.D_opx-NTuple{4, Any}' href='#MAGEMin_C.D_opx-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.D_opx</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
D_opx(T, P, melt, min_wt)
```


Orthopyroxene/melt partition coefficients after Bédard (2007), Frei et al. (2009), and Wood & Blundy (2013). Site fractions from opx_G23 (Green et al., in prep).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L582-L588" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.D_pl-NTuple{4, Any}' href='#MAGEMin_C.D_pl-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.D_pl</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
D_pl(T, P, melt, min_wt)
```


Plagioclase/melt partition coefficients after Dohmen & Blundy (2014). Site fractions from fsp_H21 (Holland et al. 2021).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L644-L649" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1837-L1855" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L867-L880" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L763-L799" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_data2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}' href='#MAGEMin_C.MAGEMin_data2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_data2dataframe</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
MAGEMin_data2dataframe(out, dtb, fileout)

Export MAGEMin minimization results to a CSV file in long (stacked) format,
writing one row per phase per point.

Each row contains point index, X fraction, P [kbar], T [°C], phase name,
modal abundances (mol%, wt%, vol%), system thermodynamic properties
(ρ, Vp, Vs, Cp, α, S, H, K, G), activity/fugacity variables, and oxide
compositions (mol% and wt%) plus apfu element compositions for each phase.
System-level rows (`"system"`) additionally carry fO₂, ΔQFM, and melt
viscosity. A companion metadata file is written at `fileout_metadata.txt`.

Parameters
----------
out : Union{Vector{gmin_struct{Float64, Int64}}, gmin_struct{Float64, Int64}}
    MAGEMin minimization output for one or more points.
dtb : String
    Database identifier used to retrieve database metadata (e.g., `"ig"`, `"mp"`).
fileout : String
    Base path for output files. Two files are created: `fileout.csv` and
    `fileout_metadata.txt`.
use_Warr2021 : Bool, optional
    If `true`, mineral phase names are converted to IMA-CNMNC approved symbols
    following Warr (2021). Names with no official symbol are returned with a
    trailing `"*"`. Default is `false`.
use_GPA : Bool, optional
    If `true`, pressure is reported in GPa (column `"P[GPa]"`) instead of kbar
    (column `"P[kbar]"`). Default is `false`.

Returns
-------
nothing
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/export2CSV.jl#L316-L349" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_data2dataframe_inlined-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}' href='#MAGEMin_C.MAGEMin_data2dataframe_inlined-Tuple{Union{out_struct, Vector{out_struct}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_data2dataframe_inlined</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
MAGEMin_data2dataframe_inlined(out, dtb, fileout)

Export MAGEMin minimization results to a CSV file in wide (inlined) format,
with one row per point and all phase data spread across columns.

The output DataFrame is built in three blocks that are horizontally
concatenated: system-level properties (`sys_*` prefix), solution-phase
columns (`<ph>_*` prefix, `NaN`-filled when a phase is absent at a given
point), and pure-phase columns (same convention). Column groups per phase
include modal fractions (mol%, wt%, vol%), thermodynamic properties
(ρ, Vp, Vs, Cp, α, S, H, K, G), and oxide compositions (mol%, wt%) plus
apfu element compositions. A companion metadata file is written at
`fileout_metadata.txt`; the CSV is written to `fileout_inlined.csv`.

Parameters
----------
out : Union{Vector{gmin_struct{Float64, Int64}}, gmin_struct{Float64, Int64}}
    MAGEMin minimization output for one or more points.
dtb : String
    Database identifier used to retrieve database metadata (e.g., `"ig"`, `"mp"`).
fileout : String
    Base path for output files. Two files are created: `fileout_inlined.csv`
    and `fileout_metadata.txt`.
use_Warr2021 : Bool, optional
    If `true`, mineral phase names used as column prefixes are converted to
    IMA-CNMNC approved symbols following Warr (2021). Names with no official
    symbol are returned with a trailing `"*"`. Default is `false`.
use_GPA : Bool, optional
    If `true`, pressure is reported in GPa (column `"P[GPa]"`) instead of kbar
    (column `"P[kbar]"`). Default is `false`.

Returns
-------
nothing
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/export2CSV.jl#L616-L651" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_dataTE2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Union{MAGEMin_C.out_tepm, Vector{MAGEMin_C.out_tepm}}, Any, Any}' href='#MAGEMin_C.MAGEMin_dataTE2dataframe-Tuple{Union{out_struct, Vector{out_struct}}, Union{MAGEMin_C.out_tepm, Vector{MAGEMin_C.out_tepm}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_dataTE2dataframe</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
MAGEMin_dataTE2dataframe(out, out_te, dtb, fileout)

Export MAGEMin minimization results together with trace element partitioning
output to a CSV file, writing one row per phase per point.

The CSV contains columns for P, T, X, phase name, mode [wt%], Zr saturation
[μg/g], corrected bulk oxide composition [wt%], and per-element concentrations
[μg/g]. A companion metadata text file recording the MAGEMin version, database,
date, and time is written alongside the CSV.

Rows are written for the bulk system (`"system"`), the melt (`"liq"`), the
bulk solid aggregate (`"sol"`), and each individual mineral phase.

Parameters
----------
out : Union{Vector{gmin_struct{Float64, Int64}}, gmin_struct{Float64, Int64}}
    MAGEMin minimization output for one or more points.
out_te : Union{Vector{out_tepm}, out_tepm}
    Trace element partitioning output corresponding to each point in `out`.
dtb : String
    Database identifier used to retrieve database metadata (e.g., `"ig"`, `"mp"`).
fileout : String
    Base path for output files. Two files are created: `fileout.csv` and
    `fileout_metadata.txt`.
use_Warr2021 : Bool, optional
    If `true`, mineral phase names are converted to IMA-CNMNC approved symbols
    following Warr (2021). Names with no official symbol are returned with a
    trailing `"*"`. Default is `false`.
use_GPA : Bool, optional
    If `true`, pressure is reported in GPa (column `"P[GPa]"`) instead of kbar
    (column `"P[kbar]"`). Default is `false`.

Returns
-------
nothing
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/export2CSV.jl#L12-L48" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.TE_prediction-NTuple{4, Any}' href='#MAGEMin_C.TE_prediction-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.TE_prediction</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
TE_prediction(out, C0, KDs_database, dtb; ZrSat_model="none", SSat_model="none", P2O5Sat_model="none", norm_TE=false)

Perform trace element partitioning, optionally with zircon, sulfide, and/or apatite saturation corrections.

Phases are classified via `mineral_classification`, elements are partitioned using the batch melting equation, and saturation corrections are applied when the corresponding model is not `"none"`. The corrected bulk composition (accounting for precipitated saturation phases) is also returned.

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output.
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm], in the order of `KDs_database.element_name`.
KDs_database : custom_KDs_database
    Compiled trace element partitioning coefficient database.
dtb : String
    Database identifier used for mineral classification (e.g., "ig", "mp").
ZrSat_model : String, optional
    Zirconium saturation model — "none" disables Zr correction (default: "none"). Valid options: "CB", "W85", "BD92", "RZ93", "CZLD08".
SSat_model : String, optional
    Sulfur saturation model — "none" disables S correction (default: "none"). Valid option: "1000ppm".
P2O5Sat_model : String, optional
    Phosphate saturation model — "none" disables P₂O₅ correction (default: "none"). Valid options: "Klein26", "HWBea92", "Tollari06".
norm_TE : Bool, optional
    Normalize phase fractions before computing KDs (default: false).

Returns
-------
out_TE : out_tepm
    Structure containing melt/solid/mineral TE concentrations, saturation values, and corrected bulk compositions.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L983-L1013" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C._augment_KDs_for_saturation-Tuple{custom_KDs_database, SaturationConfig}' href='#MAGEMin_C._augment_KDs_for_saturation-Tuple{custom_KDs_database, SaturationConfig}'><span class="jlbinding">MAGEMin_C._augment_KDs_for_saturation</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
_augment_KDs_for_saturation(KDs_database, sat)
```


Internal helper. When `sat` is a `SaturationConfig`, append a column of zero-KD functions for each active saturation phase that is not already present in `KDs_database.phase_name`.  Returns the (possibly augmented) database; the original is never mutated.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L676-L683" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.adjust_bulk_4_fapatite-Tuple{Float64, Float64, Float64}' href='#MAGEMin_C.adjust_bulk_4_fapatite-Tuple{Float64, Float64, Float64}'><span class="jlbinding">MAGEMin_C.adjust_bulk_4_fapatite</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
adjust_bulk_4_fapatite(P2O5_liq, sat_liq, liq_wt)

Compute the weight fractions of fluorapatite and CaO returned to the bulk when the melt exceeds P₂O₅ saturation.

Parameters
----------
P2O5_liq : Float64
    P₂O₅ concentration in the melt [ppm].
sat_liq : Float64
    P₂O₅ saturation concentration in the melt [ppm].
liq_wt : Float64
    Melt weight fraction.

Returns
-------
fapt_wt : Float64
    Weight fraction of precipitated fluorapatite (scaled by `liq_wt`).
CaO_wt : Float64
    CaO weight returned to the bulk (scaled by `liq_wt`).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L235-L255" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.adjust_bulk_4_fluid-Tuple{Float64, Float64, Float64}' href='#MAGEMin_C.adjust_bulk_4_fluid-Tuple{Float64, Float64, Float64}'><span class="jlbinding">MAGEMin_C.adjust_bulk_4_fluid</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
adjust_bulk_4_fluid(CO2_liq, sat_liq, liq_wt)

Compute the weight fractions of CO₂ fluid and the oxide correction when the
melt exceeds CO₂ saturation.

Unlike mineral saturation phases (zircon, sulfide, apatite), the excess CO₂
is not converted to a stoichiometrically distinct solid — it degasses into a
CO₂-bearing fluid.  The same CO₂ weight is therefore both the fluid weight
and the amount returned to the bulk CO₂ oxide budget for the next iteration.

Parameters
----------
CO2_liq : Float64
    CO₂ concentration in the melt [ppm].
sat_liq : Float64
    CO₂ saturation concentration in the melt [ppm].
liq_wt : Float64
    Melt weight fraction.

Returns
-------
fluid_wt : Float64
    Weight fraction of CO₂ fluid formed (scaled by `liq_wt`).
CO2_wt : Float64
    CO₂ weight returned to the bulk oxide budget (scaled by `liq_wt`);
    equals `fluid_wt` for a pure CO₂ fluid.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L773-L800" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.adjust_bulk_4_sulfide-Tuple{Float64, Float64, Float64}' href='#MAGEMin_C.adjust_bulk_4_sulfide-Tuple{Float64, Float64, Float64}'><span class="jlbinding">MAGEMin_C.adjust_bulk_4_sulfide</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
adjust_bulk_4_sulfide(S_liq, sat_liq, liq_wt)

Compute the weight fractions of sulfide, FeO, and O returned to the bulk when the melt exceeds sulfur saturation.

Parameters
----------
S_liq : Float64
    Sulfur concentration in the melt [ppm].
sat_liq : Float64
    Sulfur saturation concentration in the melt [ppm].
liq_wt : Float64
    Melt weight fraction.

Returns
-------
sulfide_wt : Float64
    Weight fraction of precipitated sulfide (scaled by `liq_wt`).
FeO_wt : Float64
    FeO weight returned to the bulk (scaled by `liq_wt`).
O_wt : Float64
    O weight correction (negative, scaled by `liq_wt`).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L446-L468" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.adjust_bulk_4_zircon-Tuple{Float64, Float64, Float64}' href='#MAGEMin_C.adjust_bulk_4_zircon-Tuple{Float64, Float64, Float64}'><span class="jlbinding">MAGEMin_C.adjust_bulk_4_zircon</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
adjust_bulk_4_zircon(zr_liq, sat_liq, liq_wt)

Compute the weight fractions of zircon, SiO₂, and O returned to the bulk when the melt exceeds Zr saturation.

Parameters
----------
zr_liq : Float64
    Zr concentration in the melt [ppm].
sat_liq : Float64
    Zr saturation concentration in the melt [ppm].
liq_wt : Float64
    Melt weight fraction.

Returns
-------
zircon_wt : Float64
    Weight fraction of precipitated zircon (scaled by `liq_wt`).
SiO2_wt : Float64
    SiO₂ weight returned to the bulk (scaled by `liq_wt`).
O2_wt : Float64
    O weight returned to the bulk (scaled by `liq_wt`).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L119-L141" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.adjust_chemical_system-Tuple{custom_KDs_database, Vector{Float64}, Vector{String}}' href='#MAGEMin_C.adjust_chemical_system-Tuple{custom_KDs_database, Vector{Float64}, Vector{String}}'><span class="jlbinding">MAGEMin_C.adjust_chemical_system</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
adjust_chemical_system(KDs_dtb, bulk_TE, elem_TE)

Reorder and subset a bulk trace element composition vector to match the element order defined in a KD database.

Elements present in `KDs_dtb` but absent from `elem_TE` are set to zero.

Parameters
----------
KDs_dtb : custom_KDs_database
    KD database whose `element_name` field defines the target element order.
bulk_TE : Vector{Float64}
    Input bulk trace element concentrations [ppm].
elem_TE : Vector{String}
    Element names corresponding to `bulk_TE`.

Returns
-------
C0_TE : Vector{Float64}
    Bulk trace element concentrations reordered to match `KDs_dtb.element_name` [ppm].
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L345-L365" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.all_identical-Tuple{Vector{UInt64}}' href='#MAGEMin_C.all_identical-Tuple{Vector{UInt64}}'><span class="jlbinding">MAGEMin_C.all_identical</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
all_identical(arr::Vector{UInt64})

Check whether all elements in a `UInt64` vector are identical.

Parameters
----------
arr : Vector{UInt64}
    Vector of hash values to compare.

Returns
-------
result : Bool
    `true` if all elements equal `arr[1]`, `false` otherwise.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/AMR.jl#L144-L158" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L78-L92" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.amph_sites-Tuple{Any}' href='#MAGEMin_C.amph_sites-Tuple{Any}'><span class="jlbinding">MAGEMin_C.amph_sites</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
amph_sites(wt)
```


hb_G16 — Green et al. (2016). Sites: A(v Na K), M13(Mg Fe), M2(Mg Fe Al Fe³⁺ Ti), M4(Ca Mg Fe Na), T1*(Si Al). Normalised to 23 oxygens (8 T1 positions per formula unit). TC variables:   y = xAlM2, z = xNaM4, c = xCaM4, a = total A-site occupancy.   xAlT1 ≈ y/2 + a/4  (simplified: ignoring small f, t, z contributions)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L353-L361" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.anelastic_correction-Tuple{Int64, Float64, Float64, Float64}' href='#MAGEMin_C.anelastic_correction-Tuple{Int64, Float64, Float64, Float64}'><span class="jlbinding">MAGEMin_C.anelastic_correction</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
anelastic_correction(water, Vs0, P_kbar, T_K)

Anelastic (attenuation) correction for the S-wave velocity, following the
model of Behn et al. (2009), with frequency/grain-size terms from
Cobden et al. (2018).

Parameters
----------
water : Int
    Water content mode: `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (saturated).
Vs0 : Float64
    Unrelaxed (elastic) S-wave velocity [km/s].
P_kbar : Float64
    Pressure [kbar].
T_K : Float64
    Temperature [K].

Returns
-------
Vs_anel : Float64
    Anelastically corrected S-wave velocity [km/s].

Reference
---------
Behn M.D., Hirth G., Elsenbeck J.R. (2009); Cobden L. et al. (2018)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/seismic_corrections.jl#L140-L166" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L101-L117" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.bi_Li_CB_model-Tuple{Float64, Float64, Float64}' href='#MAGEMin_C.bi_Li_CB_model-Tuple{Float64, Float64, Float64}'><span class="jlbinding">MAGEMin_C.bi_Li_CB_model</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
bi_Li_CB_model(y, f, T)

Compute the Li partition coefficient between biotite and melt, after Beard (2025).

Parameters
----------
y : Float64
    Biotite Al-content compositional variable (Al on T site).
f : Float64
    Biotite Fe/(Fe+Mg) compositional variable.
T : Float64
    Temperature [°C].

Returns
-------
KD_Li : Float64
    Li partition coefficient (biotite/melt).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_ph_models.jl#L11-L29" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.bi_Li_IL_model-Tuple{Float64}' href='#MAGEMin_C.bi_Li_IL_model-Tuple{Float64}'><span class="jlbinding">MAGEMin_C.bi_Li_IL_model</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
bi_Li_IL_model(T)

Compute the Li partition coefficient between biotite and melt using a linear temperature model (Imai & Liang, unpublished).

Parameters
----------
T : Float64
    Temperature [°C].

Returns
-------
KD_Li : Float64
    Li partition coefficient (biotite/melt).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_ph_models.jl#L42-L56" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.cd_Li_IL_model-Tuple{Float64}' href='#MAGEMin_C.cd_Li_IL_model-Tuple{Float64}'><span class="jlbinding">MAGEMin_C.cd_Li_IL_model</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
cd_Li_IL_model(T)

Compute the Li partition coefficient between cordierite and melt using a linear temperature model (Imai & Liang, unpublished).

Parameters
----------
T : Float64
    Temperature [°C].

Returns
-------
KD_Li : Float64
    Li partition coefficient (cordierite/melt).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_ph_models.jl#L61-L75" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.co2_saturation-Tuple{out_struct}' href='#MAGEMin_C.co2_saturation-Tuple{out_struct}'><span class="jlbinding">MAGEMin_C.co2_saturation</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
co2_saturation(out; model="SY26")

Compute the CO₂ saturation concentration in the melt phase [ppm].

Reads dissolved H₂O from the melt phase of `out`, inverts the SY26 H₂O
equation to find P_H₂O, then evaluates CO₂ solubility at
P_CO₂ = P_total − P_H₂O (binary H₂O–CO₂ fluid assumption).

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output (must contain a melt phase with dissolved H₂O).
model : String, optional
    Saturation model (default: "SY26"). Currently only "SY26" is supported.

Returns
-------
S_CO2 : Float64
    CO₂ saturation concentration in the melt [ppm], or NaN if H₂O is
    unavailable or the model is unrecognised.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L740-L761" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_CO2_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_CO2_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_CO2_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_CO2_sat_n_part(out, KDs_database, Cliq, bulk_cor_wt, C0, liq_wt; CO2Sat_model="SY26")

Check CO₂ saturation and adjust the corrected bulk composition if the melt exceeds the CO₂ saturation limit.

If CO₂ in the melt exceeds the saturation concentration, the excess degasses into a CO₂-bearing fluid and the
corresponding weight is added back to the bulk CO₂ oxide entry in `bulk_cor_wt`.  Unlike mineral saturation
phases, no stoichiometrically distinct oxide is returned — the excess CO₂ re-enters the CO₂ oxide budget directly.

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output.
KDs_database : custom_KDs_database
    Trace element partitioning coefficient database (must include "CO2").
Cliq : Vector{Float64}
    Current trace element concentrations in the melt [ppm].
bulk_cor_wt : Vector{Float64}
    Corrected bulk oxide weight fractions (modified in place).
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
liq_wt : Float64
    Melt weight fraction.
CO2Sat_model : String, optional
    CO₂ saturation model (default: "SY26"). Passed to `co2_saturation`.

Returns
-------
Sat_CO2_liq : Float64
    CO₂ saturation concentration in the melt [ppm].
fl_CO2_wt : Float64
    Weight fraction of CO₂ fluid formed.
bulk_cor_wt : Vector{Float64}
    Updated corrected bulk oxide weight fractions.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L921-L955" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_P2O5_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_P2O5_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_P2O5_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_P2O5_sat_n_part(out, KDs_database, Cliq, bulk_cor_wt, C0, liq_wt; P2O5Sat_model="Klein26")

Check phosphate saturation and adjust the corrected bulk composition if the melt exceeds the P₂O₅ saturation limit.

If P₂O₅ in the melt exceeds the saturation concentration, the excess is removed and the corresponding CaO is returned to the bulk. If there is no melt, all P₂O₅ is assumed to have precipitated as fluorapatite.

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output.
KDs_database : custom_KDs_database
    Trace element partitioning coefficient database (must include "P2O5").
Cliq : Vector{Float64}
    Current trace element concentrations in the melt [ppm].
bulk_cor_wt : Vector{Float64}
    Corrected bulk oxide weight fractions (modified in place).
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
liq_wt : Float64
    Melt weight fraction.
P2O5Sat_model : String, optional
    Phosphate saturation model (default: "Klein26"). Passed to `phosphate_saturation`.

Returns
-------
Sat_P2O5_liq : Float64
    P₂O₅ saturation concentration in the melt [ppm].
fapt_wt : Float64
    Weight fraction of precipitated fluorapatite.
bulk_cor_wt : Vector{Float64}
    Updated corrected bulk oxide weight fractions.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L852-L884" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_S_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_S_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_S_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_S_sat_n_part(out, KDs_database, Cliq, bulk_cor_wt, C0, liq_wt; SSat_model="1000ppm")

Check sulfur saturation and adjust the corrected bulk composition if the melt exceeds the S saturation limit.

If S in the melt exceeds the saturation concentration, the excess is removed and the corresponding FeO and O are returned to the bulk. If there is no melt, all S is assumed to have precipitated as sulfide.

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output.
KDs_database : custom_KDs_database
    Trace element partitioning coefficient database (must include "S").
Cliq : Vector{Float64}
    Current trace element concentrations in the melt [ppm].
bulk_cor_wt : Vector{Float64}
    Corrected bulk oxide weight fractions (modified in place).
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
liq_wt : Float64
    Melt weight fraction.
SSat_model : String, optional
    Sulfur saturation model (default: "1000ppm"). Passed to `sulfur_saturation`.

Returns
-------
Sat_S_liq : Float64
    S saturation concentration in the melt [ppm].
sulf_wt : Float64
    Weight fraction of precipitated sulfide.
bulk_cor_wt : Vector{Float64}
    Updated corrected bulk oxide weight fractions.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L780-L812" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_TE_partitioning-Tuple{custom_KDs_database, out_struct, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}' href='#MAGEMin_C.compute_TE_partitioning-Tuple{custom_KDs_database, out_struct, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}'><span class="jlbinding">MAGEMin_C.compute_TE_partitioning</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_TE_partitioning(KDs_database, out, C0, ph, ph_wt, liq_wt, sol_wt; norm_TE=true)

Partition trace elements between melt and solid phases using the supplied KD database.

Handles three end-member cases: fully molten (`liq_wt == 1.0`), fully solid (`liq_wt == 0.0`), and mixed (`0 < liq_wt < 1`). In the mixed case the batch melting equation is applied.

Parameters
----------
KDs_database : custom_KDs_database
    Compiled trace element partitioning coefficient database.
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output used to evaluate P-T-composition-dependent KDs.
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
ph : Vector{String}
    Phase names from `mineral_classification`.
ph_wt : Vector{Float64}
    Weight fractions of each phase.
liq_wt : Float64
    Melt weight fraction.
sol_wt : Float64
    Solid weight fraction.
norm_TE : Bool, optional
    Normalize phase fractions before computing KDs (default: true).

Returns
-------
Cliq : Vector{Float64}
    Trace element concentrations in the melt [ppm].
Csol : Vector{Float64}
    Trace element concentrations in the bulk solid [ppm].
Cmin : Matrix{Float64}
    Trace element concentrations in each mineral phase [ppm].
ph_TE : Vector{String}
    Phase names included in the calculation.
ph_wt_norm : Vector{Float64}
    Normalized solid phase weight fractions.
liq_wt_norm : Float64
    Normalized melt weight fraction.
bulk_D : Float64
    Bulk partition coefficient.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L595-L637" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_Zr_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}' href='#MAGEMin_C.compute_Zr_sat_n_part-Tuple{out_struct, custom_KDs_database, Any, Any, Any, Float64}'><span class="jlbinding">MAGEMin_C.compute_Zr_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_Zr_sat_n_part(out, KDs_database, Cliq, bulk_cor_wt, C0, liq_wt; ZrSat_model="CB")

Check zircon saturation and adjust the corrected bulk composition if the melt exceeds the Zr saturation limit.

If Zr in the melt exceeds the saturation concentration, the excess is removed from the melt and the corresponding SiO₂ and O are returned to the bulk. If there is no melt (`liq_wt == 0`), all Zr is assumed to have precipitated as zircon.

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output.
KDs_database : custom_KDs_database
    Trace element partitioning coefficient database (must include "Zr").
Cliq : Vector{Float64}
    Current trace element concentrations in the melt [ppm].
bulk_cor_wt : Vector{Float64}
    Corrected bulk oxide weight fractions (modified in place).
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
liq_wt : Float64
    Melt weight fraction.
ZrSat_model : String, optional
    Zirconium saturation model (default: "CB"). Passed to `zirconium_saturation`.

Returns
-------
Sat_Zr_liq : Float64
    Zr saturation concentration in the melt [ppm].
zrc_wt : Float64
    Weight fraction of precipitated zircon.
bulk_cor_wt : Vector{Float64}
    Updated corrected bulk oxide weight fractions.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L710-L742" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_index-Tuple{Any, Any, Any}' href='#MAGEMin_C.compute_index-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.compute_index</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_index(value, min_value, delta)

Compute the 1-based grid index of a coordinate value along one axis.

Parameters
----------
value : Float64
    Coordinate value to index.
min_value : Float64
    Minimum value of the axis.
delta : Float64
    Grid spacing along the axis.

Returns
-------
index : Int64
    1-based index of `value` in the uniform grid.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/AMR.jl#L59-L77" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_melt_viscosity_G08-Tuple{Any, Any, Any}' href='#MAGEMin_C.compute_melt_viscosity_G08-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.compute_melt_viscosity_G08</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_melt_viscosity_G08(oxides, M_mol, T_C; A = -4.55)

Compute melt viscosity using the Giordano, Russell & Dingwell (2008) model.

Oxide compositions are mapped onto the 12-component GRD08 system
(SiO₂, Al₂O₃, TiO₂, FeO, CaO, MgO, MnO, Na₂O, K₂O, P₂O₅, H₂O, F₂O₋₁),
re-normalised to 100 mol%, and combined via the VTF equation:

    log₁₀(η) = A + B / (T_K − C)

Viscosity is capped at 10¹⁴ Pa·s.

Parameters
----------
oxides : Vector{String}
    Oxide names for the melt composition (MAGEMin ordering).
M_mol : Vector{Float64}
    Melt composition in mol fractions, indexed to match `oxides`.
T_C : Float64
    Temperature [°C].
A : Float64
    Pre-exponential constant (default: −4.55, after Giordano et al. 2008).

Returns
-------
eta : Float64
    Melt viscosity [Pa·s], capped at 10¹⁴ Pa·s.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/External_routines.jl#L19-L47" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1879-L1901" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.convert_SS_eval_TE-Tuple{Any}' href='#MAGEMin_C.convert_SS_eval_TE-Tuple{Any}'><span class="jlbinding">MAGEMin_C.convert_SS_eval_TE</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
convert_SS_eval_TE(str)

Rewrite `[:phase]` subscript tokens in a KD expression string to fully-qualified `gmin_struct` accessor calls.

The pattern `[:name]` is replaced with `out.SS_vec[out.SS_syms[:name]]`, allowing KD expressions to reference solution phase data by short name (e.g., `[:liq].compVariables[1]` → `out.SS_vec[out.SS_syms[:liq]].compVariables[1]`).

Parameters
----------
str : String
    KD expression string potentially containing `[:phase]` tokens.

Returns
-------
str : String
    Expression string with all `[:phase]` tokens replaced.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L312-L328" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.cpx_sites-Tuple{Any}' href='#MAGEMin_C.cpx_sites-Tuple{Any}'><span class="jlbinding">MAGEMin_C.cpx_sites</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
cpx_sites(wt)
```


cpx_G23 — Green et al. (in prep), after Holland et al. (2018). Sites: T*(Si Al), M1(Mg Fe Al Fe³⁺ Cr Ti), M2(Ca Na K Mg Fe). Normalised to 6 oxygens. TC composition variables:   y = 2·xAlT (= Al_T count per f.u. = XAl4)   x = Fe/(Fe+Mg), o = xMgM2+xFeM2, n = xNaM2, k = xKM2   Q = order variable → set to 0 (disordered approximation).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L93-L102" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}, Vector{String}, VecOrMat{String}}' href='#MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}, Vector{String}, VecOrMat{String}}'><span class="jlbinding">MAGEMin_C.create_custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_custom_KDs_database(el_name, phase_name, KDs_expr_str; info="Custom KDs database")

Create a custom trace element partitioning coefficient (KD) database from string expressions.

Each expression in `KDs_expr_str` may reference `T_C`, `P_kbar`, `oxides`, and solution phase compositional variables using the syntax `[:phase_name]` (e.g., `[:liq].compVariables[1]`). These are resolved against the `gmin_struct` output at evaluation time.

Parameters
----------
el_name : Vector{String}
    Names of the trace elements.
phase_name : Vector{String}
    Names of the mineral phases.
KDs_expr_str : Union{Matrix{String}, Vector{String}}
    Matrix (phases × elements) or vector of KD expressions as strings.
info : String, optional
    Description or citation for the database (default: "Custom KDs database").

Returns
-------
db : custom_KDs_database
    Compiled KD database ready for use in `TE_prediction`.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L413-L435" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}, Vector{String}}' href='#MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}, Vector{String}}'><span class="jlbinding">MAGEMin_C.create_custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_custom_KDs_database(el_name, phase_name; info)

Create a KDs database with the given elements and phases, all KDs set to zero.
Useful when phases are known but partition coefficients are saturation-controlled.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L397-L402" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}}' href='#MAGEMin_C.create_custom_KDs_database-Tuple{Vector{String}}'><span class="jlbinding">MAGEMin_C.create_custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_custom_KDs_database(el_name; info)

Create an elements-only KDs database with no phases. Phases (and zero KDs) are added
automatically by `_augment_KDs_for_saturation` when a `SaturationConfig` is provided
to `TE_prediction` or `solve_with_saturation`.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L383-L389" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_gmin_struct-Tuple{Any, Any, Any}' href='#MAGEMin_C.create_gmin_struct-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.create_gmin_struct</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_gmin_struct(DB, gv, time; name_solvus=false, seismic_cor=false, aspect_ratio=0.3)

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
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) using [`wave_melt_correction`](@ref)
    and [`anelastic_correction`](@ref) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, passed to
    [`wave_melt_correction`](@ref) when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the full minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2691-L2721" target="_blank" rel="noreferrer">source</a></Badge>

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
out : light_gmin_struct{Float32, Int8, String}
    Lightweight structure containing essential minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2891-L2907" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_light_gmin_struct_ig-Tuple{Any, Any}' href='#MAGEMin_C.create_light_gmin_struct_ig-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.create_light_gmin_struct_ig</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
create_light_gmin_struct_ig(DB, gv)

Extract a lightweight output of a pointwise MAGEMin optimization into a Julia structure (Float32/Int8 types).

Parameters
----------
DB : LibMAGEMin.Database
    Database structure.
gv : LibMAGEMin.global_variables
    Global variables structure.

Returns
-------
out : light_gmin_struct_ig{Float32, Int8, String}
    Lightweight extended structure containing essential minimization results for igneous databases.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2971-L2987" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1726-L1748" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1039-L1056" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.fsp_sites-Tuple{Any}' href='#MAGEMin_C.fsp_sites-Tuple{Any}'><span class="jlbinding">MAGEMin_C.fsp_sites</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
fsp_sites(wt)
```


fsp_H21 — Holland et al. (2021), ternary feldspar. Sites: A(Na Ca K), TB*(Si Al with 1/4 entropy contribution). Normalised to 8 oxygens. TC variables: ca = xCaA = XAn, k = xKA = XOr.   xAlTB = (1 + ca)/4,  xSiTB = (3 - ca)/4


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L276-L283" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_CO_KDs_database-Tuple{}' href='#MAGEMin_C.get_CO_KDs_database-Tuple{}'><span class="jlbinding">MAGEMin_C.get_CO_KDs_database</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_CO_KDs_database()
```


Build a `custom_KDs_database` using the lattice strain models of Cornet (2017) with Thermocalc a-x solution model site fractions (cpx_G23, g_G23, opx_G23, ol_H18, fsp_H21, hb_G16).

Requires `lattice_strain.jl` to be included before calling this function.

Element order (28 elements, fixed): Cs Rb K | Ba Sr | La…Lu Sc | Ti Hf Zr | U Th | Ta Nb

Phase names after `mineral_classification` that are handled:   "cpx", "gt", "opx", "pl", "ol", "hb", "amp"

Returns a `custom_KDs_database` ready to pass directly to `TE_prediction`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L1272-L1287" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_TE_database' href='#MAGEMin_C.get_TE_database'><span class="jlbinding">MAGEMin_C.get_TE_database</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
get_TE_database(tedb="OL12")

Return the built-in trace element (TE) partitioning coefficient database.

Parameters
----------
tedb : String, optional
    Database identifier (default: "OL12"). Currently only "OL12" is supported (Laurent, 2012).

Returns
-------
db : custom_KDs_database
    Trace element partitioning coefficient database containing element names, phase names, and partition coefficient expressions.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L16-L30" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_Warr_name-Tuple{String}' href='#MAGEMin_C.get_Warr_name-Tuple{String}'><span class="jlbinding">MAGEMin_C.get_Warr_name</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_Warr_name(name)

Convert a MAGEMin mineral/endmember abbreviation to its IMA-CNMNC approved
symbol following Warr (2021).

Names with no official Warr equivalent (composite endmembers, model-specific
components, buffer assemblages, activities) are returned as `name * "*"` so
that downstream code always receives a plain `String` without special-casing.

Parameters
----------
name : String
    MAGEMin internal phase or endmember name (e.g. `"ab"`, `"phl"`, `"q4L"`).

Returns
-------
symbol : String
    Warr (2021) symbol (e.g. `"Ab"`, `"Phl"`) or `name * "*"` when not listed.

Reference
---------
Warr L.N. (2021) IMA-CNMNC approved mineral symbols.
Mineralogical Magazine 85, 291–320. doi:10.1180/mgm.2021.43
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/Warr2021.jl#L32-L56" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_Warr_names-Tuple{Vector{String}}' href='#MAGEMin_C.get_Warr_names-Tuple{Vector{String}}'><span class="jlbinding">MAGEMin_C.get_Warr_names</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_Warr_names(names)

Vectorised form of `get_Warr_name`: convert a vector of MAGEMin names to
their Warr (2021) symbols in one call. Entries with no mapping are returned
as `name * "*"`.

Parameters
----------
names : Vector{String}
    Vector of MAGEMin phase or endmember names.

Returns
-------
symbols : Vector{String}
    Corresponding Warr (2021) symbols.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/Warr2021.jl#L61-L77" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_all_stable_phases-Tuple{Union{out_struct, Vector{out_struct}}}' href='#MAGEMin_C.get_all_stable_phases-Tuple{Union{out_struct, Vector{out_struct}}}'><span class="jlbinding">MAGEMin_C.get_all_stable_phases</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_all_stable_phases(out)

Collect the unique set of stable phase names across all minimization points.

Solution phases are sorted alphabetically and listed first; pure phases follow
in their own sorted block. For example:
`["amp", "bi", "chl", "cpx", "ep", "fl", "fsp", "liq", "opx", "sph", "q", "ru"]`

Parameters
----------
out : Union{Vector{gmin_struct{Float64, Int64}}, gmin_struct{Float64, Int64}}
    MAGEMin minimization output for one or more points.

Returns
-------
ph_names : Vector{String}
    Sorted unique phase names (solution phases first, then pure phases).
n_ss : Int64
    Number of unique solution phases.
n_pp : Int64
    Number of unique pure phases.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/export2CSV.jl#L564-L586" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_mineral_name-Tuple{Any, Any, Any}' href='#MAGEMin_C.get_mineral_name-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.get_mineral_name</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_mineral_name(db, ss, SS_vec)

Return a mineralogically meaningful name for a solution phase based on its compositional variables (solvus disambiguation).

For solution phases that straddle a solvus (e.g., feldspar → plagioclase or alkali feldspar; spinel → spinel, magnetite, or ulvöspinel), the returned name reflects the dominant endmember rather than the generic solution phase label.

Parameters
----------
db : String
    Database identifier (e.g., "ig", "igad", "mp", "mpe", "mb", "ume", "mbe").
ss : String
    Solution phase short name (e.g., "fsp", "spl", "amp", "ilm").
SS_vec : LibMAGEMin.SS_data
    Solution phase data structure containing `compVariables`.

Returns
-------
mineral_name : String
    Disambiguated mineral name (e.g., "pl", "afs", "mgt", "ilm", "hem").
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/name_solvus.jl#L11-L31" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_mineral_name_Warr-Tuple{Any, Any, Any}' href='#MAGEMin_C.get_mineral_name_Warr-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.get_mineral_name_Warr</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_mineral_name_Warr(db, ss, SS_vec)

Return the Warr (2021) IMA-CNMNC symbol for the solvus-disambiguated name of
a solution phase.  Internally calls `get_mineral_name` for solvus logic, then
maps the result through `get_Warr_name`.

Parameters
----------
db     : String  — database identifier (e.g. `"ig"`, `"mp"`).
ss     : String  — solution phase short name (e.g. `"fsp"`, `"amp"`).
SS_vec : LibMAGEMin.SS_data — solution phase data structure.

Returns
-------
symbol : String — Warr (2021) symbol, or the disambiguated name * "*"` if
         no official symbol is defined.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/Warr2021.jl#L82-L99" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L53-L67" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_ss_from_mineral-Tuple{Any, Any, Any}' href='#MAGEMin_C.get_ss_from_mineral-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.get_ss_from_mineral</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_ss_from_mineral(db, mrl, mbCpx)

Return the solution phase name corresponding to a disambiguated mineral name (inverse of `get_mineral_name`).

Parameters
----------
db : String
    Database identifier (e.g., "ig", "igad", "mp", "mpe", "mb", "ume", "mbe").
mrl : String
    Disambiguated mineral name (e.g., "pl", "afs", "mgt", "hem", "omph").
mbCpx : Int64
    Metabasite clinopyroxene model flag. Controls whether omphacite/diopside maps to "dio" (0) or "aug" (1).

Returns
-------
ss : String
    Solution phase short name (e.g., "fsp", "spl", "amp", "ilm").
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/name_solvus.jl#L118-L136" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.gt_sites-Tuple{Any}' href='#MAGEMin_C.gt_sites-Tuple{Any}'><span class="jlbinding">MAGEMin_C.gt_sites</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
gt_sites(wt)
```


g_G23 — Green et al. (in prep), after Holland et al. (2018). Sites: M1(Mg Fe Ca) dodecahedral, M2(Al Cr Fe³⁺ Mg Ti) octahedral. Normalised to 12 oxygens. TC composition variables:   c = xCaM1 (= XGr), x = xFeM1/(xFeM1+xMgM1) = Fe/(Fe+Mg). Note: TC labels the dodecahedral site M1 and octahedral site M2; xAlM2 ≈ 1 for typical igneous garnets.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L164-L173" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.health_check_TE-Tuple{Any, Any}' href='#MAGEMin_C.health_check_TE-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.health_check_TE</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
health_check_TE(C0, KDs_database)

Validate that the initial composition vector and KD database are consistent before running TE partitioning.

Parameters
----------
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
KDs_database : custom_KDs_database
    KD database to validate against `C0`.

Returns
-------
status : Int64
    1 if all checks pass, 0 if any check fails (errors are also thrown).
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L554-L570" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L890-L932" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.initialize_AMR-Tuple{Any, Any, Any}' href='#MAGEMin_C.initialize_AMR-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.initialize_AMR</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
initialize_AMR(Xrange, Yrange, igs)

Create an initial uniform quadrilateral grid for Adaptive Mesh Refinement.

The grid has `2^igs` cells per dimension, covering the rectangular domain defined by `Xrange` and `Yrange`.

Parameters
----------
Xrange : Union{Tuple{Float64,Float64}, Vector{Float64}}
    X-axis bounds of the domain [Xmin, Xmax].
Yrange : Union{Tuple{Float64,Float64}, Vector{Float64}}
    Y-axis bounds of the domain [Ymin, Ymax].
igs : Int64
    Initial subdivision level; produces `2^igs × 2^igs` cells.

Returns
-------
data : AMR_data
    Initialized AMR data structure with the uniform grid.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/AMR.jl#L83-L103" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.logish-Tuple{Float64}' href='#MAGEMin_C.logish-Tuple{Float64}'><span class="jlbinding">MAGEMin_C.logish</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
logish(x)

Safe natural logarithm that returns 0.0 for non-positive inputs instead of `-Inf` or `NaN`.

Parameters
----------
x : Float64
    Input value.

Returns
-------
Float64
    `log(x)` if `x > 0`, otherwise `0.0`.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L276-L290" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.make_composition-Tuple{Vector{String}, Vector{Float64}}' href='#MAGEMin_C.make_composition-Tuple{Vector{String}, Vector{Float64}}'><span class="jlbinding">MAGEMin_C.make_composition</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
make_composition(names, wt; Fe2O3=0.0) -> NamedTuple
```


Build the oxide wt% NamedTuple expected by every `D_*` and `*_sites` function from parallel vectors of oxide names and wt% values.

Names recognised (case-sensitive):   "SiO2"  "TiO2"  "Al2O3"  "FeO"  "MnO"  "MgO"  "CaO"  "Na2O"  "K2O"  "H2O"

Any oxide not listed defaults to 0.0.

If your analysis reports total iron as Fe₂O₃, pass `Fe2O3=<wt%>` and it is converted to FeO-equivalent (×0.8998) and added to any existing "FeO" entry.

**Example**

```julia
oxides = ["SiO2","TiO2","Al2O3","FeO","MgO","CaO","Na2O"]
cpx  = make_composition(oxides, [50.45, 1.45, 6.30, 9.38, 13.53, 18.10, 0.70])
melt = make_composition(
    ["SiO2","TiO2","Al2O3","FeO","MgO","CaO","Na2O","K2O","H2O"],
    [67.67,  1.27,  15.30,  2.79,  1.39,  4.17,  3.13,  1.94, 13.8])

D = D_cpx(1273.0, 1.0, melt, cpx)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L838-L862" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.mineral_classification-Tuple{out_struct, String}' href='#MAGEMin_C.mineral_classification-Tuple{out_struct, String}'><span class="jlbinding">MAGEMin_C.mineral_classification</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
mineral_classification(out, dtb)

Classify the stable phases from a MAGEMin minimization result into mineralogical names compatible with the trace element partitioning coefficient database.

Solution phases that straddle a solvus (e.g., feldspar, spinel, ilmenite) are disambiguated using their compositional variables. Duplicate phases resulting from solvus splitting are merged by summing their weight fractions.

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output structure.
dtb : String
    Database identifier (e.g., "ig", "igad", "mp", "mpe", "mb", "ume", "mbe").

Returns
-------
ph : Vector{String}
    Classified phase names compatible with the TE partitioning database.
ph_wt : Vector{Float64}
    Weight fractions corresponding to each phase.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L44-L64" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1801-L1817" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.multi_point_minimization-Tuple{AbstractMatrix{Float64}, AbstractMatrix{Float64}, MAGEMin_Data}' href='#MAGEMin_C.multi_point_minimization-Tuple{AbstractMatrix{Float64}, AbstractMatrix{Float64}, MAGEMin_Data}'><span class="jlbinding">MAGEMin_C.multi_point_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
multi_point_minimization(P, T, MAGEMin_db; X=nothing, ...)

Matrix overload for 2D model grids. `P` and `T` are matrices of the same
size (e.g. `(nx, ny)`) representing a spatial grid of pressures [kbar] and
temperatures [°C]. They are flattened internally, computed in parallel, and
the results are returned as a matrix of the same shape.

The bulk-rock composition `X` can be:
- `nothing` (use a built-in test case, set via `test=`)
- `Vector{Float64}` of length `noxides` — same composition for every node
- `Matrix{Float64}` of size `(nx*ny, noxides)` — per-node composition,
  where row `i` corresponds to the linearised index of the grid

All other keyword arguments are forwarded to the vector-based method.

Examples
--------
```julia
data    = Initialize_MAGEMin("ig", verbose=false);
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","Fe2O3","K2O","Na2O","TiO2","Cr2O3","H2O"]
X       = [48.43, 15.19, 11.57, 10.13, 6.65, 1.64, 0.59, 1.87, 0.68, 0.0, 3.0]

# 2-D P-T grid (uniform bulk)
P_grid  = [8.0  9.0; 10.0 11.0]   # (2×2)
T_grid  = [800.0 850.0; 900.0 950.0]
out     = multi_point_minimization(P_grid, T_grid, data, X=X, Xoxides=Xoxides, sys_in="wt")
# out is a (2×2) Matrix{gmin_struct}

Finalize_MAGEMin(data)
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1202-L1233" target="_blank" rel="noreferrer">source</a></Badge>

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
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).
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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1289-L1364" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.ol_sites-Tuple{Any}' href='#MAGEMin_C.ol_sites-Tuple{Any}'><span class="jlbinding">MAGEMin_C.ol_sites</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
ol_sites(wt)
```


ol_H18 — Holland et al. (2018). Sites: M1(Mg Fe), M2(Mg Fe Ca). Normalised to 4 oxygens. TC variables: x = Fe/(Fe+Mg), c = xCaM2, Q=0.   xMgM1 = 1-x, xFeM1 = x, xMgM2 = 1-c-x, xFeM2 = x*(1-c), xCaM2 = c


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L312-L319" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.opx_sites-Tuple{Any}' href='#MAGEMin_C.opx_sites-Tuple{Any}'><span class="jlbinding">MAGEMin_C.opx_sites</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
opx_sites(wt)
```


opx_G23 — Green et al. (in prep), after Holland et al. (2018). Sites: T*(Si Al), M1(Mg Fe Al Fe³⁺ Cr Ti), M2(Ca Na Mg Fe). Normalised to 6 oxygens. TC composition variables:   y = 2·xAlT, c = xCaM2, j = xNaM2, x = Fe/(Fe+Mg), Q=0.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/lattice_strain.jl#L221-L228" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.partition_TE-Tuple{custom_KDs_database, out_struct, Vector{Float64}, Vector{String}, Vector{Float64}, Float64}' href='#MAGEMin_C.partition_TE-Tuple{custom_KDs_database, out_struct, Vector{Float64}, Vector{String}, Vector{Float64}, Float64}'><span class="jlbinding">MAGEMin_C.partition_TE</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
partition_TE(KDs_database, out, C0, ph, ph_wt, liq_wt; norm_TE=true)

Apply the batch melting equation to partition trace elements between melt and solid phases for the subset of phases present in both the MAGEMin output and the KD database.

Parameters
----------
KDs_database : custom_KDs_database
    Compiled KD database.
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output used to evaluate P-T-composition-dependent KDs.
C0 : Vector{Float64}
    Initial bulk trace element composition [ppm].
ph : Vector{String}
    Phase names from `mineral_classification`.
ph_wt : Vector{Float64}
    Weight fractions of each phase.
liq_wt : Float64
    Melt weight fraction.
norm_TE : Bool, optional
    Normalize phase fractions to the phases present in the KD database (default: true).

Returns
-------
Cliq : Vector{Float64}
    Trace element concentrations in the melt [ppm].
Cmin : Matrix{Float64}
    Trace element concentrations in each mineral phase [ppm] (phases × elements).
Csol : Vector{Float64}
    Trace element concentrations in the bulk solid [ppm].
ph_TE : Vector{String}
    Names of phases included in the calculation.
ph_wt_norm : Vector{Float64}
    Normalized solid phase weight fractions.
liq_wt_norm : Float64
    Normalized melt weight fraction.
bulk_D : Float64
    Bulk partition coefficient.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L463-L501" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.phosphate_saturation-Tuple{out_struct}' href='#MAGEMin_C.phosphate_saturation-Tuple{out_struct}'><span class="jlbinding">MAGEMin_C.phosphate_saturation</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
phosphate_saturation(out; model="Klein26")

Compute the P₂O₅ saturation concentration in the melt phase [ppm].

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output (must contain a melt phase with a "liq" solution phase).
model : String, optional
    Saturation model (default: "Klein26"). Valid options:
    - "Klein26"  — Klein et al. (2026)
    - "HWBea92"  — Harrison & Watson (1984) + correction from Bea et al. (1992); for hydrous systems
    - "Tollari06" — Tollari et al. (2006); calibrated for dry systems

Returns
-------
C_P2O5_liq : Float64
    P₂O₅ saturation concentration in the melt [ppm], or -1 if the model is unrecognized.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L159-L178" target="_blank" rel="noreferrer">source</a></Badge>

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
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L3461-L3509" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization-Tuple{Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_minimization-Tuple{Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
point_wise_minimization(P, T, gv, z_b, DB, splx_data; light=false, name_solvus=false, fixed_bulk=false, buffer_n=0.0, Gi=nothing, scp=0, dT=2.0, iguess=false, rm_list=nothing, W=nothing, seismic_cor=false, aspect_ratio=0.3)

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
light_ig : Bool, optional
    Return an extended lightweight structure for igneous databases (default: false).
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
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2043-L2126" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2462-L2480" target="_blank" rel="noreferrer">source</a></Badge>

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
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the minimization results.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L3308-L3342" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L3085-L3094" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2546-L2592" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.pwm_run-NTuple{4, Any}' href='#MAGEMin_C.pwm_run-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.pwm_run</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
pwm_run(gv, z_b, DB, splx_data; name_solvus=false, seismic_cor=false, aspect_ratio=0.3)

Run the equilibrium computation and post-processing after `pwm_init`. Intended for thermodynamic database inversion/calibration workflows.

Parameters
----------
gv : LibMAGEMin.global_variables
    Global variables structure (initialized via `pwm_init`).
z_b : LibMAGEMin.bulk_infos
    Bulk rock information structure.
DB : LibMAGEMin.Database
    Database structure.
splx_data : LibMAGEMin.simplex_datas
    Simplex data structure.
name_solvus : Bool, optional
    Resolve solvus naming (default: false).
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the minimization results.

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L2623-L2667" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L714-L730" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.retrieve_eval_rules_TE-Tuple{}' href='#MAGEMin_C.retrieve_eval_rules_TE-Tuple{}'><span class="jlbinding">MAGEMin_C.retrieve_eval_rules_TE</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
retrieve_eval_rules_TE()

Return the token substitution rules used when compiling KD expression strings.

Plain tokens such as `T_C` and `P_kbar` are replaced with their fully-qualified counterparts on a `gmin_struct` (e.g., `out.T_C`), so that compiled functions can be called with a single `out` argument.

Returns
-------
in_eval_TE : Vector{String}
    Tokens to search for in the expression string.
out_eval_TE : Vector{String}
    Replacement strings referencing the `out` argument.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L289-L302" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L690-L704" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.single_point_minimization-Union{Tuple{T1}, Tuple{T1, T1, MAGEMin_Data}} where T1<:Float64' href='#MAGEMin_C.single_point_minimization-Union{Tuple{T1}, Tuple{T1, T1, MAGEMin_Data}} where T1<:Float64'><span class="jlbinding">MAGEMin_C.single_point_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



````julia
single_point_minimization(P, T, MAGEMin_db; light=false, light_ig=false, name_solvus=false, fixed_bulk=false, test=0, X=nothing, B=nothing, G=nothing, scp=0, dT=2.0, iguess=false, rm_list=nothing, W=nothing, Xoxides=Vector{String}, sys_in="mol", rg="tc", progressbar=true)

Perform a MAGEMin Gibbs energy minimization at a single pressure-temperature point.

This is a convenience wrapper around `multi_point_minimization` for scalar `P` and `T` inputs.

Parameters
----------
P : Float64
    Pressure [kbar].
T : Float64
    Temperature [°C].
MAGEMin_db : MAGEMin_Data
    Initialized MAGEMin data structure.
light : Bool, optional
    Return a lightweight output structure (default: false).
light_ig : Bool, optional
    Return an extended lightweight structure for igneous databases (default: false).
name_solvus : Bool, optional
    Resolve solvus naming (default: false).
fixed_bulk : Bool, optional
    Use fixed bulk composition (default: false).
test : Int64, optional
    Built-in test case number (default: 0).
X : VecOrMat, optional
    Bulk rock composition. Single vector of length `noxides` (default: nothing).
B : Union{Nothing, Float64}, optional
    Buffer value (default: nothing).
G : Union{Nothing, Vector{LibMAGEMin.mSS_data}}, optional
    Initial guess data (default: nothing).
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
Xoxides : Vector{String}
    Oxide names corresponding to `X`.
sys_in : String, optional
    Input system units, "mol" or "wt" (default: "mol").
rg : String, optional
    Research group, "tc" or "sb" (default: "tc").
progressbar : Bool, optional
    Show progress bar (default: true).
seismic_cor : Bool, optional
    If true, compute melt + anelastic corrected seismic velocities of the
    solid aggregate (`Vp_cor`, `Vs_cor`) (default: false).
aspect_ratio : Float64, optional
    Aspect ratio of the melt/pore geometry, used when `seismic_cor=true` (default: 0.3).
seismic_water : Int, optional
    Water content mode passed to [`anelastic_correction`](@ref) when `seismic_cor=true`:
    `0` = dry mantle, `1` = damp mantle, `2` = wet mantle (default: 0).

Returns
-------
out : gmin_struct{Float64, Int64}
    Structure containing the minimization result at the given P-T point.

Examples
--------
```julia
data    = Initialize_MAGEMin("ig", verbose=false);
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","Fe2O3","K2O","Na2O","TiO2","Cr2O3","H2O"]
X       = [48.43, 15.19, 11.57, 10.13, 6.65, 1.64, 0.59, 1.87, 0.68, 0.0, 3.0]
out     = single_point_minimization(10.0, 1100.0, data, X=X, Xoxides=Xoxides, sys_in="wt")
Finalize_MAGEMin(data)
```
````



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1063-L1135" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.solve_with_saturation-Tuple{Float64, Float64, Any, Vector{Float64}, Vector{String}, Vector{Float64}, custom_KDs_database, String}' href='#MAGEMin_C.solve_with_saturation-Tuple{Float64, Float64, Any, Vector{Float64}, Vector{String}, Vector{Float64}, custom_KDs_database, String}'><span class="jlbinding">MAGEMin_C.solve_with_saturation</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
solve_with_saturation(P, T, data, X_mol, Xoxides, C0, KDs_dtb, dtb; sat, sys_in, tol, max_iter)

Run the MAGEMin minimization + TE partitioning loop with saturation corrections
until the corrected bulk composition converges.

Parameters
----------
P, T : Float64
    Pressure [kbar] and temperature [°C].
data : MAGEMin data handle
    Initialised with `Initialize_MAGEMin`.
X_mol : Vector{Float64}
    Normalised bulk molar composition (will not be mutated).
Xoxides : Vector{String}
    Oxide names matching `X_mol`.
C0 : Vector{Float64}
    Initial bulk trace-element composition [ppm].
KDs_dtb : custom_KDs_database
    Trace-element partitioning database (real mineral phases only;
    saturation phases are appended automatically when `sat` is provided).
dtb : String
    MAGEMin database identifier (e.g. "mp", "ig").
sat : SaturationConfig, optional
    Saturation model selection. Defaults to all "none".
sys_in : String, optional
    Composition input units for MAGEMin: "mol" (default) or "wt".
tol : Float64, optional
    Convergence tolerance on the L2-norm of `bulk_cor_mol` (default 1e-6).
max_iter : Int, optional
    Maximum number of iterations (default 32).

Returns
-------
out : MAGEMin output at convergence.
out_TE : out_tepm at convergence.
converged : Bool — true if `tol` was reached.
n_iter : Int — number of iterations performed.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_partitioning.jl#L1182-L1220" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.split_and_keep-Tuple{Any, Any}' href='#MAGEMin_C.split_and_keep-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.split_and_keep</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
split_and_keep(data, Hash_XY)

Categorise cells into the split or keep list based on phase assembly uniformity.

For each cell in `data.keep_cell_list` (from the previous refinement step) and
any remaining cells beyond that list, the function collects the phase-assembly
hash values at all corner points (and any boundary midpoints already stored in
`data.bnd_cells`). If all hashes are identical the cell is stable and added to
`keep_cell_list`; otherwise it straddles a reaction boundary and is added to
`split_cell_list`.

Parameters
----------
data : AMR_data
    AMR state structure. `data.cells`, `data.keep_cell_list`, and
    `data.bnd_cells` are read; `data.split_cell_list` and
    `data.keep_cell_list` are overwritten.
Hash_XY : Vector{UInt64}
    Per-point phase-assembly hash values, indexed by point index.

Returns
-------
data : AMR_data
    Updated AMR state with refreshed `split_cell_list` and `keep_cell_list`.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/AMR.jl#L164-L189" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.sulfur_saturation-Tuple{out_struct}' href='#MAGEMin_C.sulfur_saturation-Tuple{out_struct}'><span class="jlbinding">MAGEMin_C.sulfur_saturation</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
sulfur_saturation(out; model="1000ppm")

Compute the sulfur concentration at sulfide saturation (SCSS) in the melt phase [ppm].

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output (must contain a melt phase with a "liq" solution phase).
model : String, optional
    Saturation model (default: "1000ppm"). Valid options:
    - `"<N>ppm"`   — Fixed saturation value of N ppm (e.g., "1000ppm", "500ppm")
    - "Liu07"      — Liu et al. (2007); SCSS model, may be unreliable for anhydrous conditions
    - "Oneill21"   — O'Neill (2021); thermodynamic SCSS model using fO₂ from the minimization

Returns
-------
C_s_liq : Float64
    Sulfur saturation concentration in the melt [ppm].
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L299-L318" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1625-L1643" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1701-L1717" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.volatile_saturation_SY26-Tuple{out_struct}' href='#MAGEMin_C.volatile_saturation_SY26-Tuple{out_struct}'><span class="jlbinding">MAGEMin_C.volatile_saturation_SY26</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
volatile_saturation_SY26(out; P_H2O=NaN, P_CO2=NaN)
```


Compute H2O and CO2 solubility in the melt using the M2Fluid model of Sun & Yao (2026).

If `P_H2O` or `P_CO2` are not provided and a fluid phase is present in `out`, partial pressures are estimated from the fluid mole fractions assuming ideal mixing.  If neither a value nor a fluid phase is available for a volatile species, the corresponding saturation is returned as `NaN`.

**Parameters**

out : MAGEMin_C.gmin_struct{Float64, Int64}     MAGEMin minimization output (must contain a melt phase). P_H2O : Float64, optional     Partial pressure of H₂O [bar].  When `NaN` (default), derived from fluid composition     if a fluid phase is present. P_CO2 : Float64, optional     Partial pressure of CO₂ [bar].  When `NaN` (default), derived from fluid composition     if a fluid phase is present.

**Returns**

S_H2O : Float64     H₂O solubility in the melt [wt%], or `NaN` if P_H2O cannot be determined. S_CO2 : Float64     CO₂ solubility in the melt [ppm], or `NaN` if P_CO2 cannot be determined.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L544-L571" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.wave_melt_correction' href='#MAGEMin_C.wave_melt_correction'><span class="jlbinding">MAGEMin_C.wave_melt_correction</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
wave_melt_correction(gv, P_kbar, solid_Vp, solid_Vs, aspectRatio=0.3)

Melt-fraction correction for P- and S-wave velocities of the solid aggregate.

Uses the reduction formulation of Clark et al. (2017), based on the
equilibrium geometry model for the solid skeleton of Takei (1997).

If `gv.melt_fraction == 0.0`, a fixed near-surface porosity correction
(aspect ratio 0.25, Poisson ratio 0.25) is applied instead, using `P_kbar`
to estimate depth.

Parameters
----------
gv : LibMAGEMin.global_variables
    Global variables structure (melt/solid fractions, densities and moduli).
P_kbar : Float64
    Pressure [kbar], used for the depth/porosity estimate when `melt_fraction == 0`.
solid_Vp : Float64
    P-wave velocity of the solid aggregate [km/s] (uncorrected, or anelastically corrected).
solid_Vs : Float64
    S-wave velocity of the solid aggregate [km/s] (uncorrected, or anelastically corrected).
aspectRatio : Float64, optional
    Coefficient defining the geometry of the solid framework (contiguity):
    0.0 (layered melt) < 0.1 (grain boundary melt) < 1.0 (melt in separated
    bubble pockets) (default: 0.3).

Returns
-------
(Vp_cor, Vs_cor) : Tuple{Float64, Float64}
    Melt-corrected P- and S-wave velocities of the solid aggregate [km/s].

Reference
---------
Clark A.N. and Lesher C.E. (2017)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/seismic_corrections.jl#L12-L47" target="_blank" rel="noreferrer">source</a></Badge>

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/MAGEMin_wrappers.jl#L1764-L1780" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.zirconium_saturation-Tuple{out_struct}' href='#MAGEMin_C.zirconium_saturation-Tuple{out_struct}'><span class="jlbinding">MAGEMin_C.zirconium_saturation</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
zirconium_saturation(out; model="WH")

Compute the zirconium saturation concentration in the melt phase [ppm].

Parameters
----------
out : MAGEMin_C.gmin_struct{Float64, Int64}
    MAGEMin minimization output (must contain a melt phase).
model : String, optional
    Saturation model (default: "WH"). Valid options:
    - "WH"  — Watson & Harrison (1983)
    - "B"   — Boehnke et al. (2013)
    - "CB"  — Crisp & Berry (2022)

Returns
-------
C_zr_liq : Float64
    Zr saturation concentration in the melt [ppm], or -1 if no melt is present.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/fd07e1cff0d3580753e575ee3a32ada505119ff1/julia/TE_saturation_models.jl#L13-L32" target="_blank" rel="noreferrer">source</a></Badge>

</details>

