# List of arguments

MAGEMin is run using command line arguments when executing the binary file.

## Valid Command Line Arguments

| Arguments       | Application                                   |
|----------------|------------------------------------------------|
| `--version`    | Displays MAGEMin version                       |
| `--help`       | Displays help                                  |
| `--Verb=x`     | Verbose option, 0: inactive, 1: active         |
| `--File=path`  | Given file for multiple point calculation      |
| `--n_points=x` | Number of points when using *File* argument    |
| `--test=x`     | Run calculation on included test compositions  |
| `--Pres=y`     | Pressure in kilobar                            |
| `--Temp=y`     | Temperature in Celsius                         |
| `--Bulk=[y]`   | Bulk rock composition in molar amount          |
| `--Gam=[y]`    | Gamma, when a guess of gamma is known          |
| `--solver=x`   | Legacy, 0; PGE, 1; 2 Hybrid (default)          |
| `--db=""`      | Database, "ig" or "mp", default is "ig"        |
| `--ds=x`       | Dataset selection: 62, 633, 634, 635 or 636    |
| `--sys_in=""`  | System composition: "mol" or "wt", default is "mol" |
| `--out_matlab=x` | Matlab output, 0: inactive, 1: active        |
| `--mbCpx=x`    |  Metabasite database Dio, 0; Aug, 1            |
| `--mbIlm=x`    |  Metabasite database Ilm, 0; Ilmm, 1           |
| `--mpSp=x`     |  Metapelite database Sp, 0; Spl, 1             |
| `--mpIlm=x`    |  Metapelite database Ilm, 0; Ilmm, 1           |
| `--buffer=""`  |  Oxygen buffer, "qfm", "mw", "qif", "nno", "hm", "iw", "cco", "aH2O", "aO2", "aMgO", "aFeO", "aAl2O3", "aTiO2          |
| `--buffer_n=x` |  Buffer offset in the RTlog scale             |

where *x* is an `integer`, *y* a `float`/`double`, *""* is a `string` and *[]* a comma-separated list of size *number of oxides*.

## Order of Oxides

The list of oxides must be given in the following order:

| SiO₂  | Al₂O₃ | CaO  | MgO  | FeO | K₂O  | Na₂O | TiO₂ | O   | Cr₂O₃ | H₂O|
| :-----| :-----| :----| :----| :----| :----| :----| :----| :---| :-----| :--|
|  | | | | | | | | | | |

!!! note
    FeO is the total iron (FeOt) and O is the excess oxygen which is internally converted to Fe2O3.

---

## Single Point Calculation

Using the previously defined arguments, a valid command to run a single point calculation with MAGEMin is:

```shell
./MAGEMin --Verb=1 --Temp=718.750 --Pres=30.5000 --db=ig --test=0 >&log.txt
```

Here:
- Verbose mode is active.
- The selected database is "ig" (Igneous).
- The bulk rock composition of *test 0* is selected.
- The verbose output is saved as a log file `log.txt`.

To compute using a different bulk rock composition:

```shell
./MAGEMin --Verb=1 --Temp=488.750 --Pres=3.5000 --db=ig --Bulk=41.49,1.57,3.824,50.56,5.88,0.01,0.25,0.10,0.1,0.0 --sys_in=mol
```

---

## Multiple Points Calculation

To run multiple points at once, pass an input file containing the list of points:

```shell
./MAGEMin --Verb=1 --File=path_to_file --n_points=x --db=ig
```

where:
- `path_to_file` is the location of the input file.
- `x` is an integer corresponding to the total number of points in the file.

## File Structure

| Mode(0-1) | Pressure (kbar) | Temperature (°C) | Bulk_1 | Bulk_2 | ... | Bulk_n |
| :---------| :---------------| :----------------| :------| :------| :---| :------|
|  | | | | | | |

- `Mode = 0` for global minimization.
- `Bulk_n` represents the bulk rock composition in oxides (mol or wt fraction).

### Example Input File

```shell
MAGEMin_input.dat:

0 0.0 800.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
0 4.0 800.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
0 8.0 800.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
0 8.0 800.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
(...)
```

Run the computation:

```shell
./MAGEMin --File=/path_to_file/MAGEMin_input.dat --n_points=4 --test=0 --db=ig
```

To use a custom bulk-rock composition:

```shell
MAGEMin_input.dat:

0 0.0 800.0 41.49 1.57 4.824 52.56 5.88 0.01 0.25 0.10 0.1 0.0
0 4.0 800.0 44.49 1.56 3.24 48.56 5.2 0.01 0.25 0.10 0.1 0.0
0 8.0 800.0 42.49 1.27 3.84 51.56 4.28 0.01 0.25 0.10 0.1 0.0
0 8.0 800.0 40.49 1.87 1.824 50.56 6.08 0.01 0.25 0.10 0.1 0.0
(...)
```

Run the computation with system composition unit:

```shell
./MAGEMin --File=/path_to_file/MAGEMin_input.dat --n_points=4 --sys_in=mol --db=ig
```

---

## Multiple Points in Parallel

To run a list of points in parallel, use MPI before MAGEMin and specify the number of cores:

```shell
mpirun -np 8 ./MAGEMin --File=/path_to_file/MAGEMin_input.dat --n_points=4 --db=ig --test=0 --out_matlab=1
mpiexec -n 8 ./MAGEMin --File=/path_to_file/MAGEMin_input.dat --n_points=4 --db=ig --test=0 --out_matlab=1
```

where `8` is the number of cores. The results will be stored in an output file gathering all points' results.

!!! note In parallel mode:
    - Verbose should be deactivated (`--Verb=0` or `--Verb=-1`).
    - Matlab output can still be generated (`--out_matlab=1`).

## THERMOCALC-like Output

If `verbose` is set to 1:

```shell
--Verb=1
```

a file named `_thermocalc_style_output.txt` containing information about the stable phase equilibrium is saved in the `./output/` directory.

---

## MATLAB Output

If the following argument is used:

```shell
--out_matlab=1
```

a file named `_matlab_output.txt` containing information about the stable phase equilibrium is saved in the `./output/` directory.

This file, although similar in structure to `_thermocalc_style_output.txt`, presents the minimization results in more human-friendly units:
- Phase fraction and composition are expressed in **wt fraction**.

!!! note
    This output is used by the MATLAB notebook `MAGEMin_EquilibriumPath.mlx`, developed by Dr. Tobias Keller (tobias.keller@erdw.ethz.ch), and added to MAGEMin in version **v1.2.4**.

