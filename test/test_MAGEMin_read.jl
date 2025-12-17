# Key thing is to get at comp. vectors using cations apfu or endmembers rather than sites
using Test
using MAGEMin_C
include("Fn_MAGEMin_read.jl")
using .MAGEMinUtils

# Testset
@testset verbose = true begin

# Run 1
data    = Initialize_MAGEMin("ig", verbose=-1);
P,T     = 10.0, 800.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out_lT  = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in, name_solvus=true);

# Phase abundance (Run 1)
melt_vol = 0.24314; amp_vol = 0.58868; cpx_vol = 0.10195
pl_wt = 0.06025; q_vol = 0.00227; ol_vol = 0; ky_vol = 0;

query = [(:melt, :vol), (:amp, :vol), 
(:cpx, :vol), (:plag, :wt), (:q, :vol), (:ol, :vol), (:ky, :vol)]
data_vector = run_query(out_lT, query);
ΔlT = abs.(data_vector .- [melt_vol, amp_vol, cpx_vol, pl_wt, q_vol, ol_vol, ky_vol])
@test all(ΔlT .< 1e-5)

# Melt composition (Run 1)
phases = out_lT.ph
ind_melt = findfirst(==("liq"), phases)
oxides = out_lT.oxides
ind_H2O = findfirst(==("H2O"), oxides)
ss_H2O = out_lT.SS_vec[ind_melt].Comp_wt[ind_H2O]
denominator = 1 - ss_H2O
ind_SiO2 = findfirst(==("SiO2"), oxides)
ss_SiO2 = out_lT.SS_vec[ind_melt].Comp_wt[ind_SiO2]
ind_MgO = findfirst(==("MgO"), oxides)
ss_MgO = out_lT.SS_vec[ind_melt].Comp_wt[ind_MgO]
ind_Al2O3 = findfirst(==("Al2O3"), oxides)
ss_Al2O3 = out_lT.SS_vec[ind_melt].Comp_wt[ind_Al2O3]
ind_CaO = findfirst(==("CaO"), oxides)
ss_CaO = out_lT.SS_vec[ind_melt].Comp_wt[ind_CaO]
ind_K2O = findfirst(==("K2O"), oxides)
ss_K2O = out_lT.SS_vec[ind_melt].Comp_wt[ind_K2O]

melt_anhydrousSiO2 = ss_SiO2/denominator * 100
melt_anhydrousMgO = ss_MgO/denominator * 100
melt_anhydrousCaO = ss_CaO/denominator * 100
melt_anhydrousAl2O3 = ss_Al2O3/denominator * 100
melt_anhydrousK2O = ss_K2O/denominator * 100
melt_comp = [melt_anhydrousSiO2,melt_anhydrousMgO,melt_anhydrousCaO,melt_anhydrousAl2O3,melt_anhydrousK2O]
query = [(:melt, :SiO2), (:melt, :MgO), (:melt, :CaO), (:melt, :Al2O3), (:melt, :K2O)]
data_vector = run_query(out_lT, query)
ΔlT = abs.(data_vector .- melt_comp)
@test all(ΔlT .< 1e-10)

# Plagioclase composition (Run 1)
ind_pl = findfirst(==("pl"), phases)
end_pl = out_lT.SS_vec[ind_pl].emNames
ind_an = findfirst(==("an"), end_pl)
ind_ab = findfirst(==("ab"), end_pl)
an_pl = out_lT.SS_vec[ind_pl].emFrac[ind_an]
ab_pl = out_lT.SS_vec[ind_pl].emFrac[ind_ab]
query = [(:plag, :an), (:plag, :ab)]
data_vector = run_query(out_lT, query)
ΔlT = abs.(data_vector .- [an_pl,ab_pl])
@test all(ΔlT .< 1e-10)

# Amphibole apfu + vectors (Run 1)
# ampfu
phases = out_lT.ph
ind_amp = findfirst(==("amp"), phases)
elements = out_lT.elements
ind_Si = findfirst(==("Si"), elements)
ind_Mg = findfirst(==("Mg"), elements)
Si_apfu_amphibole = out_lT.SS_vec[ind_amp].Comp_apfu[ind_Si]
Mg_apfu_amphibole = out_lT.SS_vec[ind_amp].Comp_apfu[ind_Mg]

# vectors
endmembers = out_lT.SS_vec[ind_amp].emNames
ind_kprg = findfirst(==("kprg"), endmembers)
kprg = out_lT.SS_vec[ind_amp].emFrac[ind_kprg]
ind_prgm = findfirst(==("prgm"), endmembers)
prgm = out_lT.SS_vec[ind_amp].emFrac[ind_prgm]
ind_mrb = findfirst(==("mrb"), endmembers)
mrb = out_lT.SS_vec[ind_amp].emFrac[ind_mrb]
ind_glm = findfirst(==("glm"), endmembers)
glm = out_lT.SS_vec[ind_amp].emFrac[ind_glm]
site_list = out_lT.SS_vec[ind_amp].siteFractionsNames
sites = out_lT.SS_vec[ind_amp].siteFractions
amphibole_sites = NamedTuple{Tuple(Symbol.(site_list))}(Tuple(sites))
SiT1 = amphibole_sites.xSiT1
Ed_v = kprg + prgm
Gln_v = mrb + glm
Ts_v = (8 - (SiT1*4 + 4)) - prgm - kprg

# XFe3+
fe3 = amphibole_sites.xFe3M2*2
fe2 = amphibole_sites.xFeM13*3 + amphibole_sites.xFeM2*2 + amphibole_sites.xFeM4*2
XFe3_sites = fe3/(fe3 + fe2)

# run
query = [(:amp, :Si), (:amp, :Mg), (:amp, :Ts), (:amp, :Ed), (:amp, :Gln), (:amp, :XFe3)]
data_vector = run_query(out_lT, query)
ΔlT = abs.(data_vector .- [Si_apfu_amphibole, Mg_apfu_amphibole, Ts_v, Ed_v, Gln_v, XFe3_sites])
@test all(ΔlT .< 1e-10)

# Run 2
Finalize_MAGEMin(data)
data        =   Initialize_MAGEMin("mp", verbose=false);
X           = [0.5922, 0.1813, 0.006, 0.0223, 0.0633, 0.0365, 0.0127, 0.0084, 0.0016, 0.0007, 0.075]
Xoxides     = ["SiO2", "Al2O3", "CaO", "MgO", "FeO", "K2O", "Na2O", "TiO2", "O", "MnO", "H2O"]
sys_unit    = "wt"
P = 10.0
T = 700.0
out  = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_unit, name_solvus = true);

# Garnet endmembers, XMg
py, alm, spss, gr, kho = 0.17783014261811847, 0.6232391123850307, 0.016109866997306155, 0.1224806087543103, 0.060340269245234335
phases = out.ph
ind_g = findfirst(==("g"), phases)
site_list = out.SS_vec[ind_g].siteFractionsNames
ind_xMgM2 = findfirst(==("xMgX"), site_list)
Mg = out.SS_vec[ind_g].siteFractions[ind_xMgM2]
ind_xFeM2 = findfirst(==("xFeX"), site_list)
Fe2 = out.SS_vec[ind_g].siteFractions[ind_xFeM2]
XMg_sites = Mg / (Mg + Fe2)

query = [(:g, :py), (:g, :alm), (:g, :spss), (:g, :gr), (:g, :kho), (:g, :pyTOT), (:g, :XMg)]
data_vector = run_query(out, query)
ΔlT = abs.(data_vector .- [py, alm, spss, gr, kho, kho + py, XMg_sites])
@test all(ΔlT .< 1e-5)

# Phase proportions
phase_vol = [0.0595026834562544, 0.18000029373260565, 0.2553733579195757, 0.09141840864807373, 0.00032945059397668247]
query = [(:g, :vol), (:mu, :vol), (:melt, :vol), (:bi, :vol), (:ru, :vol)]
data_vector = run_query(out, query)
ΔlT = abs.(data_vector .- phase_vol)
@test all(ΔlT .< 1e-5)

# Muscovite variables (Xpa, cel, Si)
ind_mu = findfirst(==("mu"), phases)
SS = out.SS_vec[ind_mu] 
element = Symbol.(out.elements) 
apfu = (; (el => SS.Comp_apfu[i] for (i, el) in enumerate(element))...)
Xpa = apfu.Na./(apfu.Na + apfu.Ca +apfu.K) 
end_mu = out.SS_vec[ind_mu].emNames
ind_cel = findfirst(==("cel"), end_mu)
cel = out.SS_vec[ind_mu].emFrac[ind_cel]
Si_apfu = apfu.Si

query = [(:mu, :Xpa), (:mu, :cel), (:mu, :Si)]
data_vector = run_query(out, query)
ΔlT = abs.(data_vector .- [Xpa, cel, Si_apfu])
@test all(ΔlT .< 1e-5)

# Run 3
Finalize_MAGEMin(data)
data    = Initialize_MAGEMin("mb", verbose=false);
P,T     = 10.0, 700.0
Xoxides = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "Fe2O3"; "K2O"; "Na2O"; "TiO2"; "Cr2O3"; "H2O"];
X       = [48.43; 15.19; 11.57; 10.13; 6.65; 1.64; 0.59; 1.87; 0.68; 0.0; 3.0];
sys_in  = "wt"
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in, name_solvus=true);

# CPX variables
phases = out.ph 
ind_cpx = findfirst(==("aug"), phases)
site_list = out.SS_vec[ind_cpx].siteFractionsNames
sites = out.SS_vec[ind_cpx].siteFractions
cpx_sites = NamedTuple{Tuple(Symbol.(site_list))}(Tuple(sites))
# sites
Fe3_M1 = cpx_sites.xFe3M1
Fe2_M1 = cpx_sites.xFeM1
Fe2_M2 = cpx_sites.xFeM2
Fe3 = Fe3_M1
Fe2 = Fe2_M2 + Fe2_M1
# XFe3+, 
XFe3 = Fe3 / (Fe3 + Fe2)
SS = out.SS_vec[ind_cpx] 
element = Symbol.(out.elements) 
apfu = (; (el => SS.Comp_apfu[i] for (i, el) in enumerate(element))...)
# XJd
xjd = min(cpx_sites.xNaM2, cpx_sites.xAlM1)
end_cpx = out.SS_vec[ind_cpx].emNames
ind_di = findfirst(==("di"), end_cpx)
# Di
di = out.SS_vec[ind_cpx].emFrac[ind_di]

query = [(:cpx, :XFe3), (:cpx, :Xjd), (:cpx, :di), (:cpx, :xFeM2)]
data_vector = run_query(out, query)
ΔlT = abs.(data_vector .- [XFe3, xjd, di, Fe2_M2])
@test all(ΔlT .< 1e-5)

# Epidote
# XFe
ind_ep = findfirst(==("ep"), phases)
end_ep = out.SS_vec[ind_ep].emNames
end_i = out.SS_vec[ind_ep].emFrac
end_ep = NamedTuple{Tuple(Symbol.(end_ep))}(Tuple(end_i))
ep = end_ep.ep
fep = end_ep.fep
Xfe = (ep + 2 * fep)/3

query = [(:ep, :XFe)]
data_vector = run_query(out, query)
ΔlT = abs.(data_vector .- [Xfe])
@test all(ΔlT .< 1e-5)

Finalize_MAGEMin(data)

end
