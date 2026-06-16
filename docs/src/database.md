# Databases information

A comprehensive overview of all thermodynamic databases available in MAGEMin, including their acronyms, chemical systems, phases, and primary references.

!!! info
    - [Quick Reference Table](#Quick-Reference-Table)
    - [Detailed Database Descriptions](#Detailed-Database-Descriptions)
    - [Important Notes](#Important-Notes)
    - [Reference Citations](#Reference-Citations)
    - [Phase and End-member Listing](#Phase-and-End-member-Listing)
    - [Trace-element partitioning models](#Trace-element-partitioning-models)
        - [OL fixed Kd database](#OL-fixed-Kd-database)
        - [CO lattice strain model](#CO-lattice-strain-model)

!!! important
    The acronyms are used to construct the bulk-rock input file for the app, and link the bulk to a targeted database. The acronyms are also used when using MAGEMin_C to initialize MAGEMin_C.jl with the desired database.


## Quick Reference Table

| Acronym | Name | Version | Primary Reference |
|---------|------|---------|-------------------|
| **mp**  | Metapelite | v1.3.0 | White et al., 2014a, 2014b |
| **um**  | Ultramafic | v1.3.2 | Evans & Frost, 2021 |
| **mb** | Metabasite | v1.3.5 | Green et al., 2016 |
| **mtl** | Mantle | v1.5.5 | Holland et al., 2013 |
| **ig**  | Igneous | v1.6.2 | Green et al., 2025 (updated from Holland et al., 2018) |
| **igad**  | Igneous alkaline | v1.6.2 | Weller et al., 2024 |
| **sb11**  | Mantle (Stixrude & Lithgow-Bertelloni) | v1.7.7 | Stixrude & Lithgow-Bertelloni, 2011 |
| **sb21** | Mantle (Stixrude & Lithgow-Bertelloni) | v1.7.7 | Stixrude & Lithgow-Bertelloni, 2021 |
| **sb24**  | Mantle (Stixrude & Lithgow-Bertelloni) | v1.8.0 | Stixrude & Lithgow-Bertelloni, 2024 |
| **ume** | Ultramafic extended | — | Evans & Frost, 2021 + Green et al., 2016 |
| **mpe** | Extended metapelite | — | White et al., 2014 + Green et al., 2016 + Franzolin et al., 2011 + Diener et al., 2007 |
| **mbe** | Extended metabasite | — | Green et al., 2016 + Diener et al., 2007 + Rebay et al., 2022 |

---

## Detailed Database Descriptions

:::tabs

== Metapelite (mp)

The metapelitic model (extended with MnO, White et al., 2014) allows to compute the mineral assemblage from low temperature to supra-solidus conditions.

```@raw html
<ul>
    <li>Added March 2023, `MAGEMin v1.3.0`</li>
    <li>White et al., 2014a, 2014b (see http://hpxeosandthermocalc.org)</li>
    <li>K2O-Na2O-CaO-FeO-MgO-Al2O3-SiO2-H2O-TiO2-O-MnO chemical system</li>
    <li>Pure stoichiometric phases quartz (q), cristobalite (crst), tridymite (trd), coesite (coe), stishovite (stv), kyanite (ky), sillimanite (sill), andalusite (and), rutile (ru), corundum (cor) and sphene (sph).</li>
    <li>Solution phases spinel (spl), biotite (bi), cordierite (cd), orthopyroxene (opx), epidote (ep), garnet (g), ilmenite (ilm), silicate melt (liq), muscovite (mu), ternary feldspar (pl4T), sapphirine (sa), staurolite (st), magnetite (mt), chlorite (chl), chloritoid (ctd) and margarite (ma).</li>
</ul>
```

== Ultramafic (um)

```@raw html
<ul>
    <li>Added May 2023, `MAGEMin v1.3.2`</li>
    <li>Evans & Frost, 2021 (see http://hpxeosandthermocalc.org)</li>
    <li>SiO2-Al2O3-MgO-FeO-O-H2O-S chemical system</li>
    <li>Pure stoichiometric phases quartz (q), cristobalite (crst), tridymite (trd), coesite (coe), stishovite (stv), kyanite (ky), sillimanite (sill), corundum (cor) and pyrite (pyr).</li>
    <li>Solution phases fluid (fluid), olivine (ol), brucite (br), antigorite (atg), garnet (g), talc (t), chlorite (chl), spinel (spi), orthopyroxene (opx), pyrrhotite (po) and anthophylite (anth).</li>
</ul>
```

== Metabasite (mb)

```@raw html
<ul>
    <li>Added October 2023, `MAGEMin v1.3.5`</li>
    <li>Green et al., 2016 (see http://hpxeosandthermocalc.org)</li>
    <li>K2O-Na2O-CaO-FeO-MgO-Al2O3-SiO2-H2O-TiO2-O chemical system</li>
    <li>Pure stoichiometric phases quartz (q), cristobalite (crst), tridymite (trd), coesite (coe), stishovite (stv), kyanite (ky), sillimanite (sill), andalusite (and), rutile (ru), corundum (cor) and sphene (sph).</li>
    <li>Solution phases spinel (sp), biotite (bi), orthopyroxene (opx), epidote (ep), garnet (g), ilmenite (ilm), silicate melt (liq), muscovite (mu), ternary feldspar (pl4T), chlorite (chl), omphacite (omph), augite (aug) and clino-amphibole (amp).</li>
</ul>
```

== Igneous (ig)

```@raw html
<ul>
    <li>Added December 2024, `MAGEMin v1.6.2`</li>
    <li>Green et al., 2025, corrected from Holland et al., 2018 (see http://hpxeosandthermocalc.org)</li>
    <li>K2O-Na2O-CaO-FeO-MgO-Al2O3-SiO2-H2O-TiO2-O-Cr2O3 chemical system</li>
    <li>Pure stoichiometric phases quartz (q), cristobalite (crst), tridymite (trd), coesite (coe), stishovite (stv), kyanite (ky), sillimanite (sill), andalusite (and), rutile (ru), corundum (cor) and sphene (sph).</li>
    <li>Solution phases spinel (spl), biotite (bi), cordierite (cd), clinopyroxene (cpx), orthopyroxene (opx), epidote (ep), garnet (g), clino-amphibole (amp), ilmenite (ilm), silicate melt (liq), muscovite (mu), olivine (ol), ternary feldspar (pl4T), and aqueous fluid (fl).</li>
</ul>
```

== Igneous Alkaline (igad)

```@raw html
<ul>
    <li>Added December 2024, `MAGEMin v1.6.2`</li>
    <li>Weller et al., 2024 (see doi:10.1093/petrology/egae098)</li>
    <li>K2O-Na2O-CaO-FeO-MgO-Al2O3-SiO2-TiO2-O-Cr2O3 chemical system</li>
    <li>Pure stoichiometric phases quartz (q), cristobalite (crst), tridymite (trd), coesite (coe), stishovite (stv), kyanite (ky), sillimanite (sill), andalusite (and), rutile (ru), corundum (cor) and sphene (sph).</li>
    <li>Solution phases spinel (spl), clinopyroxene (cpx), orthopyroxene (opx), garnet (g), ilmenite (ilm), silicate melt (liq), olivine (ol), ternary feldspar (pl4T), nepheline (ness), kalsilite (kals), leucite (lct) and melilite (mel).</li>
</ul>
```

== Mantle (mtl)

```@raw html
<ul>
    <li>Added October 2024, `MAGEMin v1.5.5`</li>
    <li>Holland et al., 2013 (see https://academic.oup.com/petrology/article/54/9/1901/1514886)</li>
    <li>Na2O–CaO–FeO–MgO–Al2O3–SiO2 (NCFMAS) system</li>
    <li>Pure stoichiometric phases quartz (q), cristobalite (crst), tridymite (trd), coesite (coe), stishovite (stv), kyanite (ky), sillimanite (sill) and andalusite (and).</li>
    <li>Solution phases garnet (g), clinopyroxene (cpx), orthopyroxene (opx) and its high-P polymorph (hpx), olivine (ol), wadsleyite (wad), ringwoodite (ring), akimotoite (ak), MgSi-perovskite (mpv), CaSi–perovskite (cpv), ca-ferrite (cf), new-aluminium-phase (nal), corundum (cor) and ferropericlase (fp).</li>
</ul>
```

== Mantle (sb11)

```@raw html
<ul>
    <li>Added May 2025, `MAGEMin v1.7.7`</li>
    <li>Stixrude and Lithgow-Bertelloni, 2011 (see doi.org/10.1111/j.1365-246X.2010.04890.x)</li>
    <li>Na2O–CaO–FeO–MgO–Al2O3–SiO2 (NCFMAS) system</li>
    <li>Pure stoichiometric phases quartz (qtz), coesite (coe), stishovite (st), kyanite (ky), nepheline (neph) and kyanite (ky).</li>
    <li>Solution phases plagioclase (pl), spinel (sp), olivine (ol), wadsleyite (wa), ringwoodite (ri), orthopyroxene (opx), clinopyroxene (cpx), hp-clinopyroxene (hpcpx), akimotoite (ak), garnet (gtmk), perovskite (pv), post-perovskite (ppv), magnesio-wustite (mw) and ca-ferrite (cf).</li>
</ul>
```

== Mantle (sb21)

```@raw html
<ul>
    <li>Added May 2025, `MAGEMin v1.7.7`</li>
    <li>Stixrude and Lithgow-Bertelloni, 2021 (see doi.org/10.1093/gji/ggab394)</li>
    <li>Na2O–CaO–FeO–MgO–Al2O3–SiO2 (NCFMAS) system</li>
    <li>Pure stoichiometric phases quartz (qtz), coesite (coe), stishovite (st), kyanite (ky), nepheline (neph) and kyanite (ky).</li>
    <li>Solution phases plagioclase (pl), spinel (sp), olivine (ol), wadsleyite (wa), ringwoodite (ri), orthopyroxene (opx), clinopyroxene (cpx), hp-clinopyroxene (hpcpx), akimotoite (ak), garnet (gtmk), perovskite (pv), post-perovskite (ppv), magnesio-wustite (mw), new-aluminium-phase (nal) and ca-ferrite (cf).</li>
</ul>
```

== Mantle (sb24)

```@raw html
<ul>
    <li>Added 2024, `MAGEMin v1.8.0`</li>
    <li>Stixrude and Lithgow-Bertelloni, 2024 (see doi.org/10.1093/gji/ggae126)</li>
    <li>Na2O–CaO–FeO–MgO–Al2O3–SiO2–O–Cr2O3 (NCFMASO-Cr) system</li>
    <li>Pure stoichiometric phases nepheline (neph), kyanite (ky), stishovite (st), coesite (coe), quartz (qtz), Ca-perovskite (capv), oxygen (O2), Fe(a) (fea), Fe(e) (fee), Fe(g) (feg), alpha-AlBoO (apbo), wollastonite (wo), lower-post-perovskite (lppv), pseudo-wollastonite (pwo), MgO activity (aMgO), FeO activity (aFeO) and Al2O3 activity (aAl2O3).</li>
    <li>Solution phases plagioclase (plg), spinel (sp), olivine (ol), wadsleyite (wa), ringwoodite (ri), orthopyroxene (opx), clinopyroxene (cpx), high-pressure clinopyroxene (hpcpx), akimotoite (ak), garnet (gtmj), perovskite (pv), post-perovskite (ppv), ca-ferrite (cf), magnesio-wustite (mw) and new-aluminium-phase (nal).</li>
</ul>
```

== Extended Databases (ume, mpe, mbe)

```@raw html
<ul>
    <li><strong>Ultramafic Extended (ume)</strong>: Combines Evans & Frost, 2021 (Ultramafic) and Green et al., 2016 (Metabasite) for extended applicability across ultramafic compositions.</li>
    <li><strong>Extended Metapelite (mpe)</strong>: Combines White et al., 2014 (Metapelite) with Green et al., 2016 (Metabasite), Franzolin et al., 2011, and Diener et al., 2007 for broader coverage of metamorphic compositions.</li>
    <li><strong>Extended Metabasite (mbe)</strong>: Combines Green et al., 2016 (Metabasite) with Diener et al., 2007 and Rebay et al., 2022 for extended metabasic system coverage.</li>
</ul>
```

:::

---

## Important Notes

!!! important
    The datasets are only calibrated for a limited range of P, T, and bulk rock conditions. If you go too far outside those ranges, MAGEMin (or most other thermodynamic software packages for that matter) may not converge or give bogus results.

!!! important
    Developing new, more widely applicable, thermodynamic datasets is a huge research topic, which will require funding to develop the models themselves, as well as to perform targeted experiments to calibrate those models.

!!! warning
    For most users, we recommend starting with the relevant single-system database (mp, um, mb, ig, igad, or mtl) before exploring extended/composite databases. When using extended database, mind that all phases are active by default and that the user needs to selected the adequate subset.

---

## Reference Citations

- Green, E.C.R., Holland, T.J.B., Powell, R., Weller, O.M., & Riel, N. (2025). Journal of Petrology, 66. [doi: 10.1093/petrology/egae079](https://doi.org/10.1093/petrology/egae079)

- Weller, O.M., Holland, T.J.B., Soderman, C.R., Green, E.C.R., Powell, R., Beard, C.D., & Riel, N. (2024). New Thermodynamic Models for Anhydrous Alkaline-Silicate Magmatic Systems. Journal of Petrology, 65. [doi: 10.1093/petrology/egae098](https://doi.org/10.1093/petrology/egae098)

- Holland, T.J.B., Green, E.C.R., & Powell, R. (2022). A thermodynamic model for feldspars in KAlSi₃O₈-NaAlSi₃O₈-CaAl₂Si₂O₈ for mineral equilibrium calculations. Journal of Metamorphic Geology, 40, 587-600. [doi: 10.1111/jmg.12639](https://doi.org/10.1111/jmg.12639)

- Tomlinson, E.L., & Holland, T.J.B. (2021). A Thermodynamic Model for the Subsolidus Evolution and Melting of Peridotite. Journal of Petrology, 62. [doi: 10.1093/petrology/egab012](https://doi.org/10.1093/petrology/egab012)

- Holland, T.J.B., Green, E.C.R., & Powell, R. (2018). Melting of Peridotites through to Granites: A Simple Thermodynamic Model in the System KNCFMASHTOCr. Journal of Petrology, 59, 881-900. [doi: 10.1093/petrology/egy048](https://doi.org/10.1093/petrology/egy048)

- Green, E.C.R., White, R.W., Diener, J.F.A., Powell, R., Holland, T.J.B., & Palin, R.M. (2016). Activity-composition relations for the calculation of partial melting equilibria in metabasic rocks. Journal of Metamorphic Geology, 34, 845-869. [doi: 10.1111/jmg12211](https://doi.org/10.1111/jmg12211)

- White, R.W., Powell, R., Holland, T.J.B., Johnson, T.E., & Green, E.C.R. (2014). New mineral activity-composition relations for thermodynamic calculations in metapelitic systems. Journal of Metamorphic Geology, 32, 261-286. [doi: 10.1111/jmg.12071](https://doi.org/10.1111/jmg.12071)

- Holland, T.J.B., & Powell, R.W. (2011). An improved and extended internally consistent thermodynamic dataset for phases of petrological interest, involving a new equation of state for solids. Journal of Metamorphic Geology, 29, 333-383. [doi: 10.1111/j.1525-1314.2010.00923.x](https://doi.org/10.1111/j.1525-1314.2010.00923.x)

- Stixrude, L., & Lithgow-Bertelloni, C. (2011). Thermodynamics of mantle minerals - II. Phase equilibria. Geophysical Journal International, 184, 1456-1475. [doi: 10.1111/j.1365-246X.2010.04890.x](https://doi.org/10.1111/j.1365-246X.2010.04890.x)

- Stixrude, L., & Lithgow-Bertelloni, C. (2021). Thermal expansivity, heat capacity and isothermal compressibility of the mantle. Geophysical Journal International, 228, 1296-1314. [doi: 10.1093/gji/ggab394](https://doi.org/10.1093/gji/ggab394)

- Stixrude, L., & Lithgow-Bertelloni, C. (2024). Thermodynamics of mantle minerals – III: the role of iron. Geophysical Journal International, 237(3), 1699-1733. [doi: 10.1093/gji/ggae126](https://doi.org/10.1093/gji/ggae126)

- Evans, K.A., & Frost, B.R. (2021). Deserpentinization in Subduction Zones as a Source of Oxidation in Arcs: a Reality Check. Journal of Petrology, 62(3), egab016. [doi: 10.1093/petrology/egab016](https://doi.org/10.1093/petrology/egab016)

- Diener, J.F.A., Powell, R., White, R.W., & Holland, T.J.B. (2007). A new thermodynamic model for clino- and orthoamphiboles in the system Na₂O-CaO-FeO-MgO-Al₂O₃-SiO₂-H₂O-O. Journal of Metamorphic Geology, 25, 631-656.

- Rebay, G., Powell, R., & Diener, J.F.A. (2022). New activities for the system FeO-MgO-Al₂O₃-SiO₂ with applications to metamorphic rocks. Journal of Metamorphic Geology.

- Franzolin, E., Schmidt, M.W., & Poli, S. (2011). Ternary Ca–Fe–Mg carbonates: subsolidus phase relations at 3.5 GPa and a thermodynamic solid solution model including order/disorder. Contributions to Mineralogy and Petrology, 161(2), 213-227.

- Warr, L.N. (2021). IMA-CNMNC approved mineral symbols. Mineralogical Magazine, 85, 291-320. [doi: 10.1180/mgm.2021.43](https://doi.org/10.1180/mgm.2021.43)

---

## Phase and End-member Listing

Complete list of solution phases, end-members and pure phases for each supported database. Model name labels (W14, G16, H22, …) follow the source publication abbreviations used internally.

!!! note
    The **Warr (2021)** column lists the corresponding IMA-CNMNC approved mineral abbreviation from Warr (2021). Lower-case entries (e.g. `liq`, `fl`, `nal`, `cf`) have no official Warr equivalent and are composite, theoretical, or model-specific phases.

!!! note
    The **Buffers** row lists oxygen fugacity reference assemblages available as constraints (qfm, mw, qif, nno, hm, iw, cco). The **Activities** row lists oxide activities that can be fixed as independent variables (aH2O, aO2, aMgO, aFeO, aAl2O3, aTiO2).

:::tabs

== Metapelite (mp)

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| `liq` | liq | liq_W14 | 8 | q4L · abL · kspL · anL · slL · fo2L · fa2L · h2oL |
| `fsp` | Fsp | fsp_H22 | 3 | ab · an · san |
| `bi` | Bt | bi_W14 | 7 | phl · annm · obi · east · tbi · fbi · mmbi |
| `g` | Grt | g_W14 | 5 | py · alm · spss · gr · kho |
| `ep` | Ep | ep_H11 | 3 | cz · ep · fep |
| `ma` | Mrg | ma_W14 | 6 | mut · celt · fcelt · pat · ma · fmu |
| `mu` | Ms | mu_W14 | 6 | mut · cel · fcel · pat · ma · fmu |
| `opx` | Opx | opx_W14 | 7 | en · fs · fm · mgts · fopx · mnopx · odi |
| `sa` | Spr | sa_W14 | 5 | spr4 · spr5 · fspm · spro · ospr |
| `cd` | Crd | cd_W14 | 4 | crd · fcrd · hcrd · mncd |
| `st` | St | st_W14 | 5 | mstm · fst · mnstm · msto · mstt |
| `chl` | Chl | chl_W14 | 8 | clin · afchl · ames · daph · ochl1 · ochl4 · f3clin · mmchl |
| `ctd` | Cld | ctd_W14 | 4 | mctd · fctd · mnct · ctdo |
| `sp` | Spl | sp_W02 | 4 | herc · sp · mt · usp |
| `mt` | Mag | mt_W00 | 3 | imt · dmt · usp |
| `ilm` | Ilm | ilm_W00 | 3 | oilm · dilm · dhem |
| `ilmm` | Ilm | ilmm_W14 | 5 | oilm · dilm · dhem · geik · pnt |

**Pure phases:** q · crst · trd · coe · stv · ky · sill · and · ru · sph · O2 · H2O · zo · cor

**Buffers:** qfm · mw · qif · nno · hm · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Metabasite (mb)

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| `sp` | Spl | sp_W02 | 4 | herc · sp · mt · usp |
| `spl` | Spl | spl_W02 | 3 | herc · sp · usp |
| `fsp` | Fsp | fsp_H22 | 3 | ab · an · san |
| `liq` | liq | liq_G16 | 9 | q4L · abL · kspL · wo1L · sl1L · fa2L · fo2L · h2oL · anoL |
| `mu` | Ms | mu_W14 | 6 | mu · cel · fcel · pa · mam · fmu |
| `ilmm` | Ilm | ilmm_W14 | 4 | oilm · dilm · dhem · geik |
| `ilm` | Ilm | ilm_W00 | 3 | oilm · dilm · dhem |
| `ol` | Ol | ol_H11 | 2 | fo · fa |
| `amp` | Amp | amp_G16 | 11 | tr · tsm · prgm · glm · cumm · grnm · a · b · mrb · kprg · tts |
| `ep` | Ep | ep_H11 | 3 | cz · ep · fep |
| `g` | Grt | g_W14 | 4 | py · alm · gr · kho |
| `chl` | Chl | chl_W14 | 7 | clin · afchl · ames · daph · ochl1 · ochl4 · f3clin |
| `bi` | Bt | bi_W14 | 6 | phl · annm · obi · east · tbi · fbi |
| `opx` | Opx | opx_W14 | 6 | en · fs · fm · mgts · fopx · odi |
| `dio` | Cpx | dio_G16 | 7 | jd · di · hed · acmm · om · cfm · jac |
| `aug` | Aug | aug_G16 | 8 | di · cenh · cfs · jdm · acmm · ocats · dcats · fmc |
| `abc` | Ab | abc_H11 | 2 | abm · anm |

**Pure phases:** q · crst · trd · coe · law · ky · sill · and · ru · sph · O2 · ab · H2O · zo · cor

**Buffers:** qfm · mw · qif · nno · hm · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Metabasite extended (mbe)

Extends `mb` with two additional solution phases.

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| *(all mb phases)* | — | — | — | *(see Metabasite tab)* |
| `ta` | Tlc | — (Rebay 2022) | 5 | ta · fta · ota · tap · tats |
| `oamp` | oamp | — (Diener 2007) | 9 | anth · ged · ompa · omgl · otr · fanth · omrb · amoa · amob |

**Pure phases, Buffers, Activities:** identical to `mb`.

== Igneous (ig)

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| `spl` | Spl | spl_T21 | 8 | nsp · isp · nhc · ihc · nmt · imt · pcr · qndm |
| `bi` | Bt | bi_G25 | 6 | phl · annm · obi · eas · tbi · fbi |
| `cd` | Crd | cd_G25 | 3 | crd · fcrd · hcrd |
| `cpx` | Cpx | cpx_W24 | 10 | di · cfs · cats · crdi · cess · cbuf · jd · cen · cfm · kjd |
| `ep` | Ep | ep_H11 | 3 | cz · ep · fep |
| `g` | Grt | g_W24 | 6 | py · alm · gr · andr · knom · tig |
| `amp` | Amp | amp_G16 | 11 | tr · tsm · prgm · glm · cumm · grnm · a · b · mrb · kprg · tts |
| `ilm` | Ilm | ilm_W24 | 5 | oilm · dilm · hm · ogk · dgk |
| `liq` | liq | liq_G25w | 12 | q4L · slL · wo1L · fo2L · fa2L · jdL · hmL · ekL · tiL · kjL · ctL · h2o1L |
| `ol` | Ol | ol_H18 | 4 | mont · fa · fo · cfm |
| `opx` | Opx | opx_W24 | 9 | en · fs · fm · odi · mgts · cren · obuf · mess · ojd |
| `fsp` | Fsp | fsp_H22 | 3 | ab · an · san |
| `fl` | fl | fl_G25 | 11 | qfL · slfL · wofL · fofL · fafL · jdfL · hmfL · ekfL · tifL · kjfL · H2O |
| `mu` | Ms | mu_W14 | 6 | mu · cel · fcel · pa · mam · fmu |
| `fper` | Fper | fper | 2 | per · wu |
| `chl` | Chl | chl_W14 | 7 | clin · afchl · ames · daph · ochl1 · ochl4 · f3clin |

**Pure phases:** ne · q · crst · trd · coe · stv · ky · sill · and · ru · sph · O2 · H2O · cor

**Buffers:** qfm · mw · qif · nno · hm · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Igneous Alkaline (igad)

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| `spl` | Spl | spl_T21 | 8 | nsp · isp · nhc · ihc · nmt · imt · pcr · usp |
| `cpx` | Cpx | cpx_W24 | 10 | di · cfs · cats · crdi · cess · cbuf · jd · cen · cfm · kjd |
| `g` | Grt | g_W24 | 6 | py · alm · gr · andr · knr · tig |
| `ilm` | Ilm | ilm_W24 | 5 | oilm · dilm · hm · ogk · dgk |
| `liq` | liq | liq_W24d | 14 | q3L · sl1L · wo1L · fo2L · fa2L · nmL · hmL · ekL · tiL · kmL · anL · ab1L · enL · kfL |
| `ol` | Ol | ol_H18 | 4 | mnt · fa · fo · cfm |
| `opx` | Opx | opx_W24 | 9 | en · fs · fm · odi · mgts · cren · obuf · mess · ojd |
| `fsp` | Fsp | fsp_H22 | 3 | ab · an · san |
| `lct` | Lct | lct_W24 | 2 | nlc · klc |
| `mel` | Mel | mel_W24 | 5 | geh · ak · fak · nml · fge |
| `nph` | Nph | nph_W24 | 6 | neN · neS · neK · neO · neC · neF |
| `kals` | Kls | kals_W24 | 2 | nks · kls |

**Pure phases:** q · crst · trd · coe · stv · ky · sill · and · ru · sph · O2 · cor

**Buffers:** qfm · mw · qif · nno · hm · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Ultramafic (um)

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| `fl` | fl | fl_EF21 | 2 | H2 · H2O |
| `ol` | Ol | ol_H11 | 2 | fo · fa |
| `br` | Brc | br_E13 | 2 | br · fbr |
| `ch` | Chu | ch_EF21 | 2 | chum · chuf |
| `atg` | Atg | atg_EF21 | 5 | atgf · fatg · atgo · aatg · oatg |
| `g` | Grt | g_H18 | 2 | py · alm |
| `ta` | Tlc | ta_EF21 | 6 | ta · fta · tao · tats · ota · tap |
| `chl` | Chl | chl_W14 | 7 | clin · afchl · ames · daph · ochl1 · ochl4 · f3clin |
| `spi` | Spl | spi_W02 | 3 | herc · sp · mt |
| `opx` | Opx | opx_W14 | 5 | en · fs · fm · mgts · fopx |
| `po` | Po | po_E10 | 2 | trov · trot |
| `anth` | Ath | anth_D07 | 5 | anth · gedf · fant · a · b |

**Pure phases:** q · crst · trd · coe · stv · ky · sill · and · pyr · O2 · hem · cor

**Buffers:** qfm · qif · nno · hm · mw · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Ultramafic extended (ume)

Extends `um` with plagioclase, amphibole, augite, spinel, carbonated fluid and carbonates.

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| *(all um phases)* | — | — | — | *(see Ultramafic tab)* |
| `pl4tr` | Pl | fsp_H22 | 2 | ab · an |
| `amp` | Amp | amp_G16 | 9 | tr · tsm · prgm · glm · cumm · grnm · a · b · mrb |
| `aug` | Aug | aug_G16 | 8 | di · cenh · cfs · jdm · acmm · ocats · dcats · fmc |
| `spl` | Spl | — | 7 | nsp · isp · nhc · ihc · nmt · imt · pcr |
| `flc` | flc | fl_H03 | 2 | H2O · CO2 |
| `occm` | occm | occm_F11 | 5 | cc · odo · mag · sid · oank |

**Pure phases:** q · crst · trd · coe · stv · ky · sill · and · pyr · O2 · hem · H2O · cor · gph

**Buffers:** qfm · qif · nno · hm · mw · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Mantle (mtl)

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| `g` | Grt | g_H13 | 6 | py · alm · gr · maj · gfm · nagt |
| `fp` | Fper | fp_H13 | 2 | per · fper |
| `mpv` | mpv | mpv_H13 | 5 | mpv · fpvm · cpvm · apv · npvm |
| `cpv` | cpv | cpv_H13 | 5 | mpv · fpvm · cpvm · apv · npvm |
| `crn` | crn | crn_H13 | 3 | cor · mcor · fcor |
| `cf` | cf | cf_H13 | 6 | macf · cacf · mscf · fscf · oscf · nacfm |
| `nal` | nal | nal_H13 | 7 | nanal · canal · manal · msnal · fsnal · o1nal · o2nal |
| `aki` | Aki | aki_H13 | 3 | aak · mak · fak |
| `ol` | Ol | ol_H13 | 2 | fo · fa |
| `wad` | Wds | wad_H13 | 2 | mwd · fwd |
| `ring` | ring | ring_H13 | 2 | mrw · frw |
| `cpx` | Cpx | cpx_H13 | 6 | di · cfs · cats · jd · cen · cfm |
| `opx` | Opx | opx_H13 | 5 | en · fs · fm · odi · mgts |
| `hpx` | hpx | hpx_H13 | 5 | en · fs · fm · odi · hmts |

**Pure phases:** q · crst · trd · coe · stv · ky · sill · and

== Metapelite extended (mpe)

Extends `mp` with phases from Green et al. (2016), Evans & Frost (2021), and Diener et al. (2007).

| Phase | Warr (2021) | Model | em | End-members |
|---|---|---|:---:|---|
| *(all mp phases)* | — | — | — | *(see Metapelite tab)* |
| `occm` | occm | occm_F11 | 5 | cc · odo · mag · sid · oank |
| `fl` | fl | fl_H03 | 2 | H2O · CO2 |
| `po` | Po | po_E10 | 2 | trov · trot |
| `dio` | Cpx | dio_G16 | 7 | jd · di · hed · acmm · om · cfm · jac |
| `aug` | Aug | aug_G16 | 8 | di · cenh · cfs · jdm · acmm · ocats · dcats · fmc |
| `amp` | Amp | amp_G16 | 11 | tr · tsm · prgm · glm · cumm · grnm · a · b · mrb · kprg · tts |
| `oamp` | oamp | — (Diener 2007) | 9 | anth · ged · ompa · omgl · otr · fanth · omrb · amoa · amob |
| `carp` | Cph | — | 2 | mcar · fcar |

**Pure phases:** q · crst · trd · coe · stv · ky · sill · and · ru · sph · O2 · pyr · gph · law · zo · prl · mpm · pre · cor

**Buffers:** qfm · mw · qif · nno · hm · iw · cco &nbsp;&nbsp; **Activities:** aH2O · aO2 · aMgO · aFeO · aAl2O3 · aTiO2

== Mantle SB11

Stixrude & Lithgow-Bertelloni (2011). End-member names follow the SLB internal convention.

| Phase | Warr (2021) | em | End-members |
|---|---|:---:|---|
| `plg` | Pl | 2 | an · ab |
| `sp` | Spl | 2 | sp · hc |
| `ol` | Ol | 2 | fo · fa |
| `wa` | Wds | 2 | mgwa · fewa |
| `ri` | ring | 2 | mgri · feri |
| `opx` | Opx | 4 | en · fs · mgts · odi |
| `cpx` | Cpx | 5 | di · he · cen · cats · jd |
| `hpcpx` | hpcpx | 2 | hpcen · hpcfs |
| `ak` | Aki | 3 | mgak · feak · co |
| `gtmj` | Grt | 5 | py · alm · gr · mgmj · jdmj |
| `pv` | pv | 3 | mgpv · fepv · alpv |
| `ppv` | ppv | 3 | mppv · fppv · appv |
| `mw` | Fper | 2 | pe · wu |
| `cf` | cf | 3 | mgcf · fecf · nacf |

**Pure phases:** neph · ky · st · coe · qtz · capv · co &nbsp;&nbsp; **Activities:** aMgO · aFeO · aAl2O3

== Mantle SB21

Stixrude & Lithgow-Bertelloni (2021). Extends SB11 with new-aluminium-phase (`nal`) and an extra end-member in `mw`.

| Phase | Warr (2021) | em | End-members |
|---|---|:---:|---|
| `plg` | Pl | 2 | an · ab |
| `sp` | Spl | 2 | sp · hc |
| `ol` | Ol | 2 | fo · fa |
| `wa` | Wds | 2 | mgwa · fewa |
| `ri` | ring | 2 | mgri · feri |
| `opx` | Opx | 4 | en · fs · mgts · odi |
| `cpx` | Cpx | 5 | di · he · cen · cats · jd |
| `hpcpx` | hpcpx | 2 | hpcen · hpcfs |
| `ak` | Aki | 3 | mgak · feak · co |
| `gtmj` | Grt | 5 | py · alm · gr · mgmj · jdmj |
| `pv` | pv | 3 | mgpv · fepv · alpv |
| `ppv` | ppv | 3 | mppv · fppv · appv |
| `cf` | cf | 3 | mgcf · fecf · nacf |
| `mw` | Fper | 3 | pe · wu · anao |
| `nal` | nal | 3 | mnal · fnal · nnal |

**Pure phases:** neph · ky · st · coe · qtz · capv · co &nbsp;&nbsp; **Activities:** aMgO · aFeO · aAl2O3

== Mantle SB24

Stixrude & Lithgow-Bertelloni (2024). Expanded solid solutions throughout; new iron polymorphs and high-pressure phases as pure phases.

| Phase | Warr (2021) | em | End-members |
|---|---|:---:|---|
| `plg` | Pl | 2 | an · ab |
| `sp` | Spl | 4 | sp · hc · smag · picr |
| `ol` | Ol | 2 | fo · fa |
| `wa` | Wds | 2 | mgwa · fewa |
| `ri` | ring | 2 | mgri · feri |
| `opx` | Opx | 4 | en · fs · mgts · odi |
| `cpx` | Cpx | 6 | di · he · cen · cats · jd · acm |
| `hpcpx` | hpcpx | 2 | mgc2 · fec2 |
| `ak` | Aki | 5 | mgak · feak · co · hem · esk |
| `gtmj` | Grt | 7 | py · alm · gr · mgmj · jdmj · knor · andr |
| `pv` | pv | 7 | mgpv · fepv · alpv · hepv · hlpv · fapv · crpv |
| `ppv` | ppv | 5 | mppv · fppv · appv · hppv · cppv |
| `cf` | cf | 5 | mgcf · fecf · nacf · hmag · crcf |
| `mw` | Fper | 5 | pe · wu · wuls · mag · anao |
| `nal` | nal | 3 | mnal · fnal · nnal |

**Pure phases:** neph · ky · st · coe · qtz · capv · O2 · fea · fee · feg · apbo · wo · lppv · pwo &nbsp;&nbsp; **Activities:** aMgO · aFeO · aAl2O3

:::

---

## Trace-element partitioning models

### OL fixed Kd database

The OL model uses a fixed set of empirical mineral/melt partition coefficients compiled by O. Laurent (2012). Kd values are tabulated as geometric-mean estimates subdivided into three melt SiO₂ ranges. Phase abbreviations used throughout:

| Abbreviation | Phase | Warr (2021) |
|---|---|---|
| cpx | clinopyroxene | Cpx |
| pl | plagioclase | Pl |
| g | garnet | Grt |
| opx | orthopyroxene | Opx |
| ol | olivine | Ol |
| amp | amphibole | Amp |
| bi | biotite | Bt |
| afs | alkali feldspar | Afs |
| mu | muscovite | Ms |
| ttn | titanite (sphene) | Ttn |
| ap | apatite | Ap |
| zrc | zircon | Zrn |
| ep | epidote | Ep |
| all | allanite | Aln |
| mgt | magnetite | Mag |
| ru | rutile | Rt |
| FeTiOx | Fe-Ti oxide | — |
| sp | spinel | Spl |
| cd | cordierite | Crd |
| q | quartz | Qz |
| and | andalusite | And |
| sill | sillimanite | Sil |

!!! note
    Phases marked `—` are not present in that compositional range. Values of `1e-5` indicate nominally incompatible or effectively zero partitioning.

#### Mafic compositions

| Element | cpx | pl | g | opx | ol | amp | bi | afs | mu | ttn | ap | zrc | ep | all | mgt | ru | FeTiOx | sp | cd | and | sill | q |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| La | 0.632 | 0.387 | 0.100 | 0.158 | 0.0671 | 0.559 | 1.265 | 0.141 | 1e-5 | 6.00 | 13.2 | 1.26 | 2.05 | 1549 | 1.02 | 0.0354 | 3.35 | 0.00245 | 0.0742 | 1e-5 | 1e-5 | 0.00316 |
| Ce | 1.095 | 0.285 | 0.237 | 0.240 | 0.0775 | 1.000 | 0.949 | 0.0866 | 1e-5 | 7.42 | 21.2 | 3.46 | 2.44 | 1225 | 1.000 | 0.0458 | 2.83 | 0.00387 | 0.0849 | 1e-5 | 1e-5 | 0.00316 |
| Pr | 1.483 | 0.221 | 0.461 | 0.290 | 0.0917 | 1.597 | 0.791 | 0.0548 | 1e-5 | 8.83 | 30.6 | 2.00 | 2.85 | 1006 | 1.061 | 0.0495 | 2.58 | 0.00600 | 0.0990 | 1e-5 | 1e-5 | 0.00316 |
| Nd | 1.936 | 0.158 | 0.866 | 0.354 | 0.106 | 2.646 | 0.791 | 0.0316 | 1e-5 | 10.2 | 40.3 | 2.83 | 3.34 | 794 | 1.095 | 0.0566 | 2.51 | 0.00812 | 0.120 | 1e-5 | 1e-5 | 0.00316 |
| Sm | 2.324 | 0.126 | 1.937 | 0.424 | 0.122 | 3.464 | 0.632 | 0.0187 | 1e-5 | 10.95 | 47.4 | 7.75 | 4.22 | 447 | 1.095 | 0.0566 | 2.37 | 0.0116 | 0.173 | 1e-5 | 1e-5 | 0.00316 |
| Eu | 2.775 | 2.739 | 1.581 | 0.316 | 0.141 | 3.464 | 0.316 | 3.873 | 1e-5 | 8.06 | 21.2 | 2.24 | 3.78 | 98.0 | 0.949 | 0.00112 | 0.632 | 0.0106 | 0.0316 | 1e-5 | 1e-5 | 0.00316 |
| Gd | 3.062 | 0.116 | 6.124 | 0.583 | 0.132 | 4.743 | 0.512 | 0.0187 | 1e-5 | 10.2 | 52.9 | 20.5 | 4.67 | 255 | 1.183 | 0.0355 | 2.37 | 0.0145 | 0.403 | 1e-5 | 1e-5 | 0.00316 |
| Tb | 3.464 | 0.102 | 11.18 | 0.725 | 0.155 | 5.374 | 0.522 | 0.0167 | 1e-5 | 9.30 | 52.9 | 28.5 | 4.58 | 170 | 1.183 | 0.0278 | 1.90 | 0.0150 | 0.671 | 1e-5 | 1e-5 | 0.00316 |
| Dy | 3.578 | 0.0949 | 22.36 | 0.849 | 0.175 | 5.422 | 0.520 | 0.0200 | 1e-5 | 7.88 | 45.8 | 44.2 | 4.50 | 118 | 1.107 | 0.0257 | 1.58 | 0.0150 | 1.146 | 1e-5 | 1e-5 | 0.00316 |
| Y | 3.240 | 0.100 | 25.5 | 0.775 | 0.126 | 5.745 | 0.775 | 0.0316 | 1e-5 | 6.00 | 38.7 | 67.1 | 4.30 | 95.4 | 0.949 | 0.0707 | 0.447 | 0.0158 | 0.987 | 1e-5 | 1e-5 | 0.00316 |
| Ho | 3.354 | 0.0775 | 32.4 | 0.925 | 0.194 | 5.244 | 0.539 | 0.0200 | 1e-5 | 6.56 | 37.1 | 73.5 | 4.12 | 84.9 | 1.025 | 0.0242 | 1.58 | 0.0141 | 1.581 | 1e-5 | 1e-5 | 0.00316 |
| Er | 3.186 | 0.0693 | 41.2 | 1.000 | 0.232 | 4.970 | 0.555 | 0.0224 | 1e-5 | 5.17 | 30.0 | 110 | 3.78 | 63.2 | 0.866 | 0.0218 | 1.58 | 0.0133 | 2.291 | 1e-5 | 1e-5 | 0.00316 |
| Tm | 3.074 | 0.0574 | 44.7 | 1.162 | 0.277 | 4.500 | 0.557 | 0.0235 | 1e-5 | 3.73 | 22.9 | 140 | 3.34 | 43.3 | 0.866 | 0.0185 | 1.42 | 0.0130 | 2.806 | 1e-5 | 1e-5 | 0.00316 |
| Yb | 2.898 | 0.0524 | 44.7 | 1.275 | 0.316 | 3.742 | 0.559 | 0.0234 | 1e-5 | 2.57 | 15.8 | 173 | 2.96 | 26.8 | 0.707 | 0.0173 | 1.26 | 0.0124 | 3.162 | 1e-5 | 1e-5 | 0.00316 |
| Lu | 2.775 | 0.0447 | 37.4 | 1.549 | 0.387 | 2.958 | 0.559 | 0.0245 | 1e-5 | 1.67 | 12.5 | 224 | 2.62 | 17.7 | 0.548 | 0.0158 | 1.26 | 0.0116 | 3.518 | 1e-5 | 1e-5 | 0.00316 |
| Sc | 26.46 | 0.0316 | 22.36 | 22.36 | 0.447 | 14.14 | 9.220 | 0.0316 | 1e-5 | 2.24 | 0.316 | 63.2 | 0.0001 | 57.0 | 8.660 | 0.316 | 4.47 | 0.316 | 2.236 | 1e-5 | 1e-5 | 0.00316 |
| Rb | 0.0316 | 0.126 | 0.00791 | 0.0158 | 0.0224 | 0.0548 | 4.000 | 0.949 | 1e-5 | 0.400 | 0.00316 | 0.632 | 0.0045 | 0.0632 | 0.0224 | 0.0118 | 0.0224 | 0.00548 | 0.106 | 1e-5 | 1e-5 | 0.00316 |
| Ba | 0.122 | 0.632 | 0.0173 | 0.0500 | 0.0300 | 0.190 | 6.708 | 9.487 | 1e-5 | 1.37 | 0.274 | 0.632 | 0.408 | 3.46 | 0.0224 | 0.0100 | 0.0224 | 0.00224 | 0.0224 | 1e-5 | 1e-5 | 0.00316 |
| Sr | 0.335 | 4.472 | 0.0224 | 0.0447 | 0.132 | 0.387 | 0.224 | 3.873 | 1e-5 | 2.24 | 7.07 | 4.47 | 2.00 | 1.00 | 0.0265 | 0.0707 | 0.194 | 0.00346 | 0.187 | 1e-5 | 1e-5 | 0.00316 |
| Pb | 0.224 | 0.671 | 0.0316 | 0.0894 | 0.158 | 0.632 | 0.316 | 0.949 | 1e-5 | 0.224 | 0.158 | 0.100 | 0.500 | 0.316 | 0.548 | 0.0316 | 0.447 | 0.000316 | 0.0316 | 1e-5 | 1e-5 | 0.00316 |
| Th | 0.141 | 0.0548 | 0.0775 | 0.158 | 0.0200 | 0.212 | 0.316 | 0.0145 | 1e-5 | 0.224 | 1.00 | 18.0 | 156 | 424 | 0.221 | 0.335 | 0.387 | 0.00791 | 0.194 | 1e-5 | 1e-5 | 0.00316 |
| U | 0.155 | 0.100 | 0.158 | 0.158 | 0.0155 | 0.822 | 0.316 | 0.0158 | 1e-5 | 0.200 | 0.949 | 31.6 | 1.29 | 20.0 | 0.447 | 0.335 | 0.387 | 0.0132 | 0.632 | 1e-5 | 1e-5 | 0.00316 |
| Zr | 0.387 | 0.0894 | 0.447 | 0.0548 | 0.0253 | 0.632 | 0.632 | 0.0194 | 1e-5 | 1.34 | 0.387 | 949 | 0.100 | 0.173 | 0.671 | 3.46 | 1.58 | 0.0791 | 0.0612 | 1e-5 | 1e-5 | 0.00316 |
| Hf | 0.548 | 0.0671 | 0.707 | 0.0949 | 0.0285 | 0.707 | 0.632 | 0.0158 | 1e-5 | 1.73 | 0.387 | 949 | 10.0 | 12.2 | 0.707 | 5.29 | 1.58 | 0.100 | 0.0775 | 1e-5 | 1e-5 | 0.00316 |
| Ta | 0.155 | 0.0671 | 0.0707 | 0.316 | 0.0335 | 0.400 | 1.897 | 0.00707 | 1e-5 | 8.66 | 0.0316 | 22.4 | 0.226 | 2.74 | 2.121 | 27.4 | 44.7 | 0.0707 | 0.0316 | 1e-5 | 1e-5 | 0.00316 |
| Nb | 0.110 | 0.100 | 0.0316 | 0.253 | 0.0312 | 2.000 | 6.325 | 0.0447 | 1e-5 | 3.46 | 0.0316 | 22.4 | 0.226 | 0.447 | 1.673 | 61.2 | 28.3 | 0.0707 | 0.0316 | 1e-5 | 1e-5 | 0.00316 |
| V | 4.743 | 0.158 | 4.472 | 3.162 | 0.245 | 6.708 | 3.162 | 0.224 | 1e-5 | 5.48 | 0.316 | 0.100 | 0.100 | 1.00 | 36.06 | 47.4 | 31.6 | 8.37 | 0.447 | 1e-5 | 1e-5 | 0.00316 |

#### Intermediate compositions

Phases `and`, `sill`, `mu` and `ep` are absent in this range.

| Element | cpx | pl | g | opx | ol | amp | bi | afs | ttn | ap | zrc | all | mgt | ru | FeTiOx | sp | cd | q |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| La | 0.132 | 0.200 | 0.0265 | 0.00894 | 0.00274 | 0.335 | 0.0592 | 0.112 | 6.00 | 3.87 | 1.26 | 1414 | 0.141 | 0.0112 | 0.0224 | 0.00245 | 0.0742 | 0.00316 |
| Ce | 0.212 | 0.155 | 0.0520 | 0.0205 | 0.00490 | 0.412 | 0.0600 | 0.0671 | 7.42 | 7.07 | 3.46 | 1175 | 0.190 | 0.0141 | 0.0306 | 0.00387 | 0.0849 | 0.00316 |
| Pr | 0.291 | 0.122 | 0.102 | 0.0363 | 0.00791 | 0.574 | 0.0649 | 0.0447 | 8.83 | 11.1 | 2.00 | 949 | 0.235 | 0.0157 | 0.0367 | 0.00600 | 0.0990 | 0.00316 |
| Nd | 0.402 | 0.106 | 0.206 | 0.0574 | 0.0116 | 0.866 | 0.0671 | 0.0300 | 10.2 | 15.0 | 2.83 | 612 | 0.267 | 0.0172 | 0.0412 | 0.00812 | 0.120 | 0.00316 |
| Sm | 0.500 | 0.0775 | 0.433 | 0.0812 | 0.0153 | 1.369 | 0.0707 | 0.0212 | 10.95 | 17.3 | 7.75 | 300 | 0.300 | 0.0185 | 0.0548 | 0.0116 | 0.173 | 0.00316 |
| Eu | 0.693 | 1.118 | 0.500 | 0.114 | 0.0188 | 1.000 | 0.132 | 3.354 | 8.06 | 11.2 | 2.24 | 34.6 | 0.255 | 0.000632 | 0.0447 | 0.0106 | 0.0316 | 0.00316 |
| Gd | 0.726 | 0.0447 | 1.581 | 0.157 | 0.0228 | 1.803 | 0.0742 | 0.0167 | 10.2 | 18.4 | 20.5 | 116 | 0.324 | 0.0195 | 0.0791 | 0.0145 | 0.403 | 0.00316 |
| Tb | 0.849 | 0.0367 | 3.162 | 0.208 | 0.0271 | 2.214 | 0.0775 | 0.0150 | 9.30 | 17.9 | 28.5 | 58.3 | 0.312 | 0.0205 | 0.0900 | 0.0150 | 0.671 | 0.00316 |
| Dy | 0.954 | 0.0300 | 5.454 | 0.256 | 0.0324 | 2.291 | 0.0794 | 0.0145 | 7.88 | 15.7 | 44.2 | 31.6 | 0.302 | 0.0222 | 0.0990 | 0.0150 | 1.146 | 0.00316 |
| Y | 1.095 | 0.0292 | 6.124 | 0.283 | 0.0346 | 2.121 | 0.112 | 0.0255 | 6.00 | 12.2 | 67.1 | 31.6 | 0.335 | 0.0274 | 0.0707 | 0.0158 | 0.987 | 0.00316 |
| Ho | 1.063 | 0.0257 | 8.292 | 0.311 | 0.0370 | 2.086 | 0.0775 | 0.0162 | 6.56 | 13.4 | 73.5 | 19.0 | 0.268 | 0.0240 | 0.102 | 0.0141 | 1.581 | 0.00316 |
| Er | 1.141 | 0.0212 | 9.899 | 0.351 | 0.0400 | 1.817 | 0.0748 | 0.0190 | 5.17 | 11.2 | 110 | 13.4 | 0.246 | 0.0265 | 0.112 | 0.0133 | 2.291 | 0.00316 |
| Tm | 1.182 | 0.0182 | 10.06 | 0.400 | 0.0440 | 1.517 | 0.0735 | 0.0200 | 3.73 | 8.94 | 140 | 10.2 | 0.235 | 0.0291 | 0.117 | 0.0130 | 2.806 | 0.00316 |
| Yb | 1.186 | 0.0170 | 9.354 | 0.458 | 0.0474 | 1.407 | 0.0727 | 0.0232 | 2.57 | 6.71 | 173 | 7.75 | 0.224 | 0.0315 | 0.117 | 0.0124 | 3.162 | 0.00316 |
| Lu | 1.183 | 0.0155 | 7.746 | 0.500 | 0.0529 | 1.304 | 0.0707 | 0.0274 | 1.67 | 4.47 | 224 | 6.71 | 0.212 | 0.0335 | 0.110 | 0.0116 | 3.518 | 0.00316 |
| Sc | 7.746 | 0.0316 | 3.162 | 5.477 | 0.433 | 10.00 | 9.220 | 0.0200 | 2.24 | 0.316 | 63.2 | 57.0 | 3.162 | 0.274 | 1.73 | 0.316 | 2.236 | 0.00316 |
| Rb | 0.0316 | 0.0447 | 0.00837 | 0.0245 | 0.0132 | 0.122 | 3.162 | 0.949 | 0.400 | 0.00316 | 0.632 | 0.0632 | 0.0387 | 0.0100 | 0.00316 | 0.00548 | 0.106 | 0.00316 |
| Ba | 0.0548 | 0.387 | 0.0155 | 0.0316 | 0.0122 | 0.224 | 5.477 | 5.477 | 1.37 | 0.0791 | 0.632 | 3.46 | 0.158 | 0.00866 | 0.00447 | 0.00224 | 0.0224 | 0.00316 |
| Sr | 0.287 | 2.449 | 0.0173 | 0.0194 | 0.0100 | 0.274 | 0.235 | 2.236 | 2.24 | 1.94 | 4.47 | 1.00 | 0.0224 | 0.0316 | 0.00632 | 0.00346 | 0.187 | 0.00316 |
| Pb | 0.316 | 0.500 | 0.0316 | 0.112 | 0.0187 | 0.224 | 0.0316 | 0.224 | 0.224 | 0.316 | 0.100 | 1.00 | 0.316 | 0.0274 | 0.0158 | 0.000316 | 0.0316 | 0.00316 |
| Th | 0.0707 | 0.0316 | 0.0474 | 0.100 | 0.0155 | 0.141 | 0.0474 | 0.0173 | 0.224 | 0.791 | 18.0 | 324 | 0.0935 | 0.162 | 0.0158 | 0.00791 | 0.194 | 0.00316 |
| U | 0.0447 | 0.0548 | 0.0935 | 0.0316 | 0.0224 | 0.100 | 0.0707 | 0.0274 | 0.200 | 0.387 | 31.6 | 13.2 | 0.132 | 0.200 | 0.0237 | 0.0132 | 0.632 | 0.00316 |
| Zr | 0.235 | 0.0224 | 0.548 | 0.0346 | 0.0387 | 0.400 | 0.229 | 0.0224 | 1.34 | 0.194 | 949 | 0.173 | 0.221 | 2.24 | 1.22 | 0.0791 | 0.0612 | 0.00316 |
| Hf | 0.312 | 0.0324 | 0.387 | 0.0548 | 0.0224 | 0.548 | 0.316 | 0.0224 | 1.73 | 0.0707 | 949 | 11.2 | 0.158 | 3.74 | 1.50 | 0.100 | 0.0775 | 0.00316 |
| Ta | 0.0707 | 0.0447 | 0.0500 | 0.0671 | 0.0274 | 0.274 | 0.316 | 0.00316 | 8.66 | 0.00707 | 22.4 | 0.837 | 0.122 | 22.4 | 6.71 | 0.0707 | 0.0316 | 0.00316 |
| Nb | 0.112 | 0.0612 | 0.0265 | 0.0500 | 0.0194 | 0.559 | 0.474 | 0.0158 | 3.46 | 0.00354 | 22.4 | 0.837 | 0.137 | 33.5 | 4.47 | 0.0707 | 0.0316 | 0.00316 |
| V | 1.936 | 0.158 | 2.646 | 1.500 | 0.164 | 5.477 | 3.162 | 0.112 | 5.48 | 0.224 | 0.100 | 1.00 | 22.36 | 3.16 | 11.2 | 8.37 | 0.447 | 0.00316 |

#### Felsic compositions

Phases `and`, `sill` and `mu` are absent in this range; `ep` reappears.

| Element | cpx | pl | g | opx | ol | amp | bi | afs | ttn | ap | zrc | ep | all | mgt | ru | FeTiOx | sp | cd | q |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| La | 0.0474 | 0.112 | 0.00894 | 0.000837 | 0.000224 | 0.0725 | 0.0145 | 0.112 | 6.00 | 3.87 | 1.26 | 2.05 | 1414 | 0.0126 | 0.0112 | 0.0224 | 0.00245 | 0.0742 | 0.00316 |
| Ce | 0.0866 | 0.0894 | 0.0219 | 0.00265 | 0.000447 | 0.145 | 0.0190 | 0.0671 | 7.42 | 7.07 | 0.100 | 2.44 | 1175 | 0.0274 | 0.0141 | 0.0306 | 0.00387 | 0.0849 | 0.00316 |
| Pr | 0.145 | 0.0714 | 0.0566 | 0.00548 | 0.000935 | 0.235 | 0.0245 | 0.0447 | 8.83 | 11.1 | 2.00 | 2.89 | 949 | 0.0474 | 0.0157 | 0.0367 | 0.00600 | 0.0990 | 0.00316 |
| Nd | 0.216 | 0.0592 | 0.122 | 0.0110 | 0.00158 | 0.346 | 0.0312 | 0.0300 | 10.2 | 15.0 | 2.83 | 3.78 | 612 | 0.0624 | 0.0172 | 0.0412 | 0.00812 | 0.120 | 0.00316 |
| Sm | 0.302 | 0.0490 | 0.265 | 0.0180 | 0.00251 | 0.447 | 0.0387 | 0.0212 | 10.95 | 17.3 | 7.75 | 4.22 | 300 | 0.0725 | 0.0185 | 0.0548 | 0.0116 | 0.173 | 0.00316 |
| Eu | 0.387 | 0.707 | 0.424 | 0.0224 | 0.00316 | 0.524 | 0.0418 | 3.354 | 8.06 | 11.2 | 2.24 | 3.78 | 34.6 | 0.0361 | 0.000632 | 0.0447 | 0.0106 | 0.0316 | 0.00316 |
| Gd | 0.461 | 0.0387 | 0.822 | 0.0324 | 0.00424 | 0.590 | 0.0447 | 0.0167 | 10.2 | 18.4 | 20.5 | 4.67 | 116 | 0.0775 | 0.0195 | 0.0791 | 0.0145 | 0.403 | 0.00316 |
| Tb | 0.522 | 0.0338 | 1.323 | 0.0412 | 0.00629 | 0.635 | 0.0520 | 0.0150 | 9.30 | 17.9 | 28.5 | 4.59 | 58.3 | 0.0703 | 0.0205 | 0.0900 | 0.0150 | 0.671 | 0.00316 |
| Dy | 0.551 | 0.0300 | 1.936 | 0.0500 | 0.00908 | 0.669 | 0.0592 | 0.0145 | 7.88 | 15.7 | 44.2 | 4.50 | 31.6 | 0.0666 | 0.0222 | 0.0990 | 0.0150 | 1.146 | 0.00316 |
| Y | 0.600 | 0.0357 | 2.324 | 0.0671 | 0.00775 | 0.612 | 0.0663 | 0.0255 | 6.00 | 12.2 | 67.1 | 4.30 | 31.6 | 0.0592 | 0.0274 | 0.0707 | 0.0158 | 0.987 | 0.00316 |
| Ho | 0.586 | 0.0267 | 2.550 | 0.0620 | 0.0132 | 0.681 | 0.0693 | 0.0162 | 6.56 | 13.4 | 73.5 | 4.14 | 19.0 | 0.0620 | 0.0240 | 0.102 | 0.0141 | 1.581 | 0.00316 |
| Er | 0.608 | 0.0241 | 3.122 | 0.0735 | 0.0194 | 0.648 | 0.0748 | 0.0190 | 5.17 | 11.2 | 110 | 3.78 | 13.4 | 0.0566 | 0.0265 | 0.112 | 0.0133 | 2.291 | 0.00316 |
| Tm | 0.608 | 0.0222 | 3.518 | 0.0917 | 0.0242 | 0.604 | 0.0794 | 0.0200 | 3.73 | 8.94 | 140 | 3.37 | 10.2 | 0.0548 | 0.0291 | 0.117 | 0.0130 | 2.806 | 0.00316 |
| Yb | 0.586 | 0.0203 | 4.023 | 0.107 | 0.0274 | 0.536 | 0.0820 | 0.0232 | 2.57 | 6.71 | 173 | 2.96 | 7.75 | 0.0500 | 0.0315 | 0.117 | 0.0124 | 3.162 | 0.00316 |
| Lu | 0.560 | 0.0179 | 4.472 | 0.120 | 0.0283 | 0.458 | 0.0866 | 0.0274 | 1.67 | 4.47 | 224 | 2.55 | 6.71 | 0.0447 | 0.0335 | 0.110 | 0.0116 | 3.518 | 0.00316 |
| Sc | 4.743 | 0.0316 | 3.742 | 1.225 | 0.287 | 3.873 | 9.220 | 0.0200 | 2.24 | 0.316 | 63.2 | 0.0001 | 57.0 | 1.414 | 0.274 | 1.73 | 0.316 | 2.236 | 0.00316 |
| Rb | 0.00949 | 0.0548 | 0.000866 | 0.00548 | 0.00224 | 0.224 | 2.000 | 0.949 | 0.400 | 0.00316 | 0.632 | 0.0045 | 0.0632 | 0.0158 | 0.0100 | 0.00316 | 0.00548 | 0.106 | 0.00316 |
| Ba | 0.00500 | 0.335 | 0.000387 | 0.00173 | 0.00224 | 0.312 | 4.472 | 5.477 | 1.37 | 0.0791 | 0.632 | 0.408 | 3.46 | 0.0158 | 0.00866 | 0.00447 | 0.00224 | 0.0224 | 0.00316 |
| Sr | 0.122 | 1.658 | 0.0132 | 0.0141 | 0.000110 | 0.300 | 0.235 | 2.236 | 2.24 | 1.94 | 4.47 | 2.00 | 1.00 | 0.0122 | 0.0316 | 0.00632 | 0.00346 | 0.187 | 0.00316 |
| Pb | 0.0224 | 0.592 | 0.0122 | 0.0200 | 0.000194 | 0.0632 | 0.0316 | 0.224 | 0.224 | 0.316 | 0.316 | 0.500 | 1.00 | 0.0592 | 0.0274 | 0.0158 | 0.000316 | 0.0316 | 0.00316 |
| Th | 0.00935 | 0.100 | 0.00200 | 0.000316 | 0.000707 | 0.0141 | 0.0474 | 0.0173 | 0.224 | 0.791 | 18.0 | 156 | 324 | 0.0387 | 0.162 | 0.0158 | 0.00791 | 0.194 | 0.00316 |
| U | 0.00707 | 0.0632 | 0.00612 | 0.000500 | 0.000707 | 0.0194 | 0.0707 | 0.0274 | 0.200 | 0.387 | 31.6 | 1.29 | 13.2 | 0.0387 | 0.200 | 0.0237 | 0.0132 | 0.632 | 0.00316 |
| Zr | 0.0707 | 0.0100 | 0.300 | 0.0292 | 0.00316 | 0.335 | 0.0548 | 0.0224 | 1.34 | 0.194 | 949 | 0.100 | 0.173 | 0.151 | 2.24 | 1.22 | 0.0791 | 0.0612 | 0.00316 |
| Hf | 0.187 | 0.0155 | 0.252 | 0.0548 | 0.00548 | 0.391 | 0.0548 | 0.0224 | 1.73 | 0.0707 | 949 | 10.0 | 11.2 | 0.200 | 3.74 | 1.50 | 0.100 | 0.0775 | 0.00316 |
| Ta | 0.0180 | 0.0447 | 0.0180 | 0.00632 | 0.00500 | 0.221 | 0.187 | 0.00316 | 8.66 | 0.00707 | 22.4 | 0.226 | 0.837 | 0.100 | 22.4 | 6.71 | 0.0707 | 0.0316 | 0.00316 |
| Nb | 0.00894 | 0.0447 | 0.0132 | 0.00346 | 0.00274 | 0.158 | 0.274 | 0.0158 | 3.46 | 0.00354 | 22.4 | 0.226 | 0.837 | 0.100 | 33.5 | 4.47 | 0.0707 | 0.0316 | 0.00316 |
| V | 1.581 | 0.0671 | 2.449 | 1.000 | 0.0775 | 4.899 | 3.162 | 0.112 | 5.48 | 0.224 | 0.100 | 0.100 | 1.00 | 6.32 | 3.16 | 11.2 | 8.37 | 0.447 | 0.00316 |

---

### CO lattice strain model

The CO model (ported from TEPM v02.02, Cornet 2017) computes mineral/melt Kd values from first principles using the **Brice (1975) lattice strain** partitioning equation. Unlike OL, all Kd values are fully predictive and depend on the mineral composition, melt composition, temperature and pressure at each P-T node.

#### Elements and output order

Twenty-eight elements are predicted in the following fixed order:

| Group | Elements |
|---|---|
| LILE 1+ | Cs · Rb · K |
| LILE 2+ | Ba · Sr |
| REE + Y + Sc | La · Ce · Pr · Nd · Sm · Eu · Gd · Tb · Dy · Y · Ho · Er · Tm · Yb · Lu · Sc |
| HFSE 4+ | Ti · Hf · Zr |
| Actinides | U · Th |
| HFSE 5+ | Ta · Nb |

#### Brice lattice strain equation

The partition coefficient of an element *i* entering a crystallographic site of optimal-fit radius *r₀* is:

$$D_i = D_0 \exp\!\left[\frac{-4\pi N_A E}{RT}\left(\frac{r_0}{2}(r_0^2 - r_i^2) - \frac{r_0^3 - r_i^3}{3}\right)\right]$$

where:
- $D_0$ — peak partition coefficient at the optimal ionic radius $r_0$
- $E$ — Young's modulus of the crystallographic site [GPa]
- $r_i$ — ionic radius of element *i* in the relevant coordination (Shannon, 1976)
- $r_0$ — optimal-fit radius of the site
- $T$ — temperature [K]
- $R$ — gas constant (8.3145 J mol⁻¹ K⁻¹)
- $N_A$ — Avogadro's number

A second variant ("mixed Brice") separates the elastic radius $r_e$ from the fixed reference cation radius $r_\text{ref}$ when the peak is anchored to a cation with a known $D_0$:

$$D_i = D_0 \exp\!\left[\frac{-4\pi N_A E}{RT}\left(\frac{r_e}{2}(r_\text{ref}^2 - r_i^2) - \frac{r_\text{ref}^3 - r_i^3}{3}\right)\right]$$

#### Mineral-specific models

Mineral site fractions are derived from the oxide wt% composition following Thermocalc a-x conventions:

| Mineral | TC model | Reference for site fractions |
|---|---|---|
| cpx | cpx_G23 | Green et al. (2025, after Holland et al. 2018) |
| garnet (g) | g_G23 | Green et al. (2025, after Holland et al. 2018) |
| opx | opx_G23 | Green et al. (2025, after Holland et al. 2018) |
| olivine (ol) | ol_H18 | Holland et al. (2018) |
| feldspar (pl, afs) | fsp_H21 | Holland et al. (2021) |
| amphibole (amp) | hb_G16 | Green et al. (2016) |

**Clinopyroxene (cpx)**

| Element group | Model reference | Key parameters |
|---|---|---|
| REE 3+ (M2 site, 8-fold) | Sun & Liang (2012) | $r_0$, $E_3$ from M2 Al content; $D_0$ from $X_\text{Al4}$, $X_\text{Mg,M2}$, H₂O in melt |
| Sc | Hill et al. (2011) | $X_\text{Si}$, $X_\text{Al4}$, $X_\text{Al6}$, $z_0$ melt index |
| LILE 1+ (M2, mixed Brice) | Blundy & Wood (1994) | $r_0 = r_{0,\text{REE}}+0.20$, $E_1 = E_3/3$, ref = $D_\text{Na}$ |
| LILE 2+ (M2, mixed Brice) | Blundy & Wood (1994) | $r_0 = r_{0,\text{REE}}+0.06$, $E_2 = 2E_3/3$, ref = $D_\text{Ca}$ |
| Ti (M1 site) | Hill et al. (2011) | $X_\text{Al4}$, $X_\text{Na}$, $X_\text{K}$, $X_\text{Si}$, $P$ |
| HFSE 4+ (M1, mixed Brice) | Corgne et al. (2005) | $r_0$, $E_4$ from $X_\text{Al6}$, $X_\text{Al4}$, $P$; ref = $D_\text{Ti}$ |
| HFSE 5+ | — | Fixed regressions: $D_\text{Ta} = f(X_\text{Al4})$; $D_\text{Nb} = f(D_\text{Ta})$ |
| Actinides U, Th (M2) | Blundy & Wood (2003) | $D_\text{Th}$ from Mg-site exchange; $D_\text{U}$ from Brice relative to Th |

**Garnet (g)**

| Element group | Model reference | Key parameters |
|---|---|---|
| REE 3+ (X site, 8-fold) | van Westrenen & Draper (2007), Sun & Liang (2013) | $r_0$, $E_3$ from $X_\text{Ca,X}$; $D_0$ from $X_\text{Ca}$, $T$, $P$ |
| Sc | Adam & Green (2006) | Fixed: $D_\text{Sc} = 5.79$ |
| LILE 1+ | — | $D_\text{Cs}=0.001$ (fixed); $D_\text{Rb}$, $D_\text{K}$ from $X_\text{Mg}$, $X_\text{Ca}$, $P$ |
| LILE 2+ (X site, mixed Brice) | — | $E_2 = 2E_3/3$, ref = $D_\text{Mg}$ |
| Ti | — | Empirical regression to melt polymerisation index |
| HFSE 4+ (X or Y site) | — | Dual-site model when $0.19 < X_\text{Ca} < 0.40$; mixed Brice with $D_\text{Th}$ or $D_\text{Ti}$ as $D_0$ |
| HFSE 5+ | Adam & Green (2006) | Fixed: $D_\text{Ta}=0.0146$, $D_\text{Nb}=0.0290$ |
| Actinides | Salters & Longhi (1999) | $D_\text{Th}$ from melt Fe+Mg+Si; $D_\text{U} = 3.6 D_\text{Th} + 0.003$ |

**Orthopyroxene (opx)**

| Element group | Model reference | Key parameters |
|---|---|---|
| REE 3+ (M2 site, 8-fold) | Bédard (2007) | $r_0$, $E_3$ from $X_\text{Ca,M2}$, $X_\text{Mg,M2}$; $D_0$ from $X_\text{Ca}$, $X_\text{Al4}$, $T$ |
| Sc | Frei et al. (2009) | Regression to $X_\text{Mg}$, $X_\text{FeO}$ |
| LILE 1+ | Bédard (2007) | Regressions to melt SiO₂, Al₂O₃, MgO, FeO, Mg# |
| LILE 2+ (M2, mixed Brice) | Wood & Blundy (2013) | $E_2 = 2E_3/3$, ref = $D_\text{Mg} \approx 1$ |
| HFSE 4+ (M1 site) | Frei et al. (2009) | $r_0$, $E_4$, $D_0$ from $X_\text{Ca,M2}$, $X_\text{Mg,M1}$, $X_\text{Al4}$, $X_\text{Fe,M1}$, $T$ |
| HFSE 5+ | Bédard (2007) | $D_\text{Ta}$, $D_\text{Nb}$ from $X_\text{Al4}$ |
| Actinides | Bédard (2007) | Regressions to Mg# and melt FeO, MgO |

**Plagioclase (pl) / alkali feldspar (afs)**

| Element group | Model reference | Key parameters |
|---|---|---|
| REE 3+ (A site, mixed Brice) | Dohmen & Blundy (2014) | $r_0$, $E_3$ from $X_\text{An}$; $D_0$ anchored to $D_\text{La}$ |
| Sc | Dohmen & Blundy (2014) | Regression to melt MgO |
| LILE 1+ (A site, mixed Brice) | Dohmen & Blundy (2014) | $r_0$, $E_1$ from $X_\text{An}$; ref = $D_\text{Na}$ |
| LILE 2+ (A site, mixed Brice) | Dohmen & Blundy (2014) | $r_0$ from $X_\text{An}$, $T$; ref = $D_\text{Ca}$ |
| HFSE 4+ (Ti, Zr, Hf) | Dohmen & Blundy (2014) | Regressions to melt SiO₂ and $X_\text{An}$ |
| HFSE 5+ (Ta, Nb) | Dohmen & Blundy (2014) | Regressions to melt SiO₂, MgO, $X_\text{An}$ |
| Actinides (U, Th) | Dohmen & Blundy (2014) | Regressions to $X_\text{An}$ |

**Olivine (ol)**

| Element group | Model reference | Key parameters |
|---|---|---|
| REE 3+ + Sc (M site, 8-fold) | Yao et al. (2012) | $r_0 = 0.72$ Å, $E_3 = 426$ GPa; $D_0$ from melt Al₂O₃, $X_\text{Fo}$ |
| LILE 1+ | Bédard (2005) | Fixed value if melt MgO > 1.11 wt%, otherwise 0.035 |
| LILE 2+ | Bédard (2005) | Brice with $r_0 = 0.89$ Å, $E_2 = 240$ GPa, ref = $D_\text{Mg}$ |
| HFSE 4+ (Ti, Hf, Zr) | Bédard (2005) | Piecewise regressions to melt SiO₂, MgO and Mg# |
| HFSE 5+ (Ta, Nb) | Bédard (2005) | Piecewise regressions to melt MgO |
| Actinides (U, Th) | Bédard (2005) | Piecewise regressions to melt MgO |

**Amphibole (amp)**

| Element group | Model reference | Key parameters |
|---|---|---|
| REE 3+ (M4 site, empirical) | Tiepolo et al. (2007) | Regression to melt SiO₂ via polymerisation index |
| Sc | Tiepolo et al. (2007) | Regression to polymerisation index |
| LILE 1+ (A site, Brice) | Dalpe & Baker (2000) | 12-fold coordination; $r_0 = 1.52$ Å, $E_1 = 86.75$ GPa, $D_0 = 2.99$ |
| LILE 2+ (Ba, Sr) | Dalpe & Baker (2000) | $D_\text{Ba}$ from Brice; $D_\text{Sr}$ from regression to $D_\text{Ca}$ |
| HFSE 4+ (Ti, Hf, Zr) | Tiepolo et al. (2007) | Piecewise: regression for SiO₂ < 65 wt%; Brice otherwise |
| HFSE 5+ (Ta, Nb) | Tiepolo et al. (2007) | Piecewise: regression for SiO₂ < 56 wt%; Brice otherwise |
| Actinides (U, Th) | Tiepolo et al. (2007) | Regression to polymerisation index |

#### References

- Shannon, R. D. (1976). Revised effective ionic radii and systematic studies of interatomic distances in halides and chalcogenides. Acta Crystallographica A, 32(5), 751–767.
- Brice, J. C. (1975). Some thermodynamic aspects of the growth of strained crystals. Journal of Crystal Growth, 28(2), 249–253.
- Blundy, J., & Wood, B. (1994). Prediction of crystal–melt partition coefficients from elastic moduli. Nature, 372, 452–454.
- Blundy, J., & Wood, B. (2003). Mineral-melt partitioning of uranium, thorium and their daughters. Reviews in Mineralogy and Geochemistry, 52(1), 59–123.
- Bédard, J. H. (2005). Partitioning coefficients between olivine and silicate melts. Lithos, 83(3–4), 394–419.
- Bédard, J. H. (2007). Trace element partitioning coefficients between silicate melts and orthopyroxene: Parameterizations of D variations. Chemical Geology, 244(1–2), 263–303.
- Adam, J., & Green, T. (2006). Trace element partitioning between mica- and amphibole-bearing garnet lherzolite and hydrous basanitic melt. Contributions to Mineralogy and Petrology, 152, 1–17.
- Dalpe, C., & Baker, D. R. (2000). Experimental investigation of large-ion-lithophile-element-, high-field-strength-element- and rare-earth-element-partitioning between calcic amphibole and basaltic melt. Contributions to Mineralogy and Petrology, 140, 233–250.
- Tiepolo, M., Oberti, R., Zanetti, A., Vannucci, R., & Foley, S. F. (2007). Trace-element partitioning between amphibole and silicate melt. Reviews in Mineralogy and Geochemistry, 67(1), 417–452.
- Corgne, A., Liebske, C., Wood, B. J., Rubie, D. C., & Frost, D. J. (2005). Silicate perovskite-melt partitioning of trace elements and geochemical signature of a deep perovskitic reservoir. Geochimica et Cosmochimica Acta, 69(2), 485–496.
- Dohmen, R., & Blundy, J. (2014). A predictive thermodynamic model for element partitioning between plagioclase and melt as a function of pressure, temperature and composition. American Journal of Science, 314(9), 1319–1372.
- Frei, D., Liebscher, A., Franz, G., Wunder, B., Klemme, S., & Blundy, J. (2009). Trace element partitioning between orthopyroxene and anhydrous silicate melt on the lherzolite solidus from 1.1 to 3.2 GPa and 1230 to 1535 °C. Contributions to Mineralogy and Petrology, 157, 473–490.
- Hill, E., Blundy, J. D., & Wood, B. J. (2011). Clinopyroxene-melt trace-element partitioning and the development of a predictive model for HFSE and Sc. Contributions to Mineralogy and Petrology, 161, 423–438.
- Salters, V. J. M., & Longhi, J. (1999). Trace element partitioning during the initial stages of melting beneath mid-ocean ridges. Earth and Planetary Science Letters, 166(1–2), 15–30.
- Sun, C., & Liang, Y. (2012). Distribution of REE between clinopyroxene and basaltic melt along a mantle adiabat. Earth and Planetary Science Letters, 327–328, 9–19.
- Sun, C., & Liang, Y. (2013). The importance of crystal chemistry and lattice strain in controlling REE partitioning between garnet and melt. Earth and Planetary Science Letters, 368, 64–75.
- van Westrenen, W., & Draper, D. S. (2007). Quantifying garnet-melt trace element partitioning using lattice-strain theory. Contributions to Mineralogy and Petrology, 154, 483–497.
- Wood, B. J., & Blundy, J. D. (2013). Trace element partitioning under crustal and uppermost mantle conditions. In Treatise on Geochemistry (2nd ed., vol. 3, pp. 421–448). Elsevier.
- Yao, L., Sun, C., & Liang, Y. (2012). A parameterized model for REE distribution between low-Ca pyroxene and basaltic melts. Contributions to Mineralogy and Petrology, 164, 261–280.
