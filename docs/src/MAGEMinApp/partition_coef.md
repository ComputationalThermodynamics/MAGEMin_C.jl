```@raw html
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_bulk_TE_KD.png?raw=true" alt="MAGEMinApp bulk KD" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

## Partition coefficients input file

When modelling trace-element, you have the option to provide custom sets of partition coefficients. In the `Setup` tab navigate to the `Phase diagram parameters` panel and set `TE predictive model = true`. This displays several new fields right below:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_bulk_TE_KD_select.png?raw=true" alt="TE KD load" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

### File format

The `Upload Kd's` function take an as input an excel `xlsx` file. To prepare the file, first create a `Sheet` named `KDs`. This is important as the loading routine will only look for this spreadsheet and ignores all others!

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_bulk_TE_KD_screen.png?raw=true" alt="TE KD screen" style="max-width: 70%; height: auto; display: block; margin: 0 auto;">
```

### Spreadsheet structure

The spreadsheet must have the following structure:

| `A`  | `B`  | `C` | `...` | `N`
|------|------|------|------|---|
| Acronym | Displayed name | infos | - | - |
| `Phase`| El_1 | El_2 | ... | El_n |
| Ph_1 | D_El_1_Ph_1 | D_El_2_Ph_1 | ... | D_El_n_Ph_1 |
| Ph_2 | D_El_1_Ph_2 | D_El_2_Ph_2 | ... | D_El_n_Ph_2 |
| ... | ... | ... | ... | ... |
| Ph_m | D_El_1_Ph_m | D_El_2_Ph_m | ... | D_El_n_Ph_m |

where `El` stands for element and `Ph` for phase (pure or solution)

!!! note
    - The `Acronym` should be a few characters long without spaces
    - The phase names must satisfy the acronym of the pure/solution phases
    - When using saturation models the associated phase partition coefficient should be set to 0. For instance, Zr partition coefficient for zircon (zrc) must be set to 0. This is because the stoichiometry of Zr in zircon is treated internally and does not rely on partition coefficients.
    - Partition coefficients can be expressions e.g., `"0.14 * T_C/1000.0 + [:afs].compVariables[1]" "0.01"`. The first entry `"0.14 * T_C/1000.0 + [:afs].compVariables[1]"` is a non-linear formulation of `Li` KD for `afs` that depends on temperature `T_C` and the compositional variable 1 of biotite. See MAGEMin_C output structure for more details about available parameters.