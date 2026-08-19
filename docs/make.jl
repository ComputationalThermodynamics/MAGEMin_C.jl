using Documenter, DocumenterVitepress, MAGEMin_C

DocMeta.setdocmeta!(MAGEMin_C, :DocTestSetup, :(using MAGEMin_C); recursive=true)

makedocs(;
    modules     = [MAGEMin_C],
    repo        = Remotes.GitHub("ComputationalThermodynamics", "MAGEMin_C.jl"),
    authors     = "Nicolas-Riel <nriel@uni-mainz.de>, and contributors",
    sitename    = "MAGEMin",
    format      = DocumenterVitepress.MarkdownVitepress(
        repo    = "github.com/ComputationalThermodynamics/MAGEMin_C.jl",
        devbranch = "main",
        devurl = "dev",
    ),
    pages = [
        "Home"          => "index.md",
        "Methods"       => "problem.md",
        "Databases"      => "database.md",
        "MAGEMinApp.jl" => [
                "Introduction"  => "MAGEMinApp/MAGEMinApp.md",
                "Installation & update"  => "MAGEMinApp/installation.md",
                "Interface"     => "MAGEMinApp/interface.md",
                "Tutorials" => [
                        "Bulk input file"          => "MAGEMinApp/bulk_rock.md",
                        "Partition coeficient file" => "MAGEMinApp/partition_coef.md",
                        "Phase diagrams"            => "MAGEMinApp/PD_tutorials.md",
                        "P-T-X paths"               => "MAGEMinApp/PTX_tutorials.md",
                        # "Isentropic paths"          => "MAGEMinApp/isoS_tutorials.md",
                        "Citations"                 => "MAGEMinApp/citation.md",
                ],
        ],
        "MAGEMin_C.jl" => [
                "Reference" => [
                        "Introduction"           => "MAGEMin_C/MAGEMin_C.md",
                        "Installation & update"  => "MAGEMin_C/installation.md",
                        "Important options"      => "MAGEMin_C/options.md",
                        "API"                    => "api.md",
                ],
                "Tutorials" => [
                        "Quickstart"       => "MAGEMin_C/quickstart.md",
                        "Output structure" => "MAGEMin_C/output_structure.md",
                        "Other examples"   => "MAGEMin_C/examples.md",
                ],
                "Trace elements & saturation" => [
                        "Trace-elements"    => "MAGEMin_C/trace_elements.md",
                        "Saturation models" => "MAGEMin_C/saturation_models.md",
                ],
                "Advanced calculations" => [
                        "Fractional crystallization"          => "MAGEMin_C/fractional_crystallization.md",
                        "Threaded fractional cryst."           => "MAGEMin_C/threaded_fractional_crystallization.md",
                        "Isentropic path"                      => "MAGEMin_C/isentropic_path.md",
                        "Initial guess"                        => "MAGEMin_C/initial_guess.md",
                ],
        ],
        "MAGEMin" => [
                "Introduction"           => "MAGEMin/MAGEMin.md",
                "Compilation"            => "MAGEMin/installation.md",
                "Command-line reference" => "MAGEMin/tutorials.md",
        ],
        "Tutorials & Case Studies" => [
                "Workshop: Trace-element partitioning" => [
                        "Overview"                          => "WS_Bejing_2026/overview.md",
                        "1 - Introduction"                  => "WS_Bejing_2026/MAGEMin_C_intro.md",
                        "2 - Iterative calculations"        => "WS_Bejing_2026/MAGEMin_C_iterative_calculations.md",
                        "3 - Fractional melting"            => "WS_Bejing_2026/MAGEMin_C_fractional_melting.md",
                        "4 - Li partitioning"               => "WS_Bejing_2026/MAGEMin_C_Li_partitioning.md",
                        "5 - Li partitioning (frac. melt.)" => "WS_Bejing_2026/MAGEMin_C_Li_partitioning_fractional_melting.md",
                ],
                "Case study: Li enrichment (Riel et al. 2026)" => [
                        "Overview"                              => "Riel_2026_gcubed/overview.md",
                        "1 - P–H₂O systematics"                => "Riel_2026_gcubed/TUTORIAL_compute_PH2O_systematics.md",
                        "2 - P–T extraction curves"            => "Riel_2026_gcubed/TUTORIAL_compute_PT_curves.md",
                        "3 - Stepwise batch melting"           => "Riel_2026_gcubed/TUTORIAL_compute_plot_stepwise_batch_melting.md",
                        "4 - Biotite Li profiles"              => "Riel_2026_gcubed/TUTORIAL_compute_bi_Li_profiles.md",
                        "5 - Phase stability"                  => "Riel_2026_gcubed/TUTORIAL_compute_plot_phase_stability.md",
                        "6 - Solidus across pelites"           => "Riel_2026_gcubed/TUTORIAL_compute_solidus_FS.md",
                        "7 - Li systematics across pelites"    => "Riel_2026_gcubed/TUTORIAL_compute_systematics_FS.md",
                ],
        ],

    ],
)

DocumenterVitepress.deploydocs(;
    repo            = "github.com/ComputationalThermodynamics/MAGEMin_C.jl",
    devbranch       = "main",
    push_preview    = true,
)
