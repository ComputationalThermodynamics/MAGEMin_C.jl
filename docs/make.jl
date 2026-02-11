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
        "MAGEMinApp.jl" => [
                "Introduction"  => "MAGEMinApp/MAGEMinApp.md",
                "Installation"  => "MAGEMinApp/installation.md",
                "Interface"     => "MAGEMinApp/interface.md",
                "Tutorials - Bulk input file"   => "MAGEMinApp/bulk_rock.md",
                "Tutorials - Partition coeficient file"   => "MAGEMinApp/partition_coef.md",
                "Tutorials - Phase diagrams"    => "MAGEMinApp/PD_tutorials.md",
                "Tutorials - P-T-X paths"       => "MAGEMinApp/PTX_tutorials.md",
                "Tutorials - Isentropic paths"  => "MAGEMinApp/isoS_tutorials.md",
                "Tutorials - Citations"         => "MAGEMinApp/citation.md",

        ],
        "MAGEMin_C.jl" => [
                "Introduction"  => "MAGEMin_C/MAGEMin_C.md",
                "Installation"  => "MAGEMin_C/installation.md",
                "Tutorials - Quickstart"            => "MAGEMin_C/quickstart.md",
                "Tutorials - Output structure"      => "MAGEMin_C/output_structure.md",
                "Tutorials - Trace-elements"        => "MAGEMin_C/trace_elements.md",
                "Tutorials - Saturation models"     => "MAGEMin_C/saturation_models.md",
                "Tutorials - Fractional crystallization"     => "MAGEMin_C/fractional_crystallization.md",
                "Tutorials - Threaded fractional cryst."     => "MAGEMin_C/threaded_fractional_crystallization.md",
                "Tutorials - Isentropic path"                => "MAGEMin_C/isentropic_path.md",
                "Tutorials - Initial guess"                  => "MAGEMin_C/initial_guess.md",
                "Tutorials - Other examples"        => "MAGEMin_C/examples.md",
                "API"           => "api.md",
        ],
        "MAGEMin" => [
                "Introduction"  => "MAGEMin/MAGEMin.md",
                "Compilation"   => "MAGEMin/installation.md",
                "Tutorials"     => "MAGEMin/tutorials.md",
        ],

    ],
)

deploydocs(;
    repo            = "github.com/ComputationalThermodynamics/MAGEMin_C.jl",
    devbranch       = "main",
    push_preview    = true,
)
