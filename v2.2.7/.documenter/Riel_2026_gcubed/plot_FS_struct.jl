using JLD2, PlotlyJS, Plots, Statistics
using MAGEMin_C
model       = "MM"              # KM, MM
FC          = false             # if true, perform fractional crystallization
test        = false             # if true, only test on a small subset of the bulk-rock compositions
dpi         = 300
fake_F_bi   = false
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
Pin          = [2.0:1.0:15.0;]; 
# Pin         = [2.0]
Ex_H2O_sat  = 0.0;   
e1_liq      = 7.0;
e1_remain   = 1.0;

# P = 2.0
for P in Pin
    simu        = "FS_dtb_$(model)_P$(round(P, digits=2))kbar_H$(round(Ex_H2O_sat, digits=2))_e$(e1_liq)_r$(e1_remain)"
    output      = "$(out_dir)/$(model)/$(simu)/"

    FS_data = @load "$(output)out_struct.jld2" eq_out eq_te_out Cliq_max Extract_epi Extract_T Δbi Δcd Δmu eta_M Dbi

    FS_data = JLD2.jldopen("$(output)out_struct.jld2") do file
        Dict(
            :eq_out     => read(file, "eq_out"),
            :eq_te_out  => read(file, "eq_te_out"),
            :Cliq_max   => read(file, "Cliq_max"),
            :Extract_epi  => read(file, "Extract_epi"),
            :Extract_T  => read(file, "Extract_T"),
            :Δbi        => read(file, "Δbi"),
            :Δcd        => read(file, "Δcd"),
            :Δmu        => read(file, "Δmu"),
            :eta_M      => read(file, "eta_M"),
            :Dbi        => read(file, "Dbi"),
        )
    end
# end    

np      = length(eq_out)
bulk_S  = [eq_out[i].bulk_S_wt for i = 1:np]

id_al   = findfirst(eq_out[1].oxides .== "Al2O3")
id_si   = findfirst(eq_out[1].oxides .== "SiO2")
id_fe   = findfirst(eq_out[1].oxides .== "FeO")
id_mg   = findfirst(eq_out[1].oxides .== "MgO")
id_h2o  = findfirst(eq_out[1].oxides .== "H2O")
id_k2o  = findfirst(eq_out[1].oxides .== "K2O")

sum_dry = [sum(bulk_S[i][1:end-1]) for i = 1:np]  # Exclude H2O from the sum


A       = [bulk_S[i][id_al] for i = 1:np]   ./sum_dry.*100.0
S       = [bulk_S[i][id_si] for i = 1:np]   ./sum_dry.*100.0
F       = [bulk_S[i][id_fe] for i = 1:np]   ./sum_dry.*100.0
M       = [bulk_S[i][id_mg] for i = 1:np]   ./sum_dry.*100.0
K       = [bulk_S[i][id_k2o] for i = 1:np]  ./sum_dry.*100.0


max_Li  = [eq_te_out[i].Cliq[1] for i = 1:np]./100.0

id = findfirst(max_Li .> 20.0   )
if !isnothing(id)
    max_Li[id] = (max_Li[id+1] + max_Li[id-1]) / 2.0
    A[id] = (A[id+1] + A[id-1]) / 2.0
    S[id] = (S[id+1] + S[id-1]) / 2.0
    F[id] = (F[id+1] + F[id-1]) / 2.0
    M[id] = (M[id+1] + M[id-1]) / 2.0
    K[id] = (K[id+1] + K[id-1]) / 2.0
end

Pin_str         = string.(Pin)
Tmin            = string.(round.(min_T,digits=2))
Tmax            = string.(round.(max_T,digits=2))

PTmin           = Pin_str .* ", ".*Tmin
PTmax           =  Pin_str .* ", ".*Tmax
PTmin[2:2:end] .= ""
PTmax[2:2:end] .= ""

afm_max = scatterternary(
    a       = S,
    b       = A,
    c       = F,
    mode    = "markers",   # add "text" to mode
    text    = PTmax,                 # labels for each point
    textposition = "top right",        
    hoverinfo   = "skip",
    opacity     = 1.0,
    # line        = attr(
    #                     width       = 0.0,
    #                     # color       = :black
    #                     color = "rgba(0,0,0,0)"  
    # ),
    marker  = attr(     size        = 5.0,
                        color       = max_Li,
                        colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                        opacity     = 0.75,
                        colorbar    = attr(
                            title   = "Li<sup>*</sup>",
                            len     = 0.7,
                            titlefont = attr(size=18),   # change font size
                            tickfont = attr(size=16),
                            tickformat = ".1f",
                            y       = 0.4,          
                        ),
                        line        = attr(width = 0.0, color = :black),
                        cmin        = 2.0,      # minimum value for color scale
                        cmax        = 8.0,      # maximum value for color scale    
    ),
    name    = "Max Li<sup>*</sup>"
)

layout_afm = Layout(
    legend = attr(
        font = attr(size=20)   # <-- set legend font size here
    ),
    title= attr(
        text    = "",
        x       = 0.2,
        xanchor = "center",
        yanchor = "top"
    ),
    ternary=attr(
        sum     = 100,

        aaxis   = attr(title="SiO<sub>2</sub> [wt%]" ,  gridcolor   = "darkgray",
                                                        titlefont   = attr(size=18),
                                                        tickfont    = attr(size=16),
                                                        showline    =  true,
                                                        linecolor   = "darkgray",
                                                        min         = 50, 
                                                        max         = 100),
        baxis   = attr(title="Al<sub>2</sub>O<sub>3</sub> [wt%]",   gridcolor   = "darkgray",
                                                                    titlefont   = attr(size=18),
                                                                    tickfont    = attr(size=16),
                                                                    showline    =  true,
                                                                    linecolor   = "darkgray",
                                                                    min         = 0, 
                                                                    max         = 30),
        caxis   = attr(title="FeO [wt%]",   gridcolor   = "darkgray",
                                            titlefont   = attr(size=18),
                                            tickfont    = attr(size=16),
                                            showline    =  true,
                                            linecolor   = "darkgray",
                                            min         = 0, 
                                            max         = 30),
        bgcolor     = "#FFF",
        width       = 860,
        height      = 520,
    ),
    paper_bgcolor   = "#FFF",
)
PlotlyJS.plot([afm_max], layout_afm)

Plots.scatter(
    log10.(S ./ A), 
    log10.(F ./ K), 
    marker_z = max_Li, 
    colorbar = true, 
    xlabel = "log10(SiO2/Al2O3)",   
    ylabel = "log10(FeO/K2O)",
    title = "Li enrichment; P = $(round(P, digits=2)); H2O $(round(Ex_H2O_sat, digits=2))",
    legend = false,
    markeralpha = 0.7,
    markersize = 1.8,        # reduce marker size (adjust as needed)
    markerstrokewidth = 0,       # remove marker outline
    strokecolor=:transparent,
    c       = cgrad(:RdBu, rev=true),
    dpi     = dpi,
    colorbar_title = "Enrichment factor [-]",
    clim = (2.0, 8.0),  # set color limits
)

Plots.savefig("$(output)Li_logFK_logSA.png")


m = PlotlyJS.scatter(
    y = log.( (F .* 1.113) ./ K),  # x-axis values
    x = log.( S ./ A),  # y-axis values
    mode = "markers",
    marker = attr(
        size        = 6,                # circle size
        color       = max_Li,           # color by value
        opacity     = 0.75,
        colorscale  = "RdBu",       # or any Plotly colorscale
        colorbar    = attr(title="Li*"),
        line        = attr(width=0),      # no outline
        cmin        = 2.0,      # minimum value for color scale
        cmax        = 8.0,      # maximum value for color scale    
    ),
    showlegend = false
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

layout = Layout(
    title = "Classification diagram (after Herron, 1988)",
    xaxis = attr(
        title = "log(SiO2/Al2O3)",
        showline = true,         # show axis line
        linecolor = "black",     # color of axis line
        linewidth = 2,           # thickness of axis line
        mirror = true,           # show outline on all sides
        ticks = "outside",       # show ticks outside the box
        tickwidth = 2,           # thickness of ticks
        tickcolor = "black",      # color of ticks
        range = [0.0, 3] 
    ),
    yaxis = attr(
        title = "log(Fe2O3/K2O)",  # x-axis title
        showline = true,
        linecolor = "black",
        linewidth = 2,
        mirror = true,
        ticks = "outside",
        tickwidth = 2,
        tickcolor = "black",
        range = [-0.5,1.5] 
    ),
    paper_bgcolor = "#FFF",
    plot_bgcolor = "#FFF",
)

PlotlyJS.plot([m,t,t2,t3,t4,t5], layout)

