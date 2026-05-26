export generate_documentation_figures

"""
    generate_documentation_figures(; outdir)

Generate all figures used in the documentation pages and save them as SVG files
to `outdir` (default: `docs/src/figures/` relative to the package root).

Run once from the Julia REPL before building the docs:

```julia
using LAPM
generate_documentation_figures()
```

SI figure numbering follows document order (index → creamer_ASA → autonbolen →
autonbolen2 → moeserhorinek → mh_vs_ab → mh_vs_ab_fit → alpha_beta → experimental).
"""
function generate_documentation_figures(;
    outdir = joinpath(@__DIR__, "..", "docs", "src", "figures")
)
    mkpath(outdir)
    save(name, plt) = savefig(plt, joinpath(outdir, name))
    println("Generating figures in: $outdir")

    # -----------------------------------------------------------------------
    # index.md — Figs S1–S3
    # -----------------------------------------------------------------------
    println("  index.md  (S1–S3)...")
    save("fig_S01_index_mh_urea.svg",  plot_mvalue(MoeserHorinek, "urea"))
    save("fig_S02_index_ab_urea.svg",  plot_mvalue(AutonBolen, "urea"))
    save("fig_S03_index_ab_tmao.svg",  plot_mvalue(AutonBolen, "tmao"))

    # -----------------------------------------------------------------------
    # creamer_ASA.md — Figs S4–S7
    # -----------------------------------------------------------------------
    println("  creamer_ASA.md  (S4–S7)...")
    cd = LAPM.load_creamer_per_residue()
    save("fig_S04_creamer_fig2.svg",         LAPM.plot_cd_creamer(cd))
    save("fig_S05_ASA_creamer_vs_LAPM.svg",  LAPM.scatter_cremer_vs_current(cd))
    save("fig_S06_creamer_ua_vs_exp.svg",    LAPM.plot_ua())
    save("fig_S07_creamer_ua_vs_models.svg", LAPM.plot_mvalue_ua())

    # -----------------------------------------------------------------------
    # autonbolen.md — Figs S8–S16  (AutonBolen, Creamer SASAs)
    # -----------------------------------------------------------------------
    println("  autonbolen.md  (S8–S16)...")
    for (n, cosolvent) in zip(8:16, ["urea", "tmao", "sucrose", "betaine", "sarcosine",
                                      "proline", "sorbitol", "glycerol", "trehalose"])
        save("fig_S$(lpad(n,2,'0'))_autonbolen_creamer_$(cosolvent).svg",
             plot_mvalue(AutonBolen, cosolvent))
    end

    # -----------------------------------------------------------------------
    # autonbolen2.md — Figs S17–S25  (AutonBolen, server SASAs)
    # -----------------------------------------------------------------------
    println("  autonbolen2.md  (S17–S25)...")
    for (n, cosolvent) in zip(17:25, ["urea", "tmao", "sucrose", "betaine", "sarcosine",
                                       "proline", "sorbitol", "glycerol", "trehalose"])
        save("fig_S$(lpad(n,2,'0'))_autonbolen_server_$(cosolvent).svg",
             plot_mvalue(AutonBolen, cosolvent; sasas_from=LAPM.server_sasa))
    end

    # -----------------------------------------------------------------------
    # moeserhorinek.md — Figs S26–S27
    # -----------------------------------------------------------------------
    println("  moeserhorinek.md  (S26–S27)...")
    save("fig_S26_moeserhorinek_creamer_urea.svg",
         plot_mvalue(MoeserHorinek, "urea"))
    save("fig_S27_moeserhorinek_server_urea.svg",
         plot_mvalue(MoeserHorinek, "urea"; sasas_from=LAPM.server_sasa))

    # -----------------------------------------------------------------------
    # mh_vs_ab.md — Figs S28–S29
    # -----------------------------------------------------------------------
    println("  mh_vs_ab.md  (S28–S29)...")
    save("fig_S28_mh_vs_ab_urea_server.svg",
         plot_MH_vs_AB("urea"; sasas_from=LAPM.server_sasa))
    save("fig_S29_mh_vs_ab_urea_creamer.svg",
         plot_MH_vs_AB("urea"; sasas_from=LAPM.creamer_sasa))

    # -----------------------------------------------------------------------
    # mh_vs_ab_fit.md — Figs S30–S39
    # S30: MoeserHorinekFit vs MoeserHorinek (urea)
    # S31–S39: MoeserHorinekFit vs AutonBolen (all cosolvents)
    # -----------------------------------------------------------------------
    println("  mh_vs_ab_fit.md  (S30–S39)...")
    save("fig_S30_mhfit_vs_mh_urea.svg",
         plot_MH_vs_AB("urea"; m1=MoeserHorinek, m2=MoeserHorinekFit))
    for (n, cosolvent) in zip(31:39, ["urea", "tmao", "sarcosine", "proline", "sorbitol",
                                       "sucrose", "betaine", "glycerol", "trehalose"])
        save("fig_S$(lpad(n,2,'0'))_mhfit_vs_ab_$(cosolvent).svg",
             plot_MH_vs_AB(cosolvent; m1=AutonBolen, m2=MoeserHorinekFit))
    end

    # -----------------------------------------------------------------------
    # alpha_beta.md — Figs S40–S48
    # -----------------------------------------------------------------------
    println("  alpha_beta.md  (S40–S48)...")
    df = CSV.read(cath_data_file, DF.DataFrame)
    for (n, cosolvent) in zip(40:48, ["urea", "tmao", "proline", "sarcosine", "betaine",
                                       "sorbitol", "sucrose", "glycerol", "trehalose"])
        save("fig_S$(lpad(n,2,'0'))_alpha_beta_$(cosolvent).svg",
             plot_cosolvent(df, cosolvent))
    end

    # -----------------------------------------------------------------------
    # experimental.md — Figs S49–S58
    # -----------------------------------------------------------------------
    println("  experimental.md  (S49–S58)...")

    # Urea — Creamer SASAs
    save("fig_S49_experimental_mh_creamer_urea.svg",
         plot_experimental(MoeserHorinek; sasas_from=LAPM.creamer_sasa))
    save("fig_S50_experimental_ab_creamer_urea.svg",
         plot_experimental(AutonBolen; sasas_from=LAPM.creamer_sasa))

    # Urea — server SASAs
    save("fig_S51_experimental_mh_server_urea.svg",
         plot_experimental(MoeserHorinek; sasas_from=LAPM.server_sasa))
    save("fig_S52_experimental_ab_server_urea.svg",
         plot_experimental(AutonBolen; sasas_from=LAPM.server_sasa))

    # Other osmolytes (mean / max / min Creamer denatured model)
    save("fig_S53_other_osmolytes_mean.svg", other_osmolytes(; type=2))
    save("fig_S54_other_osmolytes_max.svg",  other_osmolytes(; type=3))
    save("fig_S55_other_osmolytes_min.svg",  other_osmolytes(; type=1))

    # SH3 unfolding + GB1 dimerisation — Pielak/Rydeen dataset
    plt_gb1 = plot_rydeen_dimmer(read_pdb(LAPM.os_pdb_files["2RMM"]))
    for (n, tag, type) in [(56, "mean", 2), (57, "max", 3), (58, "min", 1)]
        plt_sh3 = plot_rydeen_folding(read_pdb(LAPM.os_pdb_files["2AZS"]); type)
        save("fig_S$(n)_rydeen_$(tag).svg", plot_rydeen_both(plt_sh3, plt_gb1))
    end

    println("Done — $(length(readdir(outdir))) files in $outdir")
    return nothing
end
