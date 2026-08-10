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
