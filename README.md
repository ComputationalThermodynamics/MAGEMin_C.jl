# MAGEMin_C.jl

[![Build Status](https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/workflows/CI/badge.svg)](https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/actions)
[![DOI](https://zenodo.org/badge/489304972.svg)](https://zenodo.org/doi/10.5281/zenodo.10212322)

Julia interface to the MAGEMin C package, which performs thermodynamic equilibrium calculations.
See the [MAGEMin](https://github.com/ComputationalThermodynamics/MAGEMin) page for more details on the package & how to use it.

## Using the julia interface
First install julia. We recommend downloading the official binary from the [julia](julialang.org) webpage.

Next, install the `MAGEMin_C` package with:
```julia
julia> ]
pkg> add MAGEMin_C
```
You can check if it works on your system by running the build-in test suite:
```julia
pkg> test MAGEMin_C
```

By pushing `backspace` you return from the package manager to the main julia terminal. This will download a compiled version of the library as well as some wrapper functions to your system.

Next, you can do calculations with:
### Example 1 - predefined compositions
This is an example of how to use it for a predefined bulk rock composition:
```julia
julia> using MAGEMin_C
julia> db   = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
julia> data = Initialize_MAGEMin(db, verbose=true);
julia> test = 0         #KLB1
julia> data = use_predefined_bulk_rock(data, test);
julia> P    = 8.0;
julia> T    = 800.0;
julia> out  = point_wise_minimization(P,T, data);
```
which gives
``` julia
 Status             :            0 
 Mass residual      : +5.34576e-06
 Rank               :            0 
 Point              :            1 
 Temperature        :   +800.00000       [C] 
 Pressure           :     +8.00000       [kbar]

 SOL = [G: -797.749] (25 iterations, 39.62 ms)
 GAM = [-979.481432,-1774.104523,-795.261024,-673.747244,-375.070247,-917.557241,-829.990582,-1023.656703,-257.019268,-1308.294427]

 Phase :      spn      cpx      opx       ol 
 Mode  :  0.02799  0.14166  0.24228  0.58807 
```


### Example 2 - custom composition
And here a case in which you specify your own bulk rock composition.
```julia
julia> using MAGEMin_C
julia> data    = Initialize_MAGEMin("ig", verbose=false);
julia> P,T     = 10.0, 1100.0
julia> Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
julia> X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
julia> sys_in  = "wt"
julia> out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
```
which gives:
``` julia
Pressure          : 10.0      [kbar]
Temperature       : 1100.0    [Celsius]
     Stable phase | Fraction (mol fraction) 
              liq   0.75133 
              cpx   0.20987 
              opx   0.03877 
     Stable phase | Fraction (wt fraction) 
              liq   0.73001 
              cpx   0.22895 
              opx   0.04096 
Gibbs free energy : -916.874646  (45 iterations; 86.53 ms)
Oxygen fugacity          : 2.0509883251350577e-8
```

After the calculation is finished, the structure `out` holds all the information about the stable assemblage, including seismic velocities, melt content, melt chemistry, densities etc.
You can show a full overview of that with
```julia
julia> print_info(out)
```
If you are interested in the density or seismic velocity at the point, access it with
```julia
julia> out.rho
2755.2995530913095
julia> out.Vp
3.945646731595539
```
Once you are done with all calculations, release the memory with
```julia
julia> Finalize_MAGEMin(data)
```
### Example 3 - Removing solution phase(s) from consideration
To suppress solution phases from the calculation, define a remove list `rm_list` using the `remove_phases()` function. In the latter, provide a vector of the solution phase(s) you want to remove and the database acronym as a second argument. Then pass the created `rm_list` to the `single_point_minimization()` function.
```julia
julia> using MAGEMin_C
julia> data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
julia> rm_list = remove_phases(["liq","sp"],"mp");
julia> P,T     = 10.713125, 1177.34375;
julia> Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","MnO","H2O"];
julia> X       = [70.999,12.805,0.771,3.978,6.342,2.7895,1.481,0.758,0.72933,0.075,30.0];
julia> sys_in  = "mol";
julia> out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in,rm_list=rm_list)
```
which gives:
``` julia
Pressure          : 10.713125      [kbar]
Temperature       : 1177.3438    [Celsius]
     Stable phase | Fraction (mol fraction) 
              fsp   0.29236 
                g   0.13786 
             ilmm   0.01526 
                q   0.22534 
             sill   0.10705 
              H2O   0.22213 
     Stable phase | Fraction (wt fraction) 
              fsp   0.34544 
                g   0.17761 
             ilmm   0.0261 
                q   0.25385 
             sill   0.12197 
              H2O   0.07503 
     Stable phase | Fraction (vol fraction) 
              fsp   0.31975 
                g   0.10873 
             ilmm   0.01307 
                q   0.23367 
             sill   0.08991 
              H2O   0.23487 
Gibbs free energy : -920.021202  (25 iterations; 27.45 ms)
Oxygen fugacity          : -5.4221261006295105
Delta QFM                : 2.506745293747623
```

Note that if you want to suppress a single phase, you still need to define a vector to be passed to the `remove_phases()` function, such as:
```julia
julia> using MAGEMin_C
julia> data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
julia> rm_list = remove_phases(["liq"],"mp");
julia> P,T     = 10.713125, 1177.34375;
julia> Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","MnO","H2O"];
julia> X       = [70.999,12.805,0.771,3.978,6.342,2.7895,1.481,0.758,0.72933,0.075,30.0];
julia> sys_in  = "mol";
julia> out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in,rm_list=rm_list)
```
which gives:
```julia
Pressure          : 10.713125      [kbar]
Temperature       : 1177.3438    [Celsius]
     Stable phase | Fraction (mol fraction) 
              fsp   0.29337 
                g   0.12 
               sp   0.03036 
                q   0.23953 
             sill   0.08939 
               ru   0.00521 
              H2O   0.22213 
     Stable phase | Fraction (wt fraction) 
              fsp   0.34667 
                g   0.15368 
               sp   0.04514 
                q   0.26983 
             sill   0.10184 
               ru   0.00781 
              H2O   0.07503 
     Stable phase | Fraction (vol fraction) 
              fsp   0.31981 
                g   0.09422 
               sp   0.02492 
                q   0.24761 
             sill   0.07484 
               ru   0.00446 
              H2O   0.23413 
Gibbs free energy : -920.00146  (19 iterations; 27.79 ms)
Oxygen fugacity          : -5.760704474307317
Delta QFM                : 2.1681669200698166
```

### Example 4 - many points
```julia
julia> using MAGEMin_C
julia> db   = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
julia> data  = Initialize_MAGEMin(db, verbose=false);
julia> test = 0         #KLB1
julia> n    = 1000
julia> P    = rand(8.0:40,n);
julia> T    = rand(800.0:2000.0, n);
julia> out  = multi_point_minimization(P,T, data, test=test);
julia> Finalize_MAGEMin(data)
```
By default, this will show a progressbar (which you can deactivate with the `progressbar=false` option).

You can also specify a custom bulk rock for all points (see above), or a custom bulk rock for every point.

### Access complete information about the minimization
in the previous examples the results of the minimization are saved in a structure called `out`. To access all the information stored in the structure simply do:
```julia
julia> out.
```
Then press `tab` (tabulation key) to display all stored data:
```julia
julia> out.
G_system Gamma MAGEMin_ver M_sys PP_vec P_kbar SS_vec T_C V Vp Vp_S Vs Vs_S X
aAl2O3 aFeO aH2O aMgO aSiO2 aTiO2 alpha bulk bulkMod bulkModulus_M bulkModulus_S bulk_F bulk_F_wt bulk_M
bulk_M_wt bulk_S bulk_S_wt bulk_res_norm bulk_wt cp dQFM dataset enthalpy entropy fO2 frac_F frac_F_wt frac_M
frac_M_wt frac_S frac_S_wt iter mSS_vec n_PP n_SS n_mSS oxides ph ph_frac ph_frac_vol ph_frac_wt ph_id
ph_type rho rho_F rho_M rho_S s_cp shearMod shearModulus_S status time_ms
```
In order to access any of these variables type for instance:
```julia
julia> out.fO2
```
which will give you the oxygen fugacity:
```julia
julia> out.fO2
-4.405735414252153
```
to access the list of stable phases and their fraction in `mol`:

```julia
julia> out.ph
4-element Vector{String}:
 "liq"
 "g"
 "sp"
 "ru"

julia> out.ph_frac
4-element Vector{Float64}:
 0.970482189810529
 0.003792750364729876
 0.020229088594267013
 0.0054959712304740085
 ```
 Chemical potential of the pure components (oxides) of the system is retrieved as:
 ```julia
 julia> out.Gamma
11-element Vector{Float64}:
 -1017.3138187719679
 -1847.7215909497188
  -881.3605772634041
  -720.5475835413267
  -428.1896629304572
 -1051.6248892195592
 -1008.7336303031074
 -1070.7332593397723
  -228.07833391903714
  -561.1937065530427
  -440.764181608507

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
 "MnO"
 "H2O"
 ```
 The composition in `wt` of the first listed solution phase ("liq") can be accessed as
 ```julia
 julia> out.SS_vec[1].Comp_wt
11-element Vector{Float64}:
 0.6174962747665693
 0.1822124172602761
 0.006265730986600257
 0.0185105629478801
 0.04555393290694774
 0.038161590650707795
 0.013329583423813463
 0.0
 0.0
 0.0
 0.07846990705720527
 ```
and the end-member fraction in `wt` and their names as
```julia
 julia> out.SS_vec[1].emFrac_wt
8-element Vector{Float64}:
 0.4608062343057727
 0.0972375952287159
 0.17818888101139307
 0.02313962538195582
 0.12734359573100587
 0.025819902698522926
 0.047571646835750894
 0.03989251880688298
 julia> out.SS_vec[1].emNames
8-element Vector{String}:
 "q4L"
 "abL"
 "kspL"
 "anL"
 "slL"
 "fo2L"
 "fa2L"
 "h2oL"
```
### Running it in parallel
Julia can be run in parallel using multi-threading. To take advantage of this, you need to start julia from the terminal with:
```bash
$julia -t auto
```
which will automatically use all threads on your machine. Alternatively, use `julia -t 4` to start it on 4 threads.
If you are interested to see what you can do on your machine, type:
```julia
julia> versioninfo()
Julia Version 1.9.0
Commit 8e630552924 (2023-05-07 11:25 UTC)
Platform Info:
  OS: macOS (arm64-apple-darwin22.4.0)
  CPU: 12 × Apple M2 Max
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-14.0.6 (ORCJIT, apple-m1)
  Threads: 8 on 8 virtual cores
```
The function `multi_point_minimization` will automatically utilize parallelization if you run it on >1 threads.
