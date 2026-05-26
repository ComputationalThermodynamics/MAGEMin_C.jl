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
include("plot_bulk_FS.jl")

function main(;     model       = "BA",
                    test       = false,  # if true, only test on a small subset of the bulk-rock compositions
                    FC          = false,
                    dpi         = 300,
                    fake_F_bi   = false,
                    out_dir     = "./output_Li_v0.1/",
                    Li_content  = 100.0,            # Li content in ppm
                    P           = 4.0,
                    Ex_H2O_sat  = 0.0,
                    n_ee        = 1,
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

    ext_out                 = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef,np)
    ext_out_te              = Vector{MAGEMin_C.out_tepm}(undef,np)

    progr = Progress(np, desc="Computing $np FM calculations...") # progress meter
    @threads :static for i=1:np
        data_thread     = get_data_thread(data)
        
        bulk           = FS_bulks[i,:]
        H               = water_saturation_curve_FS(    data_thread,
                                                        P,
                                                        bulk,
                                                        Xoxides,
                                                        dtb,
                                                        Ex_H2O_sat );

        if H < 0.0
            @warn "Water content is negative, setting to zero."
            H = 0.0
        end

        gv, z_b, DB, splx_data = data_thread        # Unpack the MAGEMin data

        id_h        = findfirst(Xoxides .== "H2O")
        bulk[id_h]  = H
        gv          = define_bulk_rock(gv, bulk, Xoxides, sys_in, dtb);

        elem_TE     = ["Li"]
        bulk_TE     = [Li_content]           # Li	30–100 µg/g (ppm)	- Can be up to 150 ppm in Li-rich pelites

        C0          = adjust_chemical_system( KDs_database, bulk_TE, elem_TE );
        Tsol        = retrieve_solidus(P, gv, z_b, DB, splx_data)

        out         = deepcopy(point_wise_minimization(P, Tsol, gv, z_b, DB, splx_data; W = Ws, name_solvus = true))
        out_TE      = deepcopy(TE_prediction(out, C0, KDs_database, dtb; ZrSat_model = "CB", norm_TE = norm_TE))

        # # saving starting point
        # ext_out[1]      = out
        # ext_out_te[1]   = out_TE

        n_max       = 64;                    # Maximum number of iterations in the bisection method
        tolerance   = 1e-4;

        for ee = 1:n_ee    # here we loop through all the different extraction events

            a           = Tsol
            b           = T[2] + 400.0
            c           = (a+b)/2.0

            conv        = 0
            failed      = 0
            n           = 0
            sign_a      = -1

            while n < n_max && conv == 0

                c       = (a+b)/2.0
                out     = deepcopy(point_wise_minimization(P, c, gv, z_b, DB, splx_data; W = Ws, name_solvus = true))

                result  = out.frac_M_vol - e1_liq/100.0
                sign_c  = sign(result)
                if abs(result) < tolerance
                    conv    = 1
                    failed  = 0
                else
                    if n == n_max -1
                        # relax tolerance if close enough
                        if abs(result) < tolerance*100
                            conv    = 1
                            failed  = 0
                        else # Relax tolerance if P < 5 GPa
                            if abs(result) < tolerance*500 && P < 5.0
                                conv    = 1
                                failed  = 0
                            else
                                conv    = 1
                                failed  = 1
                            end
                        end

                    else
                        if  sign_c == sign_a
                            a = c
                            sign_a = sign_c
                        else
                            b = c
                        end
                    end
                end
                n += 1
            end

            # In the following, we check that the calculation converged and that there is still a melt phase, and if melt contains H2O
            # If not, we stop the loop over extraction events
            if conv == 1
                if failed == 0
                    Tsol        = c
                    out         = deepcopy(point_wise_minimization(P, Tsol, gv, z_b, DB, splx_data; W = Ws, name_solvus = true))
                    out_TE      = deepcopy(TE_prediction(out, C0, KDs_database, dtb; ZrSat_model = "CB", norm_TE = norm_TE))

                id_h2o       = findfirst(out.oxides .== "H2O")
                    if "liq" in out.ph
                        id_liq   = findfirst(out.ph .== "liq")
                        h2o_liq = out.SS_vec[id_liq].Comp[id_h2o]
                        if h2o_liq == 0.0
                            # println("No H2O in the liquid phase at P, $(round(P,digits=4)); T, $(round(Tsol,digits=4)), ee, $ee; and bulk, $(bulk)")
                            failed = 1
                        end
                    end
                end

                if failed == 0

                    ext_out[i]      = out
                    ext_out_te[i]   = out_TE

                    if ee < n_ee
                        Tsol     = c

                        if "liq" in out.ph
                            id_liq   = findfirst(out.ph .== "liq")
                            ratio    = (out.frac_M_vol - e1_remain/100.0)/out.frac_M_vol
                            bulk      = out.bulk .- out.SS_vec[id_liq].Comp .* (out.frac_M*ratio)
                
                            gv       = define_bulk_rock(gv, bulk, Xoxides, "mol", dtb);
                            C0       = C0 .- out_TE.Cliq[1] .* (out_TE.liq_wt_norm*ratio)
                        else
                            println("No liquid phase found at P, $(round(P,digits=4)); T, $(round(Tsol,digits=4)), ee, $ee; and bulk, $(bulk)")
                        end
                        
                        out      = deepcopy(point_wise_minimization(P, Tsol, gv, z_b, DB, splx_data; W = Ws, name_solvus = true))
                        out_TE   = deepcopy(TE_prediction(out, C0, KDs_database, dtb; ZrSat_model = "CB", norm_TE = norm_TE))

                        ext_out[i]      = out
                        ext_out_te[i]   = out_TE
                    end    
                else
                    break;
                end
            end

        end
        # saving starting point

        # Li_info_PM = Li_infos(ext_out, ext_out_te)


        next!(progr)
    end
    finish!(progr)

    Finalize_MAGEMin(data);

    return ext_out, ext_out_te, np, KDs_database, FS_bulks
end


model       = "MM"              # KM, MM
FC          = false             # if true, perform fractional crystallization
test        = false             # if true, only test on a small subset of the bulk-rock compositions
dpi         = 300
model       == "MM_F" ? fake_F_bi = true : fake_F_bi = false
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
P           = 8.0; 
Ex_H2O_sat  = 0.0;   
n_ee        = 1;
e1_liq      = 7.0;
e1_remain   = 1.0;


ext_out, ext_out_te, np, KDs_database, FS_bulks = main(;    model       = model,
                                                            test        = test,  # if true, only test on a small subset of the bulk-rock compositions
                                                            FC          = FC,
                                                            dpi         = dpi,
                                                            fake_F_bi   = fake_F_bi,
                                                            out_dir     = out_dir,
                                                            Li_content  = Li_content,
                                                            P           = P,
                                                            Ex_H2O_sat  = Ex_H2O_sat,
                                                            n_ee        = n_ee,
                                                            e1_liq      = e1_liq,
                                                            e1_remain   = e1_remain);


plot_bulk_FS(ext_out, P, np, FS_bulks, n_ee)
