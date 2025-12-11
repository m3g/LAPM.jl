using Documenter

per_atom_type_dir="$(@__DIR__)/../src/per_atom_type/output/"
cp("$(per_atom_type_dir)/ASA_creamer_vs_LAPM.png","$(@__DIR__)/src/figures/ASA_creamer_vs_LAPM.png"; force=true)
cp("$(per_atom_type_dir)/creamer_fig2.png","$(@__DIR__)/src/figures/creamer_fig2.png"; force=true)

makedocs(
    sitename="LAPM.jl",
    pages=[
        "Introduction" => "index.md",
        "Auton & Bolen (Creamer)" => "autonbolen.md",
        "Auton & Bolen (Server)" => "autonbolen2.md",
        "Moeser & Horinek" => "moeserhorinek.md",
        "M&H vs A&B" => "mh_vs_ab.md",
        "Experimental" => "experimental.md",
        "Creamer ASAs" => "creamer_ASA.md",
        "References" => "references.md",
    ],
)
deploydocs(
    repo="github.com/m3g/LAPM.jl.git",
    target="build",
    branch="gh-pages",
    versions=["stable" => "v^", "v#.#"],
)
