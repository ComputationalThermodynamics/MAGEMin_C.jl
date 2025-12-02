# This file contains functions to extract variables from the output of MAGEMin.
# Written by T. Mackay-Champion, University of Bristol + Oxford, 2025
"""
# Example use #
data    = Initialize_MAGEMin("ig", verbose=-1);
P,T     = 10.0, 800.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out_lT  = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in, name_solvus=true);
query = [(:melt, :vol), (:plag, :wt), (:melt, :SiO2), (:amp, :Ts), (:amp, :XFe3)]
data_vector = run_query(out_lT, query)
"""

module MAGEMin_read
export run_query

# --- Structure for phases ---
struct Phase
    aliases::Vector{String}
    SS::Bool
    extra_variables::Vector{Symbol}
end

# --- Phase dictionary ---
# Make vol, wt%, standard
const phases = Dict{String,Phase}()
phases["g"] = Phase(["g"], true, [:XMg,:pyTOT])
phases["st"] = Phase(["st"], true, [:XMg])
phases["crd"] = Phase(["crd"], true, [:XMg])
phases["chl"] = Phase(["chl"], true, [:XMg])
phases["bi"] = Phase(["bi"], true, [:XMg])
phases["mu"] = Phase(["mu","pat"], true, [:XMg,:Xpa])
phases["plag"] = Phase(["pl"], true, [])
phases["afs"] = Phase(["afs"], true, [])
phases["ep"] = Phase(["ep"], true, [:XFe])
phases["amp"] = Phase(["amp"], true, [:amp_vectors])
phases["cpx"] = Phase(["cpx","pig","Na-cpx","aug","di"], true, [:XMg,:Xjd])
phases["ol"] = Phase(["ol"], true, [:XMg])
phases["melt"] = Phase(["melt","liq"], true, [:anhydrous_oxides])
phases["ky"] = Phase(["ky"], false, [])
phases["sill"] = Phase(["sill"], false, [])
phases["and"] = Phase(["and"], false, [])
phases["q"] = Phase(["q"], false, [])
phases["ru"] = Phase(["ru"], false, [])
phases["H2O"] = Phase(["H2O"], false, [])
# ...add more phases as needed

# ----------------------------------------------
# --- General functions to extract variables ---
# ----------------------------------------------
# Ions assignment
const G_ion_per_oxide = (Na2O = :Na, Cr2O3 = :Cr, SiO2 = :Si,
                    Al2O3 = :Al, TiO2 = :Ti, CaO = :Ca,
                    FeO = :Fe2, Fe2O3 = :Fe3, 
                    K2O = :K, MgO = :Mg, H2O = :H, MnO = :Mn)
const G_cations_per_oxide = (Na2O = 2, Cr2O3 = 2, SiO2 = 1, 
                        Al2O3 = 2, TiO2 = 1, CaO = 1, 
                        FeO = 1, Fe2O3 = 2,
                        K2O = 2, MgO = 1, H2O = 2, MnO = 1)
const G_oxygens_per_oxide = (Na2O = 1, Cr2O3 = 3, SiO2 = 2, 
                        Al2O3 = 3, TiO2 = 2, CaO = 1, 
                        FeO = 1, Fe2O3 = 3,
                        K2O = 1, MgO = 1, H2O = 1, MnO = 1)

# Function to extract phase index from MAGEMin output
# If the phase is not present, it returns nothing.
# If there are two phases with the same name (e.g., two melt phases), 
# it returns the index of the most abundant phase.
function f_aliases(out, phase_names)
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

# Function to extract endmember fractions from MAGEMin output
function f_endmembers(out, index)
    SS = out.SS_vec[index]
    endmember_list = Symbol.(SS.emNames);
    endmembers = (; (el => SS.emFrac[i] for (i, el) in enumerate(endmember_list))...)
    return endmembers
end

# Function to extract endmember fractions from MAGEMin output
function f_sites(out, index)
    SS = out.SS_vec[index]
    site_list = Symbol.(SS.siteFractionsNames)
    sites = (; (el => SS.siteFractions[i] for (i, el) in enumerate(site_list))...)
    return sites
end

# Function to extract ions per formula unit, normalized to set number of oxygens
function f_cations(out,index)

    # Get mol% of oxides
    SS = out.SS_vec[index]
    oxide_list = Symbol.(out.oxides)
    oxide_mol = (; (el => SS.Comp[i] for (i, el) in enumerate(oxide_list))...)

    # Assign iron (FeO = FeOT - 2 * O; Fe2O3 = O)
    FeO =  oxide_mol.FeO - 2 * oxide_mol.O;
    Fe2O3 = oxide_mol.O;
    oxide_mol = Base.structdiff(oxide_mol, (FeO = 0, O = 0))
    oxide_mol = merge(oxide_mol, (FeO = FeO, Fe2O3 = Fe2O3))

    # Moles to cations
    sum_oxygens = 0
    cations = NamedTuple((
        G_ion_per_oxide[oxide] => moles * G_cations_per_oxide[oxide]
        for (oxide, moles) in pairs(oxide_mol)))
    sum_oxygens = sum(
        moles * G_oxygens_per_oxide[oxide] for (oxide, moles) in pairs(oxide_mol))
    cations = merge(cations, (O = sum_oxygens,))

    # Normalize to Comp_apfu
    idx_Si = findfirst(==("Si"), out.elements)
    if idx_Si !== nothing && SS.Comp_apfu[idx_Si] != 0
        normalization_factor = SS.Comp_apfu[idx_Si] / cations.Si
    else
        idx_Ca = findfirst(==("Ca"), out.elements)
        normalization_factor = SS.Comp_apfu[idx_Ca] / cations.Ca
    end
    ions = (; (k => v * normalization_factor for (k, v) in pairs(cations))...)

    # XFe3+
    xfe3 = ions.Fe3 / (ions.Fe2 + ions.Fe3)
    ions = merge(ions, (XFe3 = xfe3,))

    return ions
end

# Function to extract XMg from MAGEMin output
function f_XMg(cations)
    XMg = cations.Mg/(cations.Mg + cations.Fe2)
    return (XMg = XMg,)
end

# Function to extract phase vol% and wt% from MAGEMin output
function f_vol(out, index)
    vol = out.ph_frac_vol[index]
    wt = out.ph_frac_wt[index]
    return (vol = vol, wt = wt)
end

# Function to extract anhydrous oxide wt% from MAGEMin output
function f_oxidePercent_anhydrous(out,index)
        # wt% of oxides
        comp = out.SS_vec[index].Comp_wt
        oxides = out.oxides
        oxide_wt = (; (Symbol(oxides[i]) => comp[i] for i in eachindex(oxides))...)

        # Remove H2O and normalize to total anhydrous
        total_anhydrous = sum(values(oxide_wt)) - get(oxide_wt, :H2O, 0.0)

        # Create a named tuple with normalized wt% for each oxide
        oxide_wt_percent = (
            (; (Symbol(oxide) => get(oxide_wt, Symbol(oxide), 0.0) / total_anhydrous * 100 for oxide in oxides)...)
        )
    return oxide_wt_percent
end

# --------------------------
# --- Specific functions ---
# --------------------------
# Function to find total pyrope in garnet
function f_pyTOT(endmembers)
    py = endmembers.py
    kho = endmembers.kho
    pyTOT = py + kho
    return (pyTOT = pyTOT,)
end

# Function to find Xpa in muscovite
function f_Xpa(cations)
    Xpa = cations.Na./(cations.Na + cations.Ca +cations.K) 
    return (Xpa = Xpa,)
end

# Function to find XFe in epidote
function f_XFe(cations)
    XFe = cations.Fe3 / (cations.Al + cations.Fe3)
    return (XFe = XFe,)
end

# Function to Xjd in CPX
function f_Xjd(out,index)
    # Site fractions + vectors
    site_list = out.SS_vec[index].siteFractionsNames
    sites = out.SS_vec[index].siteFractions
    vars = NamedTuple{Tuple(Symbol.(site_list))}(Tuple(sites))
    Xjd = min(vars.xNaM2, vars.xAlM1)
    return (Xjd = Xjd,)
end

# Function to find site vectors in amphibole
function f_amph_vectors(out,index)
    # Site fractions + vectors
    var_names = out.SS_vec[index].siteFractionsNames
    var_values = out.SS_vec[index].siteFractions
    vars = (; (Symbol(name) => value for (name, value) in zip(var_names, var_values))...)
    xAlT1 = vars.xAlT1
    xNaA = vars.xNaA
    xKA = vars.xKA
    xNaM4 = vars.xNaM4
    Ts = xAlT1*4 - xNaA - xKA
    Ed = xNaA + xKA
    Gln = xNaM4 
    return (Ts = Ts, Ed = Ed, Gln = Gln)
end

# -----------------------
# --- Query functions ---
# -----------------------

# --- Extra variables function dictionary ---
const funcs = Dict{Symbol,NamedTuple}()
funcs[:XMg]        = (fn = f_XMg,   args = [:cations])
funcs[:anhydrous_oxides] = (fn = f_oxidePercent_anhydrous, args = [:out, :index])
funcs[:pyTOT] = (fn = f_pyTOT, args = [:endmembers])
funcs[:Xpa]        = (fn = f_Xpa,   args = [:cations])
funcs[:XFe]        = (fn = f_XFe,   args = [:cations])
funcs[:Xjd]        = (fn = f_Xjd,   args = [:out, :index])
funcs[:amp_vectors]      = (fn = f_amph_vectors, args = [:out, :index])
# ...add more functions as needed

# Function to return the concrete value corresponding to a symbolic argument token.
function resolve_arg_token(tok, env::Dict{Symbol,Any})
    if tok === :out || tok === :index || tok === :endmembers || tok === :cations
        return get(env, tok, nothing)
    else
        return tok
    end
end

# Function to extract information for a given phase from MAGEMin output.
function run_phase(out, phase_name::AbstractString; 
                    phases=phases, funcs=funcs,f_aliases=f_aliases, 
                    f_endmembers=f_endmembers, f_cations=f_cations)

    # Get phase index without MAGEMin output
    phase = phases[phase_name]
    aliases = phase.aliases
    index = f_aliases(out, aliases)
    if index === nothing
        return nothing
    end

    # Get phase abundance
    abundance_out = f_vol(out,index)

    # Get endmember fractions, sites, and cations for solid solutions
    endmembers_out = nothing
    sites_out = nothing
    cations_out = nothing
    if phase.SS
        endmembers_out = f_endmembers(out, index)
        sites_out = f_sites(out, index)
        cations_out = f_cations(out, index)
    end

    # Create dictionary of environment variables for function evaluation.
    env = Dict{Symbol,Any}(
        :out => out,
        :index => index,
        :endmembers => endmembers_out,
        :cations => cations_out
    )

    # Loop over extra functions for each variable
    var_results = nothing
    var_syms = Symbol.(phase.extra_variables)
    if !isempty(var_syms)
        var_keys = Symbol[]
        var_vals = Any[]
        for v in var_syms
            push!(var_keys, v)

            if !haskey(funcs, v)
                push!(var_vals, ErrorException("no function for $(v)"))
                continue
            end

            # Find functions name and arguments
            spec = funcs[v].args
            fn   = funcs[v].fn
            args = [resolve_arg_token(a, env) for a in spec]

            # Run function and store result
            try
                push!(var_vals, fn(args...))
            catch err
                push!(var_vals, err)
            end
        end
        var_results = reduce(merge, map(x -> x isa Tuple ? x[1] : x, var_vals))
    end

    # Merge into results tuple
    final_tuple = merge(
        endmembers_out === nothing ? NamedTuple() : endmembers_out,
        cations_out    === nothing ? NamedTuple() : cations_out,
        sites_out      === nothing ? NamedTuple() : sites_out,
        abundance_out  === nothing ? NamedTuple() : abundance_out,
        var_results    === nothing ? NamedTuple() : var_results)
    return final_tuple
end

# Parent function to run query on MAGEMin output.
function run_query(out, query;
                            phases::Dict{String,Phase}=phases,
                            funcs::Dict{Symbol,NamedTuple}=funcs,
                            run_phase::Function=run_phase)

    # collect unique phase keys
    phase_keys = Set{String}()
    for (p, _) in query
        push!(phase_keys, isa(p, Symbol) ? string(p) : p)
    end

    # run each unique phase once and save its output
    phase_results = Dict{String,Any}()
    for pkey in phase_keys
        try
            phase_results[pkey] = run_phase(out, pkey)
        catch err
            phase_results[pkey] = err
        end
    end

    # extract values in original query order
    results = Vector{Any}(undef, length(query))
    for (i, (p, v)) in enumerate(query)
        pkey = isa(p, Symbol) ? string(p) : p
        vsym = isa(v, Symbol) ? v : Symbol(v)

        pres = get(phase_results, pkey, ErrorException("phase not run: $pkey"))
        if pres isa Exception
            results[i] = pres
            continue
        elseif pres === nothing
            results[i] = 0.0
            continue
        elseif pres isa NamedTuple
            if hasproperty(pres, vsym)
                results[i] = getproperty(pres, vsym)
            else
                results[i] = missing
            end
        else
            # phase returned something unexpected
            results[i] = missing
        end
    end

    return results
end

end