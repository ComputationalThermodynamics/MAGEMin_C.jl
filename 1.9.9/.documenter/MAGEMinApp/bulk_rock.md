<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_bulk.png?raw=true" alt="MAGEMinApp bulk" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


## Bulk-rock input file {#Bulk-rock-input-file}

`MAGEMinApp` relies on using a bulk-rock input file (`.dat`) where the user can provide a list of bulk-rock compositions, the system unit and the thermodynamic database to be used. Such file has to be formatted as follow:

```
# this is a commented line
title; comments; db; sysUnit; oxide; frac; frac2
Test 2;Moo et al., 2000;ig;mol;[SiO2, Al2O3, CaO, MgO, FeO, K2O, Na2O, TiO2, O, Cr2O3, H2O];[48.97, 11.76, 13.87, 4.21, 8.97, 1.66, 10.66, 1.36, 1.66, 0.01, 0.0];[48.97, 11.76, 13.87, 4.21, 8.97, 1.66, 10.66, 1.36, 1.66, 0.01, 5.0]
Test 3;Coin & Kwak, 1984;mb;wt;[SiO2, Al2O3, CaO, MgO, Fe2O3, K2O,Na2O, TiO2, FeO, H2O];[55.12, 12.76, 4.32, 5.21, 2.45, 1.66, 10.66, 1.36, 1.66, 2.0];
```


::: tip Note
- If one oxide included in the thermodynamic database is not provided in the bulk-rock input file, the content of the oxide will be automatically be set to 0.0.
  
- Either `FeO` and `O` **or** `FeO` and `Fe2O3` can be provided. In the first case `FeO` = `FeOt`.
  
- To provide two bulk-rock comnposition for `P-X` or `T-X` diagrams, simply paste a second array of oxdes content as show for bulk-rock composition `Test 2`.
  
- If you want to use different thermodynamic database for the same bulk rock, copy and paste the line and change the database acronym
  

:::

::: tip Tip

Thermodynamic dataset acronym are the following:
- `mtl` -&gt; mantle (Holland et al., 2013)
  
- `mp` -&gt; metapelite (White et al., 2014)
  
- `mb` -&gt; metabasite (Green et al., 2016)
  
- `ig` -&gt; igneous (Green et al., 2025 updated from and replacing Holland et al., 2018)
  
- `igad` -&gt; igneous alkaline dry (Weller et al., 2024)
  
- `um` -&gt; ultramafic (Evans &amp; Frost, 2021)
  
- `sb11` -&gt; Stixrude &amp; Lithgow-Bertelloni (2011)
  
- `sb21` -&gt; Stixrude &amp; Lithgow-Bertelloni (2021)
  
- `ume` -&gt; ultramafic extended (Green et al., 2016 + Evans &amp; Frost, 2021)
  
- `mpe` -&gt; extended metapelite (White et al., 2014 + Green et al., 2016 + Franzolin et al., 2011 + Diener et al., 2007)
  
- `mbe` -&gt; extended metabasite (Green et al., 2016 + Diener et al., 2007 + Rebay et al., 2022)
  

:::

and for trace-elements:

```
# this is a commented line
title; comments; elements; frac; frac2
Basalt test 1;Coin & Kwak, 1986;[Li, Be, B, Sc, V, Cr, Ni, Cu, Zn, Rb, Sr, Y, Zr, Nb, Cs, Ba, La, Ce, Pr, Nd, Sm, Eu, Gd, Tb, Dy, Ho, Er, Tm, Yb, Lu, Hf, Ta, Pb, Th, U];[29.14258603, 0.434482763, 29.69200003, 38.23663423, 257.4346716, 529.333066, 208.2057375, 88.87615683, 91.7592182, 16.60777308, 163.4533209, 20.74016207,  66.90677472, 3.808354064, 1.529226981, 122.8449739, 6.938172601, 16.04827796, 2.253943183, 10.18276823, 3.3471043, 0.915941652, 3.28230146, 1.417695298, 3.851230952, 0.914966282, 2.20425, 0.343734976, 2.136202593, 0.323405135, 1.841502082, 0.330971265, 5.452969044, 1.074692058, 0.290233271];
Basalt test 2;Coin & Kwak, 1986b;[Li, Be, B, Sc, V, Cr, Ni, Cu, Zn, Rb, Sr, Y, Zr, Nb, Cs, Ba, La, Ce, Pr, Nd, Sm, Eu, Gd, Tb, Dy, Ho, Er, Tm, Yb, Lu, Hf, Ta, Pb, Th, U];[43.713879045, 0.6517241444999999, 44.538000045, 57.354951345, 386.1520074, 793.999599, 312.30860625, 133.314235245, 137.6388273, 24.911659620000002, 245.17998135, 31.110243105000002, 100.36016208000001, 5.712531096, 2.2938404715000003, 184.26746085, 10.4072589015, 24.07241694, 3.3809147745, 15.274152345000001, 5.02065645, 1.373912478, 4.92345219, 2.126542947, 5.776846428, 1.372449423, 3.306375, 0.5156024640000001, 3.2043038895000002, 0.4851077025, 2.7622531230000003, 0.4964568975, 8.179453566, 1.6120380869999997, 0.43534990650000005];[43.713879045, 0.6517241444999999, 44.538000045, 57.354951345, 386.1520074, 793.999599, 312.30860625, 133.314235245, 137.6388273, 24.911659620000002, 245.17998135, 31.110243105000002, 100.36016208000001, 5.712531096, 2.2938404715000003, 184.26746085, 10.4072589015, 24.07241694, 3.3809147745, 15.274152345000001, 5.02065645, 1.373912478, 4.92345219, 2.126542947, 5.776846428, 1.372449423, 3.306375, 0.5156024640000001, 3.2043038895000002, 0.4851077025, 2.7622531230000003, 0.4964568975, 8.179453566, 1.6120380869999997, 1.43534990650000005];
```


::: tip Note
- If one element included in the partitioning coefficient database is not provided in the trace-element bulk input file, the content of the element will be automatically be set to 0.0.
  

:::
