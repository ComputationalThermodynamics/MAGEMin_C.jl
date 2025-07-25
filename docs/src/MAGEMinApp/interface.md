```@raw html
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_tabs.png?raw=true" alt="MAGEMinApp tabs" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
```

## MAGEMinApp.jl Tips

!!! tip
    - Mind that when performing a calculation progress is indicated either by the progress bar at the top right corner of the interface, or by changing the name of your web-browser tab (where `MAGEMinApp` is opened) to `Updating...`
    - Once a calculation is launched, avoid performing other actions as it may lead to calculation failure


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
