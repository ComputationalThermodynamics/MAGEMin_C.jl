function get_Herron_plot( all, Pin, lstyle, shape )
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
                range = [0.3, 0.7],
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
                range = [-0.0,0.5],
                gridcolor   = "lightgray",    # <-- grid line color
                gridwidth   = 0.75  
            ),
            paper_bgcolor   = "#FFF",
            plot_bgcolor    = "#FFF",
                annotations = [
                attr(
                    x = 1.2, y = 1.0, text = "Fe sand",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "center"
                ),
                attr(
                    x = 0.9, y = 0.1, text = "Litharenite",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "right"
                ),
                attr(
                    x = 1.2, y = 0.2, text = "Sublitharenite",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "left"
                ),
                attr(
                    x = 0.64, y = 0.1, text = "Wacke",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "left"
                ),
                attr(
                    x = 0.5, y = 0.1, text = "Shale",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "left"
                )
            ],
        )


        t = PlotlyJS.scatter(
            x = [0.0,1.5],
            y = [0.6,0.6],
            mode = "lines",           # or "lines+markers"
            line = attr(
                color = "black",
                width = 2
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
                width = 2
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
                width = 2
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
                width = 2
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
                width = 2
            ),
            # name = "My Line"
            showlegend = false,
        )

        bulk_db     = load_Forshaw_mp()
        FS_bulks    = get_mol_bulks(bulk_db)       #this return the list of bulk-rock compositions in molar units

        Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];

        # mol_bulk    =  [mol2wt(FS_bulks[i,:], Xoxides) for i in 1:size(FS_bulks,1)] 
        n = size(FS_bulks,1)
        mol_bulk = hcat([mol2wt(FS_bulks[i,:], Xoxides) for i in 1:n]...)

        S = sum(mol_bulk[1,:])/ n
        A = sum(mol_bulk[2,:])/ n
        F = sum(mol_bulk[5,:])/ n
        K = sum(mol_bulk[6,:])/ n


        ave = PlotlyJS.scatter(
                y       = [log10.( (F .* 1.113) ./ K)],  # x-axis values
                x       = [log10.( S ./ A)],  # y-axis values
                hoverinfo       = "skip",
                mode            = "markers+lines",
                line = attr(
                    width       = 5.0,
                    color       = :black,
                    dash        = "solid",  # line style
                ),
                marker = attr(
                    size        = 30,                # circle size
                    color       = :white,           # color by value
                    opacity     = 1.0,
                    colorscale  = "RdBu",       # or any Plotly colorscale
                    colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
                    line        = attr(width = 4.0, color = :black),
                    cmin        = 2.0,      # minimum value for color scale
                    cmax        = 12.0,      # maximum value for color scale  
                    symbol      = "diamond",  
                ),
                showlegend = false
            )
    return PlotlyJS.plot(vcat([all[i][j] for i in 1:length(all), j in 3:3]..., t, t2, t3, t4, t5, ave), layout)
end


function get_PTLi_plot( all_2, Pin, lstyle, shape )
    txtfont = 10.0
    msize   = 24.0
    T       = all_2[1][1]
    P       = Pin
    max_Li  = all_2[1][2]
    Limax   = string.(round.(max_Li,digits=1))

    PTli_KM = PlotlyJS.scatter(
        y       = P,  # x-axis values
        x       = T,  # y-axis values
        text    = Limax,                 # labels for each point
        textposition    = "middle center",      
        textfont        = attr(size=txtfont, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle[1],  # line style
        ),
        marker = attr(
            size        = msize,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.8,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
            line        = attr(width = 1.0, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale  
            symbol      = shape[1],  
        ),
        showlegend = false
    )

    T       = all_2[2][1]
    P       = Pin
    max_Li  = all_2[2][2]
    Limax   = string.(round.(max_Li,digits=1))

    PTli_BA = PlotlyJS.scatter(
        y       = P,  # x-axis values
        x       = T,  # y-axis values
        text    = Limax,                 # labels for each point
        textposition    = "middle center",      
        textfont        = attr(size=txtfont, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle[2],  # line style
        ),
        marker = attr(
            size        = msize,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.8,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
            line        = attr(width = 1.0, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale  
            symbol      = shape[2],  
        ),
        showlegend = false
    )

    T       = all_2[3][1]
    P       = Pin
    max_Li  = all_2[3][2]
    Limax   = string.(round.(max_Li,digits=1))

    PTli_MM = PlotlyJS.scatter(
        y       = P,  # x-axis values
        x       = T,  # y-axis values
        text    = Limax,                 # labels for each point
        textposition    = "middle center",      
        textfont        = attr(size=txtfont, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle[3],  # line style
        ),
        marker = attr(
            size        = msize,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.8,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
            line        = attr(width = 1.0, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale  
            symbol      = shape[3],  
        ),
        showlegend = false
    )


    T       = all_2[4][1]
    P       = Pin
    max_Li  = all_2[4][2]
    Limax   = string.(round.(max_Li,digits=1))

    PTli_MM_F = PlotlyJS.scatter(
        y       = P,  # x-axis values
        x       = T,  # y-axis values
        text    = Limax,                 # labels for each point
        textposition    = "middle center",      
        textfont        = attr(size=txtfont, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle[4],  # line style
        ),
        marker = attr(
            size        = msize,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.8,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
            line        = attr(width = 1.0, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale  
            symbol      = shape[4],  
        ),
        showlegend = false
    )

    layout2 = Layout(
        width   = 800, 
        height  = 600, 
        xaxis = attr(
            title       = "Extraction temperature [°C]",
            showline    = true,         
            linecolor   = "black",  
            linewidth   = 2,         
            mirror      = true,     
            ticks       = "outside",     
            tickwidth   = 2,
            tickcolor   = "black",
            gridcolor   = "lightgray",    # <-- grid line color
            gridwidth   = 0.75,
            autorange   = false,           # disable automatic range
            range       = [650, 1025],
        ),
        yaxis = attr(
            title       = "Pressure [kbar]",
            showline    = true,
            linecolor   = "black",
            linewidth   = 2,
            mirror      = true,
            ticks       = "outside",
            tickwidth   = 2,
            tickcolor   = "black",#
            gridcolor   = "lightgray",    # <-- grid line color
            gridwidth   = 0.75  
        ),
        paper_bgcolor   = "#FFF",
        plot_bgcolor    = "#FFF",
    )

    return PlotlyJS.plot([PTli_KM, PTli_BA, PTli_MM,PTli_MM_F],layout2)  
end

function recover_FS_pressure_diagram(min_Al, mean_Al, max_Al, min_Si, mean_Si, max_Si, min_Fe, mean_Fe, max_Fe, min_Li, mean_Li, max_Li, min_T, max_T,
                                      min_K, mean_K, max_K, width, lstyle,PTmax,shape)
     # options: "solid", "dot", "dash", "longdash", "dashdot", "longdashdot"
    A   = min_Al.*100.0
    S   = min_Si.*100.0
    F   = min_Fe.*100.0
    K   = min_K .*100.0

    id = findfirst(max_Li .> 20.0   )
    if !isnothing(id)
        max_Li[id] = (max_Li[id+1] + max_Li[id-1]) / 2.0
        A[id] = (A[id+1] + A[id-1]) / 2.0
        S[id] = (S[id+1] + S[id-1]) / 2.0
        F[id] = (F[id+1] + F[id-1]) / 2.0
        K[id] = (K[id+1] + K[id-1]) / 2.0
    end
    min = PlotlyJS.scatter(
        y       = log10.( (F .* 1.113) ./ K),  # x-axis values
        x       = log10.( S ./ A),  # y-axis values
        text    = PTmax,                 # labels for each point
        textposition    = "middle center",      
        textfont = attr(size=8, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle,  # line style
        ),
        marker = attr(
            size        = 20,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.75,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
            line        = attr(width = width, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale  
            symbol      = shape,  
        ),
        showlegend = false
    )


    A   = mean_Al.*100.0
    S   = mean_Si.*100.0
    F   = mean_Fe.*100.0
    K   = mean_K .*100.0

    meann = PlotlyJS.scatter(
        y       = log10.( (F .* 1.113) ./ K),  # x-axis values
        x       = log10.( S ./ A),  # y-axis values
        text    = PTmax,                 # labels for each point
        textposition    = "middle center",      
        textfont = attr(size=8, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle,  # line style
        ),
        marker = attr(
            size        = 20,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.75,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside", tickformat = ".1f" ),
            line        = attr(width = width, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale  
            symbol      = shape,  
        ),
        showlegend = false
    )

    A   = max_Al.*100.0
    S   = max_Si.*100.0
    F   = max_Fe.*100.0
    K   = max_K .*100.0
    id = findfirst(max_Li .> 20.0   )
    if !isnothing(id)
        max_Li[id] = (max_Li[id+1] + max_Li[id-1]) / 2.0
        A[id] = (A[id+1] + A[id-1]) / 2.0
        S[id] = (S[id+1] + S[id-1]) / 2.0
        F[id] = (F[id+1] + F[id-1]) / 2.0
        K[id] = (K[id+1] + K[id-1]) / 2.0
    end
    max = PlotlyJS.scatter(
        y       = log10.( (F .* 1.113) ./ K),  # x-axis values
        x       = log10.( S ./ A),  # y-axis values
        text    = PTmax,                 # labels for each point
        textposition    = "middle center",  
        textfont = attr(size=8, color="white"),
        hoverinfo       = "skip",
        mode            = "markers+text+lines",
        line = attr(
            width       = 1.0,
            color       = :black,
            dash        = lstyle,  # line style
        ),
        marker = attr(
            size        = 20,                # circle size
            color       = max_Li,           # color by value
            opacity     = 0.75,
            colorscale  = "RdBu",       # or any Plotly colorscale
            colorbar    = attr(title="Li*",        ticks = "outside", tickformat = ".1f" ),
            line        = attr(width = width, color = :black),
            cmin        = 2.0,      # minimum value for color scale
            cmax        = 12.0,      # maximum value for color scale   
            symbol      = shape,   
        ),
        showlegend = false
    )
    return min, meann, max
end




function plot_custom_oxides(   FS_bulks, Li_content, Xoxides, point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, Dbi, afs, pl,
                            e1_liq, e1_remain, P, Ex_H2O_sat, model; rev = true,clim = (2,6), output = "./output/")

    Δmu[isnan.(Δmu)] .= 0.0
    Δcd[isnan.(Δcd)] .= 0.0
    Δbi[isnan.(Δbi)] .= 0.0
    afs[isnan.(afs)] .= 0.0
    pl[isnan.(pl)] .= 0.0
    id_b = findall(.!isnan.(Cliq_max) .&& Cliq_max .< 2000.0)

    SiO2        = FS_bulks[id_b,findfirst(Xoxides .== "SiO2")]
    MgO         = FS_bulks[id_b,findfirst(Xoxides .== "MgO")]
    Al2O3       = FS_bulks[id_b,findfirst(Xoxides .== "Al2O3")]            
    H2O         = FS_bulks[id_b,findfirst(Xoxides .== "H2O")]
    CaO         = FS_bulks[id_b,findfirst(Xoxides .== "CaO")]            
    FeO         = FS_bulks[id_b,findfirst(Xoxides .== "FeO")]
    K2O         = FS_bulks[id_b,findfirst(Xoxides .== "K2O")]

    Plots.scatter(
        log10.(SiO2 ./ Al2O3), 
        log10.(FeO ./ K2O), 
        marker_z = Cliq_max[id_b]/Li_content, 
        colorbar = true, 
        xlabel = "log10(SiO2/Al2O3)",   
        ylabel = "log10(FeO/K2O)",
        title = "Li enrichment; P = $(round(P, digits=2)); H2O $(round(Ex_H2O_sat, digits=2))",
        legend = false,
        markeralpha = 0.8,
        markersize = 1.5,        # reduce marker size (adjust as needed)
        markerstrokewidth = 0,       # remove marker outline
        strokecolor=:transparent,
        c       = cgrad(:RdBu, rev=true),
        dpi     = dpi,
        colorbar_title = "Enrichment factor [-]",
        clim = clim
    )
    Plots.savefig("$(output)Li_FK_SA.png")


    Plots.scatter(
        (Al2O3 .- H2O .- CaO ).*100.0, 
        (SiO2 .- MgO).*100.0,# ./ Al2O3_content.*100.0, 
        marker_z = Cliq_max[id_b]/Li_content, 
        colorbar = true, 
        ylabel = "SiO2 - MgO [mol%]",   
        xlabel = "Al2O3 - CaO - H2O[mol%]",
        title = "Li enrichment; P = $(round(P, digits=2)); H2O $(round(Ex_H2O_sat, digits=2))",
        legend = false,
        markeralpha = 0.8,
        markersize = 1.5,        # reduce marker size (adjust as needed)
        markerstrokewidth = 0,       # remove marker outline
        strokecolor=:transparent,
        c       = cgrad(:RdBu, rev=true),
        dpi     = dpi,
        colorbar_title = "Enrichment factor [-]",
        clim = clim
    )
    Plots.savefig("$(output)Li_SiO2-MgO_vs_Al2O3-CaO-H2O.png")

    Plots.scatter(
        (Al2O3).*100.0, 
        (SiO2).*100.0,# ./ Al2O3_content.*100.0, 
        marker_z = Cliq_max[id_b]/Li_content, 
        colorbar = true, 
        ylabel = "SiO2 [mol%]",   
        xlabel = "Al2O3 H2O[mol%]",
        title = "Li enrichment; P = $(round(P, digits=2)); H2O $(round(Ex_H2O_sat, digits=2))",
        legend = false,
        markeralpha = 0.8,
        markersize = 1.5,        # reduce marker size (adjust as needed)
        markerstrokewidth = 0,       # remove marker outline
        strokecolor=:transparent,
        c       = cgrad(:RdBu, rev=true),
        dpi     = dpi,
        colorbar_title = "Enrichment factor [-]",
        clim = clim
    )
    Plots.savefig("$(output)Li_Al2O3_vs_SiO2.png")

    Plots.scatter(
        (Al2O3).*100.0, 
        (MgO).*100.0,# ./ Al2O3_content.*100.0, 
        marker_z = Cliq_max[id_b]/Li_content, 
        colorbar = true, 
        ylabel = "MgO [mol%]",   
        xlabel = "Al2O3[mol%]",
        title = "Li enrichment; P = $(round(P, digits=2)); H2O $(round(Ex_H2O_sat, digits=2))",
        legend = false,
        markeralpha = 0.8,
        markersize = 1.5,        # reduce marker size (adjust as needed)
        markerstrokewidth = 0,       # remove marker outline
        strokecolor=:transparent,
        c       = cgrad(:RdBu, rev=true),
        dpi     = dpi,
        colorbar_title = "Enrichment factor [-]",
        clim = clim
    )
    Plots.savefig("$(output)Li_Al2O3_vs_MgO.png")


    # Create the ternary plot
    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Cliq_max[id_b]/Li_content,
                            colorscale  = "Bluered",#"RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Li enrichment"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            cmin        = clim[1],      # minimum value for color scale
                            cmax        = clim[2],      # maximum value for color scale              
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)ASM_Li.png",scale = 2.0)


    ########################################
    #=           DELTA CORDIERITE         =#
    ########################################

    data = Δcd[id_b] .* 100.0
    data = filter(!isnan, data)


    n = length(data)
    n10 = max(1, round(Int, 0.1 * n))

    # Sort data
    sorted_data = sort(data)

    # Average of lowest 10%
    low10_avg = mean(sorted_data[1:n10])

    # Average of highest 10%
    high10_avg = mean(sorted_data[end-n10+1:end])
    val = maximum([abs.(low10_avg), abs.(high10_avg)])
    clim = (-val, val)
    println("Δcd color scale limits: $clim")
    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Δcd[id_b].*100.0,
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Δcd [vol%]"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            cmin        = clim[1],      # minimum value for color scale
                            cmax        = clim[2],      # maximum value for color scale              
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)Δcd_vol.png",scale = 2.0)


    ########################################
    #=            DELTA BIOTITE           =#
    ########################################

    data = Δbi[id_b] .* 100.0
    data = filter(!isnan, data)

    n = length(data)
    n10 = max(1, round(Int, 0.1 * n))

    # Sort data
    sorted_data = sort(data)

    # Average of lowest 10%
    low10_avg = mean(sorted_data[1:n10])

    # Average of highest 10%
    high10_avg = mean(sorted_data[end-n10+1:end])
    val = maximum([abs.(low10_avg), abs.(high10_avg)])
    # println("low10_avg: $low10_avg, high10_avg: $high10_avg")
    clim = (-val, val)
    println("Δbi color scale limits: $clim")
    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Δbi[id_b].*100.0,
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Δbi [vol%]"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            cmin        = clim[1],      # minimum value for color scale
                            cmax        = clim[2],      # maximum value for color scale              
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)Δbi_vol.png",scale = 2.0)



    ########################################
    #=           DELTA MUSCOVITE          =#
    ########################################


    data = Δmu[id_b] .* 100.0
    data = filter(!isnan, data)

    n = length(data)
    n10 = max(1, round(Int, 0.1 * n))

    # Sort data
    sorted_data = sort(data)

    # Average of lowest 10%
    low10_avg = mean(sorted_data[1:n10])

    # Average of highest 10%
    high10_avg = mean(sorted_data[end-n10+1:end])
    val = maximum([abs.(low10_avg), abs.(high10_avg)])
    println("Δmu color scale limits: $clim")
    clim = (-val, val)
    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Δmu[id_b].*100.0,
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Δmu [vol%]"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            cmin        = clim[1],      # minimum value for color scale
                            cmax        = clim[2],      # maximum value for color scale              
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)Δmu_vol.png",scale = 2.0)


    ########################################
    #=            AFS           =#
    ########################################

    data = afs[id_b] .* 100.0
    data = filter(!isnan, data)

    n = length(data)
    n10 = max(1, round(Int, 0.1 * n))

    # Sort data
    sorted_data = sort(data)

    # Average of lowest 10%
    low10_avg = mean(sorted_data[1:n10])

    # Average of highest 10%
    high10_avg = mean(sorted_data[end-n10+1:end])
    val = maximum([abs.(low10_avg), abs.(high10_avg)])
    # println("low10_avg: $low10_avg, high10_avg: $high10_avg")
    clim = (-val, val)
    println("afs color scale limits: $clim")
    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = afs[id_b].*100.0,
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="afs [vol%]"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            cmin        = clim[1],      # minimum value for color scale
                            cmax        = clim[2],      # maximum value for color scale              
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)afs_vol.png",scale = 2.0)



    ########################################
    #=            PL           =#
    ########################################

    data = pl[id_b] .* 100.0
    data = filter(!isnan, data)

    n = length(data)
    n10 = max(1, round(Int, 0.1 * n))

    # Sort data
    sorted_data = sort(data)

    # Average of lowest 10%
    low10_avg = mean(sorted_data[1:n10])

    # Average of highest 10%
    high10_avg = mean(sorted_data[end-n10+1:end])
    val = maximum([abs.(low10_avg), abs.(high10_avg)])
    # println("low10_avg: $low10_avg, high10_avg: $high10_avg")
    clim = (-val, val)
    println("pl color scale limits: $clim")
    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = pl[id_b].*100.0,
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="pl [vol%]"),
                            line        = attr(width = 0.0, color = "RdBu"),
                            cmin        = clim[1],      # minimum value for color scale
                            cmax        = clim[2],      # maximum value for color scale              
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)pl_vol.png",scale = 2.0)



    ########################################

    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Extract_T[id_b],
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="T°C"),
                            line        = attr(width = 0.0, color = "RdBu")
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,

        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)ASM_T_extraction.png",scale = 2.0)


    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Extract_epi[id_b],
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Extraction #"),
                            line        = attr(width = 0.0, color = "RdBu")
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,
    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)ASM_Extraction_episode.png",scale = 2.0)


    A   = Al2O3
    S   = SiO2
    M   = MgO
    Mn   = MgO
    afm = scatterternary(
        a       = S,
        b       = A,
        c       = M,
        mode    = "markers",
        hoverinfo   = "skip",
        opacity     = 0.8,
        marker  = attr(     size        = 3.0,
                            color       = Dbi[id_b],
                            colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                            colorbar    = attr(title="Kd biotite"),
                            line        = attr(width = 0.0, color = "RdBu")
        ),
        name    = "Sample Points"
    )
    
    layout_afm = Layout(
        title= attr(
            text    = "ASM Diagram [mol%]",
            x       = 0.2,
            xanchor = "center",
            yanchor = "top"
        ),
        ternary=attr(
            sum     = 100,
            aaxis   = attr(title="S [SiO2]" ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=65, max=95),
            baxis   = attr(title="A [Al2O3]",   gridcolor     = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=5, max=25),
            caxis   = attr(title="M [MgO]"  ,   gridcolor   = "darkgray",
                                                showline    =  true,
                                                linecolor   = "darkgray",
                                                min=0, max=20),
            bgcolor = "#FFF",
            width       = 860,
            height      = 520,

    
        ),
        paper_bgcolor = "#FFF",
    )
    PlotlyJS.savefig(PlotlyJS.plot(afm, layout_afm), "$(output)ASM_Kd_biotite.png",scale = 2.0)

    # calculate mean, std, min, max, median of Cliq_max_filtered
    Cliq_max_filtered   = Cliq_max[id_b]./Li_content
    FS_bulks_filtered   = FS_bulks[id_b, :]
    Extract_T_filtered  = Extract_T[id_b]
    Extract_epi_filtered = Extract_epi[id_b]
    Δbi_filtered = Δbi[id_b]
    Δcd_filtered = Δcd[id_b]
    Δmu_filtered = Δmu[id_b]

    mean_Cliq   = mean(Cliq_max_filtered)
    std_Cliq    = std(Cliq_max_filtered)
    # min_Cliq = minimum(Cliq_max_filtered)
    # max_Cliq = maximum(Cliq_max_filtered)
    median_Cliq = median(Cliq_max_filtered)

    Plots.histogram(
        Cliq_max_filtered,
        bins = 60,                          # adjust number of bins as needed
        xlabel = "Li enrichment (normalized)",
        ylabel = "Count",
        title = "Distribution of Li enrichment",
        legend = false
    )

    id_mean         = findall(Cliq_max_filtered .<= mean_Cliq + std_Cliq .&& Cliq_max_filtered .>= median_Cliq - std_Cliq)
    mean_mean_bulk  = mean(FS_bulks_filtered[id_mean, :], dims=1)
    mean_mean_Li    = mean(Cliq_max_filtered[id_mean, :], dims=1)
    mean_mean_T     = mean(Extract_T_filtered[id_mean])
    mean_mean_epi   = mean(Extract_epi_filtered[id_mean])
    mean_mean_Δbi   = mean(Δbi_filtered[id_mean])
    mean_mean_Δcd   = mean(Δcd_filtered[id_mean])
    mean_mean_Δmu   = mean(Δmu_filtered[id_mean])

    mean_mean = (mean_mean_bulk, mean_mean_Li, mean_mean_T, mean_mean_epi, mean_mean_Δbi, mean_mean_Δcd, mean_mean_Δmu)

    id_max          = findall(Cliq_max_filtered .> median_Cliq + std_Cliq)
    mean_max_bulk   = mean(FS_bulks_filtered[id_max, :], dims=1)
    mean_max_Li     = mean(Cliq_max_filtered[id_max, :], dims=1)
    mean_max_T      = mean(Extract_T_filtered[id_max])
    mean_max_epi    = mean(Extract_epi_filtered[id_max])
    mean_max_Δbi    = mean(Δbi_filtered[id_max])
    mean_max_Δcd    = mean(Δcd_filtered[id_max])
    mean_max_Δmu    = mean(Δmu_filtered[id_max])    

    mean_max = (mean_max_bulk, mean_max_Li, mean_max_T, mean_max_epi, mean_max_Δbi, mean_max_Δcd, mean_max_Δmu)

    id_min          = findall(Cliq_max_filtered .< median_Cliq - std_Cliq)
    mean_min_bulk   = mean(FS_bulks_filtered[id_min, :], dims=1)
    mean_min_Li     = mean(Cliq_max_filtered[id_min, :], dims=1)
    mean_min_T      = mean(Extract_T_filtered[id_min])
    mean_min_epi    = mean(Extract_epi_filtered[id_min])
    mean_min_Δbi    = mean(Δbi_filtered[id_min])
    mean_min_Δcd    = mean(Δcd_filtered[id_min])
    mean_min_Δmu    = mean(Δmu_filtered[id_min])

    mean_min = (mean_min_bulk, mean_min_Li, mean_min_T, mean_min_epi, mean_min_Δbi, mean_min_Δcd, mean_min_Δmu)

    @save "$(output)Li_enrichment_stats.jld2" mean_mean mean_max mean_min


    layout_herron = Layout(
            xaxis = attr(
                title       = "log10(SiO2/Al2O3)",
                showline    = true,         
                linecolor   = "black",  
                linewidth   = 2,         
                mirror      = true,     
                ticks       = "outside",     
                tickwidth   = 2,
                tickcolor   = "black",
                range = [0.3, 0.7],
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
                range = [-0.0,0.5],
                gridcolor   = "lightgray",    # <-- grid line color
                gridwidth   = 0.75  
            ),
            paper_bgcolor   = "#FFF",
            plot_bgcolor    = "#FFF",
                annotations = [
                attr(
                    x = 1.1, y = 1.0, text = "Fe sand",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "center"
                ),
                attr(
                    x = 0.95, y = 0.1, text = "Litharenite",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "right"
                ),
                attr(
                    x = 1.3, y = 0.2, text = "Sublitharenite",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "left"
                ),
                attr(
                    x = 0.64, y = 0.1, text = "Wacke",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "left"
                ),
                attr(
                    x = 0.5, y = 0.1, text = "Shale",
                    xref = "x", yref = "y",
                    showarrow = false,
                    font = attr(size=16, color="black"),
                    align = "left"
                )
            ],
        )


        t1 = PlotlyJS.scatter(
            x = [0.0,1.8],
            y = [0.6,0.6],
            mode = "lines",           # or "lines+markers"
            line = attr(
                color = "black",
                width = 2
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
                width = 2
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
                width = 2
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
                width = 2
            ),
            # name = "My Line"
            showlegend = false,
        )
        t5 = PlotlyJS.scatter(
            x = [0.765,1.8],
            y = [0.0,0.0],
            mode = "lines",           # or "lines+markers"
            line = attr(
                color = "black",
                width = 2
            ),
            # name = "My Line"
            showlegend = false,
        )


        Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
        n = length(id_b)

        mol_bulk = hcat([mol2wt(FS_bulks[id_b[i],:], Xoxides) for i in 1:n]...)

        S = mol_bulk[1,:]
        A = mol_bulk[2,:]
        F = mol_bulk[5,:]
        K = mol_bulk[6,:]


        all = PlotlyJS.scatter(
                y       = log.( (F .* 1.113) ./ K),  # x-axis values
                x       = log.( S ./ A),  # y-axis values
                hoverinfo       = "skip",
                mode            = "markers",
                marker = attr(
                    size        = 4,                # circle size
                    color       = Cliq_max[id_b]/Li_content,           # color by value
                    opacity     = 1.0,
                    colorscale  = "RdBu",       # or any Plotly colorscale
                    colorbar    = attr(title="Li*",        ticks = "outside",  tickformat = ".1f"),
                    line        = attr(width = 0.0, color = :black),
                    cmin        = 2.0,      # minimum value for color scale
                    cmax        = 10.0,      # maximum value for color scale  
                    # symbol      = "diamond",  
                ),
                showlegend = false
            )

    PlotlyJS.savefig(PlotlyJS.plot([t1,t2,t3,t4,t5,all], layout_herron), "$(output)Herron_classification.png",scale = 2.0)



    return nothing
end


function plot_all_oxides(   FS_bulks, Li_content, Xoxides, point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu,
                            e1_liq, e1_remain, P, Ex_H2O_sat, model; rev = true, clim = (2,6), output = "./output/")

    plot_ox     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "MnO"; "H2O"];
    id_oxs      = [i for i in eachindex(Xoxides) if Xoxides[i] in plot_ox]

    n           = length(id_oxs)  # Number of oxides to plot

    id_b = findall(.!isnan.(Cliq_max))

    default(
        guidefont = font(8),   # Axis label font size
        tickfont = font(6),    # Tick label font size
        legendfont = font(6),  # Legend font size
        titlefont = font(8),   # Title font size
        markersize = 1.0
    )
    plots = [Plots.scatter(   FS_bulks[id_b,id_oxs[i]], 
                        FS_bulks[id_b,id_oxs[j]], 
                        marker_z            = Cliq_max[id_b]./Li_content, 
                        # colorbar    = true, 
                        # xlabel      = "$(Xoxides[id_oxs[i]]) [mol%]", 
                        # ylabel      = "$(Xoxides[id_oxs[j]]) [mol%]", 
                        xguide              = "$(Xoxides[id_oxs[i]]) [mol%]", 
                        yguide              = "$(Xoxides[id_oxs[j]]) [mol%]", 
                        # title               = "P = $(round(P, digits=2)); H2O $(round(Ex_H2O_sat, digits=2))",
                        legend              = false,
                        markeralpha         = 0.8,
                        markersize          = 1.5,
                        markerstrokewidth   = 0,       
                        strokecolor         =:transparent,
                        c                   = cgrad(:RdBu, rev=true),
                        dpi                 = 400,
                        colorbar_title      = "Li enrichment",
                        clim                = clim
                        ) for i in 1:n, j in 1:n]

    all_oxides_plot  = Plots.plot(plots..., layout=(n, n), size=(2400, 2400))
    Plots.savefig(all_oxides_plot, "$(output)Oxides_vs_oxides.png")

    return nothing
end


"""
This script is used to plot the output of the TE_MAGEMin_C_frac.jl script.
"""
function retrieve_outputs_FS(Out_all, np, KDs_database, output)

    Cliq_max    = zeros(Float64, np);
    Extract_epi = zeros(Float64, np);
    Extract_T   = zeros(Float64, np);
    Δbi         = zeros(Float64, np);
    Δcd         = zeros(Float64, np);
    Δmu         = zeros(Float64, np);
    afs         = zeros(Float64, np);
    pl          = zeros(Float64, np);
    eta_M       = zeros(Float64, np);
    Dbi         = zeros(Float64, np);
    point_infos = Vector{Tuple{Int64,Int64}}(undef, np);


    eq_out      = Vector{out_struct}(undef,np)
    eq_te_out   = Vector{out_TE_struct}(undef,np)

    for i = 1:np
        compute     = false
        nval_points = 0
        if !isnothing(Out_all[i].ext_out_te)
            for o=2:length(Out_all[i].ext_out_te)
                if !isassigned(Out_all[i].ext_out_te, o)
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
            Cliq = [Out_all[i].ext_out_te[k].Cliq[1] for k = 2:2:nval_points]
            Cliq[isnan.(Cliq)] .= 0.0  # Replace NaN with 0.0 for Cliq
            max_Cliq, index_Cliq = findmax(Cliq)


            eq_out[i]       = Out_all[i].ext_out[index_Cliq]
            eq_te_out[i]    = Out_all[i].ext_out_te[index_Cliq]

            if max_Cliq > 100.0
                
                Cliq_max[i]       = max_Cliq
                Extract_epi[i]    = index_Cliq
                id_index          = 2*index_Cliq
                Extract_T[i]      = Out_all[i].ext_out[id_index].T_C
                eta_M[i]          = Out_all[i].ext_out[id_index].eta_M


                if "bi" in Out_all[i].ext_out[id_index].ph
                    out               = Out_all[i].ext_out[id_index]
                    expr              = KDs_database.KDs_expr[2]
                    Dbi[i]            = Base.invokelatest(expr, out)
                else
                    Dbi[i]            = NaN
                end
                

                point_infos[i]    = (i,id_index)

                # ------------------------------------------- biotite ----------------------------------------------------#
                if "bi" in Out_all[i].ext_out[id_index].ph
                    id_bi = findfirst(Out_all[i].ext_out[id_index].ph .== "bi")
                    bi_end = Out_all[i].ext_out[id_index].ph_frac_vol[id_bi]
                else
                    bi_end = 0.0
                end
                if "bi" in Out_all[i].ext_out[id_index-1].ph
                    id_bi = findfirst(Out_all[i].ext_out[id_index-1].ph .== "bi")
                    bi_start = Out_all[i].ext_out[id_index-1].ph_frac_vol[id_bi]
                else
                    bi_start = 0.0
                end

                # ------------------------------------------- cordierite ----------------------------------------------------#
                if "cd" in Out_all[i].ext_out[id_index].ph
                    id_cd = findfirst(Out_all[i].ext_out[id_index].ph .== "cd")
                    cd_end = Out_all[i].ext_out[id_index].ph_frac_vol[id_cd]
                else
                    cd_end = 0.0
                end
                if "cd" in Out_all[i].ext_out[id_index-1].ph
                    id_cd = findfirst(Out_all[i].ext_out[id_index-1].ph .== "cd")
                    cd_start = Out_all[i].ext_out[id_index-1].ph_frac_vol[id_cd]
                else
                    cd_start = 0.0
                end

                # ------------------------------------------- muscovite ----------------------------------------------------#
                if "mu" in Out_all[i].ext_out[id_index].ph
                    id_mu = findfirst(Out_all[i].ext_out[id_index].ph .== "mu")
                    mu_end = sum(Out_all[i].ext_out[id_index].ph_frac_vol[id_mu])
                else
                    mu_end = 0.0
                end
                if "mu" in Out_all[i].ext_out[id_index-1].ph
                    id_mu = findall(Out_all[i].ext_out[id_index-1].ph .== "mu")
                    mu_start = sum(Out_all[i].ext_out[id_index-1].ph_frac_vol[id_mu])
                else
                    mu_start = 0.0
                end
                # -----------------------------------------------------------------------------------------------------------#
                if "afs" in Out_all[i].ext_out[id_index].ph
                    id_afs = findfirst(Out_all[i].ext_out[id_index].ph .== "afs")
                    afs_end = Out_all[i].ext_out[id_index].ph_frac_vol[id_afs]
                else
                    afs_end = 0.0
                end
                afs[i] = afs_end

                if "pl" in Out_all[i].ext_out[id_index].ph
                    id_pl = findfirst(Out_all[i].ext_out[id_index].ph .== "pl")
                    pl_end = Out_all[i].ext_out[id_index].ph_frac_vol[id_pl]
                else
                    pl_end = 0.0
                end
                pl[i] = pl_end

                Δbi[i] = bi_end - bi_start; Δbi[Δbi .== 0.0] .= NaN
                Δcd[i] = cd_end - cd_start; Δcd[Δcd .== 0.0] .= NaN
                Δmu[i] = mu_end - mu_start; Δmu[Δmu .== 0.0] .= NaN

            else
                afs[i]            =  NaN
                pl[i]             =  NaN
                Δbi[i]            =  NaN
                Δcd[i]            =  NaN
                Δmu[i]            =  NaN
                Cliq_max[i]       =  NaN
                Extract_epi[i]    =  NaN
                Extract_T[i]      =  NaN
                point_infos[i]    = (i,0)
            end
        else
            afs[i]            =  NaN
            pl[i]             =  NaN
            Δbi[i]            =  NaN
            Δcd[i]            =  NaN
            Δmu[i]            =  NaN
            Cliq_max[i]       =  NaN
            Extract_epi[i]    =  NaN
            Extract_T[i]      =  NaN
            point_infos[i]    = (i,0)
        end

    end  

    @save "$(output)out_struct.jld2" eq_out eq_te_out Cliq_max Extract_epi Extract_T Δbi Δcd Δmu eta_M Dbi afs pl

    return point_infos, Cliq_max, Extract_epi, Extract_T, Δbi, Δcd, Δmu, eta_M, Dbi, afs, pl
end
