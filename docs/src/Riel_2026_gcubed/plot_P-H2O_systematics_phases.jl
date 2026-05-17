#=
10/04/2025

Script to perform fractional crystallization together with `Li` partitioning
The bulk-rock composition is after FWorldMedian pelite

partitioning coefficients are from the EODC database
ph     = ["mu"; "bi"; "cd"; "FeTiOx"; "g"; "afs"; "pl"; "q"; "ru"]  
KDs    = [0.82; 1.67; 0.44; 1e-5; 0.01; 0.02; 0.01; 1e-5; 1e-5] 

After Koopmans et al., 2024, Geology
Matt Morris and Charlie Beard

=#

using MAGEMin_C, ProgressMeter, JLD2, PCHIPInterpolation, XLSX, DataFrames
using JLD2, Statistics
using Plots, Measures; pyplot()
using Base.Threads: @threads

include("TE_functions.jl")
include("TE_fractional.jl")
include("plot_figures.jl")


all_model = [ "MM","MM_F","KM", "BA"]
FC          = false             # if true, perform fractional crystallization
dpi         = 300
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
all_e1_liq      = [ 7.0, 7.0, 7.0, 7.0];
all_e1_remain   = [ 1.0, 1.0, 1.0, 1.0];
b           = "FS"   # number of points in the pressure and H2O range    
scale       = "fixed_"

plots       = []
clbs        = []
for i =1:length(all_model)
    model       = all_model[i]
    e1_liq_in   = all_e1_liq[i]
    e1_remain_in= all_e1_remain[i]
    simu        = scale*"PH_dtb_$(model)_e$(e1_liq_in)_r$(e1_remain_in)"
    output      = "$(out_dir)/$(model)/$(simu)/"

    println("$simu$output")
    @load "$(output)$(simu).jld2" point_infos Cliq_max Extract_epi Extract_T Δbi Δcd Δmu eta_M Li_content model pChip_wat H P e1_liq e1_remain

    # fig, clb = get_subplot_T2(model, pChip_wat, H, P, "Li", scale, Cliq_max,  Li_content, dpi; ylabel = true)
    # push!(plots, fig)
    # push!(clbs, clb)

    # fig, clb = get_subplot_T2(model, pChip_wat, H, P, "extraction", scale, Extract_epi, Li_content, dpi; ylabel = false)
    # push!(plots, fig)
    # push!(clbs, clb)    

    # fig, clb = get_subplot_T2(model, pChip_wat, H, P, "T", scale, Extract_T, Li_content, dpi; ylabel = false)
    # push!(plots, fig)
    # push!(clbs, clb)
    if i == 1
        label_on = true
    else
        label_on = false
    end
    fig, clb = get_subplot_T2(model, pChip_wat, H, P, "Δcd", scale, Δcd.*100.0, Li_content, dpi; ylabel = true, label_on = label_on)
    push!(plots, fig)
    # push!(clbs, clb)
    
    fig, clb = get_subplot_T2(model, pChip_wat, H, P, "Δbi", scale, Δbi.*100.0, Li_content, dpi; ylabel = false)
    push!(plots, fig)
    # push!(clbs, clb)

    fig, clb = get_subplot_T2(model, pChip_wat, H, P, "Δmu", scale, Δmu.*100.0, Li_content, dpi; ylabel = false)
    push!(plots, fig)
    # push!(clbs, clb)
end

# Plots.gr_cbar_height[]= 0.1
order               = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
# cap_order           = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
cap_order           = ["A", "E", "I", "B", "F", "J", "C", "G", "K", "D", "H", "L"];
cap_id              = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

plots_reordered     = plots[order];
plots_reordered2    = vcat(plots_reordered[1:12] )                        

tm                  = [0mm 0mm 0mm      5mm 5mm 5mm         5mm 5mm 5mm         5mm 5mm 5mm     ]
lm                  = [32mm 0mm 0mm     32mm 0mm 0mm        32mm 0mm 0mm        32mm 0mm 0mm    ]
rm                  = [5mm 5mm 5mm      5mm 5mm 5mm         5mm 5mm 5mm         5mm 5mm 5mm     ]
bm                  = [5mm 5mm 5mm      5mm 5mm 5mm         5mm 5mm 5mm         6mm 6mm 6mm     ]
l                   = grid(4, 3)
plt                 = plot(plots_reordered2..., layout = l, size=(1400,1400), left_margin=lm, right_margin=rm, bottom_margin=bm, top_margin=tm)
annotate!(plt, -1.4, 9.0, text("MO",    :black, :center, 15, "bold", "Arial"; rotation=90),subplot=1)
annotate!(plt, -1.4, 9.0, text("MO_F",  :black, :center, 15, "bold", "Arial"; rotation=90),subplot=4)
annotate!(plt, -1.4, 9.0, text("KO",    :black, :center, 15, "bold", "Arial"; rotation=90),subplot=7)
annotate!(plt, -1.4, 9.0, text("BA",    :black, :center, 15, "bold", "Arial"; rotation=90),subplot=10)
for i=1:length(cap_id)
    annotate!(plt, 0.0, 17.0, text(cap_order[i], :black, :center, 20, "bold", "Arial"), subplot=cap_id[i])
end

annotate!(plt, 6.5, 20.0, text("Δcd [vol%]",         :black, :center, 15, "bold", "Arial"), subplot=1)
annotate!(plt, 6.5, 20.0, text("Δbi [vol%]",         :black, :center, 15, "bold", "Arial"), subplot=2)
annotate!(plt, 6.5, 20.0, text("Δmu [vol%]",         :black, :center, 15, "bold", "Arial"), subplot=3)

savefig(plt, "Figure_MM_KM_BA_phase_T_v2.png")
