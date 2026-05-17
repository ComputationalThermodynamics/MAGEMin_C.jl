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

using MAGEMin_C, Plots, ProgressMeter, JLD2, PCHIPInterpolation, XLSX, DataFrames
using Base.Threads: @threads
using LaTeXStrings

include("TE_functions.jl")
include("TE_fractional.jl")
include("plot_figures.jl")

model   = "MM"

FC          = false             # if true, perform fractional crystallization
dpi         = 300
if model == "MM_F"
    fake_F_bi   = true
else
    fake_F_bi   = false
end
out_dir     = "./output_Li_v0.1/"
Li_content  = 100.0;            # Li content in ppm
# P           = 4.4;
# H           = 0.0075;
P           = 4.0;
H_ex        = 0.0;
n_ee        = 15;
e1_liq      = 7.0;
e1_remain   = 1.0;
norm_TE     = true;           # if true, normalize the TE results to 100% melt
np          = 150;
b           = "FS"   # number of points in the pressure and H2O range    
scale       = "fixed_"
max_T       = 1000
n_max       = 1024;                    # Maximum number of iterations in the bisection method

dtb         = "mp"

T           = [600.0, 1100.0]

Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
bulk        = norm2one([0.67153, 0.12111, 0.00729, 0.03762, 0.05998, 0.02638, 0.01401, 0.00717, 0.0069, 0.00071, 0.0]);
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


#= next section computes batch melting profille =#

H = pChip_wat(P)
gv, z_b, DB, splx_data = data_thread        # Unpack the MAGEMin data

id_h        = findfirst(Xoxides .== "H2O")
bulk[id_h]  = H
gv          = define_bulk_rock(gv, bulk, Xoxides, sys_in, dtb);

elem_TE     = ["Li"]
bulk_TE     = [Li_content]           # Li	30–100 µg/g (ppm)	- Can be up to 150 ppm in Li-rich pelites

C0          = adjust_chemical_system( KDs_database, bulk_TE, elem_TE );

ext_out2    = Vector{MAGEMin_C.gmin_struct{Float64, Int64}}(undef,n_max)
ext_out_te2 = Vector{MAGEMin_C.out_tepm}(undef,n_max)

Tsol        = pChip_T(P)+1
Tall        = collect(range(Tsol, max_T, length=n_max))

@showprogress for i=1:n_max
    ext_out2[i]         = deepcopy(point_wise_minimization(P, Tall[i], gv, z_b, DB, splx_data; W = Ws, name_solvus = true))
    ext_out_te2[i]      = deepcopy(TE_prediction(ext_out2[i], C0, KDs_database, dtb; ZrSat_model = "CB", norm_TE = norm_TE))

    if "liq" in ext_out2[i].ph
        id_liq  = findfirst(ext_out2[i].ph .== "liq")
        if ext_out2[i].ph_frac_vol[id_liq] >= e1_liq./100.0

            ratio    = (ext_out2[i].frac_M_vol - e1_remain/100.0)/ext_out2[i].frac_M_vol
            bulk      = deepcopy(ext_out2[i].bulk .- ext_out2[i].SS_vec[id_liq].Comp .* (ext_out2[i].frac_M*ratio))

            gv       = define_bulk_rock(gv, bulk, Xoxides, "mol", dtb);
            C0       = C0 .- ext_out_te2[i].Cliq[1] .* (ext_out_te2[i].liq_wt_norm*ratio)
        end

    end
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
q_vol = []
for i = 1:n_max
    if haskey(ext_out2[i].PP_syms, :q)
        push!(q_vol, ext_out2[i].ph_frac_vol[ext_out2[i].PP_syms[:q] + ext_out2[i].n_SS])
    else
        push!(q_vol, 0.0)  # or NaN if you prefer
    end
end

T       = [ext_out2[i].T_C for i=1:n_max]
# liq_vol[liq_vol .> e1_liq/100.0] .= e1_liq/100.0


afs_Li = []
for i = 1:n_max
    if "afs" in ext_out_te2[i].ph_TE
        id_afs = findfirst(ext_out_te2[i].ph_TE .== "afs")
        push!(afs_Li,ext_out_te2[i].Cmin[id_afs])
    else
        push!(afs_Li,0.0)
    end
end



bulk_D = []
for i = 1:n_max
    push!(bulk_D,ext_out_te2[i].bulk_D)
end


pl_Li = []
for i = 1:n_max
    if "pl" in ext_out_te2[i].ph_TE
        id_pl = findfirst(ext_out_te2[i].ph_TE .== "pl")
        push!(pl_Li,ext_out_te2[i].Cmin[id_pl])
    else
        push!(pl_Li,0.0)
    end
end

mu_Li = []
for i = 1:n_max
    if "mu" in ext_out_te2[i].ph_TE
        id_mu = findfirst(ext_out_te2[i].ph_TE .== "mu")
        push!(mu_Li,ext_out_te2[i].Cmin[id_mu])
    else
        push!(mu_Li,0.0)
    end
end

bi_Li = []
for i = 1:n_max
    if "bi" in ext_out_te2[i].ph_TE
        id_bi = findfirst(ext_out_te2[i].ph_TE .== "bi")
        push!(bi_Li,ext_out_te2[i].Cmin[id_bi])
    else
        push!(bi_Li,0.0)
    end
end

cd_Li = []
for i = 1:n_max
    if "cd" in ext_out_te2[i].ph_TE
        id_cd = findfirst(ext_out_te2[i].ph_TE .== "cd")
        push!(cd_Li,ext_out_te2[i].Cmin[id_cd])
    else
        push!(cd_Li,0.0)
    end
end

q_Li = []
for i = 1:n_max
    if "q" in ext_out_te2[i].ph_TE
        id_q = findfirst(ext_out_te2[i].ph_TE .== "q")
        push!(q_Li,ext_out_te2[i].Cmin[id_q])
    else
        push!(q_Li,0.0)
    end
end


cd_Li[cd_Li .== 0.0] .= NaN
mu_Li[mu_Li .== 0.0] .= NaN
bi_Li[bi_Li .== 0.0] .= NaN
afs_Li[afs_Li .== 0.0] .= NaN
pl_Li[pl_Li .== 0.0] .= NaN
q_Li[q_Li .== 0.0] .= NaN
plots = []
fig = plot(T, Li, xlabel = "T (°C)", ylabel = "Li [ug/g]", label =  "melt", legend =  :topleft, title = "", dpi = dpi, ylims = (0, 400),xlims = (650, max_T))
fig = plot!(T, pl_Li, xlabel = "T (°C)", ylabel = "Li [ug/g]", label =  "pl", legend =  :topleft, title = "", dpi = dpi, ylims = (0, 400),xlims = (650, max_T))
fig = plot!(T, afs_Li, xlabel = "T (°C)", ylabel = "Li [ug/g]", label =  "afs", legend =  :topleft, title = "", dpi = dpi, ylims = (0, 400),xlims = (650, max_T))
fig = plot!(T, bi_Li, xlabel = "T (°C)", ylabel = "Li [ug/g]", label =  "bi", legend =  :topleft, title = "", dpi = dpi, ylims = (0, 400),xlims = (650, max_T))
fig = plot!(T, mu_Li, xlabel = "T (°C)", ylabel = "Li [ug/g]", label =  "mu", legend =  :topright, title = "", dpi = dpi, ylims = (0, 800),xlims = (650, max_T))
fig = plot!(T, q_Li, xlabel = "T (°C)", ylabel = "Li [ug/g]", label =  "q", legend =  :topright, title = "", dpi = dpi, ylims = (0, 800),xlims = (650, max_T))
push!(plots, fig)

fig = plot(T, liq_vol.*100.0, xlabel = "T (°C)", ylabel = "Phase [vol%]", label =  "melt", legend =  :topleft, title = "", dpi = dpi, ylims = (0, 40),xlims = (650, max_T))
fig = plot!(T, afs_vol.*100.0,xlabel = "T (°C)", ylabel = "Phase [vol%]", label =  "afs",  legend =  :topleft, title = "", dpi = dpi, ylims = (0, 40),xlims = (650, max_T))
fig = plot!(T, pl_vol.*100.0, xlabel = "T (°C)", ylabel = "Phase [vol%]", label =  "pl",   legend =  :topleft, title = "", dpi = dpi, ylims = (0, 40),xlims = (650, max_T))
fig = plot!(T, mu_vol.*100.0, xlabel = "T (°C)", ylabel = "Phase [vol%]", label =  "mu",   legend =  :topleft, title = "", dpi = dpi, ylims = (0, 40),xlims = (650, max_T))
fig = plot!(T, q_vol.*100.0, xlabel = "T (°C)", ylabel = "Phase [vol%]", label =  "q",   legend =  :topleft, title = "", dpi = dpi, ylims = (0, 40),xlims = (650, max_T))
fig = plot!(T, bi_vol.*100.0, xlabel = "T (°C)", ylabel = "Phase [vol%]", label =  "bi",   legend =  :topleft, title = "", dpi = dpi, ylims = (0, 40),xlims = (650, max_T))
push!(plots, fig)

fig = plot(T, bulk_D, xlabel = "T (°C)", ylabel = "D_Li^bulk", label =  "bulk",   legend =  :topleft, title = "", dpi = dpi, yscale = :log10, ylims = (1e-2, 10.0),xlims = (650, max_T))
push!(plots, fig)

Dbi = []
for k = 1:n_max

    if "bi" in ext_out2[k].ph
        out               = ext_out2[k]
        expr              = KDs_database.KDs_expr[2]
        push!(Dbi,Base.invokelatest(expr, out))
    else
         push!(Dbi,NaN)
    end
end
Dms = []
for k = 1:n_max

    if "mu" in ext_out2[k].ph
        out               = ext_out2[k]
        expr              = KDs_database.KDs_expr[1]
        push!(Dms,Base.invokelatest(expr, out))
    else
         push!(Dms,NaN)
    end
end
Dcd = []
for k = 1:n_max

    if "cd" in ext_out2[k].ph
        out               = ext_out2[k]
        expr              = KDs_database.KDs_expr[3]
        push!(Dcd,Base.invokelatest(expr, out))
    else
         push!(Dcd,NaN)
    end
end

l                   = grid(3, 1)
plt                 = plot(plots..., layout = l, size=(600,1350),left_margin=10Plots.mm, bottom_margin=5Plots.mm, right_margin=10Plots.mm, )


savefig(plt, "P4kbar_MM_71.svg")
