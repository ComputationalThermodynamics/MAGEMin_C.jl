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


all_model = "MM"
FC          = false             # if true, perform fractional crystallization
dpi         = 300
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
all_e1_liq      = 7.0
all_e1_remain   = 1.0
b           = "FS"   # number of points in the pressure and H2O range    
scale       = "fixed_"

plots       = []
clbs        = []

model       = all_model
e1_liq_in   = all_e1_liq
e1_remain_in= all_e1_remain
simu        = scale*"PH_dtb_$(model)_e$(e1_liq_in)_r$(e1_remain_in)"
output      = "$(out_dir)/$(model)/$(simu)/"

println("$simu$output")
@load "$(output)$(simu).jld2" point_infos Cliq_max Extract_epi Extract_T Δbi Δcd Δmu eta_M Li_content model pChip_wat H P e1_liq e1_remain

fig, clb = get_subplot_T3(model, pChip_wat, H, P, "Li", scale, Cliq_max,  Li_content, dpi; ylabel = true, label_on = true)
push!(plots, fig)
# push!(clbs, clb)

fig, clb = get_subplot_T3(model, pChip_wat, H, P, "extraction", scale, Extract_epi, Li_content, dpi; ylabel = false, discr = true)
push!(plots, fig)
# push!(clbs, clb)    

fig, clb = get_subplot_T3(model, pChip_wat, H, P, "T", scale, Extract_T, Li_content, dpi; ylabel = false)
push!(plots, fig)
# push!(clbs, clb)

fig, clb = get_subplot_T3(model, pChip_wat, H, P, "Δcd", scale, Δcd.*100.0, Li_content, dpi; ylabel = true)
push!(plots, fig)
# push!(clbs, clb)

fig, clb = get_subplot_T3(model, pChip_wat, H, P, "Δbi", scale, Δbi.*100.0, Li_content, dpi; ylabel = false)
push!(plots, fig)
# push!(clbs, clb)

fig, clb = get_subplot_T3(model, pChip_wat, H, P, "Δmu", scale, Δmu.*100.0, Li_content, dpi; ylabel = false)
push!(plots, fig)
# push!(clbs, clb)



order               = [1, 2, 3, 4, 5, 6];
cap_order           = ["A", "B", "C", "D", "E", "F"];
cap_id              = [1, 2, 3, 4, 5, 6];

plots_reordered     = plots[order];
plots_reordered2    = vcat(plots_reordered[1:6] )                        

tm                  = [     24mm 24mm 24mm      5mm 5mm 5mm           ]
lm                  = [     16mm 0mm 0mm        16mm 0mm 0mm          ]
rm                  = [     -50mm -50mm -50mm   -50mm -50mm -50mm     ]
bm                  = [     0mm 0mm 0mm         12mm 12mm 12mm        ]
l                   = grid(2, 3)
plt                 = plot(plots_reordered2..., layout = l, size=(1400,700), left_margin=lm, right_margin=rm, bottom_margin=bm, top_margin=tm)

for i=1:length(cap_id)
    annotate!(plt, 0.0, 17.0, text(cap_order[i], :black, :center, 20, "bold", "Arial"), subplot=cap_id[i])
end

savefig(plt, "Figure_MM-71-PH_T_v2.png")
