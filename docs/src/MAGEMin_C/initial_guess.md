# MAGEMin_C.jl: Initial guess

This tutorial demonstrates how to use previously computed phase equilibrium results as initial guesses to accelerate subsequent minimizations in MAGEMin_C.jl, by collecting solution phase information from nearby P-T-X points and passing them to a new calculation.

!!! info
    - [Initial guess](#Initial-guess)

!!! note
    - This tutorial is not optimized for performance, but is provided in the hope it can be useful to present `MAGEMin_C` functionality.
    - Some basic background in `Julia` programming is recommended.

## Initial guess

```julia

MAGEMin_data    = Initialize_MAGEMin("ig", verbose=false, solver=0);

Xoxides         = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "Cr2O3"; "H2O"];
X1              = [70.999,  12.805, 0.771,  3.978,  6.342,  2.7895, 1.481,  0.758,  0.72933,    0.1,    3.0];
X2              = [70.999,  12.805, 0.771,  3.978,  6.342,  2.7895, 1.481,  0.758,  0.72933,    0.1,    9.0];
X3              = [70.999,  12.805, 0.771,  3.978,  6.342,  2.7895, 1.481,  0.758,  0.72933,    0.1,    15.0];
X4              = [70.999,  12.805, 0.771,  3.978,  6.342,  2.7895, 1.481,  0.758,  0.72933,    0.1,    21.0];
sys_in          = "mol";

P, T            = 19.0, 1350.0;

Pvec,Tvec       = [19.0,19.0,19.5,19.5], [1325.0,1350.0,1325.0,1350.0]

Xvec            = [X1,X2,X3,X4] # here the composition can also be slightly varied. how much I am not quite sure yet

Out_XY          = Vector{MAGEMin_C.gmin_struct}(undef,length(Pvec))
Out_XY_ig       = Vector{MAGEMin_C.gmin_struct}(undef,length(Pvec))
Out_XY          = multi_point_minimization( Pvec, Tvec, MAGEMin_data;
                                            X=Xvec, Xoxides=Xoxides, sys_in=sys_in, 
                                            name_solvus=true); 

                        
tmp             = [Out_XY[i].mSS_vec for i=1:length(Pvec)]
Gig             = vcat(tmp...)                  

Out_ig          = single_point_minimization(    19.25, 1337.5,
                                                MAGEMin_data;
                                                X           = sum(Xvec)./4.0,
                                                Xoxides     = Xoxides,
                                                sys_in      = sys_in, 
                                                name_solvus = true,
                                                iguess      = true,
                                                G           = [Gig]);
                                        
Finalize_MAGEMin(MAGEMin_data)
```
