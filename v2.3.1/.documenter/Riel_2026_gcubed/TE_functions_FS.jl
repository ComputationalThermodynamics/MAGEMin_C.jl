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
    water_saturation_curve_FS(data_thread, P::Float64, bulk::Vector{Float64},
                               Xoxides::Vector{String}, dtb::String, excess::Float64) -> Float64

Compute the water content at the solidus for a single pressure point using thread-local MAGEMin data.

Sets bulk H₂O to 40 mol% to guarantee saturation, then calls `get_wat_sat_function_FS` to
determine the exact saturation content and adds `excess` on top.

# Returns
- H₂O molar fraction at saturation + excess for pressure `P`
"""
function water_saturation_curve_FS( data_thread,
                                    P       :: Float64,
                                    bulk    :: Vector{Float64},
                                    Xoxides :: Vector{String},
                                    dtb     :: String,
                                    excess  :: Float64 )

    id_H2O      = findfirst(Xoxides .== "H2O")
    bulk_sat    = deepcopy(norm2one(bulk))
    bulk_sat[id_H2O] = 0.4         # this ensures water saturation
    bulk_sat    = norm2one(bulk_sat)


    H = get_wat_sat_function_FS(    data_thread,
                                    P,
                                    bulk_sat,
                                    Xoxides,
                                    dtb,
                                    excess );
    return H 
end

"""
    get_wat_sat_function_FS(data_thread, P, bulk_ini, oxi, dtb, watsat_val) -> Float64

Find the water-saturating H₂O content at the solidus for a single pressure point.

Uses thread-local MAGEMin data and a bisection algorithm (32 iterations, 0.01°C tolerance) to
locate the solidus. Removes any free-fluid phase from the bulk, normalizes, then adds
`watsat_val` above saturation. Issues a warning if the result is negative.

# Arguments
- `data_thread`: Tuple `(gv, z_b, DB, splx_data)` of thread-local MAGEMin data
- `P`: Pressure [kbar]
- `bulk_ini`: Bulk composition with H₂O set high enough to guarantee saturation
- `oxi`: Oxide labels
- `dtb`: MAGEMin database identifier
- `watsat_val`: Excess H₂O fraction to add above saturation [mol fraction]

# Returns
- H₂O content [mol fraction] on an anhydrous-normalized basis at the solidus + excess
"""
function get_wat_sat_function_FS(   data_thread,
                                    P,
                                    bulk_ini,
                                    oxi,
                                    dtb,
                                    watsat_val )
   
    id_h2o      = findfirst(oxi .== "H2O")

    (gv, z_b, DB, splx_data) = data_thread

    sys_in      = "mol"
    gv          =  define_bulk_rock(gv, bulk_ini, oxi, sys_in, dtb);

    Tmin        = 500.0;
    Tliq        = 2200.0;
    tolerance   = 0.01;      

    Tsol        = 0.0

    pressure    = P
    out         = deepcopy( point_wise_minimization(pressure, Tliq, gv, z_b, DB, splx_data, sys_in; name_solvus=true) )
    n_max       = 32
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

    Tsol        = b
    out         = deepcopy( point_wise_minimization(pressure, b , gv, z_b, DB, splx_data, sys_in; name_solvus=true) )

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


    tmp_bulk[id_h2o] += watsat_val/(1.0 - watsat_val)
    if tmp_bulk[id_h2o] < 0.0
        @warn "Water content at P=$P is negative, setting it to 0.1 mol%."
        tmp_bulk[id_h2o] = 0.001
    end
    tmp_bulk ./= sum(tmp_bulk) 

    tmp_bulk ./= sum(tmp_bulk[id_dry])      # normalize on anhydrous basis, to get water content
    
    H = tmp_bulk[id_h2o]

    return H
end


"""
    perform_threaded_calc_FS(Out_all, Out_all_FC, data, dtb, P, T, np, e1_liq, e1_remain,
                              sys_in, FS_bulks, Xoxides, KDs_database; ...) -> (Out_all, Out_all_FC, FS_bulks)

Run threaded fractional melting for a suite of bulk rock compositions at a single pressure.

For each composition (row of `FS_bulks`), computes the water-saturating H₂O content via
`water_saturation_curve_FS`, calls `threaded_frac_melting`, and stores the computed H₂O
back into the H₂O column of `FS_bulks`.

# Keyword Arguments
- `n_ee`: Number of extraction events (default 10)
- `Li_content`: Initial bulk Li [µg/g] (default 100.0)
- `FC`: Fractional crystallization flag (not filled, default true)
- `Ex_H2O_sat`: Excess H₂O above saturation [mol fraction] (default 0.0)
- `Ws`: Optional custom biotite W parameters
- `norm_TE`: Normalize trace element concentrations (default true)
- `solidus_calc`: Reserved flag (default false)

# Returns
- `(Out_all, Out_all_FC, FS_bulks)` with updated H₂O column in `FS_bulks`
"""
function perform_threaded_calc_FS(
                                Out_all     :: Array{Li_infos},
                                Out_all_FC  :: Array{Li_infos},
                                data        :: MAGEMin_Data,
                                dtb         :: String,
                                P           :: Float64,
                                T           :: Vector{Float64},
                                np          :: Int64, 
                                e1_liq      :: Float64, 
                                e1_remain   :: Float64, 
                                sys_in      :: String,
                                FS_bulks    :: Matrix{Float64},
                                Xoxides     :: Vector{String},
                                KDs_database;
                                n_ee        :: Int64   = 10,
                                Li_content  :: Float64 = 100.0,
                                FC          :: Bool    = true,
                                Ex_H2O_sat  :: Float64 = 0.0,
                                Ws          :: Union{Vector{MAGEMin_C.W_data{Float64, Int64}},Nothing} = nothing,
                                norm_TE     :: Bool    = true,
                                solidus_calc:: Bool    = false)

    progr = Progress(np, desc="Computing $np FM calculations...") # progress meter
    @threads :static for i=1:np

        data_thread     = get_data_thread(data)
        
        bulk_           = FS_bulks[i,:]
        P_              = P
        H_              = water_saturation_curve_FS(    data_thread,
                                                        P_,
                                                        bulk_,
                                                        Xoxides,
                                                        dtb,
                                                        Ex_H2O_sat );

        if H_ < 0.0
            @warn "Water content is negative, setting to zero."
            H_ = 0.0
        end

        Out_all[i] = threaded_frac_melting(         data_thread, dtb,
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
                                                    norm_TE     = norm_TE );


        id_h                = findfirst(Xoxides .== "H2O")
        FS_bulks[i,id_h]    = H_ #here we save water content in the bulk

        next!(progr)

    end
    finish!(progr)

    return Out_all, Out_all_FC, FS_bulks
end


"""
    get_mol_bulks(data::DataFrame) -> Matrix{Float64}

Convert a Forshaw & Pattison (2023) database DataFrame from oxide wt% to normalized molar fractions.

Extracts 11 oxides (SiO2, Al2O3, CaO, MgO, FeO, K2O, Na2O, TiO2, O, MnO, H2O), converts
each row from wt% to mol% via `wt2mol`, and normalizes to sum to 1 with `norm2one`.
Missing oxide columns are filled with zeros and a warning is issued.

# Returns
- Matrix of size `(nb, 11)` with normalized molar fractions for each sample
"""
function get_mol_bulks( data )
    Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
    nox         = length(Xoxides)

    nb          = size(data, 1)
    FS_bulks    = Matrix{Float64}(undef, nb, nox)

    for i=1:nox
        if Xoxides[i] in names(data)
            FS_bulks[:, i] = data[!, Xoxides[i]]
        else
            @warn "Column $(Xoxides[i]) not found in data. Filling with zeros."
            FS_bulks[:, i] = zeros(nb)
        end
    end

    # Convert to mol and normalize
    for i=1:nb
        FS_bulks[i, :] = wt2mol(FS_bulks[i, :], Xoxides)
        FS_bulks[i, :] = norm2one(FS_bulks[i, :])  
    end

    return FS_bulks
end