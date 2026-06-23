
using JLD2, PlotlyJS, Statistics
model       = "MM"              # KM, MM
FC          = false             # if true, perform fractional crystallization
test        = false             # if true, only test on a small subset of the bulk-rock compositions
dpi         = 300
fake_F_bi   = false
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
Pin          = [2.0:1.0:15.0;]; 
Ex_H2O_sat  = 0.0;   
e1_liq      = 7.0;
e1_remain   = 1.0;


min_Al,mean_Al,max_Al,min_Si,mean_Si,max_Si,min_Fe,mean_Fe,max_Fe,max_Li,min_Li,mean_Li,min_T,max_T = [],[],[],[],[],[],[],[],[],[],[],[],[],[]
min_K,mean_K,max_K = [],[],[]

for P in Pin
    simu        = "FS_dtb_$(model)_P$(round(P, digits=2))kbar_H$(round(Ex_H2O_sat, digits=2))_e$(e1_liq)_r$(e1_remain)"
    output      = "$(out_dir)/$(model)/$(simu)/"

    FS_data = JLD2.jldopen("$(output)Li_enrichment_stats.jld2") do file
        Dict(
            :mean_mean => read(file, "mean_mean"),
            :mean_max  => read(file, "mean_max"),
            :mean_min  => read(file, "mean_min")
        )
    end

    mean_min_bulk, mean_min_Li, mean_min_T, mean_min_epi, mean_min_Δbi, mean_min_Δcd, mean_min_Δmu = FS_data[:mean_min]
    mean_mean_bulk, mean_mean_Li, mean_mean_T, mean_mean_epi, mean_mean_Δbi, mean_mean_Δcd, mean_mean_Δmu= FS_data[:mean_mean]
    mean_max_bulk, mean_max_Li, mean_max_T, mean_max_epi, mean_max_Δbi, mean_max_Δcd, mean_max_Δmu= FS_data[:mean_max]

    push!(min_Al, mean_min_bulk[2])
    push!(mean_Al, mean_mean_bulk[2])
    push!(max_Al, mean_max_bulk[2])

    push!(min_Si, mean_min_bulk[1])
    push!(mean_Si, mean_mean_bulk[1])
    push!(max_Si, mean_max_bulk[1])

    push!(min_Fe, mean_min_bulk[5])
    push!(mean_Fe, mean_mean_bulk[5])
    push!(max_Fe, mean_max_bulk[5])

    push!(min_K, mean_min_bulk[6])
    push!(mean_K, mean_mean_bulk[6])
    push!(max_K, mean_max_bulk[6])

    push!(min_Li, mean_min_Li[1])
    push!(mean_Li, mean_mean_Li[1])
    push!(max_Li, mean_max_Li[1])

    push!(min_T, mean_min_T[1])
    push!(max_T, mean_max_T[1])
end

A   = max_Al.*100.0
S   = max_Si.*100.0
F   = max_Fe.*100.0
K   = max_K.*100.0

id = findfirst(max_Li .> 20.0   )
if !isnothing(id)
    max_Li[id] = (max_Li[id+1] + max_Li[id-1]) / 2.0
    A[id] = (A[id+1] + A[id-1]) / 2.0
    S[id] = (S[id+1] + S[id-1]) / 2.0
    F[id] = (F[id+1] + F[id-1]) / 2.0
end



Pin_str = string.(Pin)


Tmin = string.(round.(min_T,digits=2))
Tmax = string.(round.(max_T,digits=2))

PTmin = Pin_str .* ", ".*Tmin
PTmax = Pin_str .* ", ".*Tmax
PTmin[2:2:end] .= ""
PTmax[2:2:end] .= ""


afm_max = scatterternary(
    a       = S,
    b       = A,
    c       = F,
    mode    = "markers+text+lines",   # add "text" to mode
    text    = PTmax,                 # labels for each point
    textposition = "top right",        
    hoverinfo   = "skip",
    opacity     = 1.0,
    line        = attr(
                        width       = 1.0,
                        color       = :black
    ),
    marker  = attr(     size        = 10.0,
                        color       = max_Li,
                        colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                        colorbar    = attr(
                            title   = "Li<sup>*</sup>",
                            len     = 0.7,
                            titlefont = attr(size=18),   # change font size
                            tickfont = attr(size=16),
                            tickformat = ".1f",
                            y       = 0.4,          
                        ),
                        line        = attr(width = 0.5, color = :black),
                        cmin        = 2.0,      # minimum value for color scale
                        cmax        = 10.0,      # maximum value for color scale    
    ),
    name    = "Max Li<sup>*</sup>"
)



A       = min_Al .* 100.0
S       = min_Si .* 100.0
F       = min_Fe .* 100.0

afm_min = scatterternary(
    a       = S,
    b       = A,
    c       = F,
    mode    = "markers+text+lines",   # add "text" to mode
    text    = PTmin,                 # labels for each point
    textposition = "top right",     
    hoverinfo   = "skip",
    opacity     = 1.0,
    line       = attr(
                        width       = 1.0,
                        color       = :black
    ),
    marker  = attr(     size        = 10.0,
                        color       = min_Li,
                        colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                        colorbar    = attr(
                            title   = "Li<sup>*</sup>",
                            len     = 0.7,
                            titlefont = attr(size=18),   # change font size
                            tickfont = attr(size=16),
                            tickformat = ".1f",
                            y       = 0.4,          
                        ),
                        line        = attr(width = 0.5, color = :black),
                        cmin        = 2.0,      # minimum value for color scale
                        cmax        = 10.0,  
                        symbol      = "triangle-down",
    ),
    name    = "Min Li<sup>*</sup>"
)

A   = mean_Al .* 100.0
S   = mean_Si .* 100.0
F   = mean_Fe .* 100.0

afm_mean = scatterternary(
    a       = S,
    b       = A,
    c       = F,
    mode    = "markers+lines",   # add "text" to mode
    # text    = Pin_str,                 # labels for each point
    # textposition = "top right",     
    hoverinfo   = "skip",
    opacity     = 1.0,
    line        = attr(
                        width       = 1.0,
                        color       = :black
    ),
    marker  = attr(     size        = 10.0,
                        color       = mean_Li,
                        colorscale  = "RdBu",           # <-- Use colorscale, not colormap
                        colorbar    = attr(
                            title   = "Li<sup>*</sup>",
                            len     = 0.7,
                            titlefont = attr(size=18),   # change font size
                            tickfont = attr(size=16),
                            tickformat = ".1f",
                            y       = 0.4,          
                        ),
                        line        = attr(width = 0.5, color = :black),
                        cmin        = 2.0,      # minimum value for color scale
                        cmax        = 10.0,  
                        symbol      = "diamond",
    ),
    name    = "Mean Li<sup>*</sup>"
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
                                                        min         = 70, 
                                                        max         = 100),
        baxis   = attr(title="Al<sub>2</sub>O<sub>3</sub> [wt%]",   gridcolor   = "darkgray",
                                                                    titlefont   = attr(size=18),
                                                                    tickfont    = attr(size=16),
                                                                    showline    =  true,
                                                                    linecolor   = "darkgray",
                                                                    min         = 10, 
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

PlotlyJS.plot([afm_min,afm_mean,afm_max], layout_afm)


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