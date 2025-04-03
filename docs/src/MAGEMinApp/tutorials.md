```@raw html
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_tabs.png?raw=true" alt="MAGEMinApp tabs" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
```

## MAGEMinApp.jl interface

The graphic user interface includes 4 main tabs, 3 for phase equilibrium calculation and 2 for supporting information. 

:::tabs

== Phase diagram

This tab allows you to generate and post-process several types of phase diagrams including `P-T`, `T-X`, `P-X`, `PT-X` and `T-T`polymetamorphic. The main tab is divided in 3 sub-tabs: `Setup`, `Diagram` and `Trace-emements`.

== PTX path

Here you can generate pressure-temperature-composition paths e.g., for instance to model fractional crystallization/melting.

== Isentropic path

This tab allows you to compute isentropic paths i.e., decompression P-T path of constant entropy.

== General information

General information provides a set of supporting data for pure and solution phases, but also details about the methods to compute the diagrams.

:::


Available thermodynamic database are presented available [here](@ref thermodynamic_database). All other options/parameters are detailed below.

### 1. Phase diagram tab
#### 1.1. Setup panel

```@raw html

<table>
  <tbody>
    <tr>
      <th>Setup</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td><img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_setup.png?raw=true" alt="MAGEMinApp setup" style="width: 80%; height: auto; display: block; margin: 0 auto;"></td>
      <td>
        <ul>
            <li>Thermodynamic database - select among available thermodynamic database</li>
            <li>Dataset - select among available thermodynamic dataset</li>
            <li>Phase selection - click to expand and deactivate unwanted pure and solution phase models from consideration</li>
            <li>Diagram type - select diagram type amont P-T, P-X, T-X, PT-X and T-T polymetamorphic</li>
            <li>Solidus H2O-saturated - do you want to saturate the first melt in water?</li>
            <li>TE predictive model - do you want to predict trace-element partitioning at suprasolidus conditions?</li>
            <li>Pressure [kbar] - minimum and maximum pressure</li>
            <li>Temperature [°C] - minimum and maximum temperature</li>
            <li>Initial grid subdivision - choose the initial resolution of the grid</li>
            <li>Refinement type - can be phase boundary or dominant endmember</li>
            <li>Refinement levels - Starting level of refinement for the phase diagram</li>
            <li>Boost mode - choose if you want to make sure of initial guess to compute the next level of refinement</li>
            <li>Buffer - choose oxygen buffer or if you want to fix oxide activity</li>
            <li>Solver - choose algorithm used to perform the Gibbs free energy minimization</li>
            <li>Verbose - choose the level of information display in the julia terminal</li>
            <li>Specific Cp - do you want to compute latent heat of reaction?</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>

```

#### 1.2. Bulk-rock composition panel

```@raw html

<table>
  <tbody>
    <tr>
      <th>Setup</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td><img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_bulk-rock.png?raw=true" alt="MAGEMinApp bulk rock" style="width: 70%; height: auto; display: block; margin: 0 auto;"></td>
      <td>
        <ul>
            <li>mol% - select system unit to display the bulk-rock composition</li>
            <li>Drag and drop - click to open bulk-rock input file or drag and drop the file on the dashed window</li>
            <li>Bulk-rock list - select among pre-defined or custom bulk-rock composition here</li>
            <li>Table - the table display the loaded bulk-rock composiion</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>

```

#### 1.3. General parameters panel

```@raw html

<table>
  <tbody>
    <tr>
      <th>General parameters</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td><img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_general_parameters.png?raw=true" alt="MAGEMinApp general parameters" style="width: 70%; height: auto; display: block; margin: 0 auto;"></td>
      <td>
        <ul>
            <li>Title - change the name of the phase diagram here</li>
            <li>Compute phase diagram - button to launch the calculation</li>
            <li>Save/Load diagram - Here you can save/load a computed diagram together with the state of selected options</li>
            <li>Directory window - This text window indicates in which folder heavy exported data will be saved e.g., when saving all points information to csv file</li>
            <li>Help and contact - useful links to post issue and/or ask for support</li>
            <li>Contributores - list of people that contributed to improve MAGEMinApp</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>

```


#### 1.4. Display options panel

```@raw html

<table>
  <tbody>
    <tr>
      <th>Display options</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td><img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_display_options.png?raw=true" alt="MAGEMinApp display options" style="width: 60%; height: auto; display: block; margin: 0 auto;"></td>
      <td>
        <ul>
            <li>Field - this is where you can choose the displayed field</li>
            <li>Show grid - displays the adaptive mesh refinement grid</li>
            <li>Minimum field size - minimum number of cell to consider the mineral assemblage field for labelling</li>
            <li>Show phase label - hide/show phase labels</li>
            <li>Show reaction lines - hide/show reaction lines</li>
            <li>Change line style - here you can overwrite the default black reaction line with a linestyle of your choice</li>
            <li>Save - saves the defined reaction line style</li>
            <li>Reset - resets to default black line the reaction line style</li>
            <li>Update - updates the phase diagram with the newly defined reaction line style</li>
            <li>Colormap - choose the colormap of the displayed field</li>
            <li>Value range - defines the range of values considered for the colormap</li>
            <li>Colormap range - restricts the colormap</li>
            <li>Set min to white - sets the minimium value of the field to a white color (do not work with Colormap range option)</li>
            <li>Reverse colormap - true/false reverses the colormap</li>
            <li>Smooth colormap - here you can choose the interpolation scheme for the field displayed on the phase diagram</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>

```

#### 1.5. Isopleth panel

```@raw html

<table>
  <tbody>
    <tr>
      <th>Isopleths</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td><img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_isopleths.png?raw=true" alt="MAGEMinApp display options" style="width: 70%; height: auto; display: block; margin: 0 auto;"></td>
      <td>
        <ul>
            <li>Isopleth type - Pure phase, Solution phase or other. Here you can select which field to be contoured</li>
            <li>Phase - Select phase to be contoured (if isopleth type is pure or solution phase)</li>
            <li>Unit - mol/wt</li>
            <li>Range: min - minimum value for the isocontours</li>
            <li>Range: step - step for isocontours</li>
            <li>Range: max - maximum value for the isocontours</li>
            <li>Line style - change the linestyle of the isocontours (line, dot, dash etc.)</li>
            <li>Line width - choose the width of the line in pixel</li>
            <li>Color - choose the color of the isocontours</li>
            <li>Label size - choose the size of the font for the isocontours labels</li>
            <li>Add - button to add the isocontour selection to the diagram</li>
            <li>Displayed window - shows the list of displayed isocontours</li>
            <li>Hideen window - shows the list of hidden isocontours</li>
            <li>Hide - button to hide selecter isocontour in the above list</li>
            <li>Hide all - button to hide all isocontours</li>
            <li>Show - button to show the selected isocontour from the above hidden list</li>
            <li>Show all - button to show all hidden isocontours</li>
            <li>Remove - button to remove selected isocontour</li>
            <li>Remove all - button to remove all isocontours</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>

```


## Bulk-rock input file

`MAGEMinApp` relies on using a bulk-rock input file (`.dat`) where the user can provide a list of bulk-rock compositions, the system unit and the thermodynamic database to be used. Such file has to be formatted as follow:

```
# this is a commented line
title; comments; db; sysUnit; oxide; frac; frac2
Test 2;Moo et al., 2000;ig;mol;[SiO2, Al2O3, CaO, MgO, FeO, K2O, Na2O, TiO2, O, Cr2O3, H2O];[48.97, 11.76, 13.87, 4.21, 8.97, 1.66, 10.66, 1.36, 1.66, 0.01, 0.0];[48.97, 11.76, 13.87, 4.21, 8.97, 1.66, 10.66, 1.36, 1.66, 0.01, 5.0]
Test 3;Coin & Kwak, 1984;mb;wt;[SiO2, Al2O3, CaO, MgO, Fe2O3, K2O,Na2O, TiO2, FeO, H2O];[55.12, 12.76, 4.32, 5.21, 2.45, 1.66, 10.66, 1.36, 1.66, 2.0];
```

!!! note
    - If one oxide included in the thermodynamic database is not provided in the bulk-rock input file, the content of the oxide will be automatically be set to 0.0.
    - Either `FeO` and `O` **or** `FeO` and `Fe2O3` can be provided. In the first case `FeO` = `FeOt`.
    - To provide two bulk-rock comnposition for `P-X` or `T-X` diagrams, simply paste a second array of oxdes content as show for bulk-rock composition `Test 2`.
    - If you want to use different thermodynamic database for the same bulk rock, copy and paste the line and change the database acronym

!!! tip
    Thermodynamic dataset acronym are the following:
    - `mtl` -> mantle (Holland et al., 2013)
    - `mp` -> metapelite (White et al., 2014)
    - `mb` -> metabasite (Green et al., 2016)
    - `ig` -> igneous (Green et al., 2025 updated from and replacing Holland et al., 2018)
    - `igad` -> igneous alkaline dry (Weller et al., 2024)
    - `um` -> ultramafic (Evans & Frost, 2021)
    - `ume` -> ultramafic extended (Green et al., 2016 + Evans & Frost, 2021)

and for trace-elements:

```
# this is a commented line
title; comments; elements; frac; frac2
Basalt test 1;Coin & Kwak, 1986;[Li, Be, B, Sc, V, Cr, Ni, Cu, Zn, Rb, Sr, Y, Zr, Nb, Cs, Ba, La, Ce, Pr, Nd, Sm, Eu, Gd, Tb, Dy, Ho, Er, Tm, Yb, Lu, Hf, Ta, Pb, Th, U];[29.14258603, 0.434482763, 29.69200003, 38.23663423, 257.4346716, 529.333066, 208.2057375, 88.87615683, 91.7592182, 16.60777308, 163.4533209, 20.74016207,  66.90677472, 3.808354064, 1.529226981, 122.8449739, 6.938172601, 16.04827796, 2.253943183, 10.18276823, 3.3471043, 0.915941652, 3.28230146, 1.417695298, 3.851230952, 0.914966282, 2.20425, 0.343734976, 2.136202593, 0.323405135, 1.841502082, 0.330971265, 5.452969044, 1.074692058, 0.290233271];
Basalt test 2;Coin & Kwak, 1986b;[Li, Be, B, Sc, V, Cr, Ni, Cu, Zn, Rb, Sr, Y, Zr, Nb, Cs, Ba, La, Ce, Pr, Nd, Sm, Eu, Gd, Tb, Dy, Ho, Er, Tm, Yb, Lu, Hf, Ta, Pb, Th, U];[43.713879045, 0.6517241444999999, 44.538000045, 57.354951345, 386.1520074, 793.999599, 312.30860625, 133.314235245, 137.6388273, 24.911659620000002, 245.17998135, 31.110243105000002, 100.36016208000001, 5.712531096, 2.2938404715000003, 184.26746085, 10.4072589015, 24.07241694, 3.3809147745, 15.274152345000001, 5.02065645, 1.373912478, 4.92345219, 2.126542947, 5.776846428, 1.372449423, 3.306375, 0.5156024640000001, 3.2043038895000002, 0.4851077025, 2.7622531230000003, 0.4964568975, 8.179453566, 1.6120380869999997, 0.43534990650000005];[43.713879045, 0.6517241444999999, 44.538000045, 57.354951345, 386.1520074, 793.999599, 312.30860625, 133.314235245, 137.6388273, 24.911659620000002, 245.17998135, 31.110243105000002, 100.36016208000001, 5.712531096, 2.2938404715000003, 184.26746085, 10.4072589015, 24.07241694, 3.3809147745, 15.274152345000001, 5.02065645, 1.373912478, 4.92345219, 2.126542947, 5.776846428, 1.372449423, 3.306375, 0.5156024640000001, 3.2043038895000002, 0.4851077025, 2.7622531230000003, 0.4964568975, 8.179453566, 1.6120380869999997, 1.43534990650000005];
```

!!! note
    - If one element included in the partitioning coefficient database is not provided in the trace-element bulk input file, the content of the element will be automatically be set to 0.0.

## Tutorials (MAGEMinApp v0.8.6)

Here we provide a set of tutorials to generate various kind of phase diagrams, post-process the results (display various field, display reaction lines and iso-contours etc.) compute trace-element partitioning and Zr saturation, as well as tutorials to compute P-T-X and isentropic paths.

### 1. Quick start - first phase diagram 

For the first diagram, simply launch `MAGEMinApp` and navigate to the `Setup` sub-tab of the `Phase diagram` tab. Then click on `Compute phase diagram`.

```@raw html
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_compute.png?raw=true" alt="MAGEMinApp compute" style="max-width: 25%; height: auto; display: block; margin: 0 auto;">
```

In less than one minute you should get the following result (tab `Diagram`):

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_first_diagram_result.png?raw=true" alt="MAGEMinApp first diagram" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
```

The default field to be displayed is `variance`. Superimposed on it are the reactions lines (in black) and the phase assemblage labels with a list of labels shown on the right in the event the field size are too small. If you scroll down below the figure you can see the informations about the computation:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_computation_infos.png?raw=true" alt="MAGEMinApp computation infos" style="max-width: 60%; height: auto; display: block; margin: 0 auto;">
```

The caption lists useful information such as the version of `MAGEMin` backend, `MAGEMin_C` and `MAGEMinApp`, the activity-composition models, the version of the thermodynamic dataset, the bulk-rock composition and the type of diagram.

!!! note
    The caption is saved together with the figure (as a `svg` file) when clicking on the little camera icon when hovering your mouse on the top-right corner of the figure.

    ```@raw html

    <img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_screenshot.png?raw=true" alt="MAGEMinApp screenshot" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
    ```

!!! note
    The list of mineral assemblage that cannot be directly labeled on the figure is provided in a text area on the right side of the diagram. The list can be copied by clicking on the `Copy` button at the top of the list.

    ```@raw html

    <img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_label_table.png?raw=true" alt="MAGEMinApp label table" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
    ```


#### Grid point information

Stable phase mineral fractions and composition can be accessed for any point of the grid by simply clicking on the figure. Doing so will load a pie chart on the right panel in the `informations` tab:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pie_chart.png?raw=true" alt="MAGEMinApp pie chart" style="max-width: 20%; height: auto; display: block; margin: 0 auto;">
```

clicking on a mineral of the pie chart will display it's composition:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pie_chart_composition.png?raw=true" alt="MAGEMinApp pie chart composition" style="max-width: 20%; height: auto; display: block; margin: 0 auto;">
```

#### Refine diagram

In the top-right corner of the figure, there is two buttons allowing you to refine the phase diagram (increase its resolution) using adaptive mesh refinement. 

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_refine_buttons.png?raw=true" alt="MAGEMinApp refine buttons" style="max-width: 20%; height: auto; display: block; margin: 0 auto;">
```

Click on `Refine phase boundaries` and observe the top-right corner of the App where the progress bar is indicating the number of new points to be computed and the remaining time to completion.

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_refining.png?raw=true" alt="MAGEMinApp refining" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

After 2 refinements the updated diagram should look much finer:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_first_diagram_result_refined.png?raw=true" alt="MAGEMinApp first diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

On the right panel, selecting `Display options` can allow you display the adaptive refinement grid by setting `Show grid` to `true`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_display_grid.png?raw=true" alt="MAGEMinApp show grid" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
```

which results in:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_first_diagram_result_grid.png?raw=true" alt="MAGEMinApp first diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - The size of the cells is decreasing as you get near a reaction line. Here, we use phase boundary as the condition for adaptive mesh refinement but other conditions can be used e.g., dominant endmember fraction.
    - Uniform refinement adds new points uniformily and not only near reaction lines.

#### Exporting data

There is two main phase equilibrium data that can be exported: point wise (when clicking on a grid point of the phase diagram) and all points (the full phase diagram).

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_save_data.png?raw=true" alt="MAGEMinApp save data" style="max-width: 25%; height: auto; display: block; margin: 0 auto;">
```

To export single point data, first click on any point of the grid, then modify the name the file and click on the `Table` or `Text` button right next to `Save point`. For saving all point information, simply provide a filename next to `Save all` and click on `csv file`.

!!! note
    - `Table` saves the whole output of the stable phase equilibrium while `Text` saves general information.
    - Single point data are downloaded through the web-browser and are likely to end up in your `Downloads` directory.
    - Save all points data will end up in the directory indicated in the `Setup` tab and `General parameters` panel.
    - Mind that when saving all points, the size of file can quickly becomes large (> Go) if the total number of the phase diagram is also large!

### 2. Reaction lines and isopleths

#### Reaction lines

Using the previously computed KLB-1 phase diagram, let's now change the `liq` in reaction line and add isocontours for `melt` fraction. First make sure you are in the `Diagram` sub-tab and that you have the `Display options` panel selected (on the right).

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_display_options_panel.png?raw=true" alt="MAGEMinApp display panel" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

In the `Diagram options` of the `Display options` panel, change the selected phase from `ol` to `liq`, then change the line width to 2.0 and the color to red. To display the reaction line, simply click on `Save` then `Update`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_reaction_line.png?raw=true" alt="MAGEMinApp reaction line" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
```

which should update the phase diagram as follow:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_with_liq_reaction_line.png?raw=true" alt="MAGEMinApp liq reaction line" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

#### Isopleths

To add isopleths (isocontour), first change the selected right panel from `Display options` to `Isopleths`, then choose `Isopleth type = solution phase`, `Phase = liq`, `Field = mode` and `Unit = wt`. Use the default `Range`values and set `Line style = dash` and color to red. Finally click on the `Add` button:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_isopleth_setup.png?raw=true" alt="MAGEMinApp isopleth setup" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
```
which gives:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_with_isopleths.png?raw=true" alt="MAGEMinApp klb1 isopleths" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

Let's now add isocontour for the `Mg#` of the `liq`. Change `Field = mode` to `Field = Calculator apfu` which allow you to generate custom atom per formule unit isocontours. In the newly displayed option `Calculator (apfu)` keep the default value `Mg / (Mg + Fe)`. Then change the `Range` `Step`to 0.01 and the line style and color to your liking:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_apfu_setup.png?raw=true" alt="MAGEMinApp isopleth setup" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
```

which gives:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_apfu.png?raw=true" alt="MAGEMinApp klb1 isopleths" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    You can manage the isopleths, such as showing/hidding/deleting them in the bottom section of the `Isopleths` panel:

    ```@raw html

    <img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_manage_isopleths.png?raw=true" alt="MAGEMinApp isopleth setup" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
    ```

### 3. Displayed field and colormap options

You can change the field displayed on the phase diagram by selecting the `Display options` panel and, for instance, change `Field = Variance` to `Field = log10(dQFM)` which will display the $\Delta_{QFM}$ in the $RTlog()$ scale. By default the field will be displayed using the `Blues`colormap such as for variance. This can be changed in the `Color options` section located at the bottom of the `Display options` panel:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_colormap_options.png?raw=true" alt="MAGEMinApp color options" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
```

For instance, change `Colormap = Blues` to `Colormap = RdBu` and the `Colormap range` from 1-7 to 1-9:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_colormap_options_new.png?raw=true" alt="MAGEMinApp color options new" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">
```

which results in

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_dQFM.png?raw=true" alt="MAGEMinApp klb1 dQFM" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

### 4. Trace-element modelling

Let's predict trace-element partitioning together with a new phase diagram using the metapelite database (White et al., 2014) and the pre-defined World Median Pelite oversaturated.

::: details

- Thermodynamic database -> Metapelite
- Diagram type -> P-T diagram
- TE predictive model -> true
- Pressure -> 0.01 to 10.0 kbar
- Temperature -> 300.0 to 1000.0 °C
- Initial grid subdivision -> 4
- Refinement levels -> 4
- Trace-element composition panel -> select default `tonalite`

:::

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_setup.png?raw=true" alt="MAGEMinApp TE setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

Which after performing the calculation should result in:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_diagram_raw.png?raw=true" alt="MAGEMinApp TE diagram raw" style="max-width: 90%; height: auto; display: block; margin: 0 auto;">
```

Now move to the `Trace-elements` sub-tab, and to load the trace-element prediction, click on the button `Load/Reload trace-elements`. Doing so will display the default field `Sat_zr_liq`, which is the computation saturation level of liquid for zirconium in `ug/g`. To change the displayed field navigate to the `Display options` panel on the right side and choose `Field type = Trace element` ansd click `Compute and display`.

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_field.png?raw=true" alt="MAGEMinApp TE field" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

which will display (using default options) the ratio $Dy_melt / Yb_melt$:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_DyYb.png?raw=true" alt="MAGEMinApp TE DyYb" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

To make the melt-free transparent in colormap, you can change in the `Color options` section of the `Display options` panel `Set min to white = true` which yields:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_DyYb_white.png?raw=true" alt="MAGEMinApp TE DyYb white" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

#### Display trace-element spectrum

In order to display trace-element spectrum from any suprasolids point of the computed grid, simply click on the grid. Doing so will display a spectrum in the figure right above the trace-element diagram:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_spectrum.png?raw=true" alt="MAGEMinApp TE spectrum" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">
```

!!! tip
    - In the trace-element spectrum panel, you can change the display elements from `ree` to `all` and change the normalization method  from `bulk`to `chondrite`.
    - As for other `MAGEMinApp`figures, you can export the spectrum by hovering your cursor in the top-right corner of the figure and clikc on the small camera icon. This will save an `*.svg` vector graphic file.
    - Double-clicking on a phase abbreviation on the right legend of the spectrum will isolated the selected spectrum:

    ```@raw html

    <img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_spectrum_single.png?raw=true" alt="MAGEMinApp TE spectrum single" style="max-width: 70%; height: auto; display: block; margin: 0 auto;">
    ```

### 5. Solidus H₂O-saturated phase diagram

To compute solidus H₂O-saturated phase diagram, let's (for instance) change the thermodynamic database to Metabasite (Green et al., 2016), choose `Solidus H₂O-saturated = true`, select `clinopyroxene = aug`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_H2O_solidus_sat_setup.png?raw=true" alt="MAGEMinApp H₂O solidus sat setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

in the middle `Bulk-rock conmposition` panel, select `SM89 oxidised average MORB composition` and change the water-content from 20.0 to 40.0 to ensure water-saturation

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_H2O_solidus_sat_setup_bulk.png?raw=true" alt="MAGEMinApp H₂O solidus sat setup bulk" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

Computing the diagram and displaying the system H₂O-activity should gives:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_H2O_sat_wat_activity.png?raw=true" alt="MAGEMinApp H₂O sat wat activity" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - First, for the given pressure range (and using 50 pressure steps), the water-saturated solidus is extracted using bisection method. Subsequently, the pressure-dependent solidus temperature is interpolated using PChip interpolant. At Tsuprasolidus = Tsolidus + 0.01 K, a second interpolation is used to retrieve the amount of water saturating the melt. The latter interpolant is then used to prescribe the water content of the bulk, ensuring pressure-dependent water saturation at solidus (+ 0.1 K). 
    - Extra water can be added in the `Phase diagram parameter` panel, using the option `Additional H₂O [mol%]`.

### 6. T-X fixed pressure diagram

The objective of T-X diagram is to fix the pressure while having in the vertical axis a range of temperature and on the horizontal axis a varying bulk-rock composition. Variation in the bulk-rock composition can be applied to any oxides and the two end-member bulk-rock composition added to bulk-rock input file (see [Bulk-rock input file](@ref)).

To compute a T-X with fixed pressure diagram, simply select in the `Setup` sub-tab `Diagram = T-X diagram`. For instance, choose the `Igneous alkaline dry` thermodynamic database (Weller et al., 2024) and change the temperature range to 600 - 1200 °C. Keep the default fixed pressure at 10.0 kbar:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_setup.png?raw=true" alt="MAGEMinApp TX setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

In the middle `Bulk-rock composition` panel select the predefined `Ijolite` bulk composition for the left table, and the `Ne-Syenite` bulk composition for the right table.

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_setup_bulk.png?raw=true" alt="MAGEMinApp TX setup bulk" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

Compute the diagram with `Initial grid subdivision = 5` and `Refinement levels = 3`:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_diagram.png?raw=true" alt="MAGEMinApp TX diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```

!!! note
    - Some of the reaction lines in the high temperature part of the diagram are not perfectly clean. This problem is related to the use of the `Boost mode` which uses the results of the previous refinement level as an initial guess for the next level. 
    - In this case, performing the calculation with `Boost mode = false` fixed the problem:

    ```@raw html

    <img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_diagram_boostoff.png?raw=true" alt="MAGEMinApp TX diagram boostoff" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
    ``` 
!!! tip
    - In some cases, when `Boost mode = true`, the produced diagram will display some poorly resolved reaction lines. To fix this you can either increase the initial grid subdivision `Initial grid subdivision = 5` or set  `Boost mode = false`.

### 7. PT-X diagram

PT-X diagrams differ from P-X and T-X diagrams in the sense that both pressure and temperature can be varied along a pressure-temperature path. This option can be particularily useful when modelling subduction geotherm for instance.

To perform a PT-X diagram, let's first select the `Metapelite` database (White et al., 2014) and set `Diagram type = PT-X diagram`. When `PT-X diagram` is selected, a new panel with a list of pressure-temperature points becomes available. Let us define a few point as to roughly simulate a subduction pressure-temperature path:

| Pressure | Temperature |
|----------|-------------|
|0.1| 300.0 |
|10.0| 400.0|
|20.0| 550.0 |

Your `Phase diagram parameter` left panel should look like:


```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_PTX_setup.png?raw=true" alt="MAGEMinAppPTX setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
``` 

Then in the `Bulk-rock composition` middle panel, select the pre-defined bulk `FPWorldMedian pelite undersaturated` for the left table and `FPWorldMedian pelite oversaturated` for the right table. Select `Refinement levels = 4` then compute the diagram:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_PTX_diagram.png?raw=true" alt="MAGEMinAppPTX diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
``` 

### 8. T-T poly-metamorphic diagram

The goal of a T-T poly-metamorphic diagram is to predict the evolution of the stable phase assemblage for a rock undergoing two successive metamorphic events. 

During the first metamorphic event, the starting bulk-rock composition is used to compute the first stable phase equilibrium at the minimum temperature (and given fixed pressure). In the event free water is predicted, it is removed from the bulk, so that the system become water-saturated. This is repeated for every temperature step until reaching the provided maximum temperature. In a similar manner, when crossing the solidus, melt can be removed according to two options:
- `Liq extract threshold [vol%]` which is the threshold in `vol%` over which `liq` will extracted.
- `Remaining liq fraction [vol%]` which the volume of `liq` left after extraction.

!!! note
    - `Liq extract threshold [vol%]` and `Remaining liq fraction [vol%]` can both be set for metamorphic event 1 and 2.
    - Make sure your starting bulk-rock composition is water oversaturated.

Let's try it out! First, select the `Metabasite` database (Green et al., 2016) and the `FWorldMedian metabasite oversaturated` pre-defined composition. Then `Diagram type = T-T (poly-metamorphic)`, and `clinopyroxene = Augite`. You can keep the default values for the fixed pressure (10.0 kbar) and the temperature range of metamorphic events 1 and 2 (400 - 1000 and 400 - 1000 °C):

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TT_setup.png?raw=true" alt="MAGEMinApp TT setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
``` 

For the first event, you can see that the `Liq extract threshold [vol%]` is set to 7.0 while `Remaining liq fraction [vol%]` is set to 2.0. For the second event `Liq extract threshold [vol%]` is set to 101, which simply deactivate `liq` extraction.

Compute the diagram which should give:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TT_diagram.png?raw=true" alt="MAGEMinApp TT diagram" style="max-width: 45%; height: auto; display: block; margin: 0 auto;">
``` 

!!! note
    - At very high temperature extracting nearly all the melt may become a problem as you are left with highly refractory compositions. In this case you either leave slightly more melt in the host-rock or decrease the maximum temperature.

### 9. LaMEM density diagram

#### Quickstart

When computing a density diagram for `LaMEM` geodynamic modelling code, the initial grid setup needs to be changed. Density diagrams for geodynamic modelling generally need to evenly sample the pressure-temperature space of interest and should avoid using refinement. The recommanded mesh configuration in the `Setup` panel is the following.

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_LaMEM_setup.png?raw=true" alt="MAGEMinApp LaMEM setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">

```

which when displaying the grid and the system density gives:

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_LaMEM_density.png?raw=true" alt="MAGEMinApp LaMEM density" style="max-width: 90%; height: auto; display: block; margin: 0 auto;">
```

To export the diagram in the format used in LaMEM (`*.in`), simply click on the top-left `Export rho for LaMEM` button!

!!! note
    - Ensure that the thermodynamic you select is calibrated for your pressure-temperature of interest.
    - Make sure the diagram you produce cover the pressure-temperature you expect in your geodynamic simulation. Otherwise `LaMEM` will extrapolate to out of bound regions which may not be what you want!
    - With the above configuration, the total number of computed points will be 4225 which is largely sufficient. Mind that `LaMEM` does not support density diagram with a number of points greater than ~20k.


#### Upper mantle density diagram

When modeling plate-tectonics dynamics, one generally wants to account for phase change in the mantle. To produce a density diagram for the upper mantle you can use the Mantle database (Holland et al., 2012) or `mtl` acronym and the pre-defined `pyrolite` composition. A possible set of pressure-temperature valid for the lithosphere and the asthenosphere is for instance, from 1 to 300 kbar (0.1 to 30 GPa) and from 400 to 2000 °C.

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pyrolite_setup.png?raw=true" alt="MAGEMinApp pyrolite setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">
```

This results in the following upper mantle density diagram that can be exported for `LaMEM`

```@raw html

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pyrolite.png?raw=true" alt="MAGEMinApp pyrolite" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">
```
