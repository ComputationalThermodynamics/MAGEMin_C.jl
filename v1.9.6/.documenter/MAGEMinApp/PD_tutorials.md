<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_tabs_PD.png?raw=true" alt="MAGEMinApp tabs" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">


## Phase diagrams tutorials (MAGEMinApp v0.8.6) {#Phase-diagrams-tutorials-MAGEMinApp-v0.8.6}

Here we provide a set of tutorials to generate various kind of phase diagrams, post-process the results (display various field, display reaction lines and iso-contours etc.) compute trace-element partitioning and Zr saturation.

### 1. Quick start - first phase diagram {#1.-Quick-start-first-phase-diagram}

For the first diagram, simply launch `MAGEMinApp` and navigate to the `Setup` sub-tab of the `Phase diagram` tab. Then click on `Compute phase diagram`.
<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_compute.png?raw=true" alt="MAGEMinApp compute" style="max-width: 25%; height: auto; display: block; margin: 0 auto;">


In less than one minute you should get the following result (tab `Diagram`):

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_first_diagram_result.png?raw=true" alt="MAGEMinApp first diagram" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">


The default field to be displayed is `variance`. Superimposed on it are the reactions lines (in black) and the phase assemblage labels with a list of labels shown on the right in the event the field size are too small. If you scroll down below the figure you can see the informations about the computation:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_computation_infos.png?raw=true" alt="MAGEMinApp computation infos" style="max-width: 60%; height: auto; display: block; margin: 0 auto;">


The caption lists useful information such as the version of `MAGEMin` backend, `MAGEMin_C` and `MAGEMinApp`, the activity-composition models, the version of the thermodynamic dataset, the bulk-rock composition and the type of diagram.

::: tip Note

The caption is saved together with the figure (as a `svg` file) when clicking on the little camera icon when hovering your mouse on the top-right corner of the figure.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_screenshot.png?raw=true" alt="MAGEMinApp screenshot" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


:::

::: tip Note

The list of mineral assemblage that cannot be directly labeled on the figure is provided in a text area on the right side of the diagram. The list can be copied by clicking on the `Copy` button at the top of the list.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_label_table.png?raw=true" alt="MAGEMinApp label table" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


:::

#### Grid point information {#Grid-point-information}

Stable phase mineral fractions and composition can be accessed for any point of the grid by simply clicking on the figure. Doing so will load a pie chart on the right panel in the `informations` tab:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pie_chart.png?raw=true" alt="MAGEMinApp pie chart" style="max-width: 20%; height: auto; display: block; margin: 0 auto;">


clicking on a mineral of the pie chart will display it&#39;s composition:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pie_chart_composition.png?raw=true" alt="MAGEMinApp pie chart composition" style="max-width: 20%; height: auto; display: block; margin: 0 auto;">


#### Refine diagram {#Refine-diagram}

In the top-right corner of the figure, there is two buttons allowing you to refine the phase diagram (increase its resolution) using adaptive mesh refinement. 

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_refine_buttons.png?raw=true" alt="MAGEMinApp refine buttons" style="max-width: 20%; height: auto; display: block; margin: 0 auto;">


Click on `Refine phase boundaries` and observe the top-right corner of the App where the progress bar is indicating the number of new points to be computed and the remaining time to completion.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_refining.png?raw=true" alt="MAGEMinApp refining" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


After 2 refinements the updated diagram should look much finer:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_first_diagram_result_refined.png?raw=true" alt="MAGEMinApp first diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


On the right panel, selecting `Display options` can allow you display the adaptive refinement grid by setting `Show grid` to `true`:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_display_grid.png?raw=true" alt="MAGEMinApp show grid" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


which results in:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_first_diagram_result_grid.png?raw=true" alt="MAGEMinApp first diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- The size of the cells is decreasing as you get near a reaction line. Here, we use phase boundary as the condition for adaptive mesh refinement but other conditions can be used e.g., dominant endmember fraction.
  
- Uniform refinement adds new points uniformily and not only near reaction lines.
  

:::

#### Exporting data {#Exporting-data}

There is two main phase equilibrium data that can be exported: point wise (when clicking on a grid point of the phase diagram) and all points (the full phase diagram).

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_save_data.png?raw=true" alt="MAGEMinApp save data" style="max-width: 25%; height: auto; display: block; margin: 0 auto;">


To export single point data, first click on any point of the grid, then modify the name the file and click on the `Table` or `Text` button right next to `Save point`. For saving all point information, simply provide a filename next to `Save all` and click on `csv file`.

::: tip Note
- `Table` saves the whole output of the stable phase equilibrium while `Text` saves general information.
  
- Single point data are downloaded through the web-browser and are likely to end up in your `Downloads` directory.
  
- Save all points data will end up in the directory indicated in the `Setup` tab and `General parameters` panel.
  
- Mind that when saving all points, the size of file can quickly becomes large (&gt; Go) if the total number of the phase diagram is also large!
  

:::

### 2. Reaction lines and isopleths {#2.-Reaction-lines-and-isopleths}

#### Reaction lines {#Reaction-lines}

Using the previously computed KLB-1 phase diagram, let&#39;s now change the `liq` in reaction line and add isocontours for `melt` fraction. First make sure you are in the `Diagram` sub-tab and that you have the `Display options` panel selected (on the right).

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_display_options_panel.png?raw=true" alt="MAGEMinApp display panel" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


In the `Diagram options` of the `Display options` panel, change the selected phase from `ol` to `liq`, then change the line width to 2.0 and the color to red. To display the reaction line, simply click on `Save` then `Update`:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_reaction_line.png?raw=true" alt="MAGEMinApp reaction line" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


which should update the phase diagram as follow:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_with_liq_reaction_line.png?raw=true" alt="MAGEMinApp liq reaction line" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


#### Isopleths {#Isopleths}

To add isopleths (isocontour), first change the selected right panel from `Display options` to `Isopleths`, then choose `Isopleth type = solution phase`, `Phase = liq`, `Field = mode` and `Unit = wt`. Use the default `Range`values and set `Line style = dash` and color to red. Finally click on the `Add` button:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_isopleth_setup.png?raw=true" alt="MAGEMinApp isopleth setup" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


which gives:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_with_isopleths.png?raw=true" alt="MAGEMinApp klb1 isopleths" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


Let&#39;s now add isocontour for the `Mg#` of the `liq`. Change `Field = mode` to `Field = Calculator apfu` which allow you to generate custom atom per formule unit isocontours. In the newly displayed option `Calculator (apfu)` keep the default value `Mg / (Mg + Fe)`. Then change the `Range` `Step`to 0.01 and the line style and color to your liking:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_apfu_setup.png?raw=true" alt="MAGEMinApp isopleth setup" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


which gives:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_apfu.png?raw=true" alt="MAGEMinApp klb1 isopleths" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: tip Note

You can manage the isopleths, such as showing/hidding/deleting them in the bottom section of the `Isopleths` panel:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_manage_isopleths.png?raw=true" alt="MAGEMinApp isopleth setup" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


:::

### 3. Displayed field and colormap options {#3.-Displayed-field-and-colormap-options}

You can change the field displayed on the phase diagram by selecting the `Display options` panel and, for instance, change `Field = Variance` to `Field = log10(dQFM)` which will display the $\Delta_{QFM}$ in the $RTlog()$ scale. By default the field will be displayed using the `Blues`colormap such as for variance. This can be changed in the `Color options` section located at the bottom of the `Display options` panel:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_colormap_options.png?raw=true" alt="MAGEMinApp color options" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


For instance, change `Colormap = Blues` to `Colormap = RdBu` and the `Colormap range` from 1-7 to 1-9:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_colormap_options_new.png?raw=true" alt="MAGEMinApp color options new" style="max-width: 30%; height: auto; display: block; margin: 0 auto;">


which results in

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_klb1_dQFM.png?raw=true" alt="MAGEMinApp klb1 dQFM" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


### 4. Deactivate solution and/or pure phases {#4.-Deactivate-solution-and/or-pure-phases}

In some cases, it is useful to deactivate a solution model (activity-composition model) or a pure phase. 

Let&#39;s first select the thermodynamic database to be `Metapelite` (White et al., 2014) and use the default bulk-rock composition `FPWorldMedian pelite - water oversaturated`. Keep the default diagram type `P-T Diagram` and pressure range and update the temperature range from 400 to 1000 °C. in the top-left `Phase diagram parameters` panel, simply click on the rounded button of the `Phase selection` option, to display the list of available phases for the selection thermodynamic database:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_phase_selection.png?raw=true" alt="MAGEMinApp phase selection" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


Once the `Phase selection` panels are unfolded you can provide your custom selection of phases. For instance let&#39;s unselect `liq`, `mt` and `ilmm`, and then perform the calculation. Refining the phase diagram twice gives:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_phase_selection_pd.png?raw=true" alt="MAGEMinApp phase selection pd" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- Here, the solution models `liq`, `mt` and `ilmm` are deactivated. However, you can see the phase `mt` appearing for instance in the large LP-HT (`cd`+`pl`+`afs`+`ilm`+`mt`+`q`+`H2O`) field. This is because the `sp` model can also produce `mt` compositions.
  

:::

::: warning Warning
- When all `Solution phase` are selected, the default combination of phases for the activity-composition set will be applied. In the case of the `Metapelite` thermodynamic database the default combination fir spinel and ilmenite is `sp` and `ilm`.
  
- As soon as one solution model is unselected the default combination is deactivated. This implies that you manually have to select which combination of phase you want and make sure you are not using 2 spinel or 2 ilmenite models at the same time!
  

:::

### 5. Buffers {#5.-Buffers}

Several buffers can be used to fix the oxygen fugacity
- `qfm` -&gt; quartz-fayalite-magnetite
  
- `qif` -&gt; quartz-iron-fayalite
  
- `nno` -&gt; nickel-nickel oxide
  
- `hm` -&gt; hematite-magnetite
  
- `iw` -&gt; iron-wüstite
  
- `cco` -&gt; carbon dioxide-carbon
  

Similarly activity can be fixed for the following oxides
- `aH2O` -&gt; using water as reference phase
  
- `aO2`   -&gt; using dioxygen as reference phase
  
- `aMgO` -&gt; using periclase as reference phase
  
- `aFeO` -&gt; using ferropericlase as reference phase
  
- `aAl2O3` -&gt; using corundum as reference phase
  
- `aTiO2` -&gt; using rutile as reference phase
  
- `aSiO2` -&gt; using quartz/coesite as reference phase
  

Let&#39;s compute a P-T diagram using the `qfm` buffer. For instance, select the thermodynamic database to be `Metabasite` (Green et al., 2016). Choose the pressure-temperature range of your choice. Select `SQA synthethic amphibolitic composition` in the middle `Bulk-rock composition` panel, then in the `Phase diagram parameters` left panel, select `Buffer = QFM`. Finally, make sure you saturate the bulk-rock in `O` by changing the value to 3.0:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_buffer_QFM_setup.png?raw=true" alt="MAGEMinApp QFM setup" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


Which gives, after 4 levels of refinements:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_buffer_QFM_diagram.png?raw=true" alt="MAGEMinApp QFM diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- If you click on any point of the diagram, you can see in the `Informations` panel, that every field contain a `qfm` phase. This phase has a fraction equal to 0.0 and simply shows that the system is buffered. 
  
- If one of the field does not have the buffer phase, it indicates that not enough free `O` has been provided.
  

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_buffer_QFM_diagram_info.png?raw=true" alt="MAGEMinApp QFM diagram info" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


:::

::: warning Warning
- The `Buffer offset` option in the `Bulk-rock composition` panel is used to offset the oxygen buffer in the $RT log()$ scale, while for activity it serves as the activity value.
  

:::

### 6. Latent heat of reaction {#6.-Latent-heat-of-reaction}

Heat capacity is computed as a second order derivative of the Gibbs energy with respect to temperature using numerical differentiation.

$C_p = -T \frac{\partial ^2G}{\partial T^2}$

**There is however two ways to retrieve the second order derivative:**
1. Default option `Specific Cp = G0` - no latent heat of reaction: Fixing the phase assemblage (phase proportions and compositions) and computing the Gibbs energy of the assemblage at T, T+eps and T-eps.
  
2. Full differentiation option `Specific Cp = G_system` - latent heat of reaction: Computing three stable phase equilibrium at T, T+eps and T-eps.
  

::: tip Note
- While the first method is computationally more efficient, it does not account for the latent heat of reaction. When having correct heat budget is important it is therefore recommanded to employ the second approach.
  

:::

To compute a phase diagram that takes into account latent heat reaction simply choose `Specific Cp = G_system` in the `Phase diagram parameters` panel:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_LH_setup.png?raw=true" alt="MAGEMinApp LH setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


Using the metapelite database and the `FPWorldMedian pelite - oversaturated` composition and 4 levels of refinement, together with displaying s_cp (and capping max value to 4000 for the colormap) gives:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_LH_diagram.png?raw=true" alt="MAGEMinApp LH diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- Without accounting for latent heat of reaction (`Specific Cp = G0`), the values of the specific heat capacity are drastically different:
  

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_noLH_diagram.png?raw=true" alt="MAGEMinApp noLH diagram" style="max-width: 45%; height: auto; display: block; margin: 0 auto;">


:::

### 7. Trace-element modelling {#7.-Trace-element-modelling}

Let&#39;s predict trace-element partitioning together with a new phase diagram using the metapelite database (White et al., 2014) and the pre-defined World Median Pelite oversaturated.

::: details
- Thermodynamic database -&gt; Metapelite
  
- Diagram type -&gt; P-T diagram
  
- TE predictive model -&gt; true
  
- Pressure -&gt; 0.01 to 10.0 kbar
  
- Temperature -&gt; 300.0 to 1000.0 °C
  
- Initial grid subdivision -&gt; 4
  
- Refinement levels -&gt; 4
  
- Trace-element composition panel -&gt; select default `tonalite`
  

:::

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_setup.png?raw=true" alt="MAGEMinApp TE setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


Which after performing the calculation should result in:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_diagram_raw.png?raw=true" alt="MAGEMinApp TE diagram raw" style="max-width: 90%; height: auto; display: block; margin: 0 auto;">


Now move to the `Trace-elements` sub-tab, and to load the trace-element prediction, click on the button `Load/Reload trace-elements`. Doing so will display the default field `Sat_zr_liq`, which is the computation saturation level of liquid for zirconium in `ug/g`. To change the displayed field navigate to the `Display options` panel on the right side and choose `Field type = Trace element` ansd click `Compute and display`.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_field.png?raw=true" alt="MAGEMinApp TE field" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


which will display (using default options) the ratio $Dy_melt / Yb_melt$:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_DyYb.png?raw=true" alt="MAGEMinApp TE DyYb" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


To make the melt-free transparent in colormap, you can change in the `Color options` section of the `Display options` panel `Set min to white = true` which yields:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_DyYb_white.png?raw=true" alt="MAGEMinApp TE DyYb white" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


#### Display trace-element spectrum {#Display-trace-element-spectrum}

In order to display trace-element spectrum from any suprasolids point of the computed grid, simply click on the grid. Doing so will display a spectrum in the figure right above the trace-element diagram:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_spectrum.png?raw=true" alt="MAGEMinApp TE spectrum" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


::: tip Tip
- In the trace-element spectrum panel, you can change the display elements from `ree` to `all` and change the normalization method  from `bulk`to `chondrite`.
  
- As for other `MAGEMinApp`figures, you can export the spectrum by hovering your cursor in the top-right corner of the figure and clikc on the small camera icon. This will save an `*.svg` vector graphic file.
  
- Double-clicking on a phase abbreviation on the right legend of the spectrum will isolated the selected spectrum:
  

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TE_spectrum_single.png?raw=true" alt="MAGEMinApp TE spectrum single" style="max-width: 70%; height: auto; display: block; margin: 0 auto;">


:::

### 8. Solidus H₂O-saturated phase diagram {#8.-Solidus-HO-saturated-phase-diagram}

To compute solidus H₂O-saturated phase diagram, let&#39;s (for instance) change the thermodynamic database to Metabasite (Green et al., 2016), choose `Solidus H₂O-saturated = true`, select `clinopyroxene = aug`:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_H2O_solidus_sat_setup.png?raw=true" alt="MAGEMinApp H₂O solidus sat setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


in the middle `Bulk-rock conmposition` panel, select `SM89 oxidised average MORB composition` and change the water-content from 20.0 to 40.0 to ensure water-saturation

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_H2O_solidus_sat_setup_bulk.png?raw=true" alt="MAGEMinApp H₂O solidus sat setup bulk" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


Computing the diagram and displaying the system H₂O-activity should gives:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_H2O_sat_wat_activity.png?raw=true" alt="MAGEMinApp H₂O sat wat activity" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- First, for the given pressure range (and using 50 pressure steps), the water-saturated solidus is extracted using bisection method. Subsequently, the pressure-dependent solidus temperature is interpolated using PChip interpolant. At Tsuprasolidus = Tsolidus + 0.01 K, a second interpolation is used to retrieve the amount of water saturating the melt. The latter interpolant is then used to prescribe the water content of the bulk, ensuring pressure-dependent water saturation at solidus (+ 0.1 K). 
  
- Extra water can be added in the `Phase diagram parameter` panel, using the option `Additional H₂O [mol%]`.
  

:::

### 9. T-X fixed pressure diagram {#9.-T-X-fixed-pressure-diagram}

The objective of T-X diagram is to fix the pressure while having in the vertical axis a range of temperature and on the horizontal axis a varying bulk-rock composition. Variation in the bulk-rock composition can be applied to any oxides and the two end-member bulk-rock composition added to bulk-rock input file (see [Bulk-rock input file](/MAGEMinApp/bulk_rock#Bulk-rock-input-file)).

To compute a T-X with fixed pressure diagram, simply select in the `Setup` sub-tab `Diagram = T-X diagram`. For instance, choose the `Igneous alkaline dry` thermodynamic database (Weller et al., 2024) and change the temperature range to 600 - 1200 °C. Keep the default fixed pressure at 10.0 kbar:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_setup.png?raw=true" alt="MAGEMinApp TX setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


In the middle `Bulk-rock composition` panel select the predefined `Ijolite` bulk composition for the left table, and the `Ne-Syenite` bulk composition for the right table.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_setup_bulk.png?raw=true" alt="MAGEMinApp TX setup bulk" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


Compute the diagram with `Initial grid subdivision = 5` and `Refinement levels = 3`:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_diagram.png?raw=true" alt="MAGEMinApp TX diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- Some of the reaction lines in the high temperature part of the diagram are not perfectly clean. This problem is related to the use of the `Boost mode` which uses the results of the previous refinement level as an initial guess for the next level. 
  
- In this case, performing the calculation with `Boost mode = false` fixed the problem:
  

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_diagram_boostoff.png?raw=true" alt="MAGEMinApp TX diagram boostoff" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


:::

::: tip Tip
- In some cases, when `Boost mode = true`, the produced diagram will display some poorly resolved reaction lines. To fix this you can either increase the initial grid subdivision `Initial grid subdivision = 5` or set  `Boost mode = false`.
  

:::

#### T-X buffer {#T-X-buffer}

Previously we changed the composition from `Ijolite` to `Ne-Syenite`. Let&#39;s instead vary the `qfm` buffer offset for `Ijolite` composition from -5 to 5.

In the `Phase diagram parameters` left panel, select `Buffer = QFM`, then in the middle `Bulk-rock composition` panel, select `Ijolite` for both left and right composition. Then change `Buffer offset` to -5 for the left entry, and to 5 for the right entry. Don&#39;t forget to increase the `O` content, for isntance to 3.0:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_buffer_setup.png?raw=true" alt="MAGEMinApp TX buffer setup" style="max-width: 80%; height: auto; display: block; margin: 0 auto;">


Which after 4 levels of refinements results in:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_buffer_diagram.png?raw=true" alt="MAGEMinApp TX buffer diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


::: warning Warning
- Here, you can see that we did not provide enough `O` as `qfm` phase does not appear on the right side of the diagram. You can easely fix that by change the `O` value to 10 and relaunch the calculation
  

:::

Fixing the `O` content and contouring $\Delta_{QFM}$ gives the desired result:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TX_buffer_diagram_cor.png?raw=true" alt="MAGEMinApp TX buffer diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


### 10. PT-X diagram {#10.-PT-X-diagram}

PT-X diagrams differ from P-X and T-X diagrams in the sense that both pressure and temperature can be varied along a pressure-temperature path. This option can be particularily useful when modelling subduction geotherm for instance.

To perform a PT-X diagram, let&#39;s first select the `Metapelite` database (White et al., 2014) and set `Diagram type = PT-X diagram`. When `PT-X diagram` is selected, a new panel with a list of pressure-temperature points becomes available. Let us define a few point as to roughly simulate a subduction pressure-temperature path:

| Pressure | Temperature |
| --------:| -----------:|
|      0.1 |       300.0 |
|     10.0 |       400.0 |
|     20.0 |       550.0 |


Your `Phase diagram parameter` left panel should look like:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_PTX_setup.png?raw=true" alt="MAGEMinAppPTX setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


Then in the `Bulk-rock composition` middle panel, select the pre-defined bulk `FPWorldMedian pelite undersaturated` for the left table and `FPWorldMedian pelite oversaturated` for the right table. Select `Refinement levels = 4` then compute the diagram:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_PTX_diagram.png?raw=true" alt="MAGEMinAppPTX diagram" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">


### 11. T-T poly-metamorphic diagram {#11.-T-T-poly-metamorphic-diagram}

The goal of a T-T poly-metamorphic diagram is to predict the evolution of the stable phase assemblage for a rock undergoing two successive metamorphic events. 

During the first metamorphic event, the starting bulk-rock composition is used to compute the first stable phase equilibrium at the minimum temperature (and given fixed pressure). In the event free water is predicted, it is removed from the bulk, so that the system become water-saturated. This is repeated for every temperature step until reaching the provided maximum temperature. In a similar manner, when crossing the solidus, melt can be removed according to two options:
- `Liq extract threshold [vol%]` which is the threshold in `vol%` over which `liq` will extracted.
  
- `Remaining liq fraction [vol%]` which the volume of `liq` left after extraction.
  

::: tip Note
- `Liq extract threshold [vol%]` and `Remaining liq fraction [vol%]` can both be set for metamorphic event 1 and 2.
  
- Make sure your starting bulk-rock composition is water oversaturated.
  

:::

Let&#39;s try it out! First, select the `Metabasite` database (Green et al., 2016) and the `FWorldMedian metabasite oversaturated` pre-defined composition. Then `Diagram type = T-T (poly-metamorphic)`, and `clinopyroxene = Augite`. You can keep the default values for the fixed pressure (10.0 kbar) and the temperature range of metamorphic events 1 and 2 (400 - 1000 and 400 - 1000 °C):

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TT_setup.png?raw=true" alt="MAGEMinApp TT setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


For the first event, you can see that the `Liq extract threshold [vol%]` is set to 7.0 while `Remaining liq fraction [vol%]` is set to 2.0. For the second event `Liq extract threshold [vol%]` is set to 101, which simply deactivate `liq` extraction.

Compute the diagram which should give:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_TT_diagram.png?raw=true" alt="MAGEMinApp TT diagram" style="max-width: 45%; height: auto; display: block; margin: 0 auto;">


::: tip Note
- At very high temperature extracting nearly all the melt may become a problem as you are left with highly refractory compositions. In this case you either leave slightly more melt in the host-rock or decrease the maximum temperature.
  

:::

### 12. LaMEM density diagram {#12.-LaMEM-density-diagram}

#### Quickstart {#Quickstart}

When computing a density diagram for `LaMEM` geodynamic modelling code, the initial grid setup needs to be changed. Density diagrams for geodynamic modelling generally need to evenly sample the pressure-temperature space of interest and should avoid using refinement. The recommanded mesh configuration in the `Setup` panel is the following.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_LaMEM_setup.png?raw=true" alt="MAGEMinApp LaMEM setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">



which when displaying the grid and the system density gives:

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_LaMEM_density.png?raw=true" alt="MAGEMinApp LaMEM density" style="max-width: 90%; height: auto; display: block; margin: 0 auto;">


To export the diagram in the format used in LaMEM (`*.in`), simply click on the top-left `Export rho for LaMEM` button!

::: tip Note
- Ensure that the thermodynamic you select is calibrated for your pressure-temperature of interest.
  
- Make sure the diagram you produce cover the pressure-temperature you expect in your geodynamic simulation. Otherwise `LaMEM` will extrapolate to out of bound regions which may not be what you want!
  
- With the above configuration, the total number of computed points will be 4225 which is largely sufficient. Mind that `LaMEM` does not support density diagram with a number of points greater than ~20k.
  

:::

#### Upper mantle density diagram {#Upper-mantle-density-diagram}

When modeling plate-tectonics dynamics, one generally wants to account for phase change in the mantle. To produce a density diagram for the upper mantle you can use the Mantle database (Holland et al., 2012) or `mtl` acronym and the pre-defined `pyrolite` composition. A possible set of pressure-temperature valid for the lithosphere and the asthenosphere is for instance, from 1 to 300 kbar (0.1 to 30 GPa) and from 400 to 2000 °C.

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pyrolite_setup.png?raw=true" alt="MAGEMinApp pyrolite setup" style="max-width: 40%; height: auto; display: block; margin: 0 auto;">


This results in the following upper mantle density diagram that can be exported for `LaMEM`

<img src="https://raw.githubusercontent.com/ComputationalThermodynamics/repositories_pictures/main/MAGEMin_doc/MAGEMinApp_pyrolite.png?raw=true" alt="MAGEMinApp pyrolite" style="max-width: 50%; height: auto; display: block; margin: 0 auto;">

