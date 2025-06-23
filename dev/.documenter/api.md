
# API {#API}
<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR_data' href='#MAGEMin_C.AMR_data'><span class="jlbinding">MAGEMin_C.AMR_data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
AMR_data
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/AMR.jl#L15-L17" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_Data' href='#MAGEMin_C.MAGEMin_Data'><span class="jlbinding">MAGEMin_C.MAGEMin_Data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds the MAGEMin databases & required structures for every thread
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L234-L236" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.W_data' href='#MAGEMin_C.W_data'><span class="jlbinding">MAGEMin_C.W_data</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds the overriding Ws parameters
```


0 = &quot;mp&quot;, 1 = &quot;mb&quot;, 11 = &quot;mbe&quot;,2 = &quot;ig&quot;, 3 = &quot;igad&quot;, 4 = &quot;um&quot;, 5 = &quot;ume&quot;, 6 = &quot;mtl&quot;, 7 = &quot;mpe&quot;, 8 = &quot;sb11&quot;, 9 = &quot;sb21&quot;


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L245-L248" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.custom_KDs_database' href='#MAGEMin_C.custom_KDs_database'><span class="jlbinding">MAGEMin_C.custom_KDs_database</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds the partitioning coefficient database
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L139-L141" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.db_infos' href='#MAGEMin_C.db_infos'><span class="jlbinding">MAGEMin_C.db_infos</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds general information about the database
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L220-L222" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.gmin_struct' href='#MAGEMin_C.gmin_struct'><span class="jlbinding">MAGEMin_C.gmin_struct</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
structure that holds the result of the pointwise minimization
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L73-L75" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.out_tepm' href='#MAGEMin_C.out_tepm'><span class="jlbinding">MAGEMin_C.out_tepm</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds the output of the TE partitioning routine
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L120-L122" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.ss_infos' href='#MAGEMin_C.ss_infos'><span class="jlbinding">MAGEMin_C.ss_infos</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
Holds general information about solution phases
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L206-L208" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR-Tuple{Any}' href='#MAGEMin_C.AMR-Tuple{Any}'><span class="jlbinding">MAGEMin_C.AMR</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
AMR(data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/AMR.jl#L135-L137" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.AMR_minimization-Union{Tuple{T1}, Tuple{Int64, Int64, Union{Tuple{T1, T1}, T1}, Union{Tuple{T1, T1}, T1}, MAGEMin_Data}} where T1<:Float64' href='#MAGEMin_C.AMR_minimization-Union{Tuple{T1}, Tuple{Int64, Int64, Union{Tuple{T1, T1}, T1}, Union{Tuple{T1, T1}, T1}, MAGEMin_Data}} where T1<:Float64'><span class="jlbinding">MAGEMin_C.AMR_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
AMR_minimization(   init_sub    ::  Int64,
                    ref_lvl     ::  Int64,
                    Prange      ::  Union{T1, NTuple{2, T1}},
                    Trange      ::  Union{T1, NTuple{2, T1}},
                    MAGEMin_db  ::  MAGEMin_Data;
                    test        ::  Int64                           = 0, # if using a build-in test case,
                    X           ::  VecOrMat                        = nothing,
                    B           ::  Union{Nothing, T1, Vector{T1}}  = 0.0,
                    scp         ::  Int64                           = 0,  
                    iguess      ::  Union{Vector{Bool},Bool}        = false,
                    rm_list     ::  Union{Nothing, Vector{Int64}}   = nothing,
                    W           ::  Union{Nothing, Vector{MAGEMin_C.W_data{Float64, Int64}}}  = nothing,
                    Xoxides     = Vector{String},
                    sys_in      :: String                          = "mol",
                    rg          :: String                          = "tc",
                    progressbar :: Bool                             = true        # show a progress bar or not?
                ) where {T1 <: Float64}

Performs an Adaptive Mesh Refinement (AMR) minimization for a range of points as a function of pressure `Prange`, temperature `Trange` and/or composition `X`. The database `MAGEMin_db` must be initialised before calling the routine.
```


**Example**

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



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L702-L737" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.Finalize_MAGEMin-Tuple{MAGEMin_Data}' href='#MAGEMin_C.Finalize_MAGEMin-Tuple{MAGEMin_Data}'><span class="jlbinding">MAGEMin_C.Finalize_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Finalize_MAGEMin(dat::MAGEMin_Data)
```


Finalizes MAGEMin and clears variables


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L367-L370" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.Initialize_MAGEMin' href='#MAGEMin_C.Initialize_MAGEMin'><span class="jlbinding">MAGEMin_C.Initialize_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
Dat = Initialize_MAGEMin(db = "ig"; verbose::Union{Bool, Int64} = true)
```


Initializes MAGEMin on one or more threads, for the database `db`. You can suppress all output with `verbose=false`. `verbose=true` will give a brief summary of the result, whereas `verbose=1` will give more details about the computations.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L304-L308" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_data2dataframe-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}, Any, Any}' href='#MAGEMin_C.MAGEMin_data2dataframe-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_data2dataframe</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



MAGEMin_data2dataframe( out:: Union{Vector{MAGEMin_C.gmin_struct{Float64, Int64}}, MAGEMin_C.gmin_struct{Float64, Int64}})

```
Transform MAGEMin output into a dataframe for quick(ish) save
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/export2CSV.jl#L174-L179" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_data2dataframe_inlined-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}, Any, Any}' href='#MAGEMin_C.MAGEMin_data2dataframe_inlined-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_data2dataframe_inlined</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



MAGEMin_data2dataframe( out:: Union{Vector{MAGEMin_C.gmin_struct{Float64, Int64}}, MAGEMin_C.gmin_struct{Float64, Int64}})

```
Transform MAGEMin output into a dataframe for quick(ish) save
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/export2CSV.jl#L420-L425" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.MAGEMin_dataTE2dataframe-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}, Union{MAGEMin_C.out_tepm, Vector{MAGEMin_C.out_tepm}}, Any, Any}' href='#MAGEMin_C.MAGEMin_dataTE2dataframe-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}, Union{MAGEMin_C.out_tepm, Vector{MAGEMin_C.out_tepm}}, Any, Any}'><span class="jlbinding">MAGEMin_C.MAGEMin_dataTE2dataframe</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



MAGEMin_dataTE2dataframe( out:: Union{Vector{out_tepm}, out_tepm},dtb,fileout)

```
Transform MAGEMin trace-element output into a dataframe for quick(ish) save
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/export2CSV.jl#L12-L17" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.TE_prediction-NTuple{4, Any}' href='#MAGEMin_C.TE_prediction-NTuple{4, Any}'><span class="jlbinding">MAGEMin_C.TE_prediction</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out_TE = TE_prediction(  out, C0, KDs_database, dtb;
                ZrSat_model   :: String = "CB")
```


Perform TE partitioning and zircon saturation calculation.

This function computes the partitioning of elements into different phases based on the provided KDs database and the initial composition C0. It also checks for zircon saturation and adjusts the composition if necessary.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L398-L406" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.all_identical-Tuple{Vector{UInt64}}' href='#MAGEMin_C.all_identical-Tuple{Vector{UInt64}}'><span class="jlbinding">MAGEMin_C.all_identical</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
all_identical(arr::Vector{UInt64})
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/AMR.jl#L83-L86" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.allocate_output-Tuple{Int64}' href='#MAGEMin_C.allocate_output-Tuple{Int64}'><span class="jlbinding">MAGEMin_C.allocate_output</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Function to allocate memory for the output
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L42-L44" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.anhydrous_renormalization-Tuple{Vector{Float64}, Vector{String}}' href='#MAGEMin_C.anhydrous_renormalization-Tuple{Vector{Float64}, Vector{String}}'><span class="jlbinding">MAGEMin_C.anhydrous_renormalization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
bulk_dry = anhydrous_renormalization(   bulk    :: Vector{Float64},
                                        oxide   :: Vector{String})

This function renormalizes the bulk rock composition to remove water (H2O) if present.
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L50-L56" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_TE_partitioning-Tuple{MAGEMin_C.custom_KDs_database, MAGEMin_C.gmin_struct{Float64, Int64}, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}' href='#MAGEMin_C.compute_TE_partitioning-Tuple{MAGEMin_C.custom_KDs_database, MAGEMin_C.gmin_struct{Float64, Int64}, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}'><span class="jlbinding">MAGEMin_C.compute_TE_partitioning</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



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


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L293-L305" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_Zr_sat_n_part-Tuple{MAGEMin_C.gmin_struct{Float64, Int64}, MAGEMin_C.custom_KDs_database, Any, Any, Any, Any, Any, Any, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}' href='#MAGEMin_C.compute_Zr_sat_n_part-Tuple{MAGEMin_C.gmin_struct{Float64, Int64}, MAGEMin_C.custom_KDs_database, Any, Any, Any, Any, Any, Any, Vector{Float64}, Vector{String}, Vector{Float64}, Float64, Float64}'><span class="jlbinding">MAGEMin_C.compute_Zr_sat_n_part</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_Zr_sat_n_part(          out         :: MAGEMin_C.gmin_struct{Float64, Int64},
                                KDs_database:: custom_KDs_database,
                                Cliq, Csol, Cmin, ph_TE, ph_wt_norm, liq_wt_norm,
                                C0          :: Vector{Float64},
                                ph          :: Vector{String},
                                ph_wt       :: Vector{Float64}, 
                                liq_wt      :: Float64,
                                sol_wt      :: Float64;
                                ZrSat_model :: String = "CB")
```


Compute zircon saturation and adjust bulk composition if necessary.

This function checks if the zirconium content in the liquid phase exceeds the saturation limit. If it does, it adjusts the bulk composition by removing the excess zirconium and adds a new phase for zircon.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L335-L350" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.compute_index-Tuple{Any, Any, Any}' href='#MAGEMin_C.compute_index-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.compute_index</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_index(value, min_value, delta)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/AMR.jl#L32-L34" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.convertBulk4MAGEMin-Union{Tuple{T1}, Tuple{T1, Vector{String}, String, String}} where T1<:AbstractVector{Float64}' href='#MAGEMin_C.convertBulk4MAGEMin-Union{Tuple{T1}, Tuple{T1, Vector{String}, String, String}} where T1<:AbstractVector{Float64}'><span class="jlbinding">MAGEMin_C.convertBulk4MAGEMin</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
MAGEMin_bulk, MAGEMin_ox; = convertBulk4MAGEMin(bulk_in::T1,bulk_in_ox::Vector{String},sys_in::String,db::String) where {T1 <: AbstractVector{Float64}}
```


receives bulk-rock composition in [mol,wt] fraction and associated oxide list and sends back bulk-rock composition converted for MAGEMin use


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L956-L961" target="_blank" rel="noreferrer">source</a></Badge>

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


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L186-L196" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_gmin_struct-Tuple{Any, Any, Any}' href='#MAGEMin_C.create_gmin_struct-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.create_gmin_struct</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out = create_gmin_struct(gv, z_b)
```


This extracts the output of a pointwise MAGEMin optimization and adds it into a julia structure


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1539-L1543" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.create_light_gmin_struct-Tuple{Any, Any}' href='#MAGEMin_C.create_light_gmin_struct-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.create_light_gmin_struct</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out = create_light_gmin_struct(gv, z_b)
```


This extracts the output of a pointwise MAGEMin optimization and adds it into a julia structure


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1688-L1692" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.define_bulk_rock-NTuple{5, Any}' href='#MAGEMin_C.define_bulk_rock-NTuple{5, Any}'><span class="jlbinding">MAGEMin_C.define_bulk_rock</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
gv = define_bulk_rock(gv, bulk_in, bulk_in_ox, sys_in, db)
```


Defines the bulk-rock composition in `gv` structure using the input `bulk_in` and `bulk_in_ox`, converting it to the appropriate format for MAGEMin.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L888-L892" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.finalize_MAGEMin-Tuple{Any, Any, Any}' href='#MAGEMin_C.finalize_MAGEMin-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.finalize_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
finalize_MAGEMin(gv,DB)
```


Cleans up the memory


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L480-L483" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_TE_database' href='#MAGEMin_C.get_TE_database'><span class="jlbinding">MAGEMin_C.get_TE_database</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
This routine stores the TE partitioning coefficients
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L16-L18" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_all_stable_phases-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}}' href='#MAGEMin_C.get_all_stable_phases-Tuple{Union{MAGEMin_C.gmin_struct{Float64, Int64}, Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}}'><span class="jlbinding">MAGEMin_C.get_all_stable_phases</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
get_all_stable_phases(out:: Union{Vector{gmin_struct{Float64, Int64}}, gmin_struct{Float64, Int64}})
return ph_name

The function receives as an input a single/Vector of MAGEMin_C output structure and returns the list (Vector{String}) of unique stable phases
    - Note that first the sorted solution phase names are provided, followed by the sorted pure phase names
      e.g., ["amp", "bi", "chl", "cpx", "ep", "fl", "fsp", "liq", "opx", "sph"]
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/export2CSV.jl#L383-L390" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.get_ss_from_mineral-Tuple{Any, Any, Any}' href='#MAGEMin_C.get_ss_from_mineral-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.get_ss_from_mineral</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
This function returns the solution phase name given the mineral name (handling solvus -> solution phase)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/name_solvus.jl#L96-L98" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.init_MAGEMin' href='#MAGEMin_C.init_MAGEMin'><span class="jlbinding">MAGEMin_C.init_MAGEMin</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
gv, DB = init_MAGEMin(;EM_database=0)
```


Initializes MAGEMin (including setting global options) and loads the Database.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L380-L384" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.initialize_AMR-Tuple{Any, Any, Any}' href='#MAGEMin_C.initialize_AMR-Tuple{Any, Any, Any}'><span class="jlbinding">MAGEMin_C.initialize_AMR</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
compute_hash_map(data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/AMR.jl#L40-L42" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.mineral_classification-Tuple{MAGEMin_C.gmin_struct{Float64, Int64}, String}' href='#MAGEMin_C.mineral_classification-Tuple{MAGEMin_C.gmin_struct{Float64, Int64}, String}'><span class="jlbinding">MAGEMin_C.mineral_classification</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Classify the mineral output from MAGEMin to be able to be compared with partitioning coefficient database
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/TE_partitioning.jl#L31-L33" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.mol2wt-Tuple{Vector{Float64}, Vector{String}}' href='#MAGEMin_C.mol2wt-Tuple{Vector{Float64}, Vector{String}}'><span class="jlbinding">MAGEMin_C.mol2wt</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
mol2wt(bulk_mol::Vector{Float64}, bulk_ox::Vector{String})

Converts bulk-rock composition from mol to wt fraction
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L932-L936" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.multi_point_minimization-Union{Tuple{T2}, Tuple{T1}, Tuple{T2, T2, MAGEMin_Data}} where {T1<:Float64, T2<:AbstractVector{Float64}}' href='#MAGEMin_C.multi_point_minimization-Union{Tuple{T2}, Tuple{T1}, Tuple{T2, T2, MAGEMin_Data}} where {T1<:Float64, T2<:AbstractVector{Float64}}'><span class="jlbinding">MAGEMin_C.multi_point_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



Out_PT =multi_point_minimization(P::T2,T::T2,MAGEMin_db::MAGEMin_Data;test::Int64=0,X::Union{Nothing, AbstractVector{Float64}, AbstractVector{&lt;:AbstractVector{Float64}}}=nothing,B::Union{Nothing, T1, Vector{T1}}=nothing,W::Union{Nothing, Vector{MAGEMin_C.W_data{Float64, Int64}}}=nothing,Xoxides=Vector{String},sys_in=&quot;mol&quot;,progressbar=true,                                  callback_fn ::Union{Nothing, Function}= nothing,                                   callback_int::Int64 = 1) where {T1 &lt;: Float64, T2 &lt;: AbstractVector{T1}}

Perform (parallel) MAGEMin calculations for a range of points as a function of pressure `P`, temperature `T` and/or composition `X`. The database `MAGEMin_db` must be initialised before calling the routine. The bulk-rock composition can either be set to be one of the pre-defined build-in test cases, or can be specified specifically by passing `X`, `Xoxides` and `sys_in` (that specifies whether the input is in &quot;mol&quot; or &quot;wt&quot;).

Below a few examples:

**Example 1 - build-in test vs. pressure and temperature**

```julia
julia> data = Initialize_MAGEMin("ig", verbose=false);
julia> n = 10
julia> P = rand(8:40.0,n)
julia> T = rand(800:1500.0,n)
julia> out = multi_point_minimization(P, T, data, test=0)
julia> Finalize_MAGEMin(data)
```


**Example 2 - Specify constant bulk rock composition for all points:**

```julia
julia> data = Initialize_MAGEMin("ig", verbose=false);
julia> n = 10
julia> P = fill(10.0,n)
julia> T = fill(1100.0,n)
julia> Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
julia> X = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
julia> sys_in = "wt"
julia> out = multi_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
julia> Finalize_MAGEMin(data)
```


**Example 3 - Different bulk rock composition for different points**

```julia
julia> data = Initialize_MAGEMin("ig", verbose=false);
julia> P = [10.0, 20.0]
julia> T = [1100.0, 1200]
julia> Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
julia> X1 = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
julia> X2 = [49.43; 14.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
julia> X = [X1,X2]
julia> sys_in = "wt"
julia> out = multi_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
julia> Finalize_MAGEMin(data)
```


**Activating multithreading on julia**

To take advantage of multithreading, you need to start julia from the terminal with:

```bash
$ julia -t auto
```


which will automatically use all threads on your machine. Alternatively, use `julia -t 4` to start it on 4 threads. If you are interested to see what you can do on your machine type:

```
julia> versioninfo()
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L541-L605" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_metastability-Tuple{MAGEMin_C.gmin_struct{Float64, Int64}, Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_metastability-Tuple{MAGEMin_C.gmin_struct{Float64, Int64}, Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_metastability</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out = point_wise_metastability(out, P, T, data)

where out is a MAGEMin_C output structure of type MAGEMin_C.gmin_struct{Float64, Int64}, P is pressure, T is temperature and data is the MAGEMin_C working data structure. 

This function computes the metastability of the solution phases in `out` at pressure `P` and temperature `T`.
```


**Example:**

```julia
using MAGEMin_C

data    = Initialize_MAGEMin("mp", verbose=-1; solver=0);
P,T     = 6.0, 630.0
Xoxides = ["SiO2";  "TiO2";  "Al2O3";  "FeO";   "MnO";   "MgO";   "CaO";   "Na2O";  "K2O"; "H2O"; "O"];
X       = [58.509,  1.022,   14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)

Pmeta, Tmeta       = 6.0, 500.0
out2    = point_wise_metastability(out, Pmeta, Tmeta, data)
```


which gives:

```
julia> out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
Pressure          : 6.0      [kbar]
Temperature       : 630.0    [Celsius]
     Stable phase | Fraction (mol fraction) 
               bi   0.18975 
              fsp   0.33769 
              opx   0.06615 
                q   0.14587 
              sph   0.01103 
              H2O   0.24952 
     Stable phase | Fraction (wt fraction) 
               bi   0.21347 
              fsp   0.44152 
              opx   0.07259 
                q   0.17078 
              sph   0.01404 
              H2O   0.0876 
     Stable phase | Fraction (vol fraction) 
               bi   0.16535 
              fsp   0.38301 
              opx   0.05008 
                q   0.1507 
              sph   0.00921 
              H2O   0.24165 
Gibbs free energy : -806.707117  (23 iterations; 15.5 ms)
Oxygen fugacity          : 11.422305637291458
Delta QFM                : 29.789994195381436

julia> Pmeta, Tmeta       = 6.0, 500.0
(6.0, 500.0)

julia> out2    = point_wise_metastability(out, Pmeta, Tmeta, data)
Pressure          : 6.0      [kbar]
Temperature       : 500.0    [Celsius]
     Stable phase | Fraction (mol fraction) 
               bi   0.18975 
              fsp   0.33769 
              opx   0.06615 
                q   0.14587 
              sph   0.01103 
              H2O   0.24952 
     Stable phase | Fraction (wt fraction) 
               bi   0.21347 
              fsp   0.44152 
              opx   0.07259 
                q   0.17078 
              sph   0.01404 
              H2O   0.0876 
     Stable phase | Fraction (vol fraction) 
               bi   0.16819 
              fsp   0.39062 
              opx   0.05102 
                q   0.1528 
              sph   0.0094 
              H2O   0.22795 
Gibbs free energy : -791.460287  (0 iterations; 0.04 ms)
Oxygen fugacity          : 11.256905434522107
Delta QFM                : 34.26950061699225
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L2091-L2177" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization-Tuple{Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_minimization-Tuple{Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
point_wise_minimization(P::Float64,T::Float64, gv, z_b, DB, splx_data, sys_in::String="mol")
```


Computes the stable assemblage at `P` [kbar], `T` [C] and for a given bulk rock composition

**Example 1**

This is an example of how to use it for a predefined bulk rock composition:

```julia
julia> db          = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
julia> gv, z_b, DB, splx_data      = init_MAGEMin(db);
julia> test        = 0;
julia> sys_in      = "mol"     #default is mol, if wt is provided conversion will be done internally (MAGEMin works on mol basis)
julia> gv          = use_predefined_bulk_rock(gv, test, db)
julia> P           = 8.0;
julia> T           = 800.0;
julia> gv.verbose  = -1;        # switch off any verbose
julia> out         = point_wise_minimization(P,T, gv, z_b, DB, splx_data, sys_in)
Pressure          : 8.0      [kbar]
Temperature       : 800.0    [Celsius]
     Stable phase | Fraction (mol fraction)
              opx   0.24229
               ol   0.58808
              cpx   0.14165
              spl   0.02798
     Stable phase | Fraction (wt fraction)
              opx   0.23908
               ol   0.58673
              cpx   0.14583
              spl   0.02846
Gibbs free energy : -797.749183  (26 iterations; 94.95 ms)
Oxygen fugacity          : 9.645393319147175e-12
```


**Example 2**

And here a case in which you specify your own bulk rock composition. We convert that in the correct format, using the `convertBulk4MAGEMin` function.

```julia
julia> db          = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
julia> gv, z_b, DB, splx_data      = init_MAGEMin(db);
julia> bulk_in_ox = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
julia> bulk_in    = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
julia> sys_in     = "wt"
julia> gv         = define_bulk_rock(gv, bulk_in, bulk_in_ox, sys_in, db);
julia> P,T         = 10.0, 1100.0;
julia> gv.verbose  = -1;        # switch off any verbose
julia> out         = point_wise_minimization(P,T, gv, z_b, DB, splx_data, sys_in)
Pressure          : 10.0      [kbar]
Temperature       : 1100.0    [Celsius]
     Stable phase | Fraction (mol fraction)
             pl4T   0.01114
              liq   0.74789
              cpx   0.21862
              opx   0.02154
     Stable phase | Fraction (wt fraction)
             pl4T   0.01168
              liq   0.72576
              cpx   0.23872
              opx   0.02277
Gibbs free energy : -907.27887  (47 iterations; 187.11 ms)
Oxygen fugacity          : 0.02411835177808492
julia> finalize_MAGEMin(gv,DB)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1096-L1161" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization-Tuple{Number, Number, Vararg{Any, 4}}' href='#MAGEMin_C.point_wise_minimization-Tuple{Number, Number, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.point_wise_minimization</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out = point_wise_minimization(P::Number,T::Number, data::MAGEMin_Data)
```


Performs a point-wise optimization for a given pressure `P` and temperature `T` for the data specified in the MAGEMin database `MAGEMin_Data` (where also compoition is specified)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1397-L1401" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.point_wise_minimization_with_guess-Tuple{Vector{MAGEMin_C.LibMAGEMin.mSS_data}, Float64, Float64, MAGEMin_C.LibMAGEMin.global_variables, MAGEMin_C.LibMAGEMin.bulk_infos, MAGEMin_C.LibMAGEMin.Database, MAGEMin_C.LibMAGEMin.simplex_datas}' href='#MAGEMin_C.point_wise_minimization_with_guess-Tuple{Vector{MAGEMin_C.LibMAGEMin.mSS_data}, Float64, Float64, MAGEMin_C.LibMAGEMin.global_variables, MAGEMin_C.LibMAGEMin.bulk_infos, MAGEMin_C.LibMAGEMin.Database, MAGEMin_C.LibMAGEMin.simplex_datas}'><span class="jlbinding">MAGEMin_C.point_wise_minimization_with_guess</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
out = function point_wise_minimization_with_guess(mSS_vec :: Vector{mSS_data}, P, T, gv, z_b, DB, splx_data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1973-L1975" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.print_info-Tuple{MAGEMin_C.gmin_struct}' href='#MAGEMin_C.print_info-Tuple{MAGEMin_C.gmin_struct}'><span class="jlbinding">MAGEMin_C.print_info</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
print_info(g::gmin_struct)
```


Prints a more extensive overview of the simulation results


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1755-L1759" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.pwm_init-Tuple{Float64, Float64, Vararg{Any, 4}}' href='#MAGEMin_C.pwm_init-Tuple{Float64, Float64, Vararg{Any, 4}}'><span class="jlbinding">MAGEMin_C.pwm_init</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
pwm_init(P::Float64,T::Float64, gv, z_b, DB, splx_data)

Function to provide single point minimization and give access to G0 and W's (Margules) parameters
The objective here is to be able to use MAGEMin for thermodynamic database inversion/calibration
```


**Example**

```julia
dtb     = "mp"
gv, z_b, DB, splx_data  = init_MAGEMin(dtb);

Xoxides = ["SiO2";  "TiO2";  "Al2O3";  "FeO";   "MnO";   "MgO";   "CaO";   "Na2O";  "K2O"; "H2O"; "O"];
X       = [58.509,  1.022,   14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.0];
sys_in  = "wt"
gv      = define_bulk_rock(gv, X, Xoxides, sys_in, dtb);
P, T    = 6.0, 500.0
gv, z_b, DB, splx_data = pwm_init(P, T, gv, z_b, DB, splx_data);

# Modify gbase or W's here

out     = pwm_run(gv, z_b, DB, splx_data);
```


which gives:

```
julia> out       = pwm_run(gv, z_b, DB, splx_data);
Status             :            0 
Mass residual      : +3.23681e-15
Rank               :            0 
Point              :            1 
Temperature        :   +500.00000       [C] 
Pressure           :     +6.00000       [kbar]

SOL = [G: -791.477] (12 iterations, 11.03 ms)
GAM = [-943.275969,-1739.945965,-770.603948,-668.434121,-339.621452,-886.160861,-804.045787,-992.801306,-480.273909,-480.273909]

Phase :       bi      chl        g      opx      fsp        q      sph      H2O       zo 
Mode  :  0.18022  0.00161  0.00174  0.04239  0.33178  0.15155  0.01325  0.24445  0.03301 
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L1446-L1487" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.remove_phases-Tuple{Union{Nothing, Vector{String}}, String}' href='#MAGEMin_C.remove_phases-Tuple{Union{Nothing, Vector{String}}, String}'><span class="jlbinding">MAGEMin_C.remove_phases</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Function to retrieve the list of indexes of the solution phases to be removed from the minimization
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L269-L271" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.retrieve_solution_phase_information-Tuple{Any}' href='#MAGEMin_C.retrieve_solution_phase_information-Tuple{Any}'><span class="jlbinding">MAGEMin_C.retrieve_solution_phase_information</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
Function to retrieve the general information of the databases
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L257-L259" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.split_and_keep-Tuple{Any, Any}' href='#MAGEMin_C.split_and_keep-Tuple{Any, Any}'><span class="jlbinding">MAGEMin_C.split_and_keep</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
split_and_keep(data)
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/AMR.jl#L91-L94" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.use_predefined_bulk_rock' href='#MAGEMin_C.use_predefined_bulk_rock'><span class="jlbinding">MAGEMin_C.use_predefined_bulk_rock</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
data = use_predefined_bulk_rock(data::MAGEMin_Data, test=0)
```


Returns the pre-defined bulk rock composition of a given test


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L875-L879" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.use_predefined_bulk_rock-2' href='#MAGEMin_C.use_predefined_bulk_rock-2'><span class="jlbinding">MAGEMin_C.use_predefined_bulk_rock</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



bulk_rock = use_predefined_bulk_rock(gv, test=-1, db=&quot;ig&quot;)

Returns the pre-defined bulk rock composition of a given test


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L816-L820" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='MAGEMin_C.wt2mol-Tuple{Vector{Float64}, Vector{String}}' href='#MAGEMin_C.wt2mol-Tuple{Vector{Float64}, Vector{String}}'><span class="jlbinding">MAGEMin_C.wt2mol</span></a> <Badge type="info" class="jlObjectType jlMethod" text="Method" /></summary>



```julia
bulk_mol = wt2mol(bulk_wt, bulk_ox)
```


Converts bulk-rock composition from wt to mol fraction


<Badge type="info" class="source-link" text="source"><a href="https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/blob/96067a3519674b3a0779726d1bc6f292b25536cd/julia/MAGEMin_wrappers.jl#L908-L911" target="_blank" rel="noreferrer">source</a></Badge>

</details>

