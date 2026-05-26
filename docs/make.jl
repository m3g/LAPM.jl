using Documenter

per_atom_type_dir="$(@__DIR__)/../src/per_atom_type/output/"
cp("$(per_atom_type_dir)/ASA_creamer_vs_LAPM.png","$(@__DIR__)/src/figures/ASA_creamer_vs_LAPM.png"; force=true)
cp("$(per_atom_type_dir)/creamer_fig2.png","$(@__DIR__)/src/figures/creamer_fig2.png"; force=true)

makedocs(
    sitename="LAPM.jl",
    format = Documenter.HTML(
        size_threshold = 30_000_000,       # 30 MiB — needed for alpha_beta.md (density plots over ~15k structures)
        size_threshold_warn = 5_000_000,   # warn above 5 MiB
    ),
    pages=[
        "Introduction" => "index.md",
        "Installation" => "installation.md",
        "Creamer ASAs (Figs. S1-S2)" => "creamer_ASA.md",
        "Auton & Bolen (Creamer) (Figs. S3-S11)" => "autonbolen.md",
        "Auton & Bolen (Server)" => "autonbolen2.md",
        "Moeser & Horinek" => "moeserhorinek.md",
        "M&H vs A&B (Figs. S12-S20)" => "mh_vs_ab.md",
        "MoeserHorinekFit (Figs. S21-S29)" => "mh_vs_ab_fit.md",
        "Fold families (Figs. S30-S47)" => "alpha_beta.md",
        "Experimental (Fig. S48)" => "experimental.md",
        "References" => "references.md",
    ],
)
deploydocs(
    repo="github.com/m3g/LAPM.jl.git",
    target="build",
    branch="gh-pages",
    versions=["stable" => "v^", "v#.#"],
)
