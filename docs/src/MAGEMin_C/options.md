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

### Solution-phase optimizer (`optimizer`)

With the legacy solver (`solver = 0`), the local minimization of the solution phases can use either `NLopt` or a nullspace minimizer. Select it with the `optimizer` keyword of `Initialize_MAGEMin`:

| `optimizer` | Local minimization of the solution phases |
|---|---|
| `0` (default) | `NLopt` |
| `1` | Nullspace minimizer, with `NLopt` as fallback for any phase it cannot handle |

```julia
data = Initialize_MAGEMin("ig", verbose=false, solver=0, optimizer=1)
```

- The option applies to the THERMOCALC databases and to the Stixrude & Lithgow-Bertelloni databases (`sb11`, `sb21`, `sb24`). It is ignored with `solver = 1` (PGE) and `solver = 2` (hybrid).
- On ordinary bulk-rock compositions both optimizers give the same equilibrium. For example, for KLB-1 (`ig`, 15 kbar, 1300 °C) both return `cpx opx spl liq ol` with G = −845.6099 kJ.
- The nullspace minimizer is what makes [reduced chemical systems](#Reduced-chemical-systems) possible.

The method is described in [Methods](../problem.md#Local-minimization-of-solution-phases). From the command line, the same choice is made with `--ss_solver` (see [Command-line reference](../MAGEMin/tutorials.md)).

### Reduced chemical systems

`NLopt` needs every *core* oxide of a database to be present. With `optimizer = 0`, any core oxide set to 0 in the bulk is therefore raised to 1e-4 mol fraction before the minimization. The core oxides are `SiO2`, `Al2O3`, `MgO` and `FeO` (plus `Fe` and `O` for `sb24`). The other (optional) oxides can always be set to zero.

With `optimizer = 1`, an oxide set **exactly** to 0 is removed from the system, core oxides included. Systems below FMAS (e.g. MS, MAS, CMAS, FASH, MgO–FeO) can therefore be computed directly:

```julia
data = Initialize_MAGEMin("ig", verbose=false, solver=0, optimizer=1)
out  = single_point_minimization(10.0, 1200.0, data, X=[45.0, 10.0, 8.0, 35.0],
                                 Xoxides=["SiO2", "Al2O3", "CaO", "MgO"], sys_in="mol")
out.ph          # ["opx", "fsp", "cpx", "spl"], FeO stays exactly 0 in the bulk and in every phase
```

At these conditions, the same CMAS bulk with `optimizer = 0` (FeO raised to 1e-4) gives `fsp cpx spl` and a Gibbs energy 0.34 kJ higher: the floor is enough to destabilize orthopyroxene.

!!! note
    - "Reduced" means *exactly* zero: an amount between 0 and 1e-4 mol fraction is still raised to 1e-4 with both optimizers.
    - `O` represents ferric iron (FeO + O → Fe₂O₃). If `FeO` is absent, no phase can host `O`, so `O` is set to 0 (with a warning).
    - For `sb11`, `sb21` and `sb24`, exact zeros of the core oxides are kept with `optimizer = 0` as well.
    - A reduced system needs at least one phase able to host the remaining oxides; for instance MgO–FeO has no host phase in `mp`, `mb` or `um`.

### Buffers

- When using buffers, note that you need to provide enough oxide to oversaturate the system across the whole P-T(-X) range of interest. While this applies to oxygen buffers, it also applies to activity buffers (e.g., `aTiO2`, `aH2O`, `aSiO2`, etc.).

### Fixed chemical potentials (`mu_fix_idx` / `mu_fix_val`)

Instead of fixing the bulk content of an oxide, its chemical potential can be fixed directly, for one or several oxides at once. This generalizes `buffer` to any oxide and any target value, and is the mechanism behind the μ-μ diagrams of `MAGEMinApp`.

- `mu_fix_idx` (in `Initialize_MAGEMin`): names of the oxides whose chemical potential is fixed.
- `mu_fix_val` (in `single_point_minimization`/`multi_point_minimization`): target chemical potentials in **kJ/mol**, in the same order as `mu_fix_idx`, i.e. in the same unit as `out.Gamma`. They can change from one call (or grid point) to the next.

```julia
Xoxides = ["SiO2", "Al2O3", "CaO", "MgO", "FeO", "K2O", "Na2O", "TiO2", "O", "Cr2O3", "H2O"]
X       = [48.43, 15.19, 11.57, 10.13, 6.65, 1.64, 2.59, 1.33, 0.12, 0.02, 3.0]

data    = Initialize_MAGEMin("ig", verbose=false, solver=0, mu_fix_idx=["K2O", "H2O"])

Xm      = copy(X)
Xm[6]   = 100.0     # K2O in large excess
Xm[11]  = 100.0     # H2O in large excess
out     = single_point_minimization(10.0, 1100.0, data, X=Xm, Xoxides=Xoxides, sys_in="mol",
                                    mu_fix_val=[-989.0, -459.891])
out.Gamma[[6, 11]]  # [-989.0, -459.891]
out.ph              # ["spl", "ilm", "cpx", "fsp", "liq", "mK2O", "mH2O"]
```

!!! warning
    - The target is enforced by a fictive phase per fixed oxide (`mK2O`, `mH2O` above), which appears in `out.ph`. It only becomes stable if the bulk contains far more of that oxide than the target requires (several times its natural amount; `MAGEMinApp` uses 100 mol before normalization).
    - With too little of the oxide, the target is silently missed: there is no automatic check. Compare `out.Gamma` of the fixed oxides with `mu_fix_val`.
    - A target that no real phase of the database can support at the given P–T cannot be reached either.


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

