# MAGEMin_C.jl

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://computationalthermodynamics.github.io/MAGEMin_C.jl/dev/)
[![Build Status](https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/workflows/CI/badge.svg)](https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/actions)
[![DOI](https://zenodo.org/badge/489304972.svg)](https://zenodo.org/doi/10.5281/zenodo.10212322)

Julia interface to the MAGEMin C package, which performs thermodynamic equilibrium calculations.

## Using the julia interface
### Installation
First install julia. We recommend downloading the official binary from the [julia](julialang.org) webpage.

Next, install the `MAGEMin_C` package with:
```julia
]
pkg> add MAGEMin_C
```
You can check if it works on your system by running the build-in test suite:
```julia
pkg> test MAGEMin_C
```

By pushing `backspace` you return from the package manager to the main julia terminal. This will download a compiled version of the library as well as some wrapper functions to your system.


### Thermodynamic dataset selection
Thermodynamic dataset acronym are the following:
- `mtl` -> mantle (Holland et al., 2013)
- `mp` -> metapelite (White et al., 2014)
- `mb` -> metabasite (Green et al., 2016)
- `ig` -> igneous (Green et al., 2025 updated from and replacing Holland et al., 2018)
- `igad` -> igneous alkaline dry (Weller et al., 2024)
- `um` -> ultramafic (Evans & Frost, 2021)
- `sb11` -> Stixrude & Lithgow-Bertelloni (2011)
- `sb21` -> Stixrude & Lithgow-Bertelloni (2021)
- `ume` -> ultramafic extended (Green et al., 2016 + Evans & Frost, 2021)
- `mpe` -> extended metapelite (White et al., 2014 + Green et al., 2016 + Franzolin et al., 2011 + Diener et al., 2007)
- `mbe` -> extended metabasite (Green et al., 2016 + Diener et al., 2007 + Rebay et al., 2022)

### Oxygen buffers and activity
Several buffers can be used to fix the oxygen fugacity
- `qfm` -> quartz-fayalite-magnetite
- `qif` -> quartz-iron-fayalite
- `nno` -> nickel-nickel oxide
- `hm` -> hematite-magnetite
- `iw` -> iron-wüstite
- `cco` -> carbon dioxide-carbon

Similarly activity can be fixed for the following oxides
- `aH2O` -> using water as reference phase
- `aO2`   -> using dioxygen as reference phase
- `aMgO` -> using periclase as reference phase
- `aFeO` -> using ferropericlase as reference phase
- `aAl2O3` -> using corundum as reference phase
- `aTiO2` -> using rutile as reference phase
- `aSiO2` -> using quartz/coesite as reference phase

### Example 1 - predefined compositions
This is an example of how to use it for a predefined bulk rock composition:
```julia
using MAGEMin_C
db   = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
data = Initialize_MAGEMin(db, verbose=true);
test = 0         #KLB1
data = use_predefined_bulk_rock(data, test);
P    = 8.0;
T    = 800.0;
out  = point_wise_minimization(P,T, data);
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
using MAGEMin_C
data    = Initialize_MAGEMin("ig", verbose=false);
P,T     = 10.0, 1100.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
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
print_info(out)
```
If you are interested in the density or seismic velocity at the point, access it with
```julia
out.rho
2755.2995530913095
out.Vp
3.945646731595539
```
Once you are done with all calculations, release the memory with
```julia
Finalize_MAGEMin(data)
```

### Example 3 - Export data to CSV
Using previous example to compute a point:
```julia
using MAGEMin_C
dtb     = "ig"
data    = Initialize_MAGEMin(dtb, verbose=false);
P,T     = 10.0, 1100.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
```
Exporting the result of the minimization(s) to an CSV file is straightforward:
```julia
MAGEMin_data2dataframe(out,dtb,"filename")
```
where `out` is the output structure, `dtb` is the database acronym and `"filename"` is the filename :)

Notes
* You don't have to add the file extension `.csv`
* The output path (MAGEMin_C directory) is displayed in the Julia terminal
* For multiple points, simply provide the `Julia` ```Vector{out}```. See Example 8 for more details on how to create a vector of minimization output.

### Example 4 - Removing solution phase(s) from consideration
To suppress solution phases from the calculation, define a remove list `rm_list` using the `remove_phases()` function. In the latter, provide a vector of the solution phase(s) you want to remove and the database acronym as a second argument. Then pass the created `rm_list` to the `single_point_minimization()` function.
```julia
using MAGEMin_C
data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
rm_list = remove_phases(["liq","sp"],"mp");
P,T     = 10.713125, 1177.34375;
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","MnO","H2O"];
X       = [70.999,12.805,0.771,3.978,6.342,2.7895,1.481,0.758,0.72933,0.075,30.0];
sys_in  = "mol";
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in,rm_list=rm_list)
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
using MAGEMin_C
data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
rm_list = remove_phases(["liq"],"mp");
P,T     = 10.713125, 1177.34375;
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","MnO","H2O"];
X       = [70.999,12.805,0.771,3.978,6.342,2.7895,1.481,0.758,0.72933,0.075,30.0];
sys_in  = "mol";
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in,rm_list=rm_list)
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

### Example 5 - oxygen buffer

Here we need to initialize MAGEMin with the desired buffer (qfm in this case, see list at the beginning). 

*Note that O/Fe2O3 value needs to be large enough to saturate the system. Excess oxygen-content will be removed from the output*

```julia
using MAGEMin_C 
data    = Initialize_MAGEMin("ig", verbose=false, buffer="qfm");
P,T     = 10.0, 1100.0
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","Cr2O3","H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 4.0; 0.1; 3.0];
sys_in  = "wt"    
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
```

Buffer offset in the log10 scale can be applied as

```julia
using MAGEMin_C 
data    = Initialize_MAGEMin("ig", verbose=false, buffer="qfm");
P,T     = 10.0, 1100.0
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","Cr2O3","H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 4.0; 0.1; 3.0];
offset  = -1.0
sys_in  = "wt"    
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, B=offset, sys_in=sys_in)
```

### Example 6 - activity buffer

Like for oxygen buffer, activity buffer can be prescribe as follow

*Note that the corresponding oxide-content needs to be large enough to saturate the system. Excess oxide-content will be removed from the output*

```julia
using MAGEMin_C 
data    = Initialize_MAGEMin("ig", verbose=false, buffer="aTiO2");
P,T     = 10.0, 700.0
Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","Cr2O3","H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 4.0; 0.1; 0.1; 3.0];
value  = 0.9
sys_in  = "wt"    
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, B=value, sys_in=sys_in)
```

### Example 7 - many points

```julia
using MAGEMin_C
db   = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
data  = Initialize_MAGEMin(db, verbose=false);
test = 0         #KLB1
n    = 1000
P    = rand(8.0:40,n);
T    = rand(800.0:2000.0, n);
out  = multi_point_minimization(P,T, data, test=test);
Finalize_MAGEMin(data)
```
By default, this will show a progressbar (which you can deactivate with the `progressbar=false` option).

You can also specify a custom bulk rock for all points (see above), or a custom bulk rock for every point.

### Example 8 - fractional crystallization

The following example shows how to perform fractional crystallization using a hydrous basalt magma as a starting composition. The results are displayed using PlotlyJS. This example is provided in the hope it may be useful for learning how to use MAGEMin_C for more advanced applications. 

*Note that if we wanted to use a buffer, we would need to initialize MAGEMin as in example 4. Because during fractional crystallization the bulk-rock composition is updated at every step, we would need to increase the oxygen-content (`O`) of the new bulk-rock*

```julia
using MAGEMin_C
using PlotlyJS

# number of computational steps
nsteps = 64

# Starting/ending Temperature [°C]
T = range(1200.0,600.0,nsteps)

# Starting/ending Pressure [kbar]
P = range(3.0,0.1,nsteps)

# Starting composition [mol fraction], here we used an hydrous basalt; composition taken from Blatter et al., 2013 (01SB-872, Table 1), with added O and water saturated
oxides  = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "Cr2O3"; "H2O"]
bulk_0  = [38.448328757254195, 7.718376151972274, 8.254653357127351, 9.95911842561036, 5.97899305676308, 0.24079752710315697, 2.2556006776515964, 0.7244006013202644, 0.7233140004182841, 0.0, 12.696417444779453];

# Define bulk-rock composition unit
sys_in  = "mol"

# Choose database
data    = Initialize_MAGEMin("ig", verbose=false);

# allocate storage space
Out_XY  = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef,nsteps)

melt_F  = 1.0
bulk    = copy(bulk_0)
np      = 0
while melt_F > 0.0
    np             +=1

    out     = single_point_minimization(P[np], T[np], data, X=bulk, Xoxides=oxides, sys_in=sys_in) 
    Out_XY[np]   = deepcopy(out)

    # retrieve melt composition to use as starting composition for next iteration
    melt_F          = out.frac_M
    bulk           .= out.bulk_M 

    print("#$np  P: $(round(P[np],digits=3)), T: $(round(T[np],digits=3))\n")
    print("    ---------------------\n")
    print("     melt_F: $(round(melt_F, digits=3))\n     melt_composition: $(round.(bulk ,digits=3))\n\n")

end

ndata               = np -1             # last point has melt fraction = 0

x                   = Vector{String}(undef,ndata)
melt_SiO2_anhydrous = Vector{Float64}(undef,ndata)
melt_FeO_anhydrous  = Vector{Float64}(undef,ndata)
melt_H2O            = Vector{Float64}(undef,ndata)
fluid_frac          = Vector{Float64}(undef,ndata)
melt_density        = Vector{Float64}(undef,ndata)
residual_density    = Vector{Float64}(undef,ndata)
system_density      = Vector{Float64}(undef,ndata)

for i=1:ndata
    x[i]    = "[$(round(P[i],digits=3)), $(round(T[i],digits=3))]"
    melt_SiO2_anhydrous[i]  = Out_XY[i].bulk_M[1] / (sum(Out_XY[i].bulk_M[1:end-1])) * 100.0
    melt_FeO_anhydrous[i]   = Out_XY[i].bulk_M[5] / (sum(Out_XY[i].bulk_M[1:end-1])) * 100.0
    melt_H2O[i]             = Out_XY[i].bulk_M[end] *100
    fluid_frac[i]           = Out_XY[i].frac_F*100

    melt_density[i]         = Out_XY[i].rho_M
    residual_density[i]     = Out_XY[i].rho_S 
    system_density[i]       = Out_XY[i].rho
end

# section to plot composition evolution
trace1 = scatter(   x       = x, 
                    y       = melt_SiO2_anhydrous, 
                    name    = "Anyhdrous SiO₂ [mol%]",
                    line    = attr( color   = "firebrick", 
                                    width   = 2)                )
trace2 = scatter(   x       = x, 
                    y       = melt_FeO_anhydrous, 
                    name    = "Anyhdrous FeO [mol%]",
                    line    = attr( color   = "royalblue", 
                                    width   = 2)                )

trace3 = scatter(   x       = x, 
                    y       = melt_H2O, 
                    name    = "H₂O [mol%]",
                    line    = attr( color   = "cornflowerblue", 
                                    width   = 2)                )

trace4 = scatter(   x       = x, 
                    y       = fluid_frac, 
                    name    = "fluid [mol%]",
                    line    = attr( color   = "black", 
                                    width   = 2)                )

layout = Layout(    title           = "Melt composition",
                    xaxis_title     = "PT [kbar, °C]",
                    yaxis_title     = "Oxide [mol%]")


plot([trace1,trace2,trace3,trace4], layout)
```
<img src="https://github.com/ComputationalThermodynamics/repositories_pictures/blob/main/MAGEMin_C/Melt_compo.png?raw=true" alt="drawing" width="640" alt="centered image"/>

```julia

# section to plot density evolution
trace1 = scatter(   x       = x, 
                    y       = melt_density, 
                    name    = "Melt density [kg/m³]",
                    line    = attr( color   = "gold", 
                                    width   = 2)                )
                      
trace2 = scatter(   x       = x, 
                    y       = residual_density, 
                    name    = "Residual density [kg/m³]",
                    line    = attr( color   = "firebrick", 
                                    width   = 2)                )
                      
trace3 = scatter(   x       = x, 
                    y       = system_density, 
                    name    = "System density[kg/m³]",
                    line    = attr( color   = "coral", 
                                    width   = 2)                )

layout = Layout(    title           = "Density evolution",
                    xaxis_title     = "PT [kbar, °C]",
                    yaxis_title     = "Density [kg/³]")


plot([trace1,trace2,trace3], layout)
```


<img src="https://github.com/ComputationalThermodynamics/repositories_pictures/blob/main/MAGEMin_C/Density_evolution.png?raw=true" alt="drawing" width="640" alt="centered image"/>


### Access complete information about the minimization

in the previous examples the results of the minimization are saved in a structure called `out`. To access all the information stored in the structure simply do:
```julia
out.
```
Then press `tab` (tabulation key) to display all stored data:
```julia
out.
G_system Gamma MAGEMin_ver M_sys PP_vec P_kbar SS_vec T_C V Vp Vp_S Vs Vs_S X
aAl2O3 aFeO aH2O aMgO aSiO2 aTiO2 alpha bulk bulkMod bulkModulus_M bulkModulus_S bulk_F bulk_F_wt bulk_M
bulk_M_wt bulk_S bulk_S_wt bulk_res_norm bulk_wt cp dQFM dataset enthalpy entropy fO2 frac_F frac_F_wt frac_M
frac_M_wt frac_S frac_S_wt iter mSS_vec n_PP n_SS n_mSS oxides ph ph_frac ph_frac_vol ph_frac_wt ph_id
ph_type rho rho_F rho_M rho_S s_cp shearMod shearModulus_S status time_ms
```
In order to access any of these variables type for instance:
```julia
out.fO2
```
which will give you the oxygen fugacity:
```julia
out.fO2
-4.405735414252153
```
to access the list of stable phases and their fraction in `mol`:

```julia
out.ph
4-element Vector{String}:
 "liq"
 "g"
 "sp"
 "ru"

out.ph_frac
4-element Vector{Float64}:
 0.970482189810529
 0.003792750364729876
 0.020229088594267013
 0.0054959712304740085
 ```
 Chemical potential of the pure components (oxides) of the system is retrieved as:
 ```julia
 out.Gamma
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

out.oxides
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
 out.SS_vec[1].Comp_wt
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
 out.SS_vec[1].emFrac_wt
8-element Vector{Float64}:
 0.4608062343057727
 0.0972375952287159
 0.17818888101139307
 0.02313962538195582
 0.12734359573100587
 0.025819902698522926
 0.047571646835750894
 0.03989251880688298
 out.SS_vec[1].emNames
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
versioninfo()
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
