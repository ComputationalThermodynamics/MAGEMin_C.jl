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


"""
    norm2one(vec::Vector{Float64}) -> Vector{Float64}

Normalize `vec` so that its elements sum to 1. Local copy for standalone use in this script.
"""
# biotite Kd plot
function norm2one( vec :: Vector{Float64})
    return vec ./ sum(vec)
end

using MAGEMin_C, Plots, LaTeXStrings

Xoxides     = ["SiO2"; "Al2O3"; "CaO"; "MgO"; "FeO"; "K2O"; "Na2O"; "TiO2"; "O"; "MnO"; "H2O"];
bulk        = norm2one([0.67153, 0.12111, 0.00729, 0.03762, 0.05998, 0.02638, 0.01401, 0.00717, 0.0069, 0.00071, 0.2]);
sys_in      = "mol";
data        = Initialize_MAGEMin("mp", verbose=-1, solver=0);

P           = [4.0, 8.0, 12.0]
np          = 32
T           = collect(range(650.0,850.0,np))

D_bi        = fill(NaN, length(P), length(T))
# D_bi        = zeros(length(P), length(T))


for i=1:length(P)
    for j=1:length(T)
        out         = single_point_minimization(P[i], T[j], data, X=bulk, Xoxides=Xoxides, sys_in=sys_in)

        if :bi in keys(out.SS_syms) && :liq in keys(out.SS_syms)
            bi          = out.SS_syms[:bi]
            liq         = out.SS_syms[:liq]
            T_C         = T[j]

            c9          = -7.01;
            c10         = -4.29;
            c11         = 4.18;
            c12         = 0.407;
            XMFe3p      = out.SS_vec[bi].siteFractions[4];
            NaK_Almelt  = (out.SS_vec[liq].Comp_apfu[6] + out.SS_vec[liq].Comp_apfu[7]) / out.SS_vec[liq].Comp_apfu[2];
            ln_D_Li     = c9 + c10*XMFe3p + c11*(NaK_Almelt) + c12*1e4/(T_C+273.15);
        
            D_bi[i,j]   = exp(ln_D_Li)
        end


    end
end

plt = plot(xlabel="Temperature [°C]", ylabel=L"D^{\mathrm{bi/melt}}_{\mathrm{Li}}", legend=:topright, dpi=300)
for i in eachindex(P)
    plot!(plt, T, D_bi[i, :], label="P = $(P[i]) kbar", linewidth=2.)
end
display(plt)
savefig(plt, "D_Li_Bi_Beard.png")

