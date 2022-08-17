# MAGEMin_C.jl

[![Build Status](https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/workflows/CI/badge.svg)](https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/actions)


Julia interface to the MAGEMin C package, which performs thermodynamic equilibrium calculations.
See the [MAGEMin](https://github.com/ComputationalThermodynamics/MAGEMin) page for more details on the package & how to use it.

### Using the julia interface 
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

Next, you can do calculations with
```julia
julia> using MAGEMin_C
Using libMAGEMin.dylib from MAGEMin_jll
julia> gv, DB = init_MAGEMin();	# initialize database
julia> test = 0;
julia> bulk_rock   = get_bulk_rock(gv, test);	 
julia> gv.verbose  = -1; 							
julia> P_kbar, T_C = 8.0, 1300.0;		
julia> out         = point_wise_minimization(P_kbar,T_C, bulk_rock, gv, DB)
Pressure          : 8.0      [kbar]
Temperature       : 1300.0    [Celcius]
     Stable phase | Fraction (mol 1 atom basis) 
              liq   0.14216 
              cpx   0.01321 
              opx   0.22202 
               ol   0.6226 
     Stable phase | Fraction (wt fraction) 
              liq   0.14736 
              cpx   0.01356 
              opx   0.22014 
               ol   0.61895 
Gibbs free energy : -856.885051  (67 iterations; 118.47 ms)
```  
After the calculation is finished, the structure `out` holds all the information about the stable assemblage, including seismic velocities, melt content, melt chemistry, densities etc.
You can show a full overview of that with
```julia
julia> print_info(out)
```
If you are interested in the density or seismic velocity at the point,  access it with
```julia
julia> out.rho
3144.282577840362
julia> out.Vp
5.919986959559542
```
Once you are done with all calculations, release the memory with
```julia
julia> finalize_MAGEMin(gv,DB)
```

