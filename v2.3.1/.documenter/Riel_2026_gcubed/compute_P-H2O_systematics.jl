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
using Base.Threads: @threads

include("TE_functions.jl")
include("TE_fractional.jl")
include("plot_figures.jl")


function main(;     model       = "MM",
                    FC          = false,
                    dpi         = 300,
                    fake_F_bi   = false,
                    out_dir     = "./output_Li_v0.1b/",
                    Li_content  = 100.0,            # Li content in ppm
                    Pin         = [1.0, 16.0], # pressure range in kbar
                    n_ee        = 10,
                    e1_liq      = 7.0,
                    e1_remain   = 1.0,
                    np          = 100,
                    b           = "FS",
                    scale       = "",
                    norm_TE     = true)   # number of points in the pressure and H2O range)
    # first initialize MAGEMin
    dtb         = "mp"

    # Define dry bulk rock composition - average pelite (Forshaw and Pattison, 2023)
    if b == "K"
        T           = [600.0, 1000.0]
        P           = collect(range(Pin[1],Pin[2],np));      # don't increase the pressure over 18 kbar, you may rich a liq solvus!
        H           = collect(range(0.01,0.16,np));
        #RS014/97 - Knoll et al. 2023 NaCaKFMASH
        Xoxides     = [ "SiO2", "Al2O3", "CaO", "MgO", "FeO", "K2O", "Na2O", "TiO2", "O", "MnO", "H2O"]
        bulk = norm2one([56.18, 21.11, 0.65, 4.48, 10.31, 3.95, 1.75, 1.38, 0.0069, 0.19, 0.0])
        # bulk = norm2one([56.18, 21.11, 0.65, 4.48, 10.31, 3.95, 1.75, 0.0, 0.0, 0.0, 0.0])
        # bulk        = norm2one([57.19, 21.49, 0.27, 4.56, 10.69, 4.02, 1.78, 0.0, 0.0, 0.0, 0.0]) # as in paper sup data

        sys_in      = "mol";

        # Compute the pressure interpolant for the water saturated curve. One for water content, one for temperature
        if isfile("pChip_wat_st.jld2")
            pChip_wat = load("pChip_wat_st.jld2")["pChip_wat"]
        else
            pChip_wat, pChip_T = water_saturation_curve(    P,
                                                            bulk,
                                                            Xoxides,
                                                            dtb,
                                                            0.0 );
            save("pChip_wat_st.jld2", "pChip_wat", pChip_wat,"pChip_T", pChip_T)
        end

    else
        T           = [600.0, 1000.0]
        P           = collect(range(Pin[1],Pin[2],np));      # don't increase the pressure over 18 kbar, you may rich a liq solvus!
        H           = collect(range(0.01,0.12,np));

        Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
        bulk        = norm2one([0.67153, 0.12111, 0.00729, 0.03762, 0.05998, 0.02638, 0.01401, 0.00717, 0.0069, 0.00071, 0.0]);
        sys_in      = "mol";

        # Compute the pressure interpolant for the water saturated curve. One for water content, one for temperature
        if model == "MM_F"
            if isfile("pChip_wat_F.jld2")
                pChip_wat = load("pChip_wat_F.jld2")["pChip_wat"]
            else
                pChip_wat, pChip_T = water_saturation_curve(    P,
                                                                bulk,
                                                                Xoxides,
                                                                dtb,
                                                                0.0 );
                save("pChip_wat_F.jld2", "pChip_wat", pChip_wat,"pChip_T", pChip_T)
            end
        else
            if isfile("pChip_wat.jld2")
                pChip_wat = load("pChip_wat.jld2")["pChip_wat"]
            else
                pChip_wat, pChip_T = water_saturation_curve(    P,
                                                                bulk,
                                                                Xoxides,
                                                                dtb,
                                                                0.0 );
                save("pChip_wat.jld2", "pChip_wat", pChip_wat,"pChip_T", pChip_T)
            end
        end
    end

    if fake_F_bi == true
        Ws          = custom_bi_Ws()
    else
        Ws          = nothing
    end 
    # pre-allocate the output arrays
    Out_all                 = Array{Li_infos}(undef, np, np);
    Out_all_FC              = Array{Li_infos}(undef, np, np);

    # perform the calculations
    data                    = Initialize_MAGEMin(dtb, verbose=-1; solver=0);
    KDs_database            = get_Kds(;model = model);

    Out_all, Out_all_FC     = perform_threaded_calc(    pChip_wat,
                                                        Out_all, Out_all_FC, data, dtb, P, T, H, np, 
                                                        Float64(e1_liq), Float64(e1_remain), sys_in, bulk, Xoxides,
                                                        KDs_database;
                                                        n_ee        = n_ee,
                                                        Li_content  = Li_content,
                                                        FC          = FC,
                                                        Ws          = Ws,
                                                        norm_TE     = norm_TE );

    Finalize_MAGEMin(data);

    point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, Δst, eta_M  = retrieve_outputs(Out_all, np);

    simu        = scale*"PH_dtb_$(model)_e$(e1_liq)_r$(e1_remain)"
    output      = "$(out_dir)/$(model)/$(simu)/"

    if !isdir("$(out_dir)")
        mkpath("$(out_dir)")
    end
    if !isdir("$(out_dir)/$(model)")
        mkpath("$(out_dir)/$(model)")
    end
    if !isdir("$(out_dir)/$(model)/$(simu)")
        mkpath("$(out_dir)/$(model)/$(simu)")
    end

    @save "$(output)$(simu).jld2" point_infos Cliq_max Extract_epi Extract_T Δbi Δcd Δmu eta_M Li_content model pChip_wat H P e1_liq e1_remain

    plot_output("Li",           Li_content, model, pChip_wat, H, P, Cliq_max,       e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("extraction",   Li_content, model, pChip_wat, H, P, Extract_epi,    e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("T",            Li_content, model, pChip_wat, H, P, Extract_T,      e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("Δbi",          Li_content, model, pChip_wat, H, P, Δbi,            e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("Δcd",          Li_content, model, pChip_wat, H, P, Δcd,            e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("mu",           Li_content, model, pChip_wat, H, P, Δmu,            e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("st",           Li_content, model, pChip_wat, H, P, Δst,            e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)
    plot_output("eta_M",        Li_content, model, pChip_wat, H, P, eta_M,          e1_liq, e1_remain; dpi = dpi, output = output, scale = scale)

    return Out_all, Out_all_FC
end

all_model   = ["MM"];  # MM: Matt Morris model; MM_F: Matt Morris model with fake biotite KD; KMout: Klemme and Milke, 2009, EPSL model
FC          = false             # if true, perform fractional crystallization
dpi         = 300
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
Pin         = [2.0, 16.0];
n_ee        = 10;
e1_liq      = [ 14.0 ];
e1_remain   = [ 7.0 ];

np          = 150;
b           = "FS"
scale       = "fixed_"

for i =1:length(all_model)

    all_model[i] == "MM_st" ? b = "K" : b = "FS"
    all_model[i] == "MM_F" ? fake_F_bi = true : fake_F_bi = false
    # all_model[i] == "KMout" ? norm_TE   = false : norm_TE   = true
    Out_all, Out_all_FC = main(;    model       = all_model[i],
                                    FC          = FC,
                                    dpi         = dpi,
                                    fake_F_bi   = fake_F_bi,
                                    out_dir     = out_dir,
                                    Li_content  = Li_content,            # Li content in ppm
                                    Pin         = Pin, # pressure range in kbar
                                    n_ee        = n_ee,
                                    e1_liq      = e1_liq[i],
                                    e1_remain   = e1_remain[i],
                                    np          = np,
                                    b           = b,
                                    scale       = scale,
                                    norm_TE     = false)

end


#=

dtb         = "mp"
id_H2O      =  findfirst(Xoxides .== "H2O")
bulk_sat    =  deepcopy(norm2one(bulk))
bulk_sat[id_H2O] = 0.6         # this ensures water saturation
bulk_sat    =  norm2one(bulk_sat)

pChip_wat, pChip_T = get_wat_sat_function(  [0.0,16.0],
                                                       bulk_sat,
                                                       Xoxides,
                                                       dtb,
                                                       0.0 );

Pin = [2.0:0.01:16.0;] 
H   = pChip_wat.(Pin)
plot(H,Pin)

=#

