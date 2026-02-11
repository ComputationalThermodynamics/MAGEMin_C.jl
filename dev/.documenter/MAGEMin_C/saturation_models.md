
# MAGEMin_C.jl: Saturation models {#MAGEMin_C.jl:-Saturation-models}

::: tip Info
- [Saturation models](/MAGEMin_C/saturation_models#Saturation-models)
  
- [E.1 Zirconium saturation](/MAGEMin_C/saturation_models#E.1-Zirconium-saturation)
  
- [E.2 Zirconium and sulfur saturation models](/MAGEMin_C/saturation_models#E.2-Zirconium-and-sulfur-saturation-models)
  
- [E.3 Saturation models and bulk correction](/MAGEMin_C/saturation_models#E.3-Saturation-models-and-bulk-correction)
  

:::

## Introduction {#Introduction}
- When the concentration of the element in the melt increases above the saturation threshold the key phase carrying the element (see Table below) is crystallized (when the bulk-rock composition allows it) which brings back the concentration of the element in the melt to saturation.
  
- Although trace elements are not currently partitioned among mineral phases under subsolidus conditions, accessory minerals predicted by saturation models are still incorporated into the simulation. As a result, the model keeps track of the modal abundance and evolution of these accessory phases even below the solidus. This allows for  modeling of element sequestration and mineral stability, and ensures that accessory mineral fractions are accurately represented for instance during fractional crystallization.
  
- By default the bulk-rock composition is not directly adjusted to account for the extra elements (e.g., Fe for sulfide). However, MAGEMin_C provides the correction to apply to the bulk-rock composition to accomodate for the extra element(s) in the trace-element output structure: `Out_TE.bulk_cor_wt`and`Out_TE.bulk_cor_mol`.
  

::: tip Important

While saturation is computed based on available models, if the bulk-rock composition cannot satisfy the stoichiometry of the phase, the saturation level will be increased so that the element remains in the melt. 

For instance, if P2O5 concentration in the melt is greater than the saturation level but there is not enough CaO to crystallize all the excess P2O5 as fluorapatite, then the saturation level of P2O5 will be increased such that only the available CaO from the melt is used to crystallize the right fluorapatite fraction. 

**This approach enforces mass conservation**.

:::

:::tabs

== Zirconium (Zr)

<ul>
    <li>Watson & Harrison, 1983 - ZrSat_model = "WH"</li>
    <li>Boehnke et al., 2013 - ZrSat_model = "B"</li>
    <li>Crisp and Berry 2022 - ZrSat_model = "CB"</li>
</ul>


== Phosphate (P2O5)

<ul>
    <li>Tollari et al., 2006 - P2O5Sat_model = "Tollari06"</li> [dry systems only]
    <li>Harrison & Watson, 1984 with Bea et al., 1992 correction - P2O5Sat_model = "HWBea92"</li>
</ul>


== Sulfur (S)
<ul>
    <li>Liu et al., 2007 - SSat_model = "Liu07"</li>
    <li>O'Neill, 2021 - SSat_model = "Oneill21"</li>
</ul>

Note that fS2 is calculated after Bockrath et al. (2024) and that fO2 is retrieved from the phase equilibrium calculation.



:::

| `Element` |      `phase` | `acronym` |  `formula` |       `correction` |                                      `TE_prediction(; arg)` |
| ---------:| ------------:| ---------:| ----------:| ------------------:| -----------------------------------------------------------:|
|        Zr |       zircon |       zrc |     ZrSiO4 |         SiO2 and O | ZrSat_model = &quot;CB&quot;, &quot;B&quot;, &quot;WH&quot; |
|         S |      sulfide |      sulf |        FeS |          FeO and O |        SSat_model = &quot;Oneill21&quot;, &quot;Liu07&quot; |
|      P2O5 | fluorapatite |      fapt | Ca5(PO4)3F | CaO (F is omitted) |                       P2O5Sat_model = &quot;Tollari06&quot; |


## E.1 Zirconium saturation {#E.1-Zirconium-saturation}

Let&#39;s first model zirconium saturation using Crisp and Berry (2022) model. Start as usual by load MAGEMin_C, declaring the database, pressure and temperature conditions, bulk-rock composition and system unit:

```julia
using MAGEMin_C
dtb     = "mp"
data    = Initialize_MAGEMin(dtb, verbose=-1, solver=0);
P,T     = 6.0, 699.0
Xoxides = ["SiO2";  "TiO2";  "Al2O3";  "FeO";   "MnO";   "MgO";   "CaO";   "Na2O";  "K2O"; "H2O"; "O"];
X       = [58.509,  1.022,   14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.2];
sys_in  = "wt"
```


Subsequently, we need to define the element, phase, partiton coefficient and initial concentration in `ug/g`:

```julia
el      = ["Zr"]
ph      = ["zrc"]
KDs     = ["0.0"]   # phase crystallized from saturation models have 0.0 KDs
C0      = [400.0]   # starting concentration of elements in ppm (ug/g)
```


::: tip Note
- Although `Zr` is not partitioned into `zrc`, it is necessary to declare the main Zr-bearing phase and assign a &quot;dummy&quot; KD value of 0. This ensures that `zrc` will be crystallized by stoichiometry when the `Zr` concentration in the liquid exceeds the saturation threshold.
  

:::

Then create the partition coefficient database:

```julia
KDs_dtb = create_custom_KDs_database(el, ph, KDs)
```


Perform the stable phase equilibrium:

```julia
out    = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in, name_solvus=true);
```


And execute the partitioning of the trace-element together with the `Zr`saturation model `ZrSat_model     = "CB"`:

```julia
out_TE  = TE_prediction(out, C0, KDs_dtb, dtb; 
                        ZrSat_model     = "CB")

Finalize_MAGEMin(data)
```


Unfolding the `out_TE` structure yields:

```
julia> out_TE.

C0            Cliq          Cmin          Csol
Sat_P2O5_liq  Sat_S_liq     Sat_Zr_liq    bulk_D
bulk_cor_mol  bulk_cor_wt   elements      fapt_wt
liq_wt_norm   ph_TE         ph_wt_norm    sulf_wt
zrc_wt
```


::: tip Note

fapt_wt and sulf_wt are set to NaN as no saturation model has been provided.

:::

::: warning Warning

The zircon fraction `out_TE.zrc_wt` is expressed in wt fraction (wtf) and not wt% (wt% = wtf/100.0 ...).

:::

## E.2 Zirconium and sulfur saturation models {#E.2-Zirconium-and-sulfur-saturation-models}

The following example shows how to modify example E.1 to add simultaneously sulflur saturation using Liu et al. (2007) model:

```julia
using MAGEMin_C
data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
P,T     = 6.0, 699.0
Xoxides = ["SiO2";  "TiO2";  "Al2O3";  "FeO";   "MnO";   "MgO";   "CaO";   "Na2O";  "K2O"; "H2O"; "O"];
X       = [58.509,  1.022,   14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.2];
sys_in  = "wt"

el      = ["Zr","S"]
ph      = ["zrc","sulf"]
KDs     = ["0.0" "0.0"; "0.0" "0.0"]   # phase crystallized from saturation models have 0.0 KDs

C0      = [400.0, 100.0]   # starting concentration of elements in ppm (ug/g)
dtb     = "mp"

KDs_dtb = create_custom_KDs_database(el, ph, KDs)

out    = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in, name_solvus=true);
out_TE  = TE_prediction(out, C0, KDs_dtb, dtb; 
                        ZrSat_model     = "CB",
                        SSat_model      = "Liu07")

Finalize_MAGEMin(data)
```


## E.3 Saturation models and bulk correction {#E.3-Saturation-models-and-bulk-correction}

This example shows how to correct the bulk-rock composition in a iterative manner when accessory phase crystallized when saturation is exceeded.

```julia

using MAGEMin_C
data    = Initialize_MAGEMin("mp", verbose=-1, solver=0);
P,T     = 6.0, 699.0
Xoxides = ["SiO2";  "TiO2";  "Al2O3";  "FeO";   "MnO";   "MgO";   "CaO";   "Na2O";  "K2O"; "H2O"; "O"];
X       = [58.509,  1.022,   14.858, 4.371, 0.141, 4.561, 5.912, 3.296, 2.399, 10.0, 0.2];
X_mol, Xoxides  = convertBulk4MAGEMin(X, Xoxides,"wt","mp"); sys_in   = "mol"
X_mol ./= sum(X_mol)                                                    # normalize to 1.0

el      = ["Zr","S"]
ph      = ["zrc","sulf"]
KDs     = [ "0.0" "0.0";
            "0.0" "0.0"]                                          # phase crystallized from saturation models have 0.0 KDs

C0      = [400.0, 1000.0]                                        # starting concentration of elements in ppm (ug/g)
dtb     = "mp"

KDs_dtb = create_custom_KDs_database(el, ph, KDs)

out      = Vector{out_struct}(undef,1)
out_TE   = Vector{out_TE_struct}(undef,1)

X       = copy(X_mol)
tol     = 1e-6
res     = 1.0
n0      = 0.0
ite     = 0
while res > tol && ite < 32
    out[1]     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in, name_solvus=true);
    out_TE[1]  = TE_prediction(out[1] , C0, KDs_dtb, dtb; 
                            ZrSat_model     = "CB",
                            SSat_model      = "Liu07");

    X       =  X_mol .- out_TE[1].bulk_cor_mol

    res     = abs(n0 - vec_norm(out_TE[1].bulk_cor_mol))
    n0      = vec_norm(out_TE[1].bulk_cor_mol)

    ite    += 1
    if ite == 32
        @warn "Saturation model did not converge in 32 iterations, residual is $res"
    end
end
```


which displays:

```
Iteration 0: residual = 0.00011674564300540276
Iteration 1: residual = 3.909415504073306e-7
```


::: tip Note
- `out_TE[1].bulk_cor_mol` is applied to the start bulk `X_mol` between all iterations
  
- The objective of the `while` loop is to iterate until the residual defined as the difference of the norm of the bulk correction between two iteration decrease below the tolerance threshold `tol = 1e-6`
  

:::

## References {#References}
- Watson, E. B., &amp; Harrison, T. M. (1983). Zircon saturation revisited: temperature and composition effects in a variety of crustal magma types. earth and planetary science letters, 64(2), 295-304.
  
- Harrison, T. M., &amp; Watson, E. B. (1984). The behavior of apatite during crustal anatexis: equilibrium and kinetic considerations. Geochimica et cosmochimica acta, 48(7), 1467-1477.
  
- Bea, F., Fershtater, G., &amp; Corretgé, L. G. (1992). The geochemistry of phosphorus in granite rocks and the effect of aluminium. Lithos, 29(1-2), 43-56
  
- Boehnke, P., Watson, E. B., Trail, D., Harrison, T. M., &amp; Schmitt, A. K. (2013). Zircon saturation re-revisited. Chemical Geology, 351, 324-334.
  
- Crisp, L. J., &amp; Berry, A. J. (2022). A new model for zircon saturation in silicate melts. Contributions to Mineralogy and Petrology, 177(7), 71.
  
- Tollari, N., Toplis, M. J., &amp; Barnes, S. J. (2006). Predicting phosphate saturation in silicate magmas: an experimental study of the effects of melt composition and temperature. Geochimica et Cosmochimica Acta, 70(6), 1518-1536.
  
- Liu, Y., Samaha, N. T., &amp; Baker, D. R. (2007). Sulfur concentration at sulfide saturation (SCSS) in magmatic silicate melts. Geochimica et Cosmochimica Acta, 71(7), 1783-1799.
  
- O&#39;Neill, H. S. C. (2021). The thermodynamic controls on sulfide saturation in silicate melts with application to ocean floor basalts. Magma redox geochemistry, 177-213.
  
- Bockrath, C., Ballhaus, C., &amp; Holzheid, A. (2004). Stabilities of laurite RuS2 and monosulfide liquid solution at magmatic temperature. Chemical Geology, 208(1-4), 265-271.
  
