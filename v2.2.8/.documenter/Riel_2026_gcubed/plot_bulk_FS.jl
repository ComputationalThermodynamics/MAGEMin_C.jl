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

using ScatteredInterpolation

# Create interpolated grid for plagioclase using inverse distance weighting
"""
    create_heatmap_data_scattered(x_vals, y_vals, z_vals, grid_size=50) ->
        (x_range, y_range, Z_grid)

Interpolate scattered 2D data onto a regular grid using inverse distance weighting (IDW).

Filters NaN and Inf values, constructs a uniform grid over the data extent, and fills each
cell with a distance-power-2 weighted average of the surrounding data points.

# Arguments
- `x_vals`, `y_vals`: Scattered coordinate vectors
- `z_vals`: Scalar values at each (x, y) point
- `grid_size`: Number of grid points per axis (default 50)

# Returns
- `x_range`, `y_range`: Regular axis vectors of length `grid_size`
- `Z_grid`: Interpolated value matrix of size `(grid_size, grid_size)`
"""
function create_heatmap_data_scattered(x_vals, y_vals, z_vals, grid_size=50)
    # Remove any NaN or infinite values
    valid_idx = .!isnan.(x_vals) .& .!isnan.(y_vals) .& .!isnan.(z_vals) .& 
                .!isinf.(x_vals) .& .!isinf.(y_vals) .& .!isinf.(z_vals)
    
    x_clean = x_vals[valid_idx]
    y_clean = y_vals[valid_idx]
    z_clean = z_vals[valid_idx]
    
    # Create regular grid
    x_range = range(minimum(x_clean), maximum(x_clean), length=grid_size)
    y_range = range(minimum(y_clean), maximum(y_clean), length=grid_size)
    
    # Simple inverse distance weighted interpolation
    function idw_interpolation(xi, yi, x_data, y_data, z_data; power=2)
        distances = sqrt.((x_data .- xi).^2 .+ (y_data .- yi).^2)
        distances[distances .< 1e-10] .= 1e-10  # Avoid division by zero
        weights = 1 ./ (distances.^power)
        return sum(weights .* z_data) / sum(weights)
    end
    
    # Interpolate z values onto grid
    Z_grid = zeros(length(y_range), length(x_range))
    for i in 1:length(y_range), j in 1:length(x_range)
        Z_grid[i, j] = idw_interpolation(x_range[j], y_range[i], x_clean, y_clean, z_clean)
    end
    
    return collect(x_range), collect(y_range), Z_grid
end

"""
    plot_bulk_FS(ext_out, P, np, FS_bulks, n_ee)

Plot phase proportions of the Forshaw & Pattison pelite suite in Herron classification space
(log SiO₂/Al₂O₃ vs. log FeO/K₂O), colored by total Q+A+P (quartz + alkali feldspar +
plagioclase) volume fraction, and save as PNG files.

Extracts quartz, plagioclase, alkali feldspar, garnet, biotite, muscovite, cordierite, and
ilmenite fractions, sums Q+A+P, and produces both a scatter plot and an IDW-interpolated
heatmap overlaid with Herron boundary lines.

# Arguments
- `ext_out`: Vector of MAGEMin equilibrium output structs (length np)
- `P`: Pressure [kbar] (used in output filename)
- `np`: Number of bulk compositions
- `FS_bulks`: Matrix (np × n_ox) of molar bulk compositions
- `n_ee`: Number of extraction events (used in output filename)
"""
function plot_bulk_FS(ext_out,  P,  np, FS_bulks, n_ee)

    # bulk_db     = load_Forshaw_mp()
    # FS_bulks    = get_mol_bulks(bulk_db)       #this return the list of bulk-rock compositions in molar units

    Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];

    # mol_bulk    =  [mol2wt(FS_bulks[i,:], Xoxides) for i in 1:size(FS_bulks,1)] 
    n = size(FS_bulks,1)
    mol_bulk = hcat([mol2wt(FS_bulks[i,:], Xoxides) for i in 1:n]...)

    S = sum.(mol_bulk[1,:])/ n
    A = sum.(mol_bulk[2,:])/ n
    F = sum.(mol_bulk[5,:])/ n
    K = sum.(mol_bulk[6,:])/ n


    q_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "q" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "q")
                q_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                q_vol[i] = 0.0
            end
        end
    end

    pl_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "pl" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "pl")
                pl_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                pl_vol[i] = 0.0
            end
        end
    end

    afs_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "afs" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "afs")
                afs_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                afs_vol[i] = 0.0
            end
        end
    end

    sill_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "sill" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "sill")
                sill_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                sill_vol[i] = 0.0
            end
        end
    end

    g_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)   
            if "g" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "g")
                g_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                g_vol[i] = 0.0
            end
        end
    end 

    bi_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "bi" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "bi")
                bi_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                bi_vol[i] = 0.0
            end
        end
    end

    mu_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "mu" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "mu")
                mu_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                mu_vol[i] = 0.0
            end
        end
    end 

    cd_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "cd" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "cd")
                cd_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                cd_vol[i] = 0.0
            end
        end
    end 
    
    ilm_vol = zeros(np)
    for i=1:np
        if isassigned(ext_out, i)
            if "ilm" in ext_out[i].ph
                id = findfirst(ext_out[i].ph .== "ilm")
                ilm_vol[i] = ext_out[i].ph_frac_vol[id]
            else
                ilm_vol[i] = 0.0
            end
        end
    end


    pl_vol = (afs_vol .+ pl_vol .+ q_vol)
    t = PlotlyJS.scatter(
        x = [0.0,1.5],
        y = [0.6,0.6],
        mode = "lines",           # or "lines+markers"
        line = attr(
            color = "black",
            width = 1
        ),
        # name = "My Line"
        showlegend = false,
    )
    t2 = PlotlyJS.scatter(
        x = [0.55,0.71,0.71],
        y = [-0.11,0.6,1.5],
        mode = "lines",           # or "lines+markers"
        line = attr(
            color = "black",
            width = 1
        ),
        # name = "My Line"
        showlegend = false,
    )
    t3 = PlotlyJS.scatter(
        x = [0.65,0.9],
        y = [-0.5,0.6],
        mode = "lines",           # or "lines+markers"
        line = attr(
            color = "black",
            width = 1
        ),
        # name = "My Line"
        showlegend = false,
    )
    t4 = PlotlyJS.scatter(
        x = [1.04,1.139],
        y = [-0.5,0.6],
        mode = "lines",           # or "lines+markers"
        line = attr(
            color = "black",
            width = 1
        ),
        # name = "My Line"
        showlegend = false,
    )
    t5 = PlotlyJS.scatter(
        x = [0.765,1.5],
        y = [0.0,0.0],
        mode = "lines",           # or "lines+markers"
        line = attr(
            color = "black",
            width = 1
        ),
        # name = "My Line"
        showlegend = false,
    )


    # Calculate the log ratios
    x_vals = log10.(S ./ A)  # log10(SiO2/Al2O3)
    y_vals = log10.(F ./ K)  # log10(FeO/K2O)


    pl_vol_mean = mean(pl_vol).*100.0
    pl_vol_std = std(pl_vol).*100.0


    # Create the scatter plot
    scatter_plot = PlotlyJS.scatter(
        x = x_vals,
        y = y_vals,
        mode = "markers",
        opacity     = 0.8,
        marker  = attr(     size        = 5.0,
                            color       = pl_vol.*100.0,
                            opacity     = 0.7,
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Q+A+P [vol%]", titleside="right"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            # symbol      = "circle-open",
                            cmin        = pl_vol_mean - pl_vol_std,              # minimum value for color scale
                            cmax        = pl_vol_mean + pl_vol_std
        ),
        name = ""
    )

    layout = Layout(
                xaxis = attr(
                    title       = "log10(SiO2/Al2O3)",
                    showline    = true,         
                    linecolor   = "black",  
                    linewidth   = 2,         
                    mirror      = true,     
                    ticks       = "outside",     
                    tickwidth   = 2,
                    tickcolor   = "black",
                    range = [0.2, 0.8],
                    gridcolor   = "lightgray",    # <-- grid line color
                    gridwidth   = 0.75  
                ),
                yaxis = attr(
                    title       = "log10(Fe2O3/K2O)",
                    showline    = true,
                    linecolor   = "black",
                    linewidth   = 2,
                    mirror      = true,
                    ticks       = "outside",
                    tickwidth   = 2,
                    tickcolor   = "black",
                    range = [-0.3,0.8],
                    gridcolor   = "lightgray",    # <-- grid line color
                    gridwidth   = 0.75  
                ),
                paper_bgcolor   = "#FFF",
                plot_bgcolor    = "#FFF",
            )

    PlotlyJS.savefig(PlotlyJS.plot([scatter_plot,t,t2,t3,t4,t5], layout), "$(string(n_ee))e_$(string(P))_kbar_pl.png",scale = 2.0)


    # Create interpolated grid for plagioclase
    x_grid, y_grid, z_grid = create_heatmap_data_scattered(x_vals, y_vals, pl_vol.*100.0, 64)

    # Create heatmap
    heatmap_plot = PlotlyJS.heatmap(
        x = x_grid,
        y = y_grid,
        z = z_grid,
        colorscale = "RdBu",
        colorbar = attr(title="Plagioclase [vol%]", titleside="right"),
        zmin = pl_vol_mean - pl_vol_std,
        zmax = pl_vol_mean + pl_vol_std,
        name = "Plagioclase Heatmap",
            # zmax = pl_vol_mean + pl_vol_std,
        # zsmooth = "best",  # Enable smoothing (options: false, "fast", "best")
    )

    # Create layout for heatmap (same as your scatter layout)
    layout_heatmap = Layout(
        xaxis = attr(
            title = "log10(SiO2/Al2O3)",
            showline = true,         
            linecolor = "black",  
            linewidth = 2,         
            mirror = true,     
            ticks = "outside",     
            tickwidth = 2,
            tickcolor = "black",
            range = [0.2, 0.8],
            gridcolor = "lightgray",
            gridwidth = 0.75  
        ),
        yaxis = attr(
            title = "log10(Fe2O3/K2O)",
            showline = true,
            linecolor = "black",
            linewidth = 2,
            mirror = true,
            ticks = "outside",
            tickwidth = 2,
            tickcolor = "black",
            range = [-0.3, 0.8],
            gridcolor = "lightgray",
            gridwidth = 0.75  
        ),
        paper_bgcolor = "#FFF",
        plot_bgcolor = "#FFF"
    )

    # Plot heatmap with overlaid lines
    PlotlyJS.savefig(PlotlyJS.plot([heatmap_plot, t, t2, t3, t4, t5], layout_heatmap), 
                    "$(string(n_ee))e_$(string(P))_kbar_pl_heatmap.png", scale = 2.0)


    return nothing
end
