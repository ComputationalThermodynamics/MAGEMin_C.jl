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


"""
    threaded_frac_melting(data_thread, dtb, P, H, T, e1_liq, e1_remain, sys_in, bulk,
                          Xoxides, KDs_database; ...) -> Li_infos

Perform fractional melting with Li trace-element partitioning for a single (P, H₂O) condition.

Starting from the solidus, iterates up to `n_ee` extraction events. At each event, a bisection
algorithm finds the temperature at which the melt volume fraction reaches `e1_liq`%; the melt is
extracted leaving `e1_remain`% behind, the residual bulk and Li budget are updated, and the
loop continues. Pre- and post-extraction MAGEMin outputs are stored as paired entries.

# Arguments
- `data_thread`: Tuple `(gv, z_b, DB, splx_data)` of thread-local MAGEMin data
- `dtb`: MAGEMin database identifier (e.g., `"mp"`)
- `P`: Pressure [kbar]
- `H`: H₂O molar fraction (overwrites the H₂O entry in `bulk`)
- `T`: Temperature bounds `[T_min, T_max]` [°C]
- `e1_liq`: Melt volume fraction threshold for extraction [vol%]
- `e1_remain`: Residual melt fraction after extraction [vol%]
- `sys_in`: Input unit system (e.g., `"mol"`)
- `bulk`: Bulk rock composition (H₂O entry overwritten with `H`)
- `Xoxides`: Oxide labels for `bulk`
- `KDs_database`: Li partition coefficient database

# Keyword Arguments
- `n_ee`: Number of extraction events (default 10)
- `Li_content`: Initial bulk Li [µg/g] (default 100.0)
- `Ws`: Optional custom Margules W parameters for biotite
- `norm_TE`: Normalize trace element concentrations to the melt (default true)

# Returns
- `Li_infos` with `ext_out` (phase equilibrium) and `ext_out_te` (trace element) vectors
  storing results at each pre/post extraction step
"""
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

