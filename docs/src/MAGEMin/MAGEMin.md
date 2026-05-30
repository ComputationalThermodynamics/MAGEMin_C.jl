# MAGEMin - C-library

`MAGEMin` is an open-source parallel code written in `C` that minimizes the Gibbs free energy of multiphase and multicomponent systems. The main objective of `MAGEMin` is to provide a stable, consistent and fast phase equilibrium prediction routine.

The function receives bulk-rock composition, pressure and temperature to compute the most stable phase equilibrium. Presently, `MAGEMin` provides the thermodynamic dataset used natively in `THERMOCALC`. The thermodynamic datasets are directly translated into `C` routines and implemented without transformation of variables or coordinate systems, thus eliminating inconsistencies. 

The list of all available thermodynamic datasets is presented below.

!!! warning
    The `C` backend of `MAGEMin` is not the most user-friendly way to use `MAGEMin` toolset. We strongly encourage users to try out `MAGEMinApp.jl` and `MAGEMin_C.jl`. The only case where using the `C` backend of `MAGEMin` is possibly the best solution is when calling `MAGEMin` as an external library from a pre-existing `C` or `C++` code.

## Available thermodynamic databases

| Acronym | Name | Version | Primary Reference |
|---------|------|---------|-------------------|
| **mp**  | Metapelite | v1.3.0 | White et al., 2014a, 2014b |
| **um**  | Ultramafic | v1.3.2 | Evans & Frost, 2021 |
| **mb**  | Metabasite | v1.3.5 | Green et al., 2016 |
| **mtl** | Mantle | v1.5.5 | Holland et al., 2013 |
| **ig**  | Igneous | v1.6.2 | Green et al., 2025 (updated from Holland et al., 2018) |
| **igad** | Igneous alkaline | v1.6.2 | Weller et al., 2024 |
| **sb11** | Mantle (Stixrude & Lithgow-Bertelloni) | v1.7.7 | Stixrude & Lithgow-Bertelloni, 2011 |
| **sb21** | Mantle (Stixrude & Lithgow-Bertelloni) | v1.7.7 | Stixrude & Lithgow-Bertelloni, 2021 |
| **sb24** | Mantle (Stixrude & Lithgow-Bertelloni) | v1.8.0 | Stixrude & Lithgow-Bertelloni, 2024 |
| **ume** | Ultramafic extended | — | Evans & Frost, 2021 + Green et al., 2016 |
| **mpe** | Extended metapelite | — | White et al., 2014 + Green et al., 2016 + Franzolin et al., 2011 + Diener et al., 2007 |
| **mbe** | Extended metabasite | — | Green et al., 2016 + Diener et al., 2007 + Rebay et al., 2022 |

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

== Extended (ume, mpe, mbe)

```@raw html
<ul>
    <li><strong>Ultramafic Extended (ume)</strong>: Combines Evans & Frost, 2021 (Ultramafic) and Green et al., 2016 (Metabasite) for extended applicability across ultramafic compositions.</li>
    <li><strong>Extended Metapelite (mpe)</strong>: Combines White et al., 2014 (Metapelite) with Green et al., 2016 (Metabasite), Franzolin et al., 2011, and Diener et al., 2007 for broader coverage of metamorphic compositions.</li>
    <li><strong>Extended Metabasite (mbe)</strong>: Combines Green et al., 2016 (Metabasite) with Diener et al., 2007 and Rebay et al., 2022 for extended metabasic system coverage.</li>
</ul>
```

:::

!!! important
    The datasets are only calibrated for a limited range of P, T and bulk-rock conditions. If you go too far outside those ranges, MAGEMin (or most other thermodynamic software packages for that matter) may not converge or give bogus results.

!!! warning
    For most users, we recommend starting with the relevant single-system database (mp, um, mb, ig, igad, or mtl) before exploring extended/composite databases. When using an extended database, all phases are active by default and the user must select the adequate subset.

## References

- Green, ECR, Holland, TJB, Powell, R, Weller, OM, & Riel, N (2025). Journal of Petrology, 66, doi: 10.1093/petrology/egae079

- Weller, OM, Holland, TJB, Soderman, CR, Green, ECR, Powell, R, Beard, CD & Riel, N (2024). New Thermodynamic Models for Anhydrous Alkaline-Silicate Magmatic Systems. Journal of Petrology, 65, doi: 10.1093/petrology/egae098

- Holland, TJB, Green, ECR & Powell, R (2022). A thermodynamic modelfor feldspars in KAlSi3O8-NaAlSi3O8-CaAl2Si2O8 for mineral equilibrium calculations. Journal of Metamorphic Geology, 40, 587-600, doi: 10.1111/jmg.12639

- Tomlinson, EL & Holland, TJB (2021). A Thermodynamic Model for the Subsolidus Evolution and Melting of Peridotite. Journal of Petrology,62, doi: 10.1093/petrology/egab012

- Holland, TJB, Green, ECR & Powell, R (2018). Melting of Peridotitesthrough to Granites: A Simple Thermodynamic Model in the System KNCFMASHTOCr. Journal of Petrology, 59, 881-900, doi: 10.1093/petrology/egy048

- Green, ECR, White, RW, Diener, JFA, Powell, R, Holland, TJB & Palin, RM (2016). Activity-composition relations for the calculationof partial melting equilibria in metabasic rocks. Journal of Metamorphic Geology, 34, 845-869, doi: 10.1111/jmg12211

- White, RW, Powell, R, Holland, TJB, Johnson, TE & Green, ECR (2014). New mineral activity-composition relations for thermodynamic calculations in metapelitic systems. Journal of Metamorphic Geology, 32, 261-286, doi: 10.1111/jmg.12071

- Holland, TJB & Powell, RW (2011). An improved and extended internally consistent thermodynamic dataset for phases of petrological interest, involving a new equation of state for solids. Journal of Metamorphic Geology, 29, 333-383, doi: 10.1111/j.1525-1314.2010.00923.x
