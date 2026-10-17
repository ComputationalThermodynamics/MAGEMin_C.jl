# MAGEMin_py

`MAGEMin_py` is a Python interface to `MAGEMin`, the Gibbs energy minimization library written in `C`. It allows computing the most stable phase equilibrium for a given bulk-rock composition, pressure and temperature directly from `Python`, so that `MAGEMin` can be combined with the scientific `Python` ecosystem.

`MAGEMin_py` is developed by [Ondrej Lexa](https://natur.cuni.cz/en/geology/institutes-and-work-places/ipsg) (Institute of Petrology and Structural Geology, Faculty of Science, Charles University). It wraps the official minimal `C` API of `MAGEMin` and is distributed as the `magemin` package.

!!! info
    - Source code, installation instructions, documentation and examples are available in the `MAGEMin_py` repository: [https://github.com/ondrolexa/MAGEMin_py](https://github.com/ondrolexa/MAGEMin_py)
    - `MAGEMin_py` is maintained independently of `MAGEMin`, `MAGEMin_C.jl` and `MAGEMinApp.jl`. For questions, issues and feature requests regarding the `Python` interface, please use its own repository.

## Where to start

- For a `Python` workflow, follow the installation and quickstart sections of the [`MAGEMin_py` repository](https://github.com/ondrolexa/MAGEMin_py).
- The thermodynamic databases, phases and end-members that `MAGEMin` provides are described in the [Databases information](../database.md) page.
- For a `Julia` workflow, see [MAGEMin_C.jl](../MAGEMin_C/MAGEMin_C.md). For a graphical interface in the web browser, see [MAGEMinApp.jl](../MAGEMinApp/MAGEMinApp.md).
