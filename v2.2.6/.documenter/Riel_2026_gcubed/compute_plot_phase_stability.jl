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
using LaTeXStrings

include("TE_functions.jl")
include("TE_fractional.jl")
include("plot_figures.jl")

"""
    main_fct(; model="MM", Prange=[1.0, 16.0], Pstep=0.5) ->
        (mu_T_all, bi_T_all, cd_T_all, q_T_all, pl_T_all, afs_T_all, pat_T_all,
         ext_event_all, Pall, Tall2)

Compute the temperature stability ranges of key metamorphic minerals over a pressure sequence
for the average Forshaw & Pattison (2023) pelite along the water-saturated solidus.

For each pressure in `Prange[1]:Pstep:Prange[2]`, runs a dense T sequence (solidus → 1000°C)
with stepwise melt extraction (e1_liq = 7%, e1_remain = 1%), records when each mineral is
stable, and tracks cumulative extraction events.

# Keyword Arguments
- `model`: KD model identifier used to load the water-saturation interpolant and KD database
  (default `"MM"`); `"MM_F"` loads the fluorine-rich biotite interpolant
- `Prange`: `[P_min, P_max]` in kbar (default `[1.0, 16.0]`)
- `Pstep`: Pressure step size [kbar] (default 0.5)

# Returns
- `mu_T_all`, `bi_T_all`, `cd_T_all`, `q_T_all`, `pl_T_all`, `afs_T_all`, `pat_T_all`:
  Vectors of `[T_min, T_max]` stability ranges for muscovite, biotite, cordierite, quartz,
  plagioclase, alkali feldspar, and paragonite at each pressure
- `ext_event_all`: Cumulative extraction event count vectors at each pressure
- `Pall`: Pressure values at which computations were performed
- `Tall2`: Temperature vectors for each pressure
"""
function main_fct(; model = "MM", Prange = [1.0, 16.0], Pstep = 0.5)
    FC          = false             # if true, perform fractional crystallization
    dpi         = 300
    if model == "MM_F"
        fake_F_bi   = true
    else
        fake_F_bi   = false
    end
    out_dir     = "./output_Li_v0.1/"
    Li_content  = 100.0;            # Li content in ppm
    H_ex        = 0.03;
    n_ee        = 15;
    e1_liq      = 7.0;
    e1_remain   = 1.0;
    norm_TE     = true;           # if true, normalize the TE results to 100% melt
    np          = 150;
    b           = "FS"   # number of points in the pressure and H2O range    
    scale       = "fixed_"

    # first initialize MAGEMin
    dtb         = "mp"

    T           = [600.0, 1000.0]

    Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
    bulk_in     = norm2one([0.67153, 0.12111, 0.00729, 0.03762, 0.05998, 0.02638, 0.01401, 0.00717, 0.0069, 0.00071, 0.0]);
    sys_in      = "mol";

    # Compute the pressure interpolant for the water saturated curve. One for water content, one for temperature
    if model == "MM_F"
        pChip_wat, pChip_T = load("pChip_wat_F.jld2", "pChip_wat", "pChip_T")
    else
        pChip_wat, pChip_T = load("pChip_wat.jld2", "pChip_wat", "pChip_T")
    end


    model == "MM_F" ? fake_F_bi = true : fake_F_bi = false
    if fake_F_bi == true
        Ws          = custom_bi_Ws()
        println("Using custom biotite partitioning coefficients! (extended biotite stability)")
    else
        Ws          = nothing
    end 


    # pre-allocate the output arrays
    Out_all                 = Array{Li_infos}(undef, 1);

    # perform the calculations
    data                    = Initialize_MAGEMin(dtb, verbose=-1; solver=0);
    KDs_database            = get_Kds(;model = model);
    data_thread             = get_data_thread(data)

    gv, z_b, DB, splx_data = data_thread        # Unpack the MAGEMin data

    #= next section computes batch melting profille =#
    n_max       = 2048;                    # Maximum number of iterations in the bisection method

    mu_T_all = []
    bi_T_all = []
    cd_T_all = []
    q_T_all  = []
    pl_T_all = []
    afs_T_all= []
    pat_T_all= []
    ext_event_all = []
    Pall = []
    Tall2 = []

    for P = Prange[1]:Pstep:Prange[2]
        H = pChip_wat(P)


        bulk        = copy(bulk_in)
        id_h        = findfirst(Xoxides .== "H2O")
        bulk[id_h]  = H .+ H_ex
        if bulk[id_h] < 0.0
            bulk[id_h] = 0.001
        end

        gv          = define_bulk_rock(gv, bulk, Xoxides, sys_in, dtb);

        elem_TE     = ["Li"]
        bulk_TE     = [Li_content]           # Li	30–100 µg/g (ppm)	- Can be up to 150 ppm in Li-rich pelites

        C0          = adjust_chemical_system( KDs_database, bulk_TE, elem_TE );

        ext_out2    = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef,n_max)
        ext_out_te2 = Vector{MAGEMin_C.out_tepm}(undef,n_max)
        ext_event   = Vector{Int64}(undef,n_max)

        # Tsol        = pChip_T(P)+1
        Tsol        = retrieve_solidus(P, gv, z_b, DB, splx_data)
        Tall        = collect(range(Tsol, 1000.0, length=n_max))

        ee = 0
        @showprogress for i=1:n_max
            ext_out2[i]         = deepcopy(point_wise_minimization(P, Tall[i], gv, z_b, DB, splx_data; W = Ws, name_solvus = true))
            ext_out_te2[i]      = deepcopy(TE_prediction(ext_out2[i], C0, KDs_database, dtb; ZrSat_model = "CB", norm_TE = norm_TE))


            if "liq" in ext_out2[i].ph
                id_liq  = findfirst(ext_out2[i].ph .== "liq")
                if ext_out2[i].ph_frac_vol[id_liq] >= e1_liq./100.0

                    ratio    = (ext_out2[i].frac_M_vol - e1_remain/100.0)/ext_out2[i].frac_M_vol
                    bulk      = ext_out2[i].bulk .- ext_out2[i].SS_vec[id_liq].Comp .* (ext_out2[i].frac_M*ratio)

                    gv       = define_bulk_rock(gv, bulk, Xoxides, "mol", dtb);
                    C0       = C0 .- ext_out_te2[i].Cliq[1] .* (ext_out_te2[i].liq_wt_norm*ratio)

                    ee       += 1
                end

            end
            ext_event[i]        = ee
        end

        Li      = [ext_out_te2[i].Cliq[1] for i=1:n_max]
        liq_vol = [ext_out2[i].frac_M_vol for i=1:n_max]


        #= PLOT RESULTS =#
        afs_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].SS_syms, :afs)
                push!(afs_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:afs]])
            else
                push!(afs_vol, 0.0)  # or NaN if you prefer
            end
        end
        pl_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].SS_syms, :pl)
                push!(pl_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:pl]])
            else
                push!(pl_vol, 0.0)  # or NaN if you prefer
            end
        end
        mu_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].SS_syms, :mu)
                push!(mu_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:mu]])
            else
                push!(mu_vol, 0.0)  # or NaN if you prefer
            end
        end
        cd_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].SS_syms, :cd)
                push!(cd_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:cd]])
            else
                push!(cd_vol, 0.0)  # or NaN if you prefer
            end
        end
        bi_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].SS_syms, :bi)
                push!(bi_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:bi]])
            else
                push!(bi_vol, 0.0)  # or NaN if you prefer
            end
        end
        pat_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].SS_syms, :pat)
                push!(pat_vol, ext_out2[i].ph_frac_vol[ext_out2[i].SS_syms[:pat]])
            else
                push!(pat_vol, 0.0)  # or NaN if you prefer
            end
        end

        q_vol = []
        for i = 1:n_max
            if haskey(ext_out2[i].PP_syms, :q)
                push!(q_vol, ext_out2[i].ph_frac_vol[ext_out2[i].PP_syms[:q] + ext_out2[i].n_SS])
            else
                push!(q_vol, 0.0)  # or NaN if you prefer
            end
        end

        # Tall       = [ext_out2[i].T_C for i=1:n_max]
        liq_vol[liq_vol .> 0.07] .= 0.07

        mu_T_range  = Tall[mu_vol .> 0.0]
        # println("mu_T_range: $(mu_T_range)")
        if isempty(mu_T_range)
            mu_T = [NaN, NaN]
        else
            mu_T = [minimum(mu_T_range), maximum(mu_T_range)]
        end

        bi_T_range    = Tall[bi_vol .> 0.0]
        if isempty(bi_T_range)
            bi_T = [NaN, NaN]
        else
            bi_T = [minimum(bi_T_range), maximum(bi_T_range)]
        end

        cd_T_range    = Tall[cd_vol .> 0.0]
        if isempty(cd_T_range)
            cd_T = [NaN, NaN]
        else
            cd_T = [minimum(cd_T_range), maximum(cd_T_range)]
        end

        q_T_range    = Tall[q_vol .> 0.0]
        if isempty(q_T_range)
            q_T = [NaN, NaN]
        else
            q_T = [minimum(q_T_range), maximum(q_T_range)]
        end

        pl_T_range    = Tall[pl_vol .> 0.0]
        if isempty(pl_T_range)
            pl_T = [NaN, NaN]
        else
            pl_T = [minimum(pl_T_range), maximum(pl_T_range)]
        end

        afs_T_range    = Tall[afs_vol .> 0.0]
        if isempty(afs_T_range)
            afs_T = [NaN, NaN]
        else
            afs_T = [minimum(afs_T_range), maximum(afs_T_range)]
        end

        pat_T_range    = Tall[pat_vol .> 0.0]
        if isempty(pat_T_range)
            pat_T = [NaN, NaN]
        else
            pat_T = [minimum(pat_T_range), maximum(pat_T_range)]
        end

        push!(mu_T_all, mu_T)
        push!(bi_T_all, bi_T)
        push!(cd_T_all, cd_T)
        push!(q_T_all, q_T)
        push!(pl_T_all, pl_T)
        push!(afs_T_all, afs_T)
        push!(pat_T_all, pat_T)
        push!(ext_event_all, ext_event)
        push!(Pall, P)
        push!(Tall2, Tall)
    end

    return mu_T_all, bi_T_all, cd_T_all, q_T_all, pl_T_all, afs_T_all, pat_T_all, ext_event_all, Pall, Tall2
end



mu_T_all, bi_T_all, cd_T_all, q_T_all, pl_T_all, afs_T_all, pat_T_all, ext_event_all, Pall, Tall2 = main_fct(;model = "MM", Prange = [2.0, 16.0], Pstep = 0.2)



# Convert ext_event_all to a matrix for plotting
nP = length(Pall)
nT = length(Tall2[1])  # Assuming all Tall2 vectors have the same length

# Build the matrix: rows = pressure, columns = temperature
Z = zeros(nP, nT)
for i in 1:nP
    Z[i, :] .= ext_event_all[i][1:nT]
end
Z_smooth = Z
# Z_smooth = smooth_Y(Z, 1) 
# Z_smooth = smooth_X(Z, 4)

# Build temperature and pressure axes
T_axis = Tall2[1]  # Use the first Tall2 as representative
P_axis = Pall

include("plot_phase_stability_functions.jl")

x_poly, y_poly = get_mu_poly(mu_T_all, Pall)
plot(   x_poly, y_poly, 
        seriestype  = :shape, 
        alpha       = 0.3, 
        linecolor   = :black, 
        label       = "muscovite",
        palette     = :tab10)

x_poly, y_poly = get_bi_poly(bi_T_all, Pall)
plot!(   x_poly, y_poly, 
        seriestype  = :shape, 
        alpha       = 0.3, 
        linecolor   = :black, 
        label       = "biotite",
        palette     = :tab10)

x_poly, y_poly = get_cd_poly(cd_T_all, Pall)
plot!(   x_poly, y_poly, 
        seriestype  = :shape, 
        alpha       = 0.3, 
        linecolor   = :black, 
        label       = "cordierite",
        palette     = :tab10)

x_poly, y_poly = get_pat_poly(pat_T_all, Pall)
plot!(   x_poly, y_poly, 
        seriestype  = :shape, 
        alpha       = 0.3, 
        linecolor   = :black, 
        label       = "paragonite",
        palette     = :tab10)

plot!(xlabel = "T (°C)", ylabel = "P (GPa)", ylims = (2, 16), xlims = (650, 1000), legend = :topright, dpi = 300, right_margin = 20Plots.px)


 savefig("wat_phase_stability_+0.03.svg")