---
---
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_tabs.png?raw=true" alt="MAGEMinApp tabs" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">


::: tip Info
- [MAGEMinApp.jl Tips](/MAGEMinApp/interface#MAGEMinApp.jl-Tips)
  
- [1. Phase diagrams tab](/MAGEMinApp/interface#1.-Phase-diagrams-tab)
  - [1.1 Setup panel](/MAGEMinApp/interface#1.1.-Setup-panel)
    
  - [1.2 Bulk-rock composition panel](/MAGEMinApp/interface#1.2.-Bulk-rock-composition-panel)
    
  - [1.3 Trace-element composition panel](/MAGEMinApp/interface#1.3.-Trace-element-composition-panel)
    
  - [1.4 General parameters panel](/MAGEMinApp/interface#1.4.-General-parameters-panel)
    
  
- [2. Diagram sub-tab](/MAGEMinApp/interface#2.-Diagram-sub-tab)
  - [2.1 Informations panel](/MAGEMinApp/interface#2.1.-Informations-panel)
    
  - [2.2 Display options panel](/MAGEMinApp/interface#2.2.-Display-options-panel)
    
  - [2.3 Isopleths panel](/MAGEMinApp/interface#2.3.-Isopleths-panel)
    
  - [2.4 Draw path panel](/MAGEMinApp/interface#2.4.-Draw-path-panel)
    
  - [2.5 Thermobarometric intersection panel](/MAGEMinApp/interface#2.5.-Thermobarometric-intersection-panel)
    
  
- [3. Trace-elements sub-tab](/MAGEMinApp/interface#3.-Trace-elements-sub-tab)
  - [3.1 Display options](/MAGEMinApp/interface#3.1.-Display-options)
    
  - [3.2 TE Isopleths](/MAGEMinApp/interface#3.2.-TE-Isopleths)
    
  - [3.3 Export and save](/MAGEMinApp/interface#3.3.-Export-and-save)
    
  
- [4. PTX path tab](/MAGEMinApp/interface#4.-PTX-path-tab)
  - [4.1 Bulk-rock composition panel](/MAGEMinApp/interface#4.1.-Bulk-rock-composition-panel)
    
  - [4.2 Trace Elements panel](/MAGEMinApp/interface#4.2.-Trace-Elements-panel)
    
  - [4.3 Path options panel](/MAGEMinApp/interface#4.3.-Path-options-panel)
    
  - [4.4 PTX save and export](/MAGEMinApp/interface#4.4.-PTX-save-and-export)
    
  
- [5. General information tab](/MAGEMinApp/interface#5.-General-information-tab)
  
- [Trace-element Kd models](/MAGEMinApp/MAGEMinApp#thermodynamic_database)
  

:::

## MAGEMinApp.jl Tips {#MAGEMinApp.jl-Tips}

::: tip Tip
- Mind that when performing a calculation progress is indicated either by the progress bar at the top right corner of the interface, or by changing the name of your web-browser tab (where `MAGEMinApp` is opened) to `Updating...`
  
- Once a calculation is launched, avoid performing other actions as it may lead to calculation failure
  

:::

## MAGEMinApp.jl interface {#MAGEMinApp.jl-interface}

The graphic user interface includes **3 main tabs**: two for phase equilibrium calculations and one for supporting reference data.

:::tabs

== Phase diagrams

This tab contains three sub-tabs: `Setup` (configuration), `Diagram` (visualization and post-processing) and `Trace-elements` (trace-element partitioning and accessory phase saturation). It allows you to generate and post-process `P-T`, `T-X`, `P-X`, `PT-X` and `T-T` polymetamorphic phase diagrams.

== PTX path

Here you can generate pressure-temperature-composition paths to model equilibrium crystallization, fractional melting, fractional crystallization, and isentropic decompression. Trace-element partitioning can be computed simultaneously along any path.

== General information

Provides supporting reference data for pure and solution phases, the CSV bulk-rock input format, trace-element Kd tables, and methodological details about the calculation algorithms.

:::

Available thermodynamic databases are presented [here](/MAGEMinApp/MAGEMinApp#thermodynamic_database). All other options and parameters are detailed below.


---


## 1. Phase diagrams tab {#1.-Phase-diagrams-tab}

### 1.1. Setup panel {#1.1.-Setup-panel}

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
            <li><b>Thermodynamic database</b> — select among available thermodynamic databases (ig, mp, mb, um, mtl, sb11, sb21, sb24)</li>
            <li><b>Dataset</b> — select among available thermodynamic datasets for the chosen database</li>
            <li><b>Phase selection</b> — expand to activate or deactivate individual solution and pure phase models</li>
            <li><b>Diagram type</b> — P-T, P-X, T-X, PT-X, or T-T (polymetamorphic)</li>
            <li><b>Solidus H₂O-saturated</b> — saturate the first melt in water at the solidus (true/false)</li>
            <li><b>Additional H₂O [mol%]</b> — amount of extra H₂O added when solidus saturation is active (0–100)</li>
            <li><b>Clinopyroxene</b> — switch between Omphacite (Omph) and Augite (Aug) for the metabasite database</li>
            <li><b>Limit Ca-opx</b> — enforce a maximum Ca content in orthopyroxene (0–1; default 0.5)</li>
            <li><b>TE predictive model</b> — enable trace-element partitioning at suprasolidus conditions (true/false)</li>
            <li><b>KD model</b> — lattice-strain Kd database: OL (O. Laurent, 2012) or CO (J. Cornet, 2019)</li>
            <li><b>Zr saturation</b> — zircon saturation model: none, WH (Watson &amp; Harrison, 1983), B (Boehnke et al., 2013), CB (Crisp &amp; Berry, 2022)</li>
            <li><b>P₂O₅ saturation</b> — fluorapatite saturation model: none, Klein26, Tollari06, HWBea92</li>
            <li><b>S saturation</b> — sulfide saturation model: none, Liu07, Oneill21</li>
            <li><b>CO₂ saturation</b> — CO₂ fluid saturation model: none, SY26 (Sun &amp; Yao, 2026)</li>
            <li><b>EODC</b> — empirical oxide–distribution coefficient model: KP, IL, B, AV; with an associated ratio field (0–1)</li>
            <li><b>Upload Kd's</b> — drag-and-drop zone to load a custom Kd database file</li>
            <li><b>Pressure [kbar]</b> — minimum and maximum pressure range for the diagram</li>
            <li><b>Temperature [°C]</b> — minimum and maximum temperature range for the diagram</li>
            <li><b>Fixed pressure / temperature</b> — single pressure or temperature value for P-X and T-X diagram types</li>
            <li><b>Initial grid subdivision</b> — sets the starting grid resolution (2–9; default 4, yielding a 16×16 grid)</li>
            <li><b>Refinement type</b> — refine on phase boundaries (ph) or dominant end-members (em)</li>
            <li><b>Refinement levels</b> — number of adaptive mesh refinement levels applied (default 3)</li>
            <li><b>Boost mode</b> — use the previous refinement level as an initial guess for the next (true/false)</li>
            <li><b>Buffer</b> — oxygen fugacity buffer or fixed oxide activity: none, QFM, MW, IW, QIF, CCO, HM, NNO, aH₂O, aO₂, aFeO, aMgO, aAl₂O₃, aTiO₂</li>
            <li><b>Solver</b> — Gibbs energy minimization algorithm: pge (projected gradient), lp (linear programming), hyb (hybrid)</li>
            <li><b>Verbose</b> — level of output in the Julia terminal: -1 (none), 0 (light), 1 (full)</li>
            <li><b>Seismic averaging</b> — averaging scheme for seismic velocities: 0 (VRH – Voigt-Reuss-Hill), 1 (HS – Hashin-Shtrikman)</li>
            <li><b>Weight factor</b> — mixing weight between Voigt and Reuss bounds (0–1; default 0.5)</li>
            <li><b>Specific Cp</b> — 0: G₀ (no latent heat); 1: G_system (includes latent heat of reaction)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 1.2. Bulk-rock composition panel {#1.2.-Bulk-rock-composition-panel}

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
            <li><b>System unit</b> — display and input the bulk-rock composition in mol% or wt%</li>
            <li><b>Drag and drop</b> — upload a bulk-rock CSV file or drag and drop it onto the dashed upload zone</li>
            <li><b>Bulk-rock list</b> — select from pre-defined or previously uploaded bulk-rock compositions</li>
            <li><b>Composition table</b> — editable table showing the loaded oxide composition; values can be modified directly</li>
            <li><b>Buffer offset</b> — shift the oxygen fugacity relative to the selected buffer (–50 to +50; default 0)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 1.3. Trace-element composition panel {#1.3.-Trace-element-composition-panel}

When `TE predictive model = true`, a third collapsible panel appears below the bulk-rock panel:

<table>
  <tbody>
    <tr>
      <th>Trace-element panel</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>Drag and drop</b> — upload a custom trace-element file (CSV with element and μg/g columns)</li>
            <li><b>TE composition list</b> — select from built-in trace-element compositions</li>
            <li><b>TE table</b> — editable table showing element concentrations in μg/g (ppm)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 1.4. General parameters panel {#1.4.-General-parameters-panel}

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
            <li><b>Title</b> — set the title for the phase diagram; use Update/Reset buttons to apply or revert</li>
            <li><b>Compute phase diagram</b> — launch the calculation (green button)</li>
            <li><b>Save/Load diagram</b> — save or reload a computed diagram together with all selected options (modal dialogs with filename input)</li>
            <li><b>Advanced options</b> — load custom W interaction parameters from a file path</li>
            <li><b>Directory window</b> — read-only field showing the folder where exported CSV data will be saved</li>
            <li><b>Help and contact</b> — links to post issues and request support</li>
            <li><b>Contributors</b> — list of people who contributed to MAGEMinApp</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>




---


## 2. Diagram sub-tab {#2.-Diagram-sub-tab}

The Diagram sub-tab has a right-hand sidebar with five tabs: **Informations**, **Display options**, **Isopleths**, **Draw path**, and **Thermobarometric intersection**.

### 2.1. Informations panel {#2.1.-Informations-panel}

<table>
  <tbody>
    <tr>
      <th>Informations</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>Computation info</b> — read-only summary of the last computed point (phase assemblage, conditions, fractions)</li>
            <li><b>Pie unit</b> — unit for the pie chart: mol%, wt%, or vol%</li>
            <li><b>Pie chart</b> — shows the modal fractions of stable phases at the selected point</li>
            <li><b>Transfer point as bulk</b> — transfer the composition of Solid, Melt, or Whole-rock at the selected point to the bulk-rock composition panel; provide a name and click Transfer</li>
            <li><b>Mineral composition table</b> — oxide composition of each stable phase at the clicked point in mol%, wt%, and apfu (read-only, copyable)</li>
            <li><b>Save point</b> — save the full point information to a CSV or text file</li>
            <li><b>Save all</b> — save all computed points to a CSV file</li>
            <li><b>Export references</b> — export citations for the active models as a BibTeX file</li>
            <li><b>Code availability</b> — display a ready-to-use statement for methods sections</li>
            <li><b>MAGEMin_C snippet</b> — show the equivalent MAGEMin_C.jl code to reproduce the selected point calculation</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 2.2. Display options panel {#2.2.-Display-options-panel}

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
            <li><b>Field</b> — select the scalar field to display as a color map. Available fields:<br>
                <i>Phase topology:</i> Hash, Variance, #Phases<br>
                <i>Thermodynamics:</i> G_system, entropy, enthalpy, s_cp, alpha, Specific_Cp<br>
                <i>Fugacities and activities:</i> fO2, dQFM, aH2O, aFeO, aMgO, aAl2O3, aSiO2, aTiO2<br>
                <i>Physical properties:</i> eta_M, rho, rho_S, rho_M, Delta_rho<br>
                <i>Melt/solid fractions:</i> frac_S, frac_S_wt, frac_S_vol, frac_M, frac_M_wt, frac_M_vol<br>
                <i>Seismic velocities:</i> Vp, Vs, Vp_S, Vs_S, Vp/Vs, Vp_S/Vs_S<br>
                <i>Diagnostics:</i> bulk_res_norm, time_ms, status</li>
            <li><b>Show grid</b> — display the adaptive mesh refinement grid (true/false)</li>
            <li><b>Minimum field size</b> — minimum number of cells for a field to receive a phase label (0–1024; default 16)</li>
            <li><b>Show phase label</b> — show or hide phase assemblage labels</li>
            <li><b>Show reaction lines</b> — show or hide phase boundary lines</li>
            <li><b>Reaction line customization</b> — change the style (solid, dot, dash, longdash, dashdot, longdashdot), width (0–10 px), color and label size of individual reaction lines; Save/Reset/Update buttons apply the changes</li>
            <li><b>Modify phase colors</b> — open a color editor for each stable phase; colors persist after recalculation when saved</li>
            <li><b>Colormap</b> — choose among: blackbody, Blues, cividis, Greens, Greys, hot, jet, RdBu, Reds, viridis, YlGnBu, YlOrRd</li>
            <li><b>Value range</b> — manual min/max for the color scale</li>
            <li><b>Colormap range</b> — slider restricting which portion of the colormap is used (1–9)</li>
            <li><b>Set min to white</b> — set the minimum value of the field to white (incompatible with Colormap range)</li>
            <li><b>Reverse colormap</b> — invert the colormap direction</li>
            <li><b>Smooth colormap</b> — interpolation quality: fast, best, or none</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 2.3. Isopleths panel {#2.3.-Isopleths-panel}

<table>
  <tbody>
    <tr>
      <th>Isopleths</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td><img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_isopleths.png?raw=true" alt="MAGEMinApp isopleths" style="width: 70%; height: auto; display: block; margin: 0 auto;"></td>
      <td>
        <ul>
            <li><b>Isopleth type</b> — pure phase (pp), solution phase (ss), or other (of)</li>
            <li><b>Phase</b> — select the phase to contour (depends on isopleth type)</li>
            <li><b>Field</b> — for "other" type: mode, oxide composition, end-member mode, Mg#, or custom calculator (apfu, oxides, site fractions)</li>
            <li><b>Remove excess fluid</b> — exclude fluid from the normalization when computing fractions (true/false)</li>
            <li><b>Unit</b> — mol, wt, or vol</li>
            <li><b>Custom calculator</b> — enter an expression (e.g., <code>FeO/(MgO+FeO)</code>) using oxide names or site fractions</li>
            <li><b>Range: min / step / max</b> — define the isocontour interval</li>
            <li><b>Line style</b> — solid, dot, dash, longdash, dashdot, longdashdot</li>
            <li><b>Line width</b> — line thickness in pixels (0–10)</li>
            <li><b>Color</b> — color picker for the isocontour lines</li>
            <li><b>Label size</b> — font size for isocontour labels (6–20)</li>
            <li><b>Add</b> — add the configured isocontour to the diagram</li>
            <li><b>Displayed / Hidden lists</b> — manage which isopleths are currently shown or hidden</li>
            <li><b>Hide / Hide all / Show / Show all / Remove / Remove all</b> — batch management buttons</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 2.4. Draw path panel {#2.4.-Draw-path-panel}

This panel allows you to manually trace a P-T path directly on the phase diagram by clicking points, then extract the phase evolution along it.

<table>
  <tbody>
    <tr>
      <th>Draw path</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>Record</b> — toggle on to start recording clicked points on the diagram as path nodes</li>
            <li><b>Point counter</b> — displays the number of recorded points</li>
            <li><b>Clear</b> — remove all recorded points</li>
            <li><b>Remove last</b> — delete the most recently added point</li>
            <li><b>System unit</b> — unit for the generated path data: mol, wt, or vol</li>
            <li><b>Generate</b> — compute the phase fractions and compositions along the recorded P-T path</li>
            <li><b>Path table</b> — read-only table showing the recorded path points (#, P [kbar], T [°C])</li>
            <li><b>Phase fractions plot</b> — area chart of stable phase fractions along the generated path (expandable)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 2.5. Thermobarometric intersection panel {#2.5.-Thermobarometric-intersection-panel}

This panel adds isopleths derived from measured mineral compositions to the diagram and finds their intersection to estimate P-T conditions.

<table>
  <tbody>
    <tr>
      <th>Thermobarometric intersection</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>Upload CSV</b> — drag-and-drop a CSV file containing measured mineral compositions</li>
            <li><b>Phase</b> — select the mineral phase from those available in the uploaded data</li>
            <li><b>Refresh phases</b> — reload the phase list after uploading a new file</li>
            <li><b>Color</b> — choose the color for the intersection isopleths</li>
            <li><b>Composition unit</b> — unit for the input data: wt, mol, or apfu</li>
            <li><b>Formula input</b> — enter an oxide or end-member expression to convert to a contourable field (e.g., <code>FeO/(MgO+FeO)</code>)</li>
            <li><b>Add formula</b> — register the expression for contouring</li>
            <li><b>Formula table</b> — list of registered formulas (#, phase, formula)</li>
            <li><b>Remove last / Remove all</b> — manage the formula list</li>
            <li><b>Generate</b> — compute and overlay the isopleths on the phase diagram</li>
            <li><b>Intersection plot</b> — shows the overlapping isopleths with a statistics table summarizing the estimated P-T conditions (expandable)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>




---


## 3. Trace-elements sub-tab {#3.-Trace-elements-sub-tab}

The `Trace-elements` sub-tab becomes active after a phase diagram has been computed with `TE predictive model = true`. It displays element distributions and saturation fields across the phase diagram.

### 3.1. Display options {#3.1.-Display-options}

<table>
  <tbody>
    <tr>
      <th>TE Display options</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>Field type</b> — choose the category of field to display:<br>
                Zircon, Sulfide, Fluorapatite, CO₂ saturation, Trace element</li>
            <li><b>Field</b> — specific variable within the selected field type:<br>
                <i>Zircon:</i> Sat_Zr_liq [ppm], zrc_wt [wt fraction]<br>
                <i>Sulfide:</i> Sat_S_liq [ppm], sulf_wt [wt fraction]<br>
                <i>Fluorapatite:</i> Sat_P2O5_liq [ppm], fapt_wt [wt fraction]<br>
                <i>CO₂ saturation:</i> Sat_CO2_liq [ppm], fl_CO2_wt [wt fraction]<br>
                <i>Trace element:</i> concentration in the melt via Field builder</li>
            <li><b>Field builder</b> (Trace element only) — enter a custom expression using <code>[M_X]</code> for element X in the melt (e.g., <code>[M_Dy] / [M_Yb]</code>); set normalization (none, bulk, chondrite) and click Compute and display</li>
            <li><b>Available phases</b> — list of phases for which TE concentrations are available</li>
            <li><b>Colormap</b> — same options as the phase diagram colormap</li>
            <li><b>Value range</b> — manual color scale min/max</li>
            <li><b>Colormap range</b> — slider restricting the colormap portion used</li>
            <li><b>Set min to white / Reverse / Smooth</b> — same as in the phase diagram Display options</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 3.2. TE Isopleths {#3.2.-TE-Isopleths}

The Isopleths panel in the Trace-elements sub-tab works identically to the one in the Diagram sub-tab but operates on TE and saturation fields (Zircon, Sulfide, Fluorapatite, CO₂ saturation, Trace element) instead of thermodynamic fields.

### 3.3. Export and save {#3.3.-Export-and-save}
- **Export figure** — save the current TE diagram as an image file
  
- **Export all layers** — save each TE field layer as a separate image
  
- **Save point** (csv) — save the TE data at the clicked point to CSV
  
- **Save all** (csv) — save TE data for all computed points to CSV
  
- **Export references** (bibtex) — export BibTeX citations for the active Kd and saturation models
  


---


## 4. PTX path tab {#4.-PTX-path-tab}

The PTX path tab is divided into a left configuration panel and a central results area. It supports all P-T-X path modes from the same interface, including isentropic paths (previously a separate tab; merged in v1.2.1).

### 4.1. Bulk-rock composition panel {#4.1.-Bulk-rock-composition-panel}

Same controls as the phase diagram bulk-rock panel (§1.2). When `Assimilation = true`, a second bulk-rock composition panel appears for the assimilated end-member.

### 4.2. Trace Elements panel {#4.2.-Trace-Elements-panel}

Appears when `TE predictive model = true` in Path options.

<table>
  <tbody>
    <tr>
      <th>Trace Elements (PTX)</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>KD model</b> — lattice-strain Kd database: OL (O. Laurent, 2012) or CO (J. Cornet, 2019)</li>
            <li><b>Zr saturation</b> — none, Watson 1979 (WH), or Blundy 2022 (CB)</li>
            <li><b>S saturation</b> — none or Liu 2021 (Liu07)</li>
            <li><b>P₂O₅ saturation</b> — none or Tollari 2006</li>
            <li><b>CO₂ saturation</b> — none or SY26 (Sun &amp; Yao, 2026)</li>
            <li><b>Upload trace-element file</b> — drag-and-drop a CSV file with element concentrations</li>
            <li><b>Initial TE bulk composition [μg/g]</b> — editable table with element concentrations; pre-populate from built-in database dropdown</li>
            <li><b>Assimilant TE bulk composition [μg/g]</b> — second TE table for the assimilated end-member (visible when Assimilation = true)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 4.3. Path options panel {#4.3.-Path-options-panel}

<table>
  <tbody>
    <tr>
      <th>Path options</th>
      <th>Caption</th>
    </tr>
    <tr>
      <td></td>
      <td>
        <ul>
            <li><b>Resolution</b> — number of calculation steps between two consecutive path points (1–1024; default 32)</li>
            <li><b>P-T-X mode</b> — Equilibrium, Fractional melting, or Fractional crystallization</li>
            <li><b>Assimilation</b> — enable progressive addition of a second bulk-rock composition (true/false)</li>
            <li><b>TE predictive model</b> — enable trace-element partitioning along the path (true/false)</li>
            <li><b>Connectivity threshold [%]</b> — melt fraction above which melt is extracted during fractional melting (0–100; default 7); only visible in fractional melting mode</li>
            <li><b>Residual rock fraction [%]</b> — fraction of solid entrained by the fractionating melt during fractional crystallization (0–100; default 0); only visible in fractional crystallization mode</li>
            <li><b>Isentropic</b> — compute an isentropic (constant-entropy) path using bisection on temperature (true/false)</li>
            <li><b>Solidus H₂O-saturated</b> — saturate the first melt in water at the solidus (true/false)</li>
            <li><b>Additional H₂O [mol%]</b> — extra H₂O added at water saturation (visible when Solidus H₂O-saturated = true)</li>
            <li><b>Compute path</b> — launch the P-T-X path calculation (green button)</li>
        </ul>
      </td>
    </tr>

  </tbody>
</table>



### 4.4. PTX save and export {#4.4.-PTX-save-and-export}

All export options are located in the Path options panel:

|                                Button |                                                                              Content |
| -------------------------------------:| ------------------------------------------------------------------------------------:|
|                 **Save path** → `csv` |                       Full path: P, T, phase fractions and compositions at each step |
|            **Save path** → `csv line` |                                                   Same but all steps on a single row |
|        **Save cumulate** → `csv file` |                           Composition of the cumulate (extracted solid) at each step |
|  **Save trace elements** → `csv file` | TE concentrations in melt, solid and minerals at each step (requires TE computation) |
|     **Save cumulate TE** → `csv file` |            Integrated cumulate TE composition at each step (requires TE computation) |
| **Export references** → `bibtex file` |                                      BibTeX citations for active models and database |


::: tip Note
- The `Save trace elements` and `Save cumulate TE` buttons are only active after trace elements have been computed.
  
- The export path is printed in the Julia terminal.
  

:::


---


## 5. General information tab {#5.-General-information-tab}

Provides static reference data across three sections:
- **Solution phases table** — name, abbreviation, and solvus flag for all solution phases in the selected database (filterable, 16 rows per page)
  
- **End-members table** — end-member name, abbreviation, and stoichiometric formula (filterable, 16 rows per page)
  
- **CSV bulk-rock format** — example table showing the required column structure for bulk-rock input files (title, comments, db, sysUnit, oxide columns, optional _frac2 variants)
  
- **Trace-element Kd tables** — three tabs subdivided by SiO₂ content of the melt (`SiO2 < 52 wt%`, `52 ≤ SiO2 < 63 wt%`, `63 wt% ≤ SiO2`); each shows the element × mineral Kd matrix (filterable, 32 rows per page)
  
- **Calculation details** — expandable cards describing phase deactivation logic, oxide activity formulation, water saturation methodology, specific heat capacity calculation, and the site fraction calculator
  


---


::: tip Note

Trace-element partitioning model descriptions and Kd tables are documented in the [Thermodynamic Databases](/MAGEMinApp/MAGEMinApp#thermodynamic_database) page.

:::
