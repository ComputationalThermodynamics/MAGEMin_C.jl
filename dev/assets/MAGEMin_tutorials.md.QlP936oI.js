import{_ as t,c as s,o as a,aA as e}from"./chunks/framework.BAvzx4uq.js";const g=JSON.parse('{"title":"List of arguments","description":"","frontmatter":{},"headers":[],"relativePath":"MAGEMin/tutorials.md","filePath":"MAGEMin/tutorials.md","lastUpdated":null}'),l={name:"MAGEMin/tutorials.md"};function n(h,i,p,d,k,r){return a(),s("div",null,i[0]||(i[0]=[e(`<h1 id="List-of-arguments" tabindex="-1">List of arguments <a class="header-anchor" href="#List-of-arguments" aria-label="Permalink to &quot;List of arguments {#List-of-arguments}&quot;">​</a></h1><p>MAGEMin is run using command line arguments when executing the binary file.</p><h2 id="Valid-Command-Line-Arguments" tabindex="-1">Valid Command Line Arguments <a class="header-anchor" href="#Valid-Command-Line-Arguments" aria-label="Permalink to &quot;Valid Command Line Arguments {#Valid-Command-Line-Arguments}&quot;">​</a></h2><table tabindex="0"><thead><tr><th style="text-align:right;">Arguments</th><th style="text-align:right;">Application</th></tr></thead><tbody><tr><td style="text-align:right;"><code>--version</code></td><td style="text-align:right;">Displays MAGEMin version</td></tr><tr><td style="text-align:right;"><code>--help</code></td><td style="text-align:right;">Displays help</td></tr><tr><td style="text-align:right;"><code>--Verb=x</code></td><td style="text-align:right;">Verbose option, 0: inactive, 1: active</td></tr><tr><td style="text-align:right;"><code>--File=path</code></td><td style="text-align:right;">Given file for multiple point calculation</td></tr><tr><td style="text-align:right;"><code>--n_points=x</code></td><td style="text-align:right;">Number of points when using <em>File</em> argument</td></tr><tr><td style="text-align:right;"><code>--test=x</code></td><td style="text-align:right;">Run calculation on included test compositions</td></tr><tr><td style="text-align:right;"><code>--Pres=y</code></td><td style="text-align:right;">Pressure in kilobar</td></tr><tr><td style="text-align:right;"><code>--Temp=y</code></td><td style="text-align:right;">Temperature in Celsius</td></tr><tr><td style="text-align:right;"><code>--Bulk=[y]</code></td><td style="text-align:right;">Bulk rock composition in molar amount</td></tr><tr><td style="text-align:right;"><code>--Gam=[y]</code></td><td style="text-align:right;">Gamma, when a guess of gamma is known</td></tr><tr><td style="text-align:right;"><code>--solver=x</code></td><td style="text-align:right;">Legacy, 0; PGE, 1; 2 Hybrid (default)</td></tr><tr><td style="text-align:right;"><code>--db=&quot;&quot;</code></td><td style="text-align:right;">Database, &quot;ig&quot; or &quot;mp&quot;, default is &quot;ig&quot;</td></tr><tr><td style="text-align:right;"><code>--ds=x</code></td><td style="text-align:right;">Dataset selection: 62, 633, 634, 635 or 636</td></tr><tr><td style="text-align:right;"><code>--sys_in=&quot;&quot;</code></td><td style="text-align:right;">System composition: &quot;mol&quot; or &quot;wt&quot;, default is &quot;mol&quot;</td></tr><tr><td style="text-align:right;"><code>--out_matlab=x</code></td><td style="text-align:right;">Matlab output, 0: inactive, 1: active</td></tr><tr><td style="text-align:right;"><code>--mbCpx=x</code></td><td style="text-align:right;">Metabasite database Dio, 0; Aug, 1</td></tr><tr><td style="text-align:right;"><code>--mbIlm=x</code></td><td style="text-align:right;">Metabasite database Ilm, 0; Ilmm, 1</td></tr><tr><td style="text-align:right;"><code>--mpSp=x</code></td><td style="text-align:right;">Metapelite database Sp, 0; Spl, 1</td></tr><tr><td style="text-align:right;"><code>--mpIlm=x</code></td><td style="text-align:right;">Metapelite database Ilm, 0; Ilmm, 1</td></tr><tr><td style="text-align:right;"><code>--buffer=&quot;&quot;</code></td><td style="text-align:right;">Oxygen buffer, &quot;qfm&quot;, &quot;mw&quot;, &quot;qif&quot;, &quot;nno&quot;, &quot;hm&quot;, &quot;iw&quot;, &quot;cco&quot;, &quot;aH2O&quot;, &quot;aO2&quot;, &quot;aMgO&quot;, &quot;aFeO&quot;, &quot;aAl2O3&quot;, &quot;aTiO2</td></tr><tr><td style="text-align:right;"><code>--buffer_n=x</code></td><td style="text-align:right;">Buffer offset in the RTlog scale</td></tr></tbody></table><p>where <em>x</em> is an <code>integer</code>, <em>y</em> a <code>float</code>/<code>double</code>, <em>&quot;&quot;</em> is a <code>string</code> and <em>[]</em> a comma-separated list of size <em>number of oxides</em>.</p><h2 id="Order-of-Oxides" tabindex="-1">Order of Oxides <a class="header-anchor" href="#Order-of-Oxides" aria-label="Permalink to &quot;Order of Oxides {#Order-of-Oxides}&quot;">​</a></h2><p>The list of oxides must be given in the following order:</p><table tabindex="0"><thead><tr><th style="text-align:left;">SiO₂</th><th style="text-align:left;">Al₂O₃</th><th style="text-align:left;">CaO</th><th style="text-align:left;">MgO</th><th style="text-align:left;">FeO</th><th style="text-align:left;">K₂O</th><th style="text-align:left;">Na₂O</th><th style="text-align:left;">TiO₂</th><th style="text-align:left;">O</th><th style="text-align:left;">Cr₂O₃</th><th style="text-align:left;">H₂O</th></tr></thead><tbody><tr><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td></tr></tbody></table><div class="tip custom-block"><p class="custom-block-title">Note</p><p>FeO is the total iron (FeOt) and O is the excess oxygen which is internally converted to Fe2O3.</p></div><hr><h2 id="Single-Point-Calculation" tabindex="-1">Single Point Calculation <a class="header-anchor" href="#Single-Point-Calculation" aria-label="Permalink to &quot;Single Point Calculation {#Single-Point-Calculation}&quot;">​</a></h2><p>Using the previously defined arguments, a valid command to run a single point calculation with MAGEMin is:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Verb=1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Temp=718.750</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Pres=30.5000</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --test=0</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> &gt;&amp;</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">log.txt</span></span></code></pre></div><p>Here:</p><ul><li><p>Verbose mode is active.</p></li><li><p>The selected database is &quot;ig&quot; (Igneous).</p></li><li><p>The bulk rock composition of <em>test 0</em> is selected.</p></li><li><p>The verbose output is saved as a log file <code>log.txt</code>.</p></li></ul><p>To compute using a different bulk rock composition:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Verb=1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Temp=488.750</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Pres=3.5000</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Bulk=41.49,1.57,3.824,50.56,5.88,0.01,0.25,0.10,0.1,0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --sys_in=mol</span></span></code></pre></div><hr><h2 id="Multiple-Points-Calculation" tabindex="-1">Multiple Points Calculation <a class="header-anchor" href="#Multiple-Points-Calculation" aria-label="Permalink to &quot;Multiple Points Calculation {#Multiple-Points-Calculation}&quot;">​</a></h2><p>To run multiple points at once, pass an input file containing the list of points:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --Verb=1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --File=path_to_file</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --n_points=x</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span></span></code></pre></div><p>where:</p><ul><li><p><code>path_to_file</code> is the location of the input file.</p></li><li><p><code>x</code> is an integer corresponding to the total number of points in the file.</p></li></ul><h2 id="File-Structure" tabindex="-1">File Structure <a class="header-anchor" href="#File-Structure" aria-label="Permalink to &quot;File Structure {#File-Structure}&quot;">​</a></h2><table tabindex="0"><thead><tr><th style="text-align:left;">Mode(0-1)</th><th style="text-align:left;">Pressure (kbar)</th><th style="text-align:left;">Temperature (°C)</th><th style="text-align:left;">Bulk_1</th><th style="text-align:left;">Bulk_2</th><th style="text-align:left;">...</th><th style="text-align:left;">Bulk_n</th></tr></thead><tbody><tr><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td><td style="text-align:left;"></td></tr></tbody></table><ul><li><p><code>Mode = 0</code> for global minimization.</p></li><li><p><code>Bulk_n</code> represents the bulk rock composition in oxides (mol or wt fraction).</p></li></ul><h3 id="Example-Input-File" tabindex="-1">Example Input File <a class="header-anchor" href="#Example-Input-File" aria-label="Permalink to &quot;Example Input File {#Example-Input-File}&quot;">​</a></h3><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">MAGEMin_input.dat:</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 4.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 8.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 8.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Run the computation:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --File=/path_to_file/MAGEMin_input.dat</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --n_points=4</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --test=0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span></span></code></pre></div><p>To use a custom bulk-rock composition:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">MAGEMin_input.dat:</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 41.49</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 1.57</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 4.824</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 52.56</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 5.88</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.01</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.25</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.10</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 4.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 44.49</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 1.56</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 3.24</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 48.56</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 5.2</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.01</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.25</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.10</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 8.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 42.49</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 1.27</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 3.84</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 51.56</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 4.28</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.01</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.25</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.10</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 8.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 800.0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 40.49</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 1.87</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 1.824</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 50.56</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 6.08</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.01</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.25</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.10</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.1</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.0</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Run the computation with system composition unit:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --File=/path_to_file/MAGEMin_input.dat</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --n_points=4</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --sys_in=mol</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span></span></code></pre></div><hr><h2 id="Multiple-Points-in-Parallel" tabindex="-1">Multiple Points in Parallel <a class="header-anchor" href="#Multiple-Points-in-Parallel" aria-label="Permalink to &quot;Multiple Points in Parallel {#Multiple-Points-in-Parallel}&quot;">​</a></h2><p>To run a list of points in parallel, use MPI before MAGEMin and specify the number of cores:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">mpirun</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> -np</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 8</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;"> ./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --File=/path_to_file/MAGEMin_input.dat</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --n_points=4</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --test=0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --out_matlab=1</span></span>
<span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">mpiexec</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> -n</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 8</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;"> ./MAGEMin</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --File=/path_to_file/MAGEMin_input.dat</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --n_points=4</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --db=ig</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --test=0</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> --out_matlab=1</span></span></code></pre></div><p>where <code>8</code> is the number of cores. The results will be stored in an output file gathering all points&#39; results.</p><p>!!! note In parallel mode: - Verbose should be deactivated (<code>--Verb=0</code> or <code>--Verb=-1</code>). - Matlab output can still be generated (<code>--out_matlab=1</code>).</p><h2 id="THERMOCALC-like-Output" tabindex="-1">THERMOCALC-like Output <a class="header-anchor" href="#THERMOCALC-like-Output" aria-label="Permalink to &quot;THERMOCALC-like Output {#THERMOCALC-like-Output}&quot;">​</a></h2><p>If <code>verbose</code> is set to 1:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">--Verb</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">1</span></span></code></pre></div><p>a file named <code>_thermocalc_style_output.txt</code> containing information about the stable phase equilibrium is saved in the <code>./output/</code> directory.</p><hr><h2 id="MATLAB-Output" tabindex="-1">MATLAB Output <a class="header-anchor" href="#MATLAB-Output" aria-label="Permalink to &quot;MATLAB Output {#MATLAB-Output}&quot;">​</a></h2><p>If the following argument is used:</p><div class="language-shell vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">shell</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">--out_matlab</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">1</span></span></code></pre></div><p>a file named <code>_matlab_output.txt</code> containing information about the stable phase equilibrium is saved in the <code>./output/</code> directory.</p><p>This file, although similar in structure to <code>_thermocalc_style_output.txt</code>, presents the minimization results in more human-friendly units:</p><ul><li>Phase fraction and composition are expressed in <strong>wt fraction</strong>.</li></ul><div class="tip custom-block"><p class="custom-block-title">Note</p><p>This output is used by the MATLAB notebook <code>MAGEMin_EquilibriumPath.mlx</code>, developed by Dr. Tobias Keller (<a href="mailto:tobias.keller@erdw.ethz.ch" target="_blank" rel="noreferrer">tobias.keller@erdw.ethz.ch</a>), and added to MAGEMin in version <strong>v1.2.4</strong>.</p></div>`,52)]))}const C=t(l,[["render",n]]);export{g as __pageData,C as default};
