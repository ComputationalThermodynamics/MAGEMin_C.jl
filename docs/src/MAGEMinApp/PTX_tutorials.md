```@raw html
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_tabs_PTX.png?raw=true" alt="MAGEMinApp tabs" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
```

## P-T-X paths tutorials (MAGEMinApp v1.2.1)

Here we provide a set of tutorials to generate various kind of pressure-temperature-composition paths: including batch melting, fractional melting and fractional crystallization.

### E.1. Quick start - first P-T-X path

For the first P-T-X path, simply launch `MAGEMinApp` and navigate to the `PTX path` tab. Change default setting for the thermodynamic database (`Igneous`)(Green et al., 2025 after Holland et al., 2018) and default bulk-rock composition (`KLB1 Peridotite anhydrous`). In the `Path definition` panel click on `Find solidus` and `Find liquidus` and define the P-T points accordingly:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_quickstart_setup.png?raw=true" alt="PTX quickstart setup" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - New points for the P-T-X path can be added by clicking on `Add new point`.
    - To delete a point simply click on the cross icon on the left of point.
    
In the `Path options` panel, change the resolution to 32. This option defines the number of point-wise calculation between two defined points. Hit `Compute path` and after a few seconds you should get the following result:

#### Stable phase fraction

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_quickstart_diagram.png?raw=true" alt="PTX quickstart diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

#### Stable phase composition

Then in the `Phase composition` tab, click `liq` which will display the evolution of the melt composition along the path:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_quickstart_composition.png?raw=true" alt="PTX quickstart composition" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - Double-clicking on one ooxide will isolate it. 
    - Double-clicking again on the same oxide, will bring back all the oxides.
        
#### TAS diagram

When `liq` is selected you can access the `TAS diagram` which displays the evolution of the melt composition (Total Alkali Silica):

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_quickstart_TAS.png?raw=true" alt="PTX quickstart TAS" style="max-width: 60%; height: auto; display: block; margin: 0 auto;">
```

!!! warning
    - When computing a new PTX diagram, to refresh the TAS diagram, you need to unselect and reselect `liq` in the `Composition` panel.


### E.2. Fractional melting

In this example, we are going to perform fractional melting using `SM89 oxidized average MORB` composition using the `Metabasite` thermodynamic database (Green et al., 2016). First make sure you select `Aug` in the clinopyroxene selection, then define the P-T points of the path as follow:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FM_path.png?raw=true" alt="PTX FM path" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

In the `Path options` panel, choose a resolution of 32, and select `P-T-X mode = fractional melting`, keep `Assimiliation = false` and `Connectivity threshold [%] = 7`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FM_path_mode.png?raw=true" alt="PTX FM path mode" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - The connectivity threshold is the value above which melt is extracted
    - Presently, only the melt above this value is extracted to keep the melt fraction at the connectivity threshold.
    - When computing a fractional melting path using a connectivity threshold, the displayed fraction of melt can be slightly above the threshold as the removed fraction of melt is only applied to the subsequent calculation step. This effect can however be minimized by increasing the resolution.


Process with the P-T-X path calculation, which should yield:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FM_path_diagram.png?raw=true" alt="PTX FM path diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - The black continuous line `remaining %` represents the remaining % with respect to the starting material.
    - The black dashed line `removed %` is the mass % of material removed with respect to the starting material.
    - `remaining %` + `removed %` = 100.0

### E.3. Fractional crystallization

Let us the same database and bulk rock composition as for the fractional melting example. Simply change the path definition as follow:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FC_path.png?raw=true" alt="PTX FC path" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

In the `Path options` panel, choose a resolution of 32, and select `P-T-X mode = fractional crystallization`, keep `Assimiliation = false` and `Remaining fraction [%] = 1`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FC_path_mode.png?raw=true" alt="PTX FC path mode" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - `Remaining fraction [%]` can be thought as a small fraction of the solid rock carried by the fractionating melt.


Process with the P-T-X path calculation, which should yield:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FC_path_diagram.png?raw=true" alt="PTX FC path diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

and `TAS diagram` (Total Alkali Silica):

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_FC_path_TAS.png?raw=true" alt="PTX path TAS" style="max-width: 60%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - The size of the circle symbol in the TAS diagram scales with the `remaining %`. This gives an idea of the volume of generated magma along the fractional crystallization path.

### E.4. Assimilation

In this example we are going to compute an equilibrium batch crystallization path of a wet basalt, and, progressive assimilation of tonalitic composition. Let's first select the `Igneous` database (Green et al., 2025, after Holland et al., 2018) and define the P-T path as follow:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_assimilation_path.png?raw=true" alt="PTX assimilation path" style="max-width: 60%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - Notice the new column in the P-T path definition `Add [mol%]`. Here you can define how much of the assimilated composition will be added for each P-T step.


In `Path options`, set `Resolution = 32`, `P-T-X mode = Equilibrium` and `Assimilatiom = true`. When `Assimilatiom = true` a second bulk-rock composition is available for selection in the `Bulk-rock composition`left panel. Choose `Wet basalt` for the left (starting) composition and `Tonalite 101` for the right (assimilated) composition:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_assimilation_path_compo.png?raw=true" alt="PTX assimilation path compo" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

Performing the calculation of the P-T path gives:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_assimilation_diagram.png?raw=true" alt="PTX assimilation diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

and the following TAS diagram:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_assimilation_TAS.png?raw=true" alt="PTX assimilation TAS" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

### E.5. Variable buffer

To simulate a change in oxydation/reduction state of the system you can also provide variable buffer offsets. Let's start from previous assimilation example 4, and select `Buffer = QFM` and `Variable buffer = true` in the `Configuration` panel. 

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_var_buffer_path_selec.png?raw=true" alt="PTX var buffer path" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

A new column named `Buffer` is now available in the `Path definition` panel and you can modify the buffer offset to your liking. For instance:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_var_buffer_path.png?raw=true" alt="PTX var buffer path" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

!!! tip
    Don't forget to oversaturate the `O` content of the bulk-rock compositions.


Performing the calculation of the P-T path gives:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_var_buffer_diagram.png?raw=true" alt="PTX variable buffer diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

and the following TAS diagram:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_var_buffer_TAS.png?raw=true" alt="PTX variable buffer TAS" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

## Isentropic path (MAGEMinApp v1.2.1)


Isentropic path typically represent a process where a rock or material undergoes changes in pressure and temperature without any exchange of heat with its surroundings (adiabatic process) and without any entropy production (reversible process). This type of path is often used to model processes like mantle convection or adiabatic decompression melting, where material moves through the Earth's interior under conditions that approximate constant entropy.

!!! note
    The isentropic tab was removed in `MAGEMinApp@1.2.1` and merged with PTX path tab. This allowed to use the PTX functionality such as fractional crystallization and assimilation

### E.6. Isentropic path - constant bulk


Isentropic paths are easy to setup. Simply launch `MAGEMinApp` and navigate to the `PTX path` tab. Change to thermodynamic database (`Metapelite`)(White et al., 2014) and default bulk-rock composition. In the `Path options` panel, select `Isentropic = true` and keep all other parameters by default:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_opt.png?raw=true" alt="isoS path setup" style="max-width: 44%; height: auto; display: block; margin: 0 auto;">
```

Notice here that for isentropic path only the starting temperature and pressure can be changed. Then simply click `Compute path`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_res.png?raw=true" alt="isoS path diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - Here we use a bisection method to ensure constant entropy within a temperature tolerance
    - In the top-right panel (`Path preview` ) you can retrieve information about the entropy value in `J/K` and the isentropic pressure-temperature path.

    ```@raw html

    <img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_preview.png?raw=true" alt="isoS path info" style="max-width: 75%; height: auto; display: block; margin: 0 auto;">
    ```


### E.7. isentropic fractional crystallization

Building upon previous example, you can use the fractional crystallization mode along with the isentropic option:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_opt_FC.png?raw=true" alt="isoS path setup FC" style="max-width: 44%; height: auto; display: block; margin: 0 auto;">
```

Computing the path will generate two diagrams: the stable phase fractions and fractionated phases.

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_opt_FC_res.png?raw=true" alt="isoS path diagram" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```


### E.8. isentropic fractional crystallization with assimilation

One can also compute isentropic crystallization paths with assimilation of a secondary bulk-rock composition (host-rock, second magma etc.)

First activate the `Assimilation` option. Then, in the `Path definition` panel, you can see that next to pressure a new column appears which allows you to add fraction of the second bulk-rock composition in mol%. Modify the entry for the second point to 50%:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_opt_FCA.png?raw=true" alt="isoS path setup FC" style="max-width: 60%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - If you put a non zero value for the first row of the `Add [mol%]` column this will change the starting bulk-rock composition accordingly
    - When changing any other rows, the `Add [mol%]` will be added progressively from the previous point


You can now change the second bulk-rock compositon available in the left `Bulk-rock composition` panel. For instance:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_opt_FCA_bulk.png?raw=true" alt="isoS path setup FC bulk" style="max-width: 44%; height: auto; display: block; margin: 0 auto;">
```

Compute the path:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_isoS_path_opt_FCA_res.png?raw=true" alt="isoS path diagram with assimilation" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

## Modify colormap (MAGEMinApp v1.2.1)

Since version 1.2.0 it is possible to adjust the colormap of the area plots. In the `Display options` panel on the right, click on `Modify phase colors`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_colormap_select.png?raw=true" alt="colormap select" style="max-width: 44%; height: auto; display: block; margin: 0 auto;">
```

This unfold a window a the left of your screen where the colors of all stable phases are displayed:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_colormap.png?raw=true" alt="colormap" style="max-width: 44%; height: auto; display: block; margin: 0 auto;">
```

To modify a color, click the corresponding cell in the Change column, then change the thin colored bar on the right. This option the color picker:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/v1.2.1_MAGEMinApp_PTX_color_pick.png?raw=true" alt="color_pick" style="max-width: 70%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - Only the phases stable in your calculation can be modified
    - Once your happy with the updated colors, to apply the changes, you need to redo the PTX path calculation
    - You can save your changes by clicking on the green button `Save colors/styles`. The changes are saved even when restarting the App.