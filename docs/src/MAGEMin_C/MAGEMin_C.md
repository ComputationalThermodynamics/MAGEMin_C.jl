## MAGEMin_C.jl

`MAGEMin_C` is designed to simplify single and multipoint phase equilibrium modelling using `Julia` programming language. The main objective is to provide a set of routine to initialize MAGEMin, perform a set of calculation, store the results of the phase equilibrium modelling in an output structure and free (deallocate) MAGEMin. This approach allow to easily create custom script to perform advanced phas equilibrium modelling calculations but also to offer an interface with geodynamic modelling (such as reactive two-phase modelling of magma transport).


## Quick start

The most convinient way to use `MAGEMin_C.jl` is by first creating a `Julia` script. To do so, simply create a new text file and change the extension to `.jl`, e.g., `MAGEMin_C_script.jl`.

The following example shows you how to perform a **single point calculation** with the following parameters:

```@raw html
<ul>
    <li>Thermodynamic database = ig which stands for Igneous (Green et al., 2025 modified from Holland et al., 2018)</li>
    <li>P = pressure in kbar</li>
    <li>T = temperature in °C</li>
    <li>Xoxides = array of oxides names for the bulk rock-composition</li>
    <li>X = array of oxides content for the bulk-rock composition </li>
    <li>sys_in = system unit. It can be mol or wt</li>
</ul>
```

```julia
using MAGEMin_C
data    = Initialize_MAGEMin("ig", verbose=false);
P,T     = 10.0, 1100.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)
```

- `using MAGEMin_C` loads the package, while `data    = Initialize_MAGEMin("ig", verbose=false);` initializes `MAGEMin_C` with the wanted database and reduced verbose.
- `out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)`performs the phase equilibrium calculation given the provided parameters. The results of the computation, such as the stable phase names, fractions, composition etc, are store in the `out` structure. Details about how to access the full list of saved variables are provided in the tutorials section.


!!! note
    A number of options other than `verbose=false` can be added to the command. For instance `solver= x` or `buffer= "qfm"` are also valid. The complete list of options is given in the in the tutorials section.


!!! note
    Thermodynamic dataset acronym are the following:
    - `mtl` -> mantle (Holland et al., 2013)
    - `mp` -> metapelite (White et al., 2014)
    - `mb` -> metabasite (Green et al., 2016)
    - `ig` -> igneous (Green et al., 2025 updated from and replacing Holland et al., 2018)
    - `igad` -> igneous alkaline dry (Weller et al., 2024)
    - `um` -> ultramafic (Evans & Frost, 2021)
    - `ume` -> ultramafic extended (Green et al., 2016 + Evans & Frost, 2021)
