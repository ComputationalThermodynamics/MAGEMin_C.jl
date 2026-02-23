
# MAGEMin_C.jl: Examples {#MAGEMin_C.jl:-Examples}

This page provides a set of quick examples showing how to use MAGEMin_C.jl to perform phase equilibrium calculations.

::: tip Info

Examples 1 to 8 are simple exercises to make you familiar with the various options available for the calculation
- [E.1 Predefined compositions](/MAGEMin_C/examples#E.1-Predefined-compositions)
  
- [E.2 Minimization output](/MAGEMin_C/examples#E.2-Minimization-output)
  
- [E.3 Custom composition](/MAGEMin_C/examples#E.3-Custom-composition)
  
- [E.4 Export data to CSV](/MAGEMin_C/examples#E.4-Export-data-to-CSV)
  
- [E.5 Removing solution phase from consideration](/MAGEMin_C/examples#E.5-Removing-solution-phase-from-consideration)
  
- [E.6 Oxygen buffer](/MAGEMin_C/examples#E.6-Oxygen-buffer)
  
- [E.7 Activity buffer](/MAGEMin_C/examples#E.7-Activity-buffer)
  
- [E.8 Many points](/MAGEMin_C/examples#E.8-Many-points)
  

:::

::: tip Note
- The examples are not optimized for performances, but are provided in hope they can be useful to present `MAGEMin_C` functionality.
  

:::

## Quickstart examples {#Quickstart-examples}

### E.1 Predefined compositions {#E.1-Predefined-compositions}

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

```julia
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


::: tip Note

Thermodynamic dataset acronym are the following:
- `mtl` -&gt; mantle (Holland et al., 2013)
  
- `mp` -&gt; metapelite (White et al., 2014)
  
- `mb` -&gt; metabasite (Green et al., 2016)
  
- `ig` -&gt; igneous (Green et al., 2025 updated from and replacing Holland et al., 2018)
  
- `igad` -&gt; igneous alkaline dry (Weller et al., 2024)
  
- `um` -&gt; ultramafic (Evans &amp; Frost, 2021)
  
- `sb11` -&gt; Stixrude &amp; Lithgow-Bertelloni (2011)
  
- `sb21` -&gt; Stixrude &amp; Lithgow-Bertelloni (2021)
  
- `ume` -&gt; ultramafic extended (Green et al., 2016 + Evans &amp; Frost, 2021)
  
- `mpe` -&gt; extended metapelite (White et al., 2014 + Green et al., 2016 + Franzolin et al., 2011 + Diener et al., 2007)
  
- `mbe` -&gt; extended metabasite (Green et al., 2016 + Diener et al., 2007 + Rebay et al., 2022)
  

:::

### E.2 Minimization output {#E.2-Minimization-output}

in the previous example the results of the minimization are saved in a structure called `out`. To access all the information stored in the structure simply do:

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


The composition in `wt` of the first listed solution phase (&quot;liq&quot;) can be accessed as

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


### E.3 Custom composition {#E.3-Custom-composition}

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

```julia
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


After the calculation is finished, the structure `out` holds all the information about the stable assemblage, including seismic velocities, melt content, melt chemistry, densities etc. You can show a full overview of that with

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


### E.4 Export data to CSV {#E.4-Export-data-to-CSV}

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

The output structure can also be saved as `inlined` i.e., that every line of the `.csv` file will output one pressure-temperature phase equilibrium calculation:

```julia
MAGEMin_data2dataframe_inlined(out,dtb,"filename")
```


::: tip Note
- You don&#39;t have to add the file extension `.csv`
  
- The output path (MAGEMin_C directory) is displayed in the Julia terminal
  
- For multiple points, simply provide the `Julia` `Vector{out}`. See Example 8 for more details on how to create a vector of minimization output.
  

:::

### E.5 Removing solution phase from consideration {#E.5-Removing-solution-phase-from-consideration}

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

```julia
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


::: tip Note

Note that if you want to suppress a single phase, you still need to define a vector to be passed to the `remove_phases()` function, such as shown below.

:::

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


### E.6 Oxygen buffer {#E.6-Oxygen-buffer}

Here we need to initialize MAGEMin with the desired buffer (qfm in this case, see list at the beginning). 

::: tip Note

Note that O/Fe2O3 value needs to be large enough to saturate the system. Excess oxygen-content will be removed from the output

:::

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


::: tip Note

Several buffers can be used to fix the oxygen fugacity
- `qfm` -&gt; quartz-fayalite-magnetite
  
- `qif` -&gt; quartz-iron-fayalite
  
- `nno` -&gt; nickel-nickel oxide
  
- `hm` -&gt; hematite-magnetite
  
- `iw` -&gt; iron-wüstite
  
- `cco` -&gt; carbon dioxide-carbon
  

:::

### E.7 Activity buffer {#E.7-Activity-buffer}

Like for oxygen buffer, activity buffer can be prescribe as follow

::: tip Note

Note that the corresponding oxide-content needs to be large enough to saturate the system. Excess oxide-content will be removed from the output

:::

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


::: tip Note

Similarly activity can be fixed for the following oxides
- `aH2O` -&gt; using water as reference phase
  
- `aO2`   -&gt; using dioxygen as reference phase
  
- `aMgO` -&gt; using periclase as reference phase
  
- `aFeO` -&gt; using ferropericlase as reference phase
  
- `aAl2O3` -&gt; using corundum as reference phase
  
- `aTiO2` -&gt; using rutile as reference phase
  
- `aSiO2` -&gt; using quartz/coesite as reference phase
  

:::

### E.8 Many points {#E.8-Many-points}

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

## References {#References}
- Green, ECR, Holland, TJB, Powell, R, Weller, OM, &amp; Riel, N (2025). Journal of Petrology, 66, doi: 10.1093/petrology/egae079
  
- Weller, OM, Holland, TJB, Soderman, CR, Green, ECR, Powell, R, Beard, CD &amp; Riel, N (2024). New Thermodynamic Models for Anhydrous Alkaline-Silicate Magmatic Systems. Journal of Petrology, 65, doi: 10.1093/petrology/egae098
  
- Holland, TJB, Green, ECR &amp; Powell, R (2022). A thermodynamic modelfor feldspars in KAlSi3O8-NaAlSi3O8-CaAl2Si2O8 for mineral equilibrium calculations. Journal of Metamorphic Geology, 40, 587-600, doi: 10.1111/jmg.12639
  
- Tomlinson, EL &amp; Holland, TJB (2021). A Thermodynamic Model for the Subsolidus Evolution and Melting of Peridotite. Journal of Petrology,62, doi: 10.1093/petrology/egab012
  
- Holland, TJB, Green, ECR &amp; Powell, R (2018). Melting of Peridotitesthrough to Granites: A Simple Thermodynamic Model in the System KNCFMASHTOCr. Journal of Petrology, 59, 881-900, doi: 10.1093/petrology/egy048
  
- Green, ECR, White, RW, Diener, JFA, Powell, R, Holland, TJB &amp; Palin, RM (2016). Activity-composition relations for the calculationof partial melting equilibria in metabasic rocks. Journal of Metamorphic Geology, 34, 845-869, doi: 10.1111/jmg12211
  
- White, RW, Powell, R, Holland, TJB, Johnson, TE &amp; Green, ECR (2014). New mineral activity-composition relations for thermodynamic calculations in metapelitic systems. Journal of Metamorphic Geology, 32, 261-286, doi: 10.1111/jmg.12071
  
- Holland, TJB &amp; Powell, RW (2011). An improved and extended internally consistent thermodynamic dataset for phases of petrological interest, involving a new equation of state for solids. Journal of Metamorphic Geology, 29, 333-383, doi: 10.1111/j.1525-1314.2010.00923.x
  
