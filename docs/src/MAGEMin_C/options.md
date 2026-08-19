# MAGEMin_C.jl: options

## General options / functionality

### Name solvus

- When performing calculations, it is usually recommended to use the argument `name_solvus = true`, e.g.,

```julia
out = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_unit, name_solvus = true)
```

This option checks the composition of the stable solution phases and tries to name them accordingly. For instance, this allows distinguishing feldspar as plagioclase or alkali-feldspar. Details about how solvus phases are named are provided in the Method section.

### Solver option

- It is usually best to use the solver option `solver = 0` when performing calculations. This is easily activated by initializing `MAGEMin_C.jl` such as:

```julia
data        =   Initialize_MAGEMin("mb", verbose=false, solver = 0);
```

### Buffers

- When using buffers, note that you need to provide enough oxide to oversaturate the system across the whole P-T(-X) range of interest. While this applies to oxygen buffers, it also applies to activity buffers (e.g., `aTiO2`, `aH2O`, `aSiO2`, etc.).


## Database dependent choices

### Metabasite (mb)

- When using the metabasite database (Green et al., 2016), it is important to activate the correct clinopyroxene depending on the temperature conditions. By default, `aug` (the high-temperature solution model) is active. If you need to use the low-temperature solution model `dio` instead, you can initialize `MAGEMin_C.jl` such as:

```julia
data        =   Initialize_MAGEMin("mb", verbose=false, mbCpx = 0);
```
!!! note
    The default value is `mbCpx = 1`

- Similarly, `mbIlm`, `mpSp`, and `mpIlm` switch between paired solution models on the metabasite/metapelite databases:

| Option | Database | `= 0` | `= 1` | Default |
|---|---|---|---|---|
| `mbCpx` | `mb` | Omphacite (`dio`, low-T) | Augite (`aug`, high-T) | `1` |
| `mbIlm` | `mb` | Ilmenite-hematite (`ilmm`) | Ilmenite (`ilm`) | `0` |
| `mpSp` | `mp` | Spinel (`sp`) | Spinel (`spl`) | `0` |
| `mpIlm` | `mp` | Ilmenite-hematite (`ilmm`) | Ilmenite (`ilm`) | `0` |

```julia
data        =   Initialize_MAGEMin("mb", verbose=false, mbIlm = 1);
```

!!! warning
    None of `mbCpx`/`mbIlm`/`mpSp`/`mpIlm` apply to the `all` database - its dispatch
    deliberately keeps both phase variants each toggle would otherwise switch between as
    independent, separately selectable phases (e.g. both `dio_G16` and `aug_G16` are always
    present). Use [`select_phases`/`pp_list=`/`ss_list=`](#Selecting-which-phases-to-consider)
    or `remove_phases`/`rm_list=` to pick between them there instead.

## Selecting which phases to consider

Two complementary ways to restrict which pure/solution phases MAGEMin considers during
minimization - an exclude-list and an include-list. Use whichever is shorter to write for your
case; passing both at once raises an error.

### Exclude a list of phases (`remove_phases`/`rm_list=`)

`remove_phases(list, dtb)` resolves phase names against the given database and returns an
index list (`rm_list`) to pass to `single_point_minimization`/`multi_point_minimization`/
`AMR_minimization`. See [example E.5](examples.md#E.5-Removing-solution-phase-from-consideration).

### Keep only a list of phases (`select_phases`/`pp_list=`/`ss_list=`)

`select_phases` is the inverse: give it the pure phases (`pp_list=`) and/or solution phases
(`ss_list=`) you want to **keep active**, and every other phase in that category is deactivated
automatically. `pp_list` and `ss_list` are independent - passing only one leaves the other
phase category untouched.

```julia
data    = Initialize_MAGEMin("mp", verbose=false);
out     = single_point_minimization(P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in,
                                     ss_list=["liq_W14", "g_W14", "bi_W14"])
```

is equivalent to writing out the complement by hand with `remove_phases`, but self-updates if
the database's phase list changes. The 13 oxygen-fugacity buffer / fixed-activity pure phases
(`qfm`, `mw`, `qif`, `nno`, `hm`, `iw`, `cco`, `aH2O`, `aO2`, `aMgO`, `aFeO`, `aAl2O3`, `aTiO2`)
never need to be listed in `pp_list` - `select_phases` always leaves them untouched, since their
activation is governed solely by the `buffer="..."` keyword (see [Buffers](#Buffers) above), not
by phase selection.

!!! note
    `select_phases`/`pp_list=`/`ss_list=` and `remove_phases`/`rm_list=` are mutually exclusive
    on a single call - combining them raises an error rather than silently guessing intent.

### Discovering phase names (`print_phase_info`)

Both `remove_phases` and `select_phases` need exact phase names, which can be hard to guess for
an unfamiliar database (particularly `all`, with its citation-tagged names like `liq_W14` vs
`liq_G16`). `print_phase_info(dtb; level=0|1)` prints them directly:

```julia
print_phase_info("mp")            # database info, solution-phase names, pure-phase names
print_phase_info("mp"; level=1)   # same, plus every solution phase's endmember list
```

