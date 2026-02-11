# MAGEMin_C.jl: Isentropic path calculation

This tutorial demonstrates how to compute an isentropic decompression path using MAGEMin_C.jl, employing a bisection method to find the temperature at each pressure step that preserves the reference entropy, and visualizing the resulting melt fraction, melt density, and melt composition.

!!! info
    - [Isentropic path calculation](#Isentropic-path-calculation)

!!! note
    - This tutorial is not optimized for performance, but is provided in the hope it can be useful to present `MAGEMin_C` functionality.
    - Some basic background in `Julia` programming is recommended.

## Isentropic path calculation

```julia
using MAGEMin_C
using Plots
using ProgressMeter

dtb         = "ig"
data        = Initialize_MAGEMin(dtb,verbose=-1);
test        = 0         # KLB-1
data        = use_predefined_bulk_rock(data, test);

MPT         = 1350.0;                                                            # Mantle potential temperature in °C
adiabat     = 0.55;                                                              # Adiabatic gradient in the upper mantle °C/km
Depth       = 100.0;                                                             # Depth in km
rho_Mantle  = 3300.0;                                                            # Density of the mantle in kg/m³

Ts          = MPT + adiabat * Depth                                              # Starting temperature in the isentropic path (rough estimate)
Ps          = Depth*1e3*9.81*rho_Mantle/1e5/1e3                                  # Starting pressure in kbar (rough estimate)
Pe          = 0.001;                                                             # Ending pressure in kbar

n_steps     = 32;                                                                # number of steps in the isentropic path
n_max       = 32;                                                                # Maximum number of iterations in the bisection method
tolerance   = 0.1;                                                               # Tolerance for the bisection method
P           = Array(range(Ps, stop=Pe, length=n_steps))                          # Defines pressure values for the isentropic path
out         = Vector{out_struct}(undef, n_steps)      # Vector to store the output of the single_point_minimization function
out_tmp     = out_struct;

# compute the reference entropy at pressure and temperature of reference 
out[1]      = deepcopy( single_point_minimization(Ps,Ts, data));
Sref        = out[1].entropy[1]                                                    # Entropy of the system at the starting point   

@showprogress for j = 2:n_steps

        a           = out[j-1].T_C - 50.0
        b           = out[j-1].T_C
        n           = 1
        conv        = 0
        n           = 0
        sign_a      = -1

        while n < n_max && conv == 0
            c       = (a+b)/2.0
            out_tmp = deepcopy( single_point_minimization(P[j],c, data));
            result  = out_tmp.entropy[1] - Sref

            sign_c  = sign(result)

            if abs(b-a) < tolerance
                conv = 1
            else
                if  sign_c == sign_a
                    a = c
                    sign_a = sign_c
                else
                    b = c
                end
                
            end
            n += 1
        end

        out[j] = deepcopy(out_tmp)
end

Finalize_MAGEMin(data)


#=
    In the following section we extract the melt fraction, total melt fraction, SiO2 in the melt, melt density for all steps
=#
S           = [out[i].entropy[1] for i in 1:n_steps];                          # check entropy values
frac_M      = [out[i].frac_M for i in 1:n_steps];                           # Melt fraction for all steps
frac_M[frac_M .== 0.0] .= NaN;                                              # Replace 0.0 values with NaN
T           = [out[i].T_C for i in 1:n_steps];                              # extract temperature for all steps

SiO2_id     = findfirst(out[1].oxides .== "SiO2")                           # Index of SiO2 in the oxides array   
dry_id      = findall(out[1].oxides .!= "H2O")                              # Indices of all oxides except H2O
SiO2_M_dry  = [ (out[i].bulk_M[SiO2_id] / sum(out[i].bulk_M[dry_id])*100.0) for i in 1:n_steps];                             # SiO2 in the melt for all steps
rho_M       = [ (out[i].rho_M) for i in 1:n_steps];                         # melt density for all steps
rho_M[rho_M .== 0.0] .= NaN;                                                # Replace 0.0 values with NaN


#=
    Ploting the results using Plots
=#
p1          = plot(T,P, xlabel="Temperature (°C)", marker = :circle, markersize = 2, lw=2, ylabel="Pressure (kbar)", legend=false)
p2          = plot(frac_M,P, xlabel="Melt fraction (mol)", marker = :circle, markersize = 2, lw=2, ylabel="Pressure (kbar)", legend=false)
p3          = plot(rho_M,P, xlabel="Melt density (kg/m³)", marker = :circle, markersize = 2, lw=2, ylabel="Pressure (kbar)",        legend=false)
p4          = plot(SiO2_M_dry,P, xlabel="SiO₂ melt anhydrous (mol%)", marker = :circle, markersize = 2, lw=2, ylabel="Pressure (kbar)",  legend=false)


fig = plot(p1, p2, p3, p4, layout=(2, 2), size=(800, 600))
savefig(fig,"isentropic_path.png")
```
