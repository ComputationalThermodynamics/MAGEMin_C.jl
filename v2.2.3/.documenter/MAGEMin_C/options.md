
# MAGEMin_C.jl: options {#MAGEMin_C.jl:-options}

## General options / functionality {#General-options-/-functionality}

### Name solvus {#Name-solvus}
- When performing calculations, it is usually recommended to use the argument `name_solvus = true`, e.g.,
  

```julia
out = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_unit, name_solvus = true)
```


This option checks the composition of the stable solution phases and tries to name them accordingly. For instance, this allows distinguishing feldspar as plagioclase or alkali-feldspar. Details about how solvus phases are named are provided in the Method section.

### Solver option {#Solver-option}
- It is usually best to use the solver option `solver = 0` when performing calculations. This is easily activated by initializing `MAGEMin_C.jl` such as:
  

```julia
data        =   Initialize_MAGEMin("mb", verbose=false, solver = 0);
```


### Buffers {#Buffers}
- When using buffers, note that you need to provide enough oxide to oversaturate the system across the whole P-T(-X) range of interest. While this applies to oxygen buffers, it also applies to activity buffers (e.g., `aTiO2`, `aH2O`, `aSiO2`, etc.).
  

## Database dependent choices {#Database-dependent-choices}

### Metabasite (mb) {#Metabasite-mb}
- When using the metabasite database (Green et al., 2016), it is important to activate the correct clinopyroxene depending on the temperature conditions. By default, `aug` (the high-temperature solution model) is active. If you need to use the low-temperature solution model `dio` instead, you can initialize `MAGEMin_C.jl` such as:
  

```julia
data        =   Initialize_MAGEMin("mb", verbose=false, mbCpx = 0);
```


::: tip Note

The default value is `mbCpx = 1`

:::
