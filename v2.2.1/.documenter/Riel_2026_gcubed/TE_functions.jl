#=
10/04/2025

Script to perform fractional crystallization together with `Li` partitioning
The bulk-rock composition is after FWorldMedian pelite

partitioning coefficients are from the EODC database
ph     = ["mu"; "bi"; "cd"; "FeTiOx"; "g"; "afs"; "pl"; "q"; "ru"]  
KDs    = [0.82; 1.67; 0.44; 1e-5; 0.01; 0.02; 0.01; 1e-5; 1e-5] 

=#

function custom_bi_Ws()
    dtb     = 0             # metapelite
    ss_id   = 3             # biotite
    n_Ws    = 21            # number of Margules parameters
    x       = 0.1
   Ws_mod   = [ 12.0 0.0 0.0;
                4.0 0.0 0.0;
                10.0 0.0 0.0;
                30.0*x 0.0 0.0;##
                8.0 0.0 0.0;
                9.0 0.0 0.0;
                8.0 0.0 0.0;
                15.0 0.0 0.0;
                32.0*x 0.0 0.0;##
                13.6 0.0 0.0; 
                6.3 0.0 0.0;
                7.0 0.0 0.0;
                24.0*x 0.0 0.0;##
                5.6 0.0 0.0;
                8.1 0.0 0.0;
                40.0*x 0.0 0.0;##
                1.0 0.0 0.0;
                13.0 0.0 0.0;
                40.0*x 0.0 0.0;#
                30.0*x 0.0 0.0;#
                11.6 0.0 0.0]
    new_Ws      =  Vector{MAGEMin_C.W_data{Float64,Int64}}(undef, 1)
    new_Ws[1]   = MAGEMin_C.W_data(dtb, ss_id, n_Ws, Ws_mod)   

    return new_Ws
end


struct Li_infos
    ext_out     :: Union{Nothing,Vector{MAGEMin_C.gmin_struct{Float64, Int64}}}
    ext_out_te  :: Union{Nothing,Vector{MAGEMin_C.out_tepm}}
end


function get_coordinates(k::Int, np::Int)
    i = div(k - 1, np) + 1  # Row index
    j = mod(k - 1, np) + 1  # Column index
    return i, j
end


function get_data_thread( MAGEMin_db :: MAGEMin_Data )

    id          = Threads.threadid()
    gv          = MAGEMin_db.gv[id]
    z_b         = MAGEMin_db.z_b[id]
    DB          = MAGEMin_db.DB[id]
    splx_data   = MAGEMin_db.splx_data[id]
    
   return (gv, z_b, DB, splx_data)
end

function norm2one( vec :: Vector{Float64})
    return vec ./ sum(vec)
end

function get_Kds_data(; model::String = "MM")
    if model == "KM"
        println("Using Koopmans et al. (2022) partitioning coefficients for Li - no qtz, grt")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "afs"; "pl";"q";"opx";"amp";"cpx";"ilm";"mt";"ky";"sill";"hem";"ru"]  
        KDs     = ["0.82"; "1.67"; "0.44";  "0.01"; "0.02";"1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"] 
    elseif model == "KM0"
        println("Using Koopmans et al. (2022) partitioning coefficients for Li - no qtz, grt, set to 0.0")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "afs"; "pl";"q";"opx";"amp";"cpx";"ilm";"mt";"ky";"sill";"hem";"ru"]  
        KDs     = ["0.82"; "1.67"; "0.44";  "0.01"; "0.02";"0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"] 
    elseif model == "KMout"
        println("Using Koopmans et al. (2022) partitioning coefficients for Li - no qtz, grt ignored")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "afs"; "pl"]  
        KDs     = ["0.82"; "1.67"; "0.44";  "0.01"; "0.02"] 
        
    elseif model == "BA"
        println("Using Ballouard et al. (2023) partitioning coefficients for Li - no qtz)")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "g"; "q";"afs";"pl";"opx";"amp";"cpx";"ilm";"mt";"ky";"sill";"hem";"ru"]  
        KDs     = ["0.11"; "0.55"; "1.10";  "0.09"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"]
    elseif model == "MM"
        println("Using Matt Morris and Charlie Beard (2024) updated partitioning coefficients for Li")
        el      = ["Li"]
        ph      = ["q";"bi";"afs";"pl";"opx";"cd";"mu";"amp";"fl";"cpx";"g";"ilm";"mt";"ky";"sill";"hem";"ru"]
        bi_exp  = "c9 = -7.01; c10 = -4.29; c11 = 4.18; c12 = 0.407; XMFe3p = [:bi].siteFractions[4]; NaK_Almelt = ([:liq].Comp_apfu[6] + [:liq].Comp_apfu[7]) / [:liq].Comp_apfu[2]; ln_D_Li = c9 + c10*XMFe3p + c11*(NaK_Almelt) + c12*1e4/(T_C+273.15); exp(ln_D_Li)"
        # bi_exp  = "y = [:bi].compVariables[3];f = [:bi].compVariables[4]; bi_xSiT = 0.5-f/2.0 - y/2.0;bi_SiT  = (2.0 * bi_xSiT)+2.0; ln_D_Li = (-22.359) + (5.592*bi_SiT) + (10000*0.67*1/(T_C+273.15)); exp(ln_D_Li)"
        KDs     = ["0.21";bi_exp;"0.13";"0.45";"0.2";"0.14";"0.82";"0.2";"0.65";"0.26";"0.083";"0.85";"0.08";"1e-4"; "1e-4";"1e-4"; "1e-4"] 
    elseif model == "MM_F"
        println("Using Matt Morris and Charlie Beard (2024) updated partitioning coefficients for Li")
        el      = ["Li"]
        ph      = ["q";"bi";"afs";"pl";"opx";"cd";"mu";"amp";"fl";"cpx";"g";"ilm";"mt";"ky";"sill";"hem";"ru"]
        KDs     = ["0.21";"32.8";"0.13";"0.45";"0.2";"0.14";"0.82";"0.2";"0.65";"0.26";"0.083";"0.85";"0.08";"1e-4"; "1e-4";"1e-4"; "1e-4"] 
    elseif model == "MM_st"
        println("Using Matt Morris and Charlie Beard (2024) updated partitioning coefficients for Li - With staurolite")
        el      = ["Li"]
        ph      = ["q";"bi";"afs";"pl";"opx";"cd";"mu";"amp";"fl";"cpx";"g";"ilm";"mt";"ky";"sill";"hem";"ru";"st"]
        # bi_exp  = "y = [:bi].compVariables[3];f = [:bi].compVariables[4]; bi_xSiT = 0.5-f/2.0 - y/2.0;bi_SiT  = (2.0 * bi_xSiT)+2.0; ln_D_Li = (-22.359) + (5.592*bi_SiT) + (10000*0.67*1/(T_C+273.15)); exp(ln_D_Li)"
        bi_exp  = "c9 = -7.01; c10 = -4.29; c11 = 4.18; c12 = 0.407; XMFe3p = [:bi].siteFractions[4]; NaK_Almelt = ([:liq].Comp_apfu[6] + [:liq].Comp_apfu[7]) / [:liq].Comp_apfu[2]; ln_D_Li = c9 + c10*XMFe3p + c11*(NaK_Almelt) + c12*1e4/(T_C+273.15); exp(ln_D_Li)"
        KDs     = ["0.21";bi_exp;"0.13";"0.45";"0.2";"0.14";"0.82";"0.2";"0.65";"0.26";"0.083";"0.85";"0.08";"1e-4"; "1e-4";"1e-4"; "1e-4";"5.46"] 
    elseif model == "HO"
        println("Using Horányi et al., (2025)")
        el      = ["Li"]
        ph      = ["q";    "bi";  "afs"; "pl";  "opx";  "cd"; "mu";  "amp";  "fl"; "cpx";  "g";  "ilm";  "mt";  "ky";  "sill"; "hem"; "ru"; "st"]
        KDs     = ["0.007";"0.46";"0.35";"0.49";"1e-4";"0.29";"0.31";"1e-4";"1e-4";"1e-4";"0.28";"0.002";"1e-4";"1e-4"; "1e-4";"1e-4"; "1e-4";"0.53"] 
        # KDs_database = create_custom_KDs_database(el, ph, KDs)
    else
        error("Model $model is not implemented...")
    end

    return (el, ph, KDs)
end


function get_Kds(; model::String = "MM")
    if model == "KM"
        println("Using Koopmans et al. (2022) partitioning coefficients for Li - no qtz, grt")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "afs"; "pl";"q";"opx";"amp";"cpx";"ilm";"mt";"ky";"sill";"hem";"ru"]  
        KDs     = ["0.82"; "1.67"; "0.44";  "0.01"; "0.02";"1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "KM0"
        println("Using Koopmans et al. (2022) partitioning coefficients for Li - no qtz, grt set to 0.0")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "afs"; "pl";"q";"opx";"amp";"cpx";"ilm";"mt";"ky";"sill";"hem";"ru"]  
        KDs     = ["0.82"; "1.67"; "0.44";  "0.01"; "0.02";"0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"; "0.0"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "KMout"
        println("Using Koopmans et al. (2022) partitioning coefficients for Li - no qtz, grt ignored")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "afs"; "pl"]  
        KDs     = ["0.82"; "1.67"; "0.44";  "0.01"; "0.02"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "BA"
        println("Using Ballouard et al. (2023) partitioning coefficients for Li - no qtz)")
        el      = ["Li"]
        ph      = ["mu"; "bi"; "cd"; "g"; "q";"afs";"pl";"opx";"amp";"cpx";"ilm";"mt";"ky";"sill";"hem";"ru"]  
        KDs     = ["0.11"; "0.55"; "1.10";  "0.09"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"; "1e-4"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "MM"
        println("Using Matt Morris and Charlie Beard (2024) updated partitioning coefficients for Li")
        el      = ["Li"]
        ph      = ["q";"bi";"afs";"pl";"opx";"cd";"mu";"amp";"fl";"cpx";"g";"ilm";"mt";"ky";"sill";"hem";"ru"]
        # bi_exp  = "y = [:bi].compVariables[3];f = [:bi].compVariables[4]; bi_xSiT = 0.5-f/2.0 - y/2.0;bi_SiT  = (2.0 * bi_xSiT)+2.0; ln_D_Li = (-22.359) + (5.592*bi_SiT) + (10000*0.67*1/(T_C+273.15)); exp(ln_D_Li)"
        bi_exp  = "c9 = -7.01; c10 = -4.29; c11 = 4.18; c12 = 0.407; XMFe3p = [:bi].siteFractions[4]; NaK_Almelt = ([:liq].Comp_apfu[6] + [:liq].Comp_apfu[7]) / [:liq].Comp_apfu[2]; ln_D_Li = c9 + c10*XMFe3p + c11*(NaK_Almelt) + c12*1e4/(T_C+273.15); exp(ln_D_Li)"
        KDs     = ["0.21";bi_exp;"0.13";"0.45";"0.2";"0.14";"0.82";"0.2";"0.65";"0.26";"0.083";"0.85";"0.08";"1e-4"; "1e-4";"1e-4"; "1e-4"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "MM_F"
        println("Using Matt Morris and Charlie Beard (2024) updated partitioning coefficients for Li")
        el      = ["Li"]
        ph      = ["q";"bi";"afs";"pl";"opx";"cd";"mu";"amp";"fl";"cpx";"g";"ilm";"mt";"ky";"sill";"hem";"ru"]
        KDs     = ["0.21";"32.8";"0.13";"0.45";"0.2";"0.14";"0.82";"0.2";"0.65";"0.26";"0.083";"0.85";"0.08";"1e-4"; "1e-4";"1e-4"; "1e-4"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "MM_st"
        println("Using Matt Morris and Charlie Beard (2024) updated partitioning coefficients for Li - With staurolite")
        el      = ["Li"]
        ph      = ["q";"bi";"afs";"pl";"opx";"cd";"mu";"amp";"fl";"cpx";"g";"ilm";"mt";"ky";"sill";"hem";"ru";"st"]
        # bi_exp  = "y = [:bi].compVariables[3];f = [:bi].compVariables[4]; bi_xSiT = 0.5-f/2.0 - y/2.0;bi_SiT  = (2.0 * bi_xSiT)+2.0; ln_D_Li = (-22.359) + (5.592*bi_SiT) + (10000*0.67*1/(T_C+273.15)); exp(ln_D_Li)"
        bi_exp  = "c9 = -7.01; c10 = -4.29; c11 = 4.18; c12 = 0.407; XMFe3p = [:bi].siteFractions[4]; NaK_Almelt = ([:liq].Comp_apfu[6] + [:liq].Comp_apfu[7]) / [:liq].Comp_apfu[2]; ln_D_Li = c9 + c10*XMFe3p + c11*(NaK_Almelt) + c12*1e4/(T_C+273.15); exp(ln_D_Li)"
        KDs     = ["0.21";bi_exp;"0.13";"0.45";"0.2";"0.14";"0.82";"0.2";"0.65";"0.26";"0.083";"0.85";"0.08";"1e-4"; "1e-4";"1e-4"; "1e-4";"5.46"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    elseif model == "HO"
        println("Using Horányi et al., (2025)")
        el      = ["Li"]
        ph      = ["q";    "bi";  "afs"; "pl";  "opx";  "cd"; "mu";  "amp";  "fl"; "cpx";  "g";  "ilm";  "mt";  "ky";  "sill"; "hem"; "ru"; "st"]
        KDs     = ["0.007";"0.46";"0.35";"0.49";"1e-4";"0.29";"0.31";"1e-4";"1e-4";"1e-4";"0.28";"0.002";"1e-4";"1e-4"; "1e-4";"1e-4"; "1e-4";"0.53"] 
        KDs_database = create_custom_KDs_database(el, ph, KDs)
    else
        error("Model $model is not implemented...")
    end

    return KDs_database
end

"""
    Function to saturate water + small excess value accross a pressure range

"""
function water_saturation_curve(P       :: Vector{Float64},
                                bulk    :: Vector{Float64},
                                Xoxides :: Vector{String},
                                dtb     :: String,
                                excess  :: Float64 )

    id_H2O      = findfirst(Xoxides .== "H2O")
    bulk_sat    = deepcopy(norm2one(bulk))
    bulk_sat[id_H2O] = 0.6         # this ensures water saturation
    bulk_sat    = norm2one(bulk_sat)


    pChip_wat, pChip_T = get_wat_sat_function(  [P[1],P[end]],
                                                bulk_sat,
                                                Xoxides,
                                                dtb,
                                                excess );
    return pChip_wat, pChip_T 
end

function get_wat_sat_function(  Yrange,
                                bulk_ini,
                                oxi,
                                dtb,
                                watsat_val )
   
    id_h2o      = findfirst(oxi .== "H2O")
    watsat_val  = watsat_val
                          
    println("Computing water-saturation at sub-solidus. Make sure you provided enough water to oversaturate below solidus.")
    stp     = (Yrange[2] - Yrange[1])/63.0                        
    Prange  = Vector(Yrange[1]:stp:Yrange[2])


    # initialize single thread MAGEMin 
    gv, z_b, DB, splx_data = init_MAGEMin(  dtb;        
                                            verbose     = -1,
                                            solver      = 0    );

    sys_in      = "mol"
    gv          =  define_bulk_rock(gv, bulk_ini, oxi, sys_in, dtb);

    Tmin        = 500.0;
    Tliq        = 2200.0;
    tolerance   = 1e-4;      

    Tsol        = zeros(Float64,length(Prange))
    SatSol      = zeros(Float64,length(Prange))

    @showprogress 1 "Computing sub-solidus water-saturating curve..." for i = 1:length(Prange)

        pressure    = Prange[i]
        out         = deepcopy( point_wise_minimization(pressure, Tliq, gv, z_b, DB, splx_data, sys_in; name_solvus=true) )
        n_max       = 64
        a           = Tmin
        b           = Tliq
        n           = 1
        conv        = 0
        n           = 0
        sign_a      = -1

        while n < n_max && conv == 0
            c       = (a+b)/2.0
            out     = deepcopy( point_wise_minimization(pressure, c, gv, z_b, DB, splx_data, sys_in; name_solvus=true) )

            if "liq" in out.ph
                result = 1;
            else
                result = -1;
            end

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

        if n == n_max
            println("Warning: solidus not converged at P = $pressure GPa")
        end

        Tsol[i]     = (a+b)/2.0 + 0.01   # add small value to ensure we are above solidus
        out         = deepcopy( point_wise_minimization(pressure,(a+b)/2.0 + 0.01 , gv, z_b, DB, splx_data, sys_in; name_solvus=true) )

        id_dry      = findall(out.oxides .!= "H2O")
        id_h2o      = findfirst(out.oxides .== "H2O")

        tmp_bulk    = deepcopy(out.bulk)

        # extracting excess water
        if "H2O" in out.ph
            id = findfirst(out.ph .== "H2O")
            tmp_bulk .-= out.PP_vec[id - out.n_SS].Comp .* out.ph_frac[id]
        elseif "fl" in out.ph
            id = findfirst(out.ph .== "fl")
            tmp_bulk .-= out.SS_vec[id].Comp .* out.ph_frac[id]
        end            

        tmp_bulk ./= sum(tmp_bulk)              # normalize to 100%

        if watsat_val > 0.0
            tmp_bulk[id_h2o] += watsat_val/(1.0 - watsat_val)
            tmp_bulk ./= sum(tmp_bulk) 
        end

        tmp_bulk ./= sum(tmp_bulk[id_dry])      # normalize on anhydrous basis, to get water content
        
        SatSol[i]  = tmp_bulk[id_h2o]
    end
    pChip_wat   = Interpolator(Prange, SatSol)
    pChip_T     = Interpolator(Prange, Tsol)
    LibMAGEMin.FreeDatabases(gv, DB, z_b)


    return pChip_wat, pChip_T
end


function retrieve_concentration(np          :: Int64,
                                out_XY      :: Vector{MAGEMin_C.gmin_struct{Float64, Int64}},
                                out_TE_XY   :: Union{Nothing,Vector{MAGEMin_C.out_tepm}};
                                arg         :: String = "Cliq")

    C = zeros(np);
    for i=1:np

        if arg == "Cliq"
            if isnothing(out_TE_XY[i].Cliq)
                C[i] = 0.0
            else
                C[i] = out_TE_XY[i].Cliq[1]
            end
        elseif arg == "Csol"
            if isnothing(out_TE_XY[i].Csol)
                C[i] = 0.0
            else
                C[i] = out_TE_XY[i].Csol[1]
            end
        elseif arg == "liq_wt"
            id = findfirst(out_XY[i].ph .== "liq")
            if isnothing(id)
                C[i] = 0.0
            else
                C[i] = out_XY[i].ph_frac_wt[id]
            end
        elseif arg == "liq_wt_norm"
            if isnothing(out_TE_XY[i].liq_wt_norm)
                C[i] = 0.0
            else
                C[i] = out_TE_XY[i].liq_wt_norm
            end
        elseif arg == "C0"
            if isnothing(out_TE_XY[i].C0)
                C[i] = 0.0
            else
                C[i] = out_TE_XY[i].C0[1]
            end
        end
    end

    return C
end


function perform_threaded_calc( 
                                pChip_wat   :: Interpolator{Vector{Float64}, Vector{Float64}, Vector{Float64}}, 
                                Out_all     :: Array{Li_infos},
                                Out_all_FC  :: Array{Li_infos},
                                data        :: MAGEMin_Data,
                                dtb         :: String,
                                P           :: Vector{Float64},
                                T           :: Vector{Float64},
                                H           :: Vector{Float64},
                                np          :: Int64,
                                e1_liq      :: Float64, 
                                e1_remain   :: Float64, 
                                sys_in      :: String,
                                bulk        :: Vector{Float64},
                                Xoxides     :: Vector{String},
                                KDs_database;
                                n_ee        :: Int64   = 10,
                                Li_content  :: Float64 = 100.0,
                                FC          :: Bool    = true,
                                Ws          :: Union{Vector{MAGEMin_C.W_data{Float64, Int64}},Nothing} = nothing,
                                norm_TE     :: Bool    = true)
    nt = np*np
    progr = Progress(nt, desc="Computing $nt FM calculations...") # progress meter
    @threads :static for k=1:nt
        i, j            = get_coordinates(k, np)
        data_thread     = get_data_thread(data)
        
        bulk_           = bulk
        P_              = P[i]
        H_              = H[j]
        H_sat_          = pChip_wat(P_)

        if H_ < H_sat_ + 0.03 && H_ > H_sat_ - 0.03  && H_ > 0.0
            Out_all[i,j] = threaded_frac_melting(    data_thread, dtb,
                                                        P_,
                                                        H_,
                                                        T,
                                                        e1_liq,
                                                        e1_remain,
                                                        sys_in,
                                                        bulk_,
                                                        Xoxides,
                                                        KDs_database;
                                                        n_ee        = n_ee,
                                                        Li_content  = Li_content,
                                                        Ws          = Ws,
                                                        norm_TE     = norm_TE  );
        else
            Out_all[i,j] = Li_infos(nothing, nothing)
        end
        next!(progr)

    end
    finish!(progr)

    return Out_all, Out_all_FC
end



function perform_threaded_calc_EE( 
                                Out_all     :: Array{Li_infos},
                                data        :: MAGEMin_Data,
                                dtb         :: String,
                                P           :: Vector{Float64},
                                T           :: Vector{Float64},
                                np          :: Int64,

                                model       :: String,

                                e1_liq      :: Float64, 
                                e1_remain   :: Float64, 
                                sys_in      :: String,
                                bulk        :: Vector{Float64},
                                Xoxides     :: Vector{String};
                                n_ee        :: Int64   = 10,
                                Ex_H2O_sat  :: Float64 = 0.0,
                                Li_content  :: Float64 = 100.0,
                                Ws          :: Union{Vector{MAGEMin_C.W_data{Float64, Int64}},Nothing} = nothing,
                                norm_TE     :: Bool    = true)

    (el, ph, KDs)   = get_Kds_data(; model = model)
    progr           = Progress(np, desc="Computing $np FM calculations...") # progress meter
    @threads :static for i=1:np

        data_thread     = get_data_thread(data)
        bulk_           = bulk
        P_              = P[i]
        H_              = water_saturation_curve_FS(    data_thread,
                                                        P_,
                                                        bulk_,
                                                        Xoxides,
                                                        dtb,
                                                        Ex_H2O_sat );


        KDs_database    = create_custom_KDs_database(el, ph, KDs)
        Out_all[i]    = threaded_frac_melting(    data_thread, dtb,
                                                    P_,
                                                    H_,
                                                    T,
                                                    e1_liq,
                                                    e1_remain,
                                                    sys_in,
                                                    bulk_,
                                                    Xoxides,
                                                    KDs_database;
                                                    n_ee        = n_ee,
                                                    Li_content  = Li_content,
                                                    Ws          = Ws,
                                                    norm_TE     = norm_TE  );

        next!(progr)

    end
    finish!(progr)

    return Out_all

end



function perform_threaded_calc_sensitivity( 
                                Out_all     :: Array{Li_infos},
                                data        :: MAGEMin_Data,
                                dtb         :: String,
                                P           :: Vector{Float64},
                                T           :: Vector{Float64},
                                np          :: Int64,

                                ph_list     :: Vector{String},
                                model       :: String,
                                off_diag    :: Int64,

                                e1_liq      :: Float64, 
                                e1_remain   :: Float64, 
                                sys_in      :: String,
                                bulk        :: Vector{Float64},
                                Xoxides     :: Vector{String};
                                n_ee        :: Int64   = 10,
                                Ex_H2O_sat  :: Float64 = 0.0,
                                Li_content  :: Float64 = 100.0,
                                Ws          :: Union{Vector{MAGEMin_C.W_data{Float64, Int64}},Nothing} = nothing,
                                norm_TE     :: Bool    = true)

    KDs_eps         = ["-1e-3"; "+0.0"; "+1e-3"]     # perturbation values for sensitivity analysis
    (el, ph, KDs)   = get_Kds_data(; model = model)
    nss             = length(ph_list)
    progr           = Progress(np, desc="Computing $np FM calculations...") # progress meter
    @threads :static for i=1:np

        data_thread     = get_data_thread(data)
        bulk_           = bulk
        P_              = P[i]
        H_              = water_saturation_curve_FS(    data_thread,
                                                        P_,
                                                        bulk_,
                                                        Xoxides,
                                                        dtb,
                                                        Ex_H2O_sat );

        for k=1:nss
            KDs_up          = copy(KDs)
            id_ph           = findfirst(ph .== ph_list[k])

            for l = 1:3
                perturbation = KDs_eps[l]
                KDs_up[id_ph] = (KDs[id_ph] * perturbation)

                j = 3*(k-1) + l
                KDs_database    = create_custom_KDs_database(el, ph, KDs_up)
                Out_all[i,j]    = threaded_frac_melting(    data_thread, dtb,
                                                            P_,
                                                            H_,
                                                            T,
                                                            e1_liq,
                                                            e1_remain,
                                                            sys_in,
                                                            bulk_,
                                                            Xoxides,
                                                            KDs_database;
                                                            n_ee        = n_ee,
                                                            Li_content  = Li_content,
                                                            Ws          = Ws,
                                                            norm_TE     = norm_TE  );
            end
        end
        
        k = 1
        for l=1:nss
            for j=l+1:nss

                KDs_up          = copy(KDs)
                id_ph_l         = findfirst(ph .== ph_list[l])
                id_ph_j         = findfirst(ph .== ph_list[j])

                # println("$(ph[id_ph_l]) and $(ph[id_ph_j])")

                perturbation    = KDs_eps[3]
                KDs_up[id_ph_l] = (KDs[id_ph_l] * perturbation)
                KDs_up[id_ph_j] = (KDs[id_ph_j] * perturbation)

                # println("KDs_up: $(KDs_up)")

                KDs_database        = create_custom_KDs_database(el, ph, KDs_up)
                Out_all[i,nss*3+k]  = threaded_frac_melting(    data_thread, dtb,
                                                                P_,
                                                                H_,
                                                                T,
                                                                e1_liq,
                                                                e1_remain,
                                                                sys_in,
                                                                bulk_,
                                                                Xoxides,
                                                                KDs_database;
                                                                n_ee        = n_ee,
                                                                Li_content  = Li_content,
                                                                Ws          = Ws,
                                                                norm_TE     = norm_TE  );

                k += 1
            end
        end

        next!(progr)

    end
    finish!(progr)

    return Out_all

end



"""
    Function to retrieve the solidus temperature for a given pressure
    using a bisection method. The function will return the temperature
    at which the solidus is reached.
"""
function retrieve_solidus(P, gv, z_b, DB, splx_data)
    n_max       = 64
    tolerance   = 0.0001

    a           = 600.0
    b           = 1200.0
    conv        = 0
    n           = 0
    sign_a      = -1

    while n < n_max && conv == 0
        c       = (a+b)/2.0
        out = deepcopy(point_wise_minimization(P, c, gv, z_b, DB, splx_data))

        if "liq" in out.ph
            result = 1;
        else
            result = -1;
        end

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

    return b
end


function load_Forshaw_mp(; filename = "./Forshaw_bulk_db/G50542_SuppData.xlsx")
    sheet_name = "Database Catalogue"
    XLSX.openxlsx(filename) do xf
        if sheet_name in XLSX.sheetnames(xf)
            sheet   = xf[sheet_name]
            data    = XLSX.readtable(filename, sheet_name; first_row=3) |> DataFrame

            return data
        else
            error("Sheet 'KDs' not found in $filename.")
            return nothing
        end
    end
end
