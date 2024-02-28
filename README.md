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

### Example 3 - many points
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
