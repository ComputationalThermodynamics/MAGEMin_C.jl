# ==========================================================================================================
# ==========================================================================================================
function threaded_frac_melting(     data_thread :: Tuple{Any, Any, Any, Any}, dtb :: String,

                                    P           :: Float64,
                                    H           :: Float64,
                                    T           :: Vector{Float64},
                                    e1_liq      :: Float64, 
                                    e1_remain   :: Float64, 
                                    sys_in      :: String,
                                    bulk        :: Vector{Float64},
                                    Xoxides     :: Vector{String},
                                    KDs_database;
                                    n_ee        :: Int64    = 10,
                                    Li_content  :: Float64  = 100.0,
                                    Ws          :: Union{Vector{MAGEMin_C.W_data{Float64, Int64}},Nothing} = nothing,
                                    norm_TE     :: Bool     = true)

    gv, z_b, DB, splx_data = data_thread        # Unpack the MAGEMin data

    id_h        = findfirst(Xoxides .== "H2O")
    bulk[id_h]  = H
    gv          = define_bulk_rock(gv, bulk, Xoxides, sys_in, dtb);

    elem_TE     = ["Li"]
    bulk_TE     = [Li_content]           # Li	30–100 µg/g (ppm)	- Can be up to 150 ppm in Li-rich pelites

    C0          = adjust_chemical_system( KDs_database, bulk_TE, elem_TE );

    ext_out     = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef,n_ee*2)
    ext_out_te  = Vector{MAGEMin_C.out_tepm}(undef,n_ee*2)

    n_max       = 64;                    # Maximum number of iterations in the bisection method
    tolerance   = 1e-4;

    Tsol        = retrieve_solidus(P, gv, z_b, DB, splx_data)
    # println("Tsol: $Tsol at P: $P and H: $H")

    out         = deepcopy(point_wise_minimization(P, Tsol, gv, z_b, DB, splx_data; W = Ws, name_solvus = true))
    out_TE      = deepcopy(TE_prediction(out, C0, KDs_database, dtb; ZrSat_model = "CB", norm_TE = norm_TE))

    # saving starting point
    ext_out[1]      = out
    ext_out_te[1]   = out_TE

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
                        if abs(result) < tolerance*500# && P < 10.0
                            conv    = 1
                            failed  = 0
                        else
                            # println("Bisection method did not converge after $n_max iterations at P, $(round(P,digits=4)); T, $(round(c,digits=4)), ee, $ee; and bulk, $(bulk)")
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

                ext_out[ee*2]      = out
                ext_out_te[ee*2]   = out_TE

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

                    ext_out[ee*2+1]      = out
                    ext_out_te[ee*2+1]   = out_TE
                end    
            else
                break;
            end
        end

    end

    Li_info_PM = Li_infos(ext_out, ext_out_te)

    return Li_info_PM
end

