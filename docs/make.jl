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
        "Method"        => "problem.md",
        "MAGEMinApp.jl" => [
                "Introduction"  => "MAGEMinApp/MAGEMinApp.md",
                "Installation"  => "MAGEMinApp/installation.md",
                "Tutorials - Bulk input file"   => "MAGEMinApp/bulk_rock.md",
                "Tutorials - Phase diagrams"    => "MAGEMinApp/PD_tutorials.md",
                "Tutorials - P-T-X paths"       => "MAGEMinApp/PTX_tutorials.md",
                "Tutorials - Isentropic paths"  => "MAGEMinApp/isoS_tutorials.md",
                "Citation"      => "MAGEMinApp/citation.md",
                "Interface"     => "MAGEMinApp/interface.md",
        ],
        "MAGEMin_C.jl" => [
                "Introduction"  => "MAGEMin_C/MAGEMin_C.md",
                "Installation"  => "MAGEMin_C/installation.md",
                "Tutorials - Output"  => "MAGEMin_C/output_structure.md",
                "Tutorials - Step by step"      => "MAGEMin_C/tutorials.md",
                "Tutorials - Quick examples"    => "MAGEMin_C/examples.md",

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
