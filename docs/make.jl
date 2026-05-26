using Documenter

makedocs(
    sitename="LAPM.jl",
    format = Documenter.HTML(
        size_threshold = 30_000_000,       # 30 MiB — needed for alpha_beta.md (density plots over ~15k structures)
        size_threshold_warn = 5_000_000,   # warn above 5 MiB
    ),
    pages=[
        "Introduction" => "index.md",
        "Installation" => "installation.md",
        "Creamer ASAs (Figs. S4-S7)" => "creamer_ASA.md",
        "Auton & Bolen (Creamer) (Figs. S8-S16)" => "autonbolen.md",
        "Auton & Bolen (Server) (Figs. S17-S25)" => "autonbolen2.md",
        "Moeser & Horinek (Figs. S26-S27)" => "moeserhorinek.md",
        "M&H vs A&B (Figs. S28-S29)" => "mh_vs_ab.md",
        "MoeserHorinekFit (Figs. S30-S39)" => "mh_vs_ab_fit.md",
        "Fold families (Figs. S40-S48)" => "alpha_beta.md",
        "Experimental (Figs. S49-S58)" => "experimental.md",
        "References" => "references.md",
    ],
)
deploydocs(
    repo="github.com/m3g/LAPM.jl.git",
    target="build",
    branch="gh-pages",
    versions=["stable" => "v^", "v#.#"],
)
