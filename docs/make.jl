using Documenter

makedocs(
    sitename="LAPM.jl",
    pages=[
        "Introduction" => "index.md",
        "Auton & Bolen (Creamer)" => "autonbolen.md",
        "Auton & Bolen (Server)" => "autonbolen2.md",
        "Moeser & Horinek" => "moeserhorinek.md",
        "M&H vs A&B" => "mh_vs_ab.md",
        "References" => "references.md",
    ],
)
deploydocs(
    repo="github.com/m3g/LAPM.jl.git",
    target="build",
    branch="gh-pages",
    versions=["stable" => "v^", "v#.#"],
)
