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
                "Tutorials"     => "MAGEMinApp/tutorials.md",
        ],
        "MAGEMin_C.jl" => [
                "Introduction"  => "MAGEMin_C/MAGEMin_C.md",
                "Installation"  => "MAGEMin_C/installation.md",
                "Tutorials"     => "MAGEMin_C/tutorials.md",
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
