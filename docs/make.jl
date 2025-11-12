using Documenter

makedocs(
    sitename="LAPM.jl",
    pages=[
        "Introduction" => "index.md",
        "Auton & Bolen" => "autonbolen.md",
        "Moeser & Horinek" => "moeserhorinek.md",
        "References" => "references.md",
    ],
)
deploydocs(
    repo="github.com/m3g/LAPM.jl.git",
    target="build",
    branch="gh-pages",
    versions=["stable" => "v^", "v#.#"],
)
