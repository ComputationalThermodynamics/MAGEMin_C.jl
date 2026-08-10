#= Last modified: 12/05/2026

Thermodynamic modelling of lithium enrichment during partial melting: the importance of partition coefficients
Riel el al., 2026, Geochemistry, Geophysics, Geosystems

Set of scripts to perform fractional melting together with `Li` partitioning
The bulk-rock composition are after:
Forshaw, J.B., and Pattison, D.R.M., 2023, Major-element geochemistry of pelites: Geology,
https://doi.org/10.1130/G50542.1

partitioning coefficients are from:

Ballouard, C., Couziné, S., Bouilhol, P., Harlaux, M., Mercadier, J., & Montel, J.-M. (2023).
A felsic meta-igneous source for Li-F-rich peraluminous granites: insights from the Variscan
Velay dome (French Massif Central) and implications for rare-metal magmatism.
Contributions to Mineralogy and Petrology, 178(11), 75.

Koopmans, L., Martins, T., Linnen, R., Gardiner, N. J., Breasley, C. M., Palin, R. M., . . . Robb, L. J.
(2024). The formation of lithium-rich pegmatites through multi-stage melting. Geology, 52(1), 7–11.

Morris, M. C., Weller, O. M., Soderman, C. R., Edmonds, M., Beard, C. D., & Yeomans, C. M. (2026).
Melting of fluorine-rich biotite as a mechanism for generating lithium-rich granites.
Communications Earth & Environment.

=#

using MAGEMin_C, Plots, ProgressMeter, JLD2, PCHIPInterpolation, XLSX, DataFrames
using LaTeXStrings, Measures
using Base.Threads: @threads

include("TE_functions.jl")
include("TE_functions_FS.jl")
include("TE_fractional.jl")
include("plot_figures.jl")

model       = "MM"              # KM, MM
dpi         = 300
model       == "MM_F" ? fake_F_bi = true : fake_F_bi = false
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
Pin         = [2.0, 16.0];
e1_liq      = 7.0;
e1_remain   = 1.0;
np          = 100;
norm_TE     = true    # number of points in the pressure and H2O range
Ex_H2O_sat  = 0.03;

dtb         = "mp"
T           = [600.0, 1000.0]
P           = collect(range(Pin[1],Pin[2],np)); 

# Define dry bulk rock composition - average pelite (Forshaw and Pattison, 2023)
Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
bulk        = norm2one([0.67153, 0.12111, 0.00729, 0.03762, 0.05998, 0.02638, 0.01401, 0.00717, 0.0069, 0.00071, 0.0]);
sys_in      = "mol";

fake_F_bi == true ? Ws = custom_bi_Ws() : Ws = nothing

# pre-allocate the output arrays
Out_all                 = Array{Li_infos}(undef, np);
# perform the calculations
data                    = Initialize_MAGEMin(dtb, verbose=-1; solver=0);

Out_all     = perform_threaded_calc_EE(             Out_all, data, dtb, P, T, np, 
                                                    model, 
                                                    Float64(e1_liq), Float64(e1_remain), sys_in, bulk, Xoxides;
                                                    n_ee        = 15,
                                                    Ex_H2O_sat  = Ex_H2O_sat,
                                                    Li_content  = Li_content,
                                                    Ws          = Ws,
                                                    norm_TE     = norm_TE );

Finalize_MAGEMin(data);

Extract_events = []

for i = 1:np
    compute     = false
    nval_points = 0

    if !isnothing(Out_all[i].ext_out_te)
        for o = 2:length(Out_all[i].ext_out_te)
            if !isassigned(Out_all[i].ext_out_te, o)
                break
            else
                nval_points = o
            end
        end
        if nval_points >= 2
            compute = true
        end
    end

    if compute == true
        T   = [Out_all[i].ext_out[k].T_C for k = 2:2:nval_points]
        push!(Extract_events, (T))
    else
        push!(Extract_events, NaN)
    end
end

for i=1:np
    println("P = $(P[i]) kbar, T = $(Extract_events[i]) °C")
end

# Find the maximum length of T arrays in Extract_events
max_len = 0
for i=1:np
    if length(Extract_events[i]) > max_len
        max_len = length(Extract_events[i])
    end
end

# Preallocate the matrix
T_curves = fill(NaN, np, max_len)

for i in 1:np
    nl = length(Extract_events[i])
    T_curves[i, 1:nl] = Extract_events[i]
end

plt = plot()
plot(T_curves[:,1], P)
plot!(T_curves[:,2], P)
plot!(T_curves[:,3], P)
plot!(T_curves[:,4], P)
plot!(T_curves[:,5], P)
plot!(T_curves[:,6], P)
plot!(T_curves[:,7], P)
plot!(T_curves[:,8], P)
plot!(T_curves[:,9], P)
plot!(T_curves[:,10], P)
plot!(T_curves[:,11], P)
plot!(T_curves[:,12], P)
plot!(T_curves[:,13], P)
plot!(T_curves[:,14], P)
plot!(T_curves[:,15], P)



plot!(xlabel = "T (°C)", ylabel = "P (GPa)", ylims = (2, 16), xlims = (650, 1000), legend = :topright, dpi = 300, right_margin = 20Plots.px)

 savefig("wat_phase_stability_EE-T_+0.03.svg")