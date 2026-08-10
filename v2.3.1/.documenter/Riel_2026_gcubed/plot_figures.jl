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
    get_subplot_T3(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi;
                   ylabel=false, label_on=false, discr=false) -> (f1, clb)

Create a heatmap or contourf subplot of a scalar field in P–H₂O space with colorbar on the right
and water-saturation boundary lines overlaid (±0.03 mol% and exact saturation).

# Arguments
- `model`: KD model label (for axis decisions)
- `pChip_wat`: PCHIP interpolator for saturation H₂O vs. pressure
- `H`: H₂O axis vector [mol fraction]
- `P`: Pressure axis vector [kbar]
- `field`: One of `"Li"`, `"LiMax"`, `"extraction"`, `"T"`, `"Δbi"`, `"Δcd"`, `"Δmu"`, `"eta_M"`
- `scale`: `"fixed_"` for hard-coded color limits, otherwise `:auto`
- `mat`: Data matrix (np × np)
- `Li_content`: Initial bulk Li [µg/g] (used to normalize the `"Li"` field)
- `dpi`: Figure resolution

# Keyword Arguments
- `ylabel`: Show pressure axis label if true
- `label_on`: Show water-saturation line labels in legend if true
- `discr`: Use discrete contourf levels (suitable for integer fields such as extraction count)

# Returns
- `(f1, clb)`: Main figure handle and dummy colorbar scatter handle
"""
function get_subplot_T3(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi; ylabel = false, label_on = false, discr = false)
    rev = true
    if field == "Li"
        title = "Li enrichment"
        mat  ./= Li_content
    elseif field == "LiMax"
        title = "Li_max[ug/g]"
    elseif field == "extraction"
        title = "Extraction event"
    elseif field == "T"
        title = "Temperature [°C]"
    elseif field == "Δbi"
        title = "Δbi [vol.%]"
        rev = true
    elseif field == "Δcd"
        title = "Δcd [vol.%]"
        rev = true
    elseif field == "Δmu"
        title = "Δmu [vol.%]"
        rev = true
    elseif field == "eta_M"
        title = "log10(Viscosity_[Pa.s])"
    else
        error("Invalid field name")
    end

    # if scale == "fixed_"
    #     if field == "Li"
    #         clims = (0.0,10.0)
    #     elseif field == "T"
    #         clims = (675.0,1175.0)
    #     elseif field == "extraction"
    #         clims = (1,10)
    #     elseif field == "Δbi"
    #         clims = (-0.2,0.2).*100.0
    #     elseif field == "Δcd"
    #         clims = (-0.25,0.25).*100.0
    #     elseif field == "Δmu"
    #         clims = (-0.15,0.15).*100.0
    #     else
    #         clims = :auto
    #     end
    # else 
        
    # end

    # if model == "MM" || model == "KMout"
        colorbar = :right
    # else 
    #     colorbar = false
    # end

    if field == "Δbi" || field == "Δcd" || field == "Δmu"
        xlabel = "H₂O [mol%]"
        xticks  = :auto

        val = maximum(filter(!isnan, abs.(mat)))
        clims = (-val,val)
        println("clims = $clims")
    else 
        xlabel = ""
        xticks  = :auto
        clims = :auto
    end

    if ylabel == true
        ylabel  = "Pressure [kbar]"
        yticks  = :auto
    else
        ylabel  = ""
        yticks  = :auto
    end

    if discr == true

        m0 = minimum(mat[mat .> 0])
        m1 = maximum(mat[mat .> 0])
        nl = Int64(m1-m0)
        # Create discrete levels
        levels_vec = range(m0, m1, length=nl+1)
        
        # Create tick positions at the center of each color band
        tick_positions = [(levels_vec[i] + levels_vec[i+1])/2 for i in 1:nl]
        tick_labels = [string(i) for i=1:nl]
        
        println("discr = true")
        f1 = Plots.contourf(H.*100, P, mat,
                    ylabel          = ylabel,
                    xlabel          = xlabel,
                    yticks          = yticks,
                    xticks          = xticks,
                    c               = cgrad(:RdBu, rev=rev),
                    levels          = levels_vec,  # Use the discrete levels
                    clims           = clims, 
                    colorbar_title  = title,
                    colorbar        = colorbar,
                    colorbar_ticks  = (tick_positions, tick_labels),  # Center the ticks
                    dpi             = dpi)
    else
        c = cgrad(:RdBu, rev=rev)  # continuous
        f1 = Plots.heatmap(H.*100, P, mat,
                    ylabel          = ylabel,
                    xlabel          = xlabel,
                    yticks          = yticks,
                    xticks          = xticks,
                    c               = c,
                    # No levels parameter for continuous
                    clims           = clims, 
                    colorbar_title  = title,
                    colorbar        = colorbar,
                    dpi             = dpi)
    end

    # Overlay lines
    h = pChip_wat.(P) .- 0.03    
    h[h .< 0.005] .= NaN    

    if label_on == true
        label = "-3.0 mol%"
    else
        label = ""
    end
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = label,
        legend    = :topleft)

    h = pChip_wat.(P) 
    if label_on == true
        label = "H₂O sat"
    else
        label = ""
    end            
    plot!(f1, h.*100, P,
        linewidth = 4,
        linecolor = :black,
        label     = label,
        legend    = :topleft)

    h = pChip_wat.(P) .+ 0.03    
    if label_on == true
        label = "+3.0 mol%"
    else
        label = ""
    end
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = label,
        legend    = :topleft)

    clb = Plots.scatter([0,0],
                        [0,0],
                        zcolor          = [0,1],
                        clims           = clims,
                        xlims           = (1,1.1),
                        label           = "",
                        c               = cgrad(:RdBu, rev=rev),
                        # colorbar_title  = title,
                        framestyle      = :none,
                        colorbar        = :bottom)
    return f1, clb
end

"""
    get_subplot_T2(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi;
                   ylabel=false, liqE=false, label_on=false, discr=false, e1_liq_in=7.0) -> (f1, nothing)

Create a heatmap or contourf subplot of a scalar field in P–H₂O space. Colorbar is shown only
for `model ∈ ("MM", "KMout")` with the default `e1_liq_in`; otherwise suppressed.

Parameters and behavior are identical to `get_subplot_T3` except for colorbar placement.

# Keyword Arguments
- `liqE`: Reserved flag (currently unused)
- `e1_liq_in`: Melt extraction threshold [vol%] used to decide whether to show the colorbar (default 7.0)
- See `get_subplot_T3` for all other keyword arguments.

# Returns
- `(f1, nothing)`: Plot handle and `nothing` (no colorbar handle returned)
"""
function get_subplot_T2(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi; ylabel = false, liqE = false, label_on = false, discr = false, e1_liq_in = 7.0)
    rev = true
    if field == "Li"
        title = "Li enrichment"
        mat  ./= Li_content
    elseif field == "LiMax"
        title = "Li_max[ug/g]"
    elseif field == "extraction"
        title = "Extraction event"
    elseif field == "T"
        title = "Temperature [°C]"
    elseif field == "Δbi"
        title = "Δbi [vol]"
        rev = true
    elseif field == "Δcd"
        title = "Δcd [vol]"
        rev = true
    elseif field == "Δmu"
        title = "Δmu [vol]"
        rev = true
    elseif field == "eta_M"
        title = "log10(Viscosity_[Pa.s])"
    else
        error("Invalid field name")
    end

    if scale == "fixed_"
        if field == "Li"
            clims = (0.0,10.0)
        elseif field == "T"
            clims = (675.0,1175.0)
        elseif field == "extraction"
            clims = (1,10)
        elseif field == "Δbi"
            clims = (-0.2,0.2).*100.0
        elseif field == "Δcd"
            clims = (-0.25,0.25).*100.0
        elseif field == "Δmu"
            clims = (-0.15,0.15).*100.0
        else
            clims = :auto
        end
    end

    if (model == "MM" || model == "KMout") && e1_liq_in == 7.0
        println("colorbar = :top")
        colorbar = :top
    else 
        colorbar = false
    end

    if model == "BA"
        xlabel = "H₂O [mol%]"
        xticks  = :auto
    else 
        xlabel = ""
        xticks  = :auto
    end

    if ylabel == true
        ylabel  = "Pressure [kbar]"
        yticks  = :auto
    else
        ylabel  = ""
        yticks  = :auto
    end

    if discr == true #&& model != "BA" 

        # m0 = minimum(mat[mat .> 0])
        # m1 = maximum(mat[mat .> 0])
        # nl = Int64(m1-m0)
        nl = 10
        # Create discrete levels
        levels_vec = range(1, nl, length=nl+1)
        
        # Create tick positions at the center of each color band
        tick_positions = [(levels_vec[i] + levels_vec[i+1])/2 for i in 1:nl]
        tick_labels = [string(i) for i=1:nl]
        
        println("discr = true")
        f1 = Plots.contourf(H.*100, P, mat,
                    ylabel          = ylabel,
                    xlabel          = xlabel,
                    yticks          = yticks,
                    xticks          = xticks,
                    c               = cgrad(:RdBu, rev=rev),
                    levels          = levels_vec,  # Use the discrete levels
                    clims           = clims, 
                    # colorbar_title  = title,
                    colorbar        = colorbar,
                    colorbar_ticks  = (tick_positions, tick_labels),  # Center the ticks
                    dpi             = dpi)
    else
        f1 = Plots.heatmap(H.*100, P, mat,
                    ylabel          = ylabel,
                    xlabel          = xlabel,
                    yticks          = yticks,
                    xticks          = xticks,
                    c               = cgrad(:RdBu, rev=rev),
                    clims           = clims, 
                    # colorbar_title  = title,
                    colorbar        = colorbar,
                    dpi             = dpi)
    end
    # Overlay lines
    h = pChip_wat.(P) .- 0.03    
    h[h .< 0.005] .= NaN    
    if label_on == true
        label = "-3.0 mol%"
    else
        label = ""
    end
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = label,
        legend    = :topleft)

    h = pChip_wat.(P)  
    if label_on == true
        label = "H2O sat"
    else
        label = ""
    end           
    plot!(f1, h.*100, P,
        linewidth = 4,
        linecolor = :black,
        label     = label,
        legend    = :topleft)

    h = pChip_wat.(P) .+ 0.03  
    if label_on == true
        label = "+3.0 mol%"
    else
        label = ""
    end  
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = label,
        legend    = :topleft)

    # clb = Plots.scatter([0,0],
    #                     [0,0],
    #                     zcolor          = [0,1],
    #                     clims           = clims,
    #                     xlims           = (1,1.1),
    #                     label           = "",
    #                     c               = cgrad(:RdBu, rev=rev),
    #                     # colorbar_title  = title,
    #                     framestyle      = :none,
    #                     colorbar        = :bottom)
    return f1, nothing
end

"""
    get_subplot_T(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi;
                  ylabel=false) -> (f1, clb)

Create a heatmap subplot of a scalar field in P–H₂O space without an attached colorbar.
Returns a separate dummy scatter handle `clb` for manual colorbar placement.

See `get_subplot_T3` for full parameter descriptions.
"""
function get_subplot_T(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi; ylabel = false)
    rev = true
    if field == "Li"
        title = "Li enrichment"
        mat  ./= Li_content
    elseif field == "LiMax"
        title = "Li_max[ug/g]"
    elseif field == "extraction"
        title = "Extraction event"
    elseif field == "T"
        title = "Temperature [°C]"
    elseif field == "Δbi"
        title = "Δbi_[vol]"
        rev = true
    elseif field == "Δcd"
        title = "Δcd_[vol]"
        rev = true
    elseif field == "Δmu"
        title = "Δmu_[vol]"
        rev = true
    elseif field == "eta_M"
        title = "log10(Viscosity_[Pa.s])"
    else
        error("Invalid field name")
    end

    if scale == "fixed_"
        if field == "Li"
            clims = (0.0,8.0)
        elseif field == "T"
            clims = (675.0,1175.0)
        elseif field == "extraction"
            clims = (1,10)
        elseif field == "Δbi"
            clims = (-0.2,0.2)
        elseif field == "Δcd"
            clims = (-0.25,0.25)
        elseif field == "Δmu"
            clims = (-0.15,0.15)
        else
            clims = :auto
        end
    end

    # if model == "BA"
    #     colorbar = false
    # else 
        colorbar = false
    # end

    if model == "BA"
        xlabel = "H₂O [mol%]"
        xticks  = :auto
    else 
        xlabel = ""
        xticks  = :auto
    end

    if ylabel == true
        ylabel  = "Pressure [kbar]"
        yticks  = :auto
    else
        ylabel  = ""
        yticks  = :auto
    end

    f1 = Plots.heatmap(H.*100, P, mat,
                ylabel          = ylabel,
                xlabel          = xlabel,
                yticks          = yticks,
                xticks          = xticks,
                c               = cgrad(:RdBu, rev=rev),
                clims           = clims, 
                colorbar        = colorbar,
                dpi             = dpi,
                left_margin     = 10Plots.mm,
                right_margin    = 0Plots.mm,
                top_margin      = 1Plots.mm,
                bottom_margin   = 5Plots.mm,
                )

    # Overlay lines
    h = pChip_wat.(P) .- 0.03    
    h[h .< 0.005] .= NaN    
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = "-3.0 mol%")

    h = pChip_wat.(P)             
    plot!(f1, h.*100, P,
        linewidth = 4,
        linecolor = :black,
        label     = "H2O sat")

    h = pChip_wat.(P) .+ 0.03    
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = "+3.0 mol%")

    clb = Plots.scatter([0,0],
                        [0,0],
                        zcolor          = [0,1],
                        clims           = clims,
                        xlims           = (1,1.1),
                        label           = "",
                        c               = cgrad(:RdBu, rev=rev),
                        # colorbar_title  = title,
                        framestyle      = :none)
    return f1, clb
end


"""
    get_subplot(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi;
                xlabel=false) -> (f1, clb)

Create a heatmap subplot of a scalar field in P–H₂O space. The pressure axis label is shown
only for `model ∈ ("MM", "KMout")`; the H₂O axis label is shown when `xlabel=true`.

See `get_subplot_T3` for full parameter descriptions.
"""
function get_subplot(model, pChip_wat, H, P, field, scale, mat, Li_content, dpi; xlabel = false)
    rev = true
    if field == "Li"
        title = "Li enrichment"
        mat  ./= Li_content
    elseif field == "LiMax"
        title = "Li_max[ug/g]"
    elseif field == "extraction"
        title = "Extraction event"
    elseif field == "T"
        title = "Temperature [°C]"
    elseif field == "Δbi"
        title = "Δbi_[vol]"
        rev = true
    elseif field == "Δcd"
        title = "Δcd_[vol]"
        rev = true
    elseif field == "Δmu"
        title = "Δmu_[vol]"
        rev = true
    elseif field == "eta_M"
        title = "log10(Viscosity_[Pa.s])"
    else
        error("Invalid field name")
    end

    if scale == "fixed_"
        if field == "Li"
            clims = (0.0,8.0)
        elseif field == "T"
            clims = (675.0,1175.0)
        elseif field == "extraction"
            clims = (1,10)
        elseif field == "Δbi"
            clims = (-0.2,0.2)
        elseif field == "Δcd"
            clims = (-0.25,0.25)
        elseif field == "Δmu"
            clims = (-0.15,0.15)
        else
            clims = :auto
        end
    end

    if model == "BA"
        colorbar = false
    else 
        colorbar = false
    end

    if model == "MM" || model == "KMout"
        ylabel  = "Pressure [kbar]"
        yticks  = :auto
    else 
        ylabel  = ""
        yticks  = :auto
    end

    if xlabel == false
        xlabel = ""
        xticks  = :auto
    else
        xlabel = "H₂O [mol%]"
        xticks  = :auto
    end

    f1 = Plots.heatmap(H.*100, P, mat,
                ylabel          = ylabel,
                xlabel          = xlabel,
                yticks          = yticks,
                xticks          = xticks,
                c               = cgrad(:RdBu, rev=rev),
                clims           = clims, 
                colorbar        = colorbar,
                dpi             = dpi,
                left_margin     = 10Plots.mm,
                right_margin    = 0Plots.mm,
                top_margin      = 1Plots.mm,
                bottom_margin   = 5Plots.mm,
                )

    # Overlay lines
    h = pChip_wat.(P) .- 0.03    
    h[h .< 0.005] .= NaN    
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = "-3.0 mol%")

    h = pChip_wat.(P)             
    plot!(f1, h.*100, P,
        linewidth = 4,
        linecolor = :black,
        label     = "H2O sat")

    h = pChip_wat.(P) .+ 0.03    
    plot!(f1, h.*100, P,
        linewidth = 2,
        linecolor = :black,
        label     = "+3.0 mol%")

    clb = Plots.scatter([0,0],
                        [0,0],
                        zcolor          = [0,1],
                        clims           = clims,
                        xlims           = (1,1.1),
                        label           = "",
                        c               = cgrad(:RdBu, rev=rev),
                        # colorbar_title  = title,
                        framestyle      = :none)
    return f1, clb
end



"""
    retrieve_outputs(Out_all::Array{Li_infos}, np::Int) ->
        (point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, Δst, eta_M)

Post-process a 2D (np × np) array of `Li_infos` from P–H₂O grid calculations.

For each grid point, identifies the extraction event with peak melt Li concentration and
records the phase volume changes for biotite, cordierite, muscovite, and staurolite
between the pre- and post-extraction MAGEMin outputs.

# Returns
- `point_infos`: Matrix of `(i, j, id_index)` tuples for the peak extraction event
- `Cliq_max`: Maximum melt Li [µg/g] per grid point (NaN for invalid points)
- `Extract_epi`: Extraction event index at peak Li
- `Extract_T`: Temperature [°C] at peak extraction
- `Δbi`, `Δcd`, `Δmu`, `Δst`: Volume fraction change of biotite, cordierite, muscovite, staurolite
- `eta_M`: Melt viscosity [Pa·s] at peak extraction
"""
function retrieve_outputs(Out_all, np)

    Cliq_max    = zeros(Float64, np, np);
    Extract_epi = zeros(Float64, np, np);
    Extract_T   = zeros(Float64, np, np);
    Δbi         = zeros(Float64, np, np);
    Δcd         = zeros(Float64, np, np);
    Δmu         = zeros(Float64, np, np);
    Δst         = zeros(Float64, np, np);
    eta_M       = zeros(Float64, np, np);

    point_infos = Matrix{Tuple{Int64,Int64,Int64}}(undef, np, np);
    for i = 1:np
        for j = 1:np

            compute     = false
            nval_points = 0

            if !isnothing(Out_all[i,j].ext_out_te)
                for o=2:length(Out_all[i,j].ext_out_te)
                    if !isassigned(Out_all[i,j].ext_out_te, o)
                        break
                    else
                        nval_points = o
                    end
                end
                if nval_points >= 2
                    compute = true
                end
            end

            if compute == true
                Cliq = [Out_all[i,j].ext_out_te[k].Cliq[1] for k = 2:2:nval_points]
                max_Cliq, index_Cliq = findmax(Cliq)
                
                Cliq_max[i,j]       = max_Cliq
                Extract_epi[i,j]    = index_Cliq
                id_index            = 2*index_Cliq
                Extract_T[i,j]      = Out_all[i,j].ext_out[id_index].T_C
                eta_M[i,j]          = Out_all[i,j].ext_out[id_index].eta_M
                point_infos[i,j]    = (i,j,id_index)

                # ------------------------------------------- staurolite ----------------------------------------------------#
                if "st" in Out_all[i,j].ext_out[id_index].ph
                    id_st = findfirst(Out_all[i,j].ext_out[id_index].ph .== "st")
                    st_end = Out_all[i,j].ext_out[id_index].ph_frac_vol[id_st]
                else
                    st_end = 0.0
                end
                if "st" in Out_all[i,j].ext_out[id_index-1].ph
                    id_st = findfirst(Out_all[i,j].ext_out[id_index-1].ph .== "st")
                    st_start = Out_all[i,j].ext_out[id_index-1].ph_frac_vol[id_st]
                else
                    st_start = 0.0
                end

                # ------------------------------------------- biotite ----------------------------------------------------#
                if "bi" in Out_all[i,j].ext_out[id_index].ph
                    id_bi = findfirst(Out_all[i,j].ext_out[id_index].ph .== "bi")
                    bi_end = Out_all[i,j].ext_out[id_index].ph_frac_vol[id_bi]
                else
                    bi_end = 0.0
                end
                if "bi" in Out_all[i,j].ext_out[id_index-1].ph
                    id_bi = findfirst(Out_all[i,j].ext_out[id_index-1].ph .== "bi")
                    bi_start = Out_all[i,j].ext_out[id_index-1].ph_frac_vol[id_bi]
                else
                    bi_start = 0.0
                end

                # ------------------------------------------- cordierite ----------------------------------------------------#
                if "cd" in Out_all[i,j].ext_out[id_index].ph
                    id_cd = findfirst(Out_all[i,j].ext_out[id_index].ph .== "cd")
                    cd_end = Out_all[i,j].ext_out[id_index].ph_frac_vol[id_cd]
                else
                    cd_end = 0.0
                end
                if "cd" in Out_all[i,j].ext_out[id_index-1].ph
                    id_cd = findfirst(Out_all[i,j].ext_out[id_index-1].ph .== "cd")
                    cd_start = Out_all[i,j].ext_out[id_index-1].ph_frac_vol[id_cd]
                else
                    cd_start = 0.0
                end

                # ------------------------------------------- muscovite ----------------------------------------------------#
                if "mu" in Out_all[i,j].ext_out[id_index].ph
                    id_mu = findfirst(Out_all[i,j].ext_out[id_index].ph .== "mu")
                    mu_end = sum(Out_all[i,j].ext_out[id_index].ph_frac_vol[id_mu])
                else
                    mu_end = 0.0
                end
                if "mu" in Out_all[i,j].ext_out[id_index-1].ph
                    id_mu = findall(Out_all[i,j].ext_out[id_index-1].ph .== "mu")
                    mu_start = sum(Out_all[i,j].ext_out[id_index-1].ph_frac_vol[id_mu])
                else
                    mu_start = 0.0
                end
                # -----------------------------------------------------------------------------------------------------------#

                Δbi[i,j] = bi_end - bi_start; Δbi[Δbi .== 0.0] .= NaN
                Δcd[i,j] = cd_end - cd_start; Δcd[Δcd .== 0.0] .= NaN
                Δmu[i,j] = mu_end - mu_start; Δmu[Δmu .== 0.0] .= NaN
                Δst[i,j] = st_end - st_start; Δst[Δst .== 0.0] .= NaN
            else
                Δbi[i,j]            =  NaN
                Δcd[i,j]            =  NaN
                Δmu[i,j]            =  NaN
                Δst[i,j]            =  NaN
                Cliq_max[i,j]       =  NaN
                Extract_epi[i,j]    =  NaN
                Extract_T[i,j]      =  NaN
                point_infos[i,j]    = (i,j,0)
            end

        end
    end  

    return point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, Δst, eta_M
end


"""
    retrieve_outputs_sys(Out_all, np, nss, model, ph_list, off_diag) -> (dLidKD, d2LidKD2)

Compute first- and second-order numerical sensitivities of maximum melt Li enrichment
with respect to mineral–melt partition coefficients.

Uses finite differences on the perturbed runs stored in `Out_all` (from
`perform_threaded_calc_sensitivity`) to estimate ∂Li*/∂KD and ∂²Li*/∂KD_i∂KD_j.

# Arguments
- `Out_all`: Output array `np × (3*nss + off_diag)` from sensitivity calculations
- `np`: Number of pressure points
- `nss`: Number of phases with perturbed KDs
- `model`: KD model identifier (used to retrieve base KD values for scaling)
- `ph_list`: Phase abbreviation list whose KDs were perturbed
- `off_diag`: Number of cross-term perturbation pairs

# Returns
- `dLidKD`: Matrix `(np × nss)` of first-order sensitivities ∂Li*/∂KD
- `d2LidKD2`: Matrix `(np × (nss + off_diag))` of second-order sensitivities
"""
function retrieve_outputs_sys(Out_all, np, nss, model, ph_list, off_diag)

   (el, ph, KDs)    = get_Kds_data(; model = model)
    Cliq_max        = zeros(Float64, np, nss*3 + off_diag);

    for i = 1:np
        for j = 1:nss*3+off_diag

            compute     = false
            nval_points = 0

            if !isnothing(Out_all[i,j].ext_out_te)
                for o=2:length(Out_all[i,j].ext_out_te)
                    if !isassigned(Out_all[i,j].ext_out_te, o)
                        break
                    else
                        nval_points = o
                    end
                end
                if nval_points >= 2
                    compute = true
                end
            end

            if compute == true
                Cliq = [Out_all[i,j].ext_out_te[k].Cliq[1] for k = 2:2:nval_points]
                max_Cliq, index_Cliq = findmax(Cliq)
                # Out_all[i,j].ext_out[id_index].T_C
                Cliq_max[i,j]       = max_Cliq
            else
                Cliq_max[i,j]       =  NaN
            end

        end
    end  

    dLidKD      = zeros(Float64, np, nss);
    d2LidKD2    = zeros(Float64, np, nss+off_diag);
    for i = 1:nss
        k = 3*(i-1) + 2

        id_ph   = findfirst(ph .== ph_list[i])
        x       = 1.0
        try
            x  = parse(Float64, KDs[id_ph])
        catch e
            x = 1.0
        end

        dLidKD[:,i]     = (Cliq_max[:,k+1] .- Cliq_max[:,k-1])/(2e-3) * x
        d2LidKD2[:,i]   = ((Cliq_max[:,k+1] .- Cliq_max[:,k])/(1e-3) - (Cliq_max[:,k] .- Cliq_max[:,k-1])/(1e-3))/(1e-3) * x
    end


    k=1+nss*3
    l = nss + 1
    for i=1:nss
        for j=i+1:nss
            id_ph1   = findfirst(ph .== ph_list[i])
            id_ph2   = findfirst(ph .== ph_list[j])
            x           = 1.0
            y           = 1.0
            try
                x       = parse(Float64, KDs[id_ph1])
            catch e
            end

            try
                y       = parse(Float64, KDs[id_ph2])
            catch e
            end

            row = 3*(i-1) + 2
            col = 3*(j-1) + 2
            d2LidKD2[:,l] = ((Cliq_max[:,k]  .- Cliq_max[:,col+1])/(1e-3) - (Cliq_max[:,row+1]  .- Cliq_max[:,row])/(1e-3))/(1e-3) * x
            k += 1
            l += 1
        end
    end

    return dLidKD, d2LidKD2
end


"""
    plot_output(field, Li_content, model, pChip_wat, H, P, mat, e1_liq, e1_remain;
                dpi=300, output="output/", scale="")

Plot a scalar field in P–H₂O space as a heatmap and save to disk.

Field-specific color limits and transformations are applied (e.g., log10 for viscosity,
C/C₀ normalization for Li). Water-saturation boundary lines are overlaid.

# Arguments
- `field`: One of `"Li"`, `"LiMax"`, `"extraction"`, `"T"`, `"Δbi"`, `"Δcd"`, `"Δmu"`, `"st"`, `"eta_M"`
- `Li_content`: Initial bulk Li [µg/g] (for `"Li"` normalization)
- `model`: KD model label (kept for interface consistency)
- `pChip_wat`: PCHIP interpolator for saturation H₂O vs. pressure
- `H`, `P`: H₂O and pressure axis vectors
- `mat`: Data matrix to plot
- `e1_liq`, `e1_remain`: Extraction parameters (used in the filename via `np`)

# Keyword Arguments
- `dpi`: Figure resolution (default 300)
- `output`: Output directory (default `"output/"`)
- `scale`: `"fixed_"` for hard-coded limits; otherwise `:auto`
"""
function plot_output(field, Li_content, model, pChip_wat, H, P, mat, e1_liq, e1_remain; dpi=300, output="output/", scale = "")
    rev = true
    if field == "Li"
        title = "Li_enrichment"
        mat  ./= Li_content
    elseif field == "LiMax"
        title = "Li_max[ug/g]"
    elseif field == "extraction"
        title = "Extraction_event"
    elseif field == "T"
        title = "Temperature_[°C]"
    elseif field == "Δbi"
        title = "Δbi_[vol]"
        rev = true
    elseif field == "Δcd"
        title = "Δcd_[vol]"
        rev = true
    elseif field == "mu"
        title = "Δmu_[vol]"
        rev = true
    elseif field == "st"
        title = "Δst_[vol]"
        rev = true
    elseif field == "eta_M"
        title = "log10(Viscosity_[Pa.s])"
    else
        error("Invalid field name")
    end

    if field == "eta_M"
        f1 = Plots.heatmap(H.*100, P, log10.(mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    colorbar_title = title,
                    dpi     = dpi)
    elseif field == "extraction"
        if scale == "fixed_"
            clims = (0,10)
        else
            clims = :auto
        end
        f1 = Plots.heatmap(H.*100, P, (mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    elseif field == "T"
        if scale == "fixed_"
            clims = (675,1175)
        else
            clims = :auto
        end
        f1 = Plots.heatmap(H.*100, P, (mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    elseif field == "Li"
        if scale == "fixed_"
            clims = (2.5,6.0)
        else
            clims = :auto
        end
        f1 = Plots.heatmap(H.*100, P, (mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    elseif field == "Δbi"
        if scale == "fixed_"
            clims = (-0.25,0.25)
        else
            clims = :auto
        end
        f1 = Plots.heatmap(H.*100, P, (mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    elseif field == "Δcd"
        if scale == "fixed_"
            clims = (-0.25,0.25)
        else
            clims = :auto
        end
        f1 = Plots.heatmap(H.*100, P, (mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    elseif field == "Δmu"
        if scale == "fixed_"
            clims = (-0.1,0.1)
        else
            clims = :auto
        end
        f1 = Plots.heatmap(H.*100, P, (mat),
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    else
        clims = :auto
        f1 = Plots.heatmap(H.*100, P, mat,
                    ylabel  = "Pressure [kbar]",
                    xlabel  = "H₂O [mol%]",
                    # color   = reverse(:jet),
                    c       = cgrad(:RdBu, rev=rev),
                    clims   = clims, 
                    colorbar_title = title,
                    dpi     = dpi)
    end

    h =  pChip_wat.(P) .- 0.03    
    h[h .< 0.005] .= NaN    
    plot!(h.*100,P,
                linewidth = 2,
                linecolor = :black,
                label     = "-3.0 mol%")

    h =  pChip_wat.(P)             
    plot!(h.*100,P,
                linewidth = 4,
                linecolor = :black,
                label     = "H2O sat")

    h =  pChip_wat.(P) .+ 0.03    
    plot!(h.*100,P,
                linewidth = 2,
                linecolor = :black,
                label     = "+3.0 mol%")

    Plots.savefig("$(output)$(field)_np$np.png")
end


"""
    retrieve_frac_crys_outputs(Out_all_FC, np; k=1) -> (point_infos, Cliq_max, Extract_T)

Extract Li concentration and temperature at a fixed extraction step `k` from a 2D array
of fractional crystallization results.

# Arguments
- `Out_all_FC`: 2D array of `Li_infos` (np × np) from fractional crystallization calculations
- `np`: Grid resolution

# Keyword Arguments
- `k`: Extraction step index to read (default 1)

# Returns
- `point_infos`: Matrix of `(i, j, k)` tuples for valid points
- `Cliq_max`: Melt Li [µg/g] at step `k` (NaN where absent)
- `Extract_T`: Temperature [°C] at step `k`
"""
function retrieve_frac_crys_outputs(Out_all_FC, np; k = 1)

    Cliq_max    = zeros(Float64, np, np);
    Extract_T   = zeros(Float64, np, np);
    point_infos = Matrix{Tuple{Int64,Int64,Int64}}(undef, np, np);

    for i = 1:np
        for j = 1:np
            # println("i = ", i, " j = ", j)
            if !isnothing(Out_all_FC[i,j].ext_out_te)
                if !isnothing(Out_all_FC[i,j].ext_out_te[k].Cliq)
                    Cliq = Out_all_FC[i,j].ext_out_te[k].Cliq[1]
                    Cliq_max[i,j]       = Cliq
                    Extract_T[i,j]      = Out_all_FC[i,j].ext_out[k].T_C
                    point_infos[i,j]    = (i,j,k)
                else
                    Cliq_max[i,j]       =  NaN
                    Extract_T[i,j]      =  NaN
                    point_infos[i,j]    = (i,j,0)
                end
            else
                Cliq_max[i,j]       =  NaN
                Extract_T[i,j]      =  NaN
                point_infos[i,j]    = (i,j,0)
            end

        end
    end  

    return point_infos, Cliq_max, Extract_T
end
