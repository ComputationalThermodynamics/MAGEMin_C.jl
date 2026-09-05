# MAGEMin - C-library

`MAGEMin` is an open-source parallel code written in `C` that minimizes the Gibbs free energy of multiphase and multicomponent systems. The main objective of `MAGEMin` is to provide a stable, consistent and fast phase equilibrium prediction routine.

The function receives bulk-rock composition, pressure and temperature to compute the most stable phase equilibrium. Presently, `MAGEMin` provides the thermodynamic dataset used natively in `THERMOCALC`. The thermodynamic datasets are directly translated into `C` routines and implemented without transformation of variables or coordinate systems, thus eliminating inconsistencies. 

The list of all available thermodynamic datasets is presented below.

!!! warning
    The `C` backend of `MAGEMin` is not the most user-friendly way to use `MAGEMin` toolset. We strongly encourage users to try out `MAGEMinApp.jl` and `MAGEMin_C.jl`. The only case where using the `C` backend of `MAGEMin` is possibly the best solution is when calling `MAGEMin` as an external library from a pre-existing `C` or `C++` code.

## Available thermodynamic databases

`MAGEMin` ships 15 thermodynamic databases - `mp`, `um`, `mb`, `mtl`, `ig`, `igd`, `igad`, `sb11`, `sb21`, `sb24`, `po`, `ume`, `mpe`, `mbe`, and `all` (a master database unifying every unique solution-phase model across mp/mb/mbe/ig/igd/igad/um/ume/mpe) - plus the DEW aqueous fluid model, available in `all` and several of the single-system databases.

**→ See the full [Databases information](../database.md) page** for the acronym reference table, per-database chemical systems, phase/end-member listings, and the DEW aqueous fluid model section - kept in one place rather than duplicated here to avoid the two copies drifting apart.

For the command-line arguments used to select a database and configure a run (`--db=`, `--rg=`, `--buffer=`, `--DEW_solve_algorithm=`, etc.), see [MAGEMin command-line reference](tutorials.md).

## References

- Su et al. (2026). Igneous thermodynamic model (`igd` database), corrected from Tomlinson & Holland (2021).

- Green, ECR, Holland, TJB, Powell, R, Weller, OM, & Riel, N (2025). Journal of Petrology, 66, doi: 10.1093/petrology/egae079

- Weller, OM, Holland, TJB, Soderman, CR, Green, ECR, Powell, R, Beard, CD & Riel, N (2024). New Thermodynamic Models for Anhydrous Alkaline-Silicate Magmatic Systems. Journal of Petrology, 65, doi: 10.1093/petrology/egae098

- Holland, TJB, Green, ECR & Powell, R (2022). A thermodynamic modelfor feldspars in KAlSi3O8-NaAlSi3O8-CaAl2Si2O8 for mineral equilibrium calculations. Journal of Metamorphic Geology, 40, 587-600, doi: 10.1111/jmg.12639

- Tomlinson, EL & Holland, TJB (2021). A Thermodynamic Model for the Subsolidus Evolution and Melting of Peridotite. Journal of Petrology,62, doi: 10.1093/petrology/egab012

- Holland, TJB, Green, ECR & Powell, R (2018). Melting of Peridotitesthrough to Granites: A Simple Thermodynamic Model in the System KNCFMASHTOCr. Journal of Petrology, 59, 881-900, doi: 10.1093/petrology/egy048

- Green, ECR, White, RW, Diener, JFA, Powell, R, Holland, TJB & Palin, RM (2016). Activity-composition relations for the calculationof partial melting equilibria in metabasic rocks. Journal of Metamorphic Geology, 34, 845-869, doi: 10.1111/jmg12211

- White, RW, Powell, R, Holland, TJB, Johnson, TE & Green, ECR (2014). New mineral activity-composition relations for thermodynamic calculations in metapelitic systems. Journal of Metamorphic Geology, 32, 261-286, doi: 10.1111/jmg.12071

- Holland, TJB & Powell, RW (2011). An improved and extended internally consistent thermodynamic dataset for phases of petrological interest, involving a new equation of state for solids. Journal of Metamorphic Geology, 29, 333-383, doi: 10.1111/j.1525-1314.2010.00923.x
