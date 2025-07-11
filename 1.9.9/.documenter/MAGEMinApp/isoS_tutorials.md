<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_tabs_isoS.png?raw=true" alt="MAGEMinApp tabs" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">


## Isentropic path (MAGEMinApp v0.8.6) {#Isentropic-path-MAGEMinApp-v0.8.6}

Isentropic path typically represent a process where a rock or material undergoes changes in pressure and temperature without any exchange of heat with its surroundings (adiabatic process) and without any entropy production (reversible process). This type of path is often used to model processes like mantle convection or adiabatic decompression melting, where material moves through the Earth&#39;s interior under conditions that approximate constant entropy.

### 1. Quick start - first isentropic path {#1.-Quick-start-first-isentropic-path}

Isentropic paths are easy to setup. Simply launch `MAGEMinApp` and navigate to the `Isentropic path` tab. Keep the default setting for the thermodynamic database (`Igneous`)(Green et al., 2025 after Holland et al., 2018) and default bulk-rock composition (`KLB1 Peridotite anhydrous`). In the `Path definition` choose the starting pressure and temperature, and the ending pressure:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/isoS_path_setup.png?raw=true" alt="isoS path setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


In the `Path options` panel, you can choose the resolution (number of pressure steps) and the tolerance to enforce constant entropy.

::: tip Note
- Here we use a bisection method to ensure constant entropy within a temperature tolerance
  

:::

Compute the path:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/isoS_path_diagram.png?raw=true" alt="isoS path diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- In the top-middle panels (`Path information` and `P-T isentropic path`) you can retrieve information about the entropy value in `J/K` and the isentropic pressure-temperature path.
  

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/isoS_path_info.png?raw=true" alt="isoS path info" style="max-width: 75%; height: auto; display: block; margin: 0 auto;">


:::
