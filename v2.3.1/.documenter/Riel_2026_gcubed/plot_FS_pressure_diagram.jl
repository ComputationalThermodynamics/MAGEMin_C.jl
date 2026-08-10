
using JLD2, PlotlyJS, Statistics, MAGEMin_C, LaTeXStrings, XLSX, DataFrames

include("plot_figures_FS.jl")

FC          = false             # if true, perform fractional crystallization
test        = false             # if true, only test on a small subset of the bulk-rock compositions
dpi         = 300
fake_F_bi   = false
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0
Pin          = [2.0:1.0:15.0;]
Ex_H2O_sat  = -0.03;   
e1_liq      = 7.0;
e1_remain   = 1.0;
model_      = ["KM","BA","MM","MM_F"]  
# model_      = ["KM","BA","MM_F"]  
lstyle      = ["dash","solid","dot","longdash"] 
shape       = ["square","diamond","circle","triangle-up"]
width       = [1,1,1,1]
all         = []
all_2       = []


for i=1:length(model_)
    model       = model_[i]              # KM, MM

    min_Al,mean_Al,max_Al,min_Si,mean_Si,max_Si             = [],[],[],[],[],[]
    min_Fe,mean_Fe,max_Fe,max_Li,min_Li,mean_Li,min_T,max_T = [],[],[],[],[],[],[],[]
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

        mean_min_bulk, mean_min_Li, mean_min_T, mean_min_epi, mean_min_Δbi, mean_min_Δcd, mean_min_Δmu          = FS_data[:mean_min]
        mean_mean_bulk, mean_mean_Li, mean_mean_T, mean_mean_epi, mean_mean_Δbi, mean_mean_Δcd, mean_mean_Δmu   = FS_data[:mean_mean]
        mean_max_bulk, mean_max_Li, mean_max_T, mean_max_epi, mean_max_Δbi, mean_max_Δcd, mean_max_Δmu          = FS_data[:mean_max]

        Xoxides         = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
        mean_min_bulk   = mol2wt(vec(mean_min_bulk), Xoxides)
        mean_mean_bulk  = mol2wt(vec(mean_mean_bulk), Xoxides)
        mean_max_bulk   = mol2wt(vec(mean_max_bulk), Xoxides)

        # println(mean_max_bulk," $P")
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

    Pin_str = string.(Pin)
    # Tmin = string.(round.(min_T,digits=2))
    # Tmax = string.(round.(max_T,digits=2))

    # PTmin = Pin_str .* ", ".*Tmin
    PTmax   = Pin_str# .* ", ".*Tmax
    # PTmin[2:2:end] .= ""
    PTmax[2:2:end] .= ""

    min, meann, max = recover_FS_pressure_diagram(min_Al, mean_Al, max_Al, min_Si, mean_Si, max_Si, min_Fe, mean_Fe, max_Fe, min_Li, mean_Li, max_Li, min_T, max_T,
                                        min_K, mean_K, max_K,width[i],lstyle[i],PTmax,shape[i]);

    push!(all, (min, meann, max ))

    push!(all_2, (max_T,max_Li))
end

PlotlyJS.savefig(get_PTLi_plot( all_2, Pin, lstyle, shape ), "$(out_dir)PT_Li_enrichment2_H$(round(Ex_H2O_sat, digits=2)).png", scale = 2.0)

PlotlyJS.savefig(get_Herron_plot( all, Pin, lstyle, shape ), "$(out_dir)Li_logFK_logSA_all2_H$(round(Ex_H2O_sat, digits=2)).png", scale = 2.0)








