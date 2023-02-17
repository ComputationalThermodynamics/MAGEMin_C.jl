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
# Example 1

This is an example of how to use it for a predefined bulk rock composition:
```julia
julia> gv, z_b, DB, splx_data      = init_MAGEMin();
julia> test        = 0;
julia> sys_in      = "mol"     #default is mol, if wt is provided conversion will be done internally (MAGEMin works on mol basis)
julia> gv          = use_predefined_bulk_rock(gv, test);
julia> P           = 8.0;
julia> T           = 800.0;
julia> gv.verbose  = -1;        # switch off any verbose
julia> out         = point_wise_minimization(P,T, gv, z_b, DB, splx_data, sys_in)
Pressure          : 8.0      [kbar]
Temperature       : 800.0    [Celcius]
     Stable phase | Fraction (mol 1 atom basis) 
              opx   0.24229 
               ol   0.58808 
              cpx   0.14165 
              spn   0.02798 
     Stable phase | Fraction (wt fraction) 
              opx   0.23908 
               ol   0.58673 
              cpx   0.14583 
              spn   0.02846 
Gibbs free energy : -797.749183  (26 iterations; 94.95 ms)
Oxygen fugacity          : 9.645393319147175e-12
```

# Example 2
And here a case in which you specify your own bulk rock composition. 
We convert that in the correct format, using the `convertBulk4MAGEMin` function. 
```julia
julia> using MAGEMin_C
julia> gv, z_b, DB, splx_data      = init_MAGEMin();
julia> bulk_in_ox = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
julia> bulk_in    = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
julia> sys_in     = "wt"
julia> bulk_rock  = convertBulk4MAGEMin(bulk_in,bulk_in_ox,sys_in);
julia> gv         = define_bulk_rock(gv, bulk_rock);
julia> P,T         = 10.0, 1100.0;
julia> gv.verbose  = -1;        # switch off any verbose
julia> out         = point_wise_minimization(P,T, gv, z_b, DB, splx_data, sys_in)
Pressure          : 10.0      [kbar]
Temperature       : 1100.0    [Celcius]
     Stable phase | Fraction (mol 1 atom basis) 
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


