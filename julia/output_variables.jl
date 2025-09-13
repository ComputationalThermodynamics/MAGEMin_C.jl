# This file contains functions to extract variables from the output of MAGEMin.
# Each function corresponds to a specific mineral phase and extracts the desired variables.
# Written by T. Mackay-Champion, University of Oxford, 2025

# Garnet: XAlm, Xgrs, Xsps, Xprp, vol%, cations apfu (12 oxygens)
function f_g(out)
    index = find_phase_index(out, ["g"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Endmembers
        endMembers = out.SS_vec[index].emNames;
        py = findfirst(isequal("py"), endMembers); py = out.SS_vec[index].emFrac[py]
        alm = findfirst(isequal("alm"), endMembers); alm = out.SS_vec[index].emFrac[alm]
        gr = findfirst(isequal("gr"), endMembers); gr = out.SS_vec[index].emFrac[gr]
        kho = findfirst(isequal("kho"), endMembers); kho = out.SS_vec[index].emFrac[kho]
        pyT = py + kho;
        # Mn
        spss_index = findfirst(isequal("spss"), endMembers)
        if spss_index !== nothing
            spss = out.SS_vec[index].emFrac[spss_index]
        end
        # Collate endmembers
        endmembers = (Xalm = alm, Xgrs = gr, Xprp = pyT, vol = vol)
        if spss !== nothing
            endmembers = merge(endmembers, (Xsps = spss,))
        end

        # Cations apfu
        oxygens = 12
        cations = cations_apfu(out, index, oxygens)
        
    else # If no garnet, return zeros
        alm = 0; gr = 0; spss = 0; pyT = 0; vol = 0
        endmembers = (Xalm = alm, Xgrs = gr, Xprp = pyT, Xsps = spss, vol = vol)
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    result = merge(endmembers, cations)
    return result
end

# Staurolite: XMg, vol%, cations apfu (48 oxygens)
function f_st(out)
    index = find_phase_index(out, ["st"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 48
        cations = cations_apfu(out, index, oxygens)

        # XMg
        XMg = cations.Mg/(cations.Mg + cations.Fe2)

    else # If no staurolite, return zeros
        XMg = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (XMg = XMg, vol = vol, cations...);
    return results
end

# Cordierite: XMg, vol%, cations apfu (18 oxygens)
function f_crd(out)
    index = find_phase_index(out, ["crd"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 18
        cations = cations_apfu(out, index, oxygens)

        # XMg
        XMg = cations.Mg/(cations.Mg +cations.Fe2)

    else # If no cordierite, return zeros
        XMg = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (XMg = XMg, vol = vol, cations...);
    return results
end

# Chlorite: XMg, vol%, cations apfu (14 oxygens)
function f_chl(out)
    index = find_phase_index(out, ["chl"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 14
        cations = cations_apfu(out, index, oxygens)

        # XMg
        XMg = cations.Mg/(cations.Mg +cations.Fe2)

    else
        XMg = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (XMg = XMg, vol = vol, cations...);
    return results
end

# Biotite: XMg, vol%, cations apfu (11 oxygens)
function f_bi(out)
    index = find_phase_index(out, ["bi"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 11
        cations = cations_apfu(out, index, oxygens)
        
        # Compute XMg
        XMg = cations.Mg/(cations.Mg + cations.Fe2)

    else # If no biotite, return zeros
        XMg = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (XMg = XMg, vol = vol, cations...);
    return results
end

# Muscovite: XCel, XPa, vol%, cations apfu (11 oxygens)
function f_mu(out)
    index = find_phase_index(out, ["mu"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 11
        cations = cations_apfu(out, index, oxygens)
        
        # Compute Xpa, Xcel
        endMembers = phaseInfo.emNames; 
        pa = cations.Na./(cations.Na + cations.Ca +cations.K) 
        cel = findfirst(isequal("cel"), endMembers); cel = phaseInfo.emFrac[cel]

    else # If no muscovite, return zeros
        cel = 0; pa = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (Xcel = cel, Xpa = pa, vol = vol, cations...);
    return results

end

# Plagioclase feldspar: Xan, vol%, cations apfu (8 oxygens)
function f_plag(out)
    indices = findall(x -> occursin("fsp", x), out.ph)

    # If multiple feldspars, choose the one with an > san and highest vol%
    if !isempty(indices)
        ind = Int[]       # to store indices where an > san
        vols = Float64[]  # to store corresponding volumes
        an_values = Float64[]   # to store anorthite values

        for index in indices
            endMembers = out.SS_vec[index].emNames
            vol = out.ph_frac_vol[index]

            # Get an and san fractions (set to 0 if not found)
            an_idx = findfirst(isequal("an"), endMembers)
            san_idx = findfirst(isequal("san"), endMembers)
            an = an_idx !== nothing ? out.SS_vec[index].emFrac[an_idx] : 0.0
            san = san_idx !== nothing ? out.SS_vec[index].emFrac[san_idx] : 0.0

            if an > san
                push!(ind, index)
                push!(vols, vol)
                push!(an_values, an)
            end
        end

        # Get index of phase with maximum volume (if any were stored)
        if !isempty(vols)
            max_vol_index = argmax(vols)
            index = ind[max_vol_index]
            an = an_values[max_vol_index]
        else
            index = nothing
        end
    end

    # Get data
    if index !== nothing

        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 8
        cations = cations_apfu(out, index, oxygens)

    else # If no feldspar, return zeros
        an = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end
    
    # Merge
    results = (Xan = an, vol = vol, cations...);
    return results
end

# K-feldspar: Xsan, vol%, cations apfu (8 oxygens)
function f_kfs(out)
    indices = findall(x -> occursin("fsp", x), out.ph)

    # If multiple feldspars, choose the one with an > san and highest vol%
    if !isempty(indices)
        ind = Int[]       # to store indices where an > san
        vols = Float64[]  # to store corresponding volumes
        san_values = Float64[]   # to store anorthite values

        for index in indices
            endMembers = out.SS_vec[index].emNames
            vol = out.ph_frac_vol[index]

            # Get an and san fractions (set to 0 if not found)
            an_idx = findfirst(isequal("an"), endMembers)
            san_idx = findfirst(isequal("san"), endMembers)
            an = an_idx !== nothing ? out.SS_vec[index].emFrac[an_idx] : 0.0
            san = san_idx !== nothing ? out.SS_vec[index].emFrac[san_idx] : 0.0

            if san > an
                push!(ind, index)
                push!(vols, vol)
                push!(san_values, san)
            end
        end

        # Get index of phase with maximum volume (if any were stored)
        if !isempty(vols)
            max_vol_index = argmax(vols)
            index = ind[max_vol_index]
            san = san_values[max_vol_index]
        else
            index = nothing
        end
    end

    # Get data
    if index !== nothing

        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 8
        cations = cations_apfu(out, index, oxygens)

    else # If no feldspar, return zeros
        san = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end
    
    # Merge
    results = (Xsan = san, vol = vol, cations...);
    return results
end

# Epidote: XFe, vol%, cations apfu (12.5 oxygens, after removing H2O)
function f_ep(out)
    index = find_phase_index(out, ["ep"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Calculate XFe
        var_names = out.SS_vec[index].siteFractionsNames
        var_values = out.SS_vec[index].siteFractions
        vars = (; (Symbol(name) => value for (name, value) in zip(var_names, var_values))...)
        xFeM1 = vars.xFeM1; xAlM1 = vars.xAlM1
        xFeM3 = vars.xFeM3; xAlM3 = vars.xAlM3        
        Fe_total = xFeM1 + xFeM3; Al_total = xAlM1 + xAlM3
        XFe = Fe_total / (Fe_total + Al_total)

        # Cations apfu
        oxygens = 12.5
        phaseInfo = out.SS_vec[index]
        oxides = out.oxides;
        comp = phaseInfo.Comp;
        cations, oxygen_total = molesCation_noH2O(oxides,comp) # Remove H2O impact
        normalization_factor = oxygens / oxygen_total
        cations = (; (k => v * normalization_factor for (k, v) in pairs(cations))...)

    else # If no epidote, return zeros
        XFe = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (XFe = XFe, vol = vol, cations...);
    return results
end

# Amphibole: Ts, Ed, Gln, vol%, cations apfu (22 oxygens)
function f_amph(out)
    index = find_phase_index(out, ["amp"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Site fractions + vectors
        var_names = out.SS_vec[index].siteFractionsNames
        var_values = out.SS_vec[index].siteFractions
        vars = (; (Symbol(name) => value for (name, value) in zip(var_names, var_values))...)
        xAlT1 = vars.xAlT1
        xNaA = vars.xNaA
        xKA = vars.xKA
        xNaM4 = vars.xNaM4
        Ts = xAlT1 - xNaA - xKA
        Ed = xNaA + xKA
        Gln = xNaM4

        # Cations apfu
        oxygens = 22
        cations = cations_apfu(out, index, oxygens)

    else # If no amphibole, return zeros
        Ts = 0; Ed = 0; Gln = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (Ts = Ts, Ed = Ed, Gln = Gln, vol = vol, cations...);
    return results
end

# CPX: XMg, Xjd, vol%, cations apfu (6 oxygens)
function f_cpx(out)
    index = find_phase_index(out, ["aug", "cpx", "diop"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Site fractions + vectors
        var_names = out.SS_vec[index].siteFractionsNames
        var_values = out.SS_vec[index].siteFractions
        vars = (; (Symbol(name) => value for (name, value) in zip(var_names, var_values))...)
        Mg = vars.xMgM1 + vars.xMgM2
        Fe2 = vars.xFeM1 + vars.xFeM2
        xCaM2 = vars.xCaM2
        xNaM2 = vars.xNaM2
        xAlM1 = vars.xAlM1

        # Calculate XMg and Xjd
        XMg = Mg / (Mg + Fe2)
        Xjd = xAlM1 / (xNaM2 + xCaM2)

        # Cations apfu
        oxygens = 6
        cations = cations_apfu(out, index, oxygens)

    else # If no clinopyroxene, return zeros
        XMg = 0; Xjd = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (XMg = XMg, Xjd = Xjd, vol = vol, cations...);
    return results
end

# OPX: XX
# f_opx

# Olivine: Xfa, vol%, cations apfu (4 oxygens)
function f_ol(out)
    index = find_phase_index(out, ["ol"])

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # Cations apfu
        oxygens = 4
        cations = cations_apfu(out, index, oxygens)

        # Endmembers
        endMembers = out.SS_vec[index].emNames;
        fa = findfirst(isequal("fa"), endMembers); fa = out.SS_vec[index].emFrac[fa]

    else # If no olivine, return zeros
        fa = 0; vol = 0;
        oxides = out.oxides; comp = zeros(length(oxides))
        cations, _ = molesCation(oxides,comp)

    end

    # Merge
    results = (Xfa = fa, vol = vol, cations...);
    return results
end

# Melt: vol%, oxides in wt% (normalized to anhydrous)
function f_melt(out)
    index = find_phase_index(out, ["melt","liq"])
    oxides = out.oxides;

    if index !== nothing
        # Vol
        vol = out.ph_frac_vol[index]

        # wt% of oxides
        comp = out.SS_vec[index].Comp_wt
        oxide_wt = vector_to_tuple(oxides, comp)

        # Remove H2O and normalize to total anhydrous
        total_anhydrous = sum(values(oxide_wt)) - get(oxide_wt, :H2O, 0.0)

        # Create a named tuple with normalized wt% for each oxide
        oxide_wt_percent = (
            (; (Symbol(oxide) => get(oxide_wt, Symbol(oxide), 0.0) / total_anhydrous * 100 for oxide in oxides)...,
            vol = out.ph_frac_vol[index])
        )

    else # If no melt, return zeros
        vol = 0;
        comp = zeros(length(oxides))
        oxide_wt_percent = vector_to_tuple(oxides, comp)
        oxide_wt_percent = merge(oxide_wt_percent, (vol = vol,))
    end


    return oxide_wt_percent
end

# Kyanite: vol%
function f_ky(out)
    id = find_phase_index(out, ["ky"])
    vol = 0
    if id !== nothing
        vol = out.ph_frac_vol[id]
    end
    return (
    vol = vol,
    )
end

# Sillimanite: vol%
function f_sill(out)
    id = find_phase_index(out, ["sill"])
    vol = 0
    if id !== nothing
        vol = out.ph_frac_vol[id]
    end
    return (
    vol = vol,
    )
end

# Andalusite: vol%
function f_and(out)
    id = find_phase_index(out, ["and"])
    vol = 0
    if id !== nothing
        vol = out.ph_frac_vol[id]
    end
    return (
    vol = vol,
    )
end

# Quartz: vol%
function f_q(out)
    id = find_phase_index(out, ["q"])
    vol = 0
    if id !== nothing
        vol = out.ph_frac_vol[id]
    end
    return (
    vol = vol,
    )
end

# Converts list of oxides and mol% into a tuple
function vector_to_tuple(oxides, values)
    return (; (Symbol(oxides[i]) => values[i] for i in eachindex(oxides))...)
end

# Finds cations per formula unit, normalized to given number of oxygens
function cations_apfu(out, index, oxygens)
    phaseInfo = out.SS_vec[index]
    oxides = out.oxides;
    comp = phaseInfo.Comp;
    cations, oxygen_total = molesCation(oxides,comp)
    normalization_factor = oxygens / oxygen_total
    cations = (; (k => v * normalization_factor for (k, v) in pairs(cations))...)
    return cations
end

# Converts mol% in oxides to cation apfu, including H2O
function molesCation(oxides,comp)
    oxide_mol = vector_to_tuple(oxides, comp)

    # Use get to safely access named tuple fields, falling back to 0.0
    get_nt(nt, field) = hasproperty(nt, field) ? getfield(nt, field) : 0.0

    # Cation moles
    FeO = get_nt(oxide_mol, :FeO) - 2 * get_nt(oxide_mol, :O)
    Fe2O3 = get_nt(oxide_mol, :O)
    moles_cation = (
        Si  = get_nt(oxide_mol, :SiO2),
        Ti  = get_nt(oxide_mol, :TiO2),
        Al  = 2 * get_nt(oxide_mol, :Al2O3),
        Mn  = get_nt(oxide_mol, :MnO),
        Fe2 = FeO,
        Fe3 = 2 * Fe2O3,
        Mg  = get_nt(oxide_mol, :MgO),
        Ca  = get_nt(oxide_mol, :CaO),
        Na  = 2 * get_nt(oxide_mol, :Na2O),
        K   = 2 * get_nt(oxide_mol, :K2O),
        H   = 2 * get_nt(oxide_mol, :H2O)
    )
    # Oxygen moles
    oxygens = moles_cation.Si * 2 + moles_cation.Ti * 2 + moles_cation.Al * 3/2 + moles_cation.Mn +
            moles_cation.Fe2 + moles_cation.Fe3 * 3/2 + moles_cation.Mg + moles_cation.Ca +
            moles_cation.Na / 2 + moles_cation.K / 2 + moles_cation.H / 2
    return moles_cation, oxygens
end

# Converts mol% in oxides to cation apfu, exluding H2O
function molesCation_noH2O(oxides,comp)
    oxide_mol = vector_to_tuple(oxides, comp)
    oxide_mol = sum(values(oxide_wt)) - get(oxide_wt, :H2O, 0.0) # Make anhydrous

    # Use get to safely access named tuple fields, falling back to 0.0
    get_nt(nt, field) = hasproperty(nt, field) ? getfield(nt, field) : 0.0

    # Cation moles
    FeO = get_nt(oxide_mol, :FeO) - 2 * get_nt(oxide_mol, :O)
    Fe2O3 = get_nt(oxide_mol, :O)
    moles_cation = (
        Si  = get_nt(oxide_mol, :SiO2),
        Ti  = get_nt(oxide_mol, :TiO2),
        Al  = 2 * get_nt(oxide_mol, :Al2O3),
        Mn  = get_nt(oxide_mol, :MnO),
        Fe2 = FeO,
        Fe3 = 2 * Fe2O3,
        Mg  = get_nt(oxide_mol, :MgO),
        Ca  = get_nt(oxide_mol, :CaO),
        Na  = 2 * get_nt(oxide_mol, :Na2O),
        K   = 2 * get_nt(oxide_mol, :K2O),
        H   = 2 * get_nt(oxide_mol, :H2O)
    )
    # Oxygen moles
    oxygens = moles_cation.Si * 2 + moles_cation.Ti * 2 + moles_cation.Al * 3/2 + moles_cation.Mn +
            moles_cation.Fe2 + moles_cation.Fe3 * 3/2 + moles_cation.Mg + moles_cation.Ca +
            moles_cation.Na / 2 + moles_cation.K / 2 + moles_cation.H / 2
    return moles_cation, oxygens
end 

# Function finds the index of the phase in out.ph. If the phase is not present, it returns nothing.
# If there are two phases with the same name (e.g., two melt phases), it returns the index of the most abundant phase.
function find_phase_index(out, phase_names)
    indices = findall(x -> x in phase_names, out.ph)
    if isempty(indices)
        return nothing
    else
        # Return the index of the most abundant phase
        vol_fracs = out.ph_frac_vol[indices]
        max_index = indices[argmax(vol_fracs)]
        return max_index
    end
end

# Phase dictionary: points towards function for each phase
phase_table = Dict(
    :g => f_g,
    :st => f_st,
    :crd => f_crd,
    :chl => f_chl,
    :bi => f_bi,
    :mu => f_mu,
    :plag => f_plag,
    :Kfs => f_kfs,
    :ep => f_ep,
    :amph => f_amph,
    :cpx => f_cpx,
    :ol => f_ol,
    :ky => f_ky,
    :sill => f_sill,
    :and => f_and,
    :q => f_q,
    :melt => f_melt
)

# Function to extract variables from output using above functions.
# e.g., query = [(:g, :Xalm), (:g, :Xgrs), (:melt, :SiO2), (:cpx, :Xjd)]
# e.g., run_query(out, query)
function run_query(out, query)
    results = []

    for (phase_sym, var_sym) in query
        # Get the function from phase_table
        f = get(phase_table, phase_sym, nothing)
        if f === nothing
            push!(results, missing)  # or handle error
            continue
        end

        # Run the phase function on `out`
        res = f(out)

        # Extract variable if it exists
        if haskey(res, var_sym)
            push!(results, getfield(res, var_sym))
        else
            push!(results, missing)  # or handle error
        end
    end

    return results
end


# Test scripts
# using MAGEMin_C
# data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
# P,T     = 10.0, 1100.0
#Xoxides = ["SiO2","Al2O3","CaO","MgO","FeO","K2O","Na2O","TiO2","O","MnO","H2O"];
#X       = [70.999,12.805,0.771,3.978,6.342,2.7895,1.481,0.758,0.72933,0.075,30.0];
#sys_in  = "mol"
#out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in)