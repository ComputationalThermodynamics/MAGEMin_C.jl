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

using MAGEMin_C, Plots, ProgressMeter, JLD2, PCHIPInterpolation, XLSX, DataFrames, PlotlyJS, Statistics
using Base.Threads: @threads
using Plots.PlotMeasures

include("TE_functions.jl")
include("TE_functions_FS.jl")
include("TE_fractional.jl")
include("plot_figures.jl")
include("plot_figures_FS.jl")


"""
    main(; model, test, FC, dpi, fake_F_bi, out_dir, Li_content, P, Ex_H2O_sat,
            n_ee, e1_liq, e1_remain, norm_TE) -> (Out_all, np, KDs_database, FS_bulks)

Run the full Li fractional melting systematics for the Forshaw & Pattison (2023) pelite database.

Loads the bulk-rock database, initializes MAGEMin, runs `perform_threaded_calc_FS` over all
compositions at pressure `P`, and generates compositional plots via `plot_all_oxides` and
`plot_custom_oxides`. Figures and statistics are saved to `out_dir`.

# Keyword Arguments
- `model`: KD model (`"MM"`, `"BA"`, `"KM"`, `"MM_F"`, `"HO"`; default `"BA"`)
- `test`: If true, subsamples every 50th composition for rapid testing (default false)
- `FC`: Fractional crystallization flag (default false)
- `dpi`: Figure resolution (default 300)
- `fake_F_bi`: Apply custom biotite W parameters to extend stability (default false)
- `out_dir`: Output directory (default `"./output_Li_v0.1/"`)
- `Li_content`: Initial bulk Li [µg/g] (default 100.0)
- `P`: Pressure [kbar] (default 4.0)
- `Ex_H2O_sat`: Excess H₂O above saturation [mol fraction] (default 0.0)
- `n_ee`: Number of extraction events (default 10)
- `e1_liq`, `e1_remain`: Melt extraction and residual thresholds [vol%] (defaults 7.0 / 1.0)
- `norm_TE`: Normalize trace element concentrations (default true)
"""
function main(;     model       = "BA",
                    test       = false,  # if true, only test on a small subset of the bulk-rock compositions
                    FC          = false,
                    dpi         = 300,
                    fake_F_bi   = false,
                    out_dir     = "./output_Li_v0.1/",
                    Li_content  = 100.0,            # Li content in ppm
                    P           = 4.0,
                    Ex_H2O_sat  = 0.0,
                    n_ee        = 10,
                    e1_liq      = 7.0,
                    e1_remain   = 1.0,
                    norm_TE     = true   )

    # first initialize MAGEMin
    dtb       = "mp"
    if model == "KM"
        clim        = (2.0, 10.0)  
    elseif model == "KM0"
        clim        = (2.0, 10.0)  
    elseif model == "KMout"
        clim        = (2.0, 10.0)  
    elseif model == "MM"
        clim        = (2.0, 6.0)
    elseif model == "MM_st"
        clim        = (2.0, 6.0)
    elseif model == "BA"
        clim        = (2.0, 10.0)
    elseif model == "MM_F"
        clim        = (2.0, 8.0)
    elseif model == "HO"
        clim        = (2.0, 6.0)
    end

    if fake_F_bi == true
        Ws          = custom_bi_Ws()
        println("Using custom biotite partitioning coefficients! (extended biotite stability)")
    else
        Ws          = nothing
    end 
 
    T           = [600.0, 1100.0]
    simu        = "FS_dtb_$(model)_P$(round(P, digits=2))kbar_H$(round(Ex_H2O_sat, digits=2))_e$(e1_liq)_r$(e1_remain)"
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

    # Define dry bulk rock composition
    Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
    sys_in      = "mol";

    bulk_db     = load_Forshaw_mp()
    FS_bulks    = get_mol_bulks(bulk_db)       #this return the list of bulk-rock compositions in molar units

    if test == true
        FS_bulks    = FS_bulks[1:50:end,:]
    end
    np          = size(FS_bulks,1);

    # pre-allocate the output arrays
    Out_all                 = Array{Li_infos}(undef, np);
    Out_all_FC              = Array{Li_infos}(undef, np);

    # perform the calculations
    data                    = Initialize_MAGEMin(dtb, verbose=-1; solver=0);
    KDs_database            = get_Kds(model = model);

    Out_all, Out_all_FC, FS_bulks     = perform_threaded_calc_FS(   Out_all, Out_all_FC, data, dtb, P, T, np, 
                                                                    Float64(e1_liq), Float64(e1_remain), sys_in, FS_bulks, Xoxides,
                                                                    KDs_database;
                                                                    n_ee        = n_ee,
                                                                    Li_content  = Li_content,
                                                                    FC          = FC,
                                                                    Ex_H2O_sat  = Ex_H2O_sat,
                                                                    Ws          = Ws,
                                                                    norm_TE     = norm_TE,
                                                                    solidus_calc= false);
    # @save "$(output)Out_all.jld2" Out_all Out_all_FC


    Finalize_MAGEMin(data);

    point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, eta_M, Dbi, afs, pl  = retrieve_outputs_FS(Out_all, np, KDs_database, output);

    plot_all_oxides(   FS_bulks, Li_content, Xoxides, point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu,
                                e1_liq, e1_remain, P, Ex_H2O_sat, model; rev = true, clim = clim, output = output)

    plot_custom_oxides(   FS_bulks, Li_content, Xoxides, point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, Dbi, afs, pl,
                                e1_liq, e1_remain, P, Ex_H2O_sat, model; rev = true, clim = clim, output = output)

    return Out_all, np, KDs_database, FS_bulks
end


# "MM", "BA", "KM", "MM_F"
model       = "MM"              # KM, MM
FC          = false             # if true, perform fractional crystallization
test        = false             # if true, only test on a small subset of the bulk-rock compositions
dpi         = 300
model       == "MM_F" ? fake_F_bi = true : fake_F_bi = false
out_dir     = "./output_Li_v0.1"
Li_content  = 100.0;            # Li content in ppm
# P           = [2.0:1.0:15.0;]; 
# P           = [2.0:1.0:16.0;]; 
P           = [4.0,8.0];

Ex_H2O_sat  = 0.03;   
n_ee        = 10;
e1_liq      = 7.0;
e1_remain   = 1.0;

for Pin in P

Out_all, np, KDs_database, FS_bulks = main(;    model       = model,
                                                test        = test,  # if true, only test on a small subset of the bulk-rock compositions
                                                FC          = FC,
                                                dpi         = dpi,
                                                fake_F_bi   = fake_F_bi,
                                                out_dir     = out_dir,
                                                Li_content  = Li_content,
                                                P           = Pin,
                                                Ex_H2O_sat  = Ex_H2O_sat,
                                                n_ee        = n_ee,
                                                e1_liq      = e1_liq,
                                                e1_remain   = e1_remain);
end

