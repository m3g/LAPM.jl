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
The two new CATH S20 figures are S6–S7; the remaining figures are shifted by 2 relative
to previous numbering.
"""
function generate_documentation_figures(;
    outdir=joinpath(@__DIR__, "..", "docs", "src", "figures"),
    update_all=false,
)
    mkpath(outdir)
    println("Generating figures in: $outdir")

    function up(src, fig_name; update_all)
        update_all && return true
        file = joinpath(outdir, fig_name)
        !isfile(file) && return true
        return mtime(src) > mtime(file)
    end

    function save(ref, name, plt_call; update_all)
        if up(ref, name; update_all)
            savefig(plt_call(), joinpath(outdir, name))
            print("x")
        else
            print("o")
        end
    end

    # -----------------------------------------------------------------------
    # index.md — Figs S1–S3
    # -----------------------------------------------------------------------
    print("\n  index.md  (S1–S3)...")
    ref = joinpath(@__DIR__, "plot_mvalue.jl")
    save(ref, "fig_S01_index_mh_urea.svg", () -> plot_mvalue(MoeserHorinek, "urea"); update_all)
    save(ref, "fig_S02_index_ab_urea.svg", () -> plot_mvalue(AutonBolen, "urea"); update_all)
    save(ref, "fig_S03_index_ab_tmao.svg", () -> plot_mvalue(AutonBolen, "tmao"); update_all)

    # -----------------------------------------------------------------------
    # creamer_ASA.md — Figs S4–S9
    # -----------------------------------------------------------------------
    print("\n  creamer_ASA.md  (S4–S9)...")
    cd_orig = LAPM.load_creamer_per_residue()
    cd_cath = LAPM.load_creamer_per_residue(cath_s20=true)
    ref = joinpath(@__DIR__, "per_atom_type", "get_sasa_per_type.jl")
    save(ref, "fig_S04_creamer_fig2.svg", () -> LAPM.plot_cd_creamer(cd_orig); update_all)
    save(ref, "fig_S05_ASA_creamer_vs_LAPM.svg", () -> LAPM.scatter_creamer_vs_current(cd_orig); update_all)
    save(ref, "fig_S06_creamer_fig2_cath_s20.svg", () -> LAPM.plot_cd_creamer(cd_cath); update_all)
    save(ref, "fig_S07_ASA_creamer_vs_LAPM_cath_s20.svg", () -> LAPM.scatter_creamer_vs_current(cd_cath); update_all)
    ref = joinpath(@__DIR__, "per_atom_type", "creamer_per_atom.jl")
    save(ref, "fig_S08_creamer_ua_vs_exp.svg", () -> LAPM.plot_ua(); update_all)
    save(ref, "fig_S09_creamer_ua_vs_models.svg", () -> LAPM.plot_mvalue_ua(); update_all)

    # -----------------------------------------------------------------------
    # autonbolen.md — Figs S10–S18  (AutonBolen, Creamer SASAs)
    # -----------------------------------------------------------------------
    print("\n  autonbolen.md  (S10–S18)...")
    ref = joinpath(@__DIR__, "plot_mvalue.jl")
    for (n, cosolvent) in zip(10:18, ["urea", "tmao", "sucrose", "betaine", "sarcosine",
        "proline", "sorbitol", "glycerol", "trehalose"])
        save(ref, "fig_S$(lpad(n,2,'0'))_autonbolen_creamer_$(cosolvent).svg",
            () -> plot_mvalue(AutonBolen, cosolvent); update_all)
    end

    # -----------------------------------------------------------------------
    # autonbolen2.md — Figs S19–S27  (AutonBolen, server SASAs)
    # -----------------------------------------------------------------------
    print("\n  autonbolen2.md  (S19–S27)...")
    for (n, cosolvent) in zip(19:27, ["urea", "tmao", "sucrose", "betaine", "sarcosine",
        "proline", "sorbitol", "glycerol", "trehalose"])
        save(ref, "fig_S$(lpad(n,2,'0'))_autonbolen_server_$(cosolvent).svg",
            () -> plot_mvalue(AutonBolen, cosolvent; sasas_from=LAPM.server_sasa); update_all)
    end

    # -----------------------------------------------------------------------
    # moeserhorinek.md — Figs S28–S29
    # -----------------------------------------------------------------------
    print("\n  moeserhorinek.md  (S28–S29)...")
    save(ref, "fig_S28_moeserhorinek_creamer_urea.svg",
        () -> plot_mvalue(MoeserHorinek, "urea"); update_all)
    save(ref, "fig_S29_moeserhorinek_server_urea.svg",
        () -> plot_mvalue(MoeserHorinek, "urea"; sasas_from=LAPM.server_sasa); update_all)

    # -----------------------------------------------------------------------
    # mh_vs_ab.md — Figs S30–S31
    # -----------------------------------------------------------------------
    print("\n  mh_vs_ab.md  (S30–S31)...")
    ref = joinpath(@__DIR__, "plot_MH_vs_AB.jl")
    save(ref, "fig_S30_mh_vs_ab_urea_server.svg",
        () -> plot_MH_vs_AB("urea"; sasas_from=LAPM.server_sasa); update_all)
    save(ref, "fig_S31_mh_vs_ab_urea_creamer.svg",
        () -> plot_MH_vs_AB("urea"; sasas_from=LAPM.creamer_sasa); update_all)

    # -----------------------------------------------------------------------
    # mh_vs_ab_fit.md — Figs S32–S41
    # S32: MoeserHorinekApp vs MoeserHorinek (urea)
    # S33–S41: MoeserHorinekApp vs AutonBolen (all cosolvents)
    # -----------------------------------------------------------------------
    print("\n  mh_vs_ab_fit.md  (S32–S41)...")
    save(ref, "fig_S32_mhapp_vs_mh_urea.svg",
        () -> plot_MH_vs_AB("urea"; m1=MoeserHorinek, m2=MoeserHorinekApp); update_all)
    for (n, cosolvent) in zip(33:41, ["urea", "tmao", "sarcosine", "proline", "sorbitol",
        "sucrose", "betaine", "glycerol", "trehalose"])
        save(ref, "fig_S$(lpad(n,2,'0'))_mhapp_vs_ab_$(cosolvent).svg",
            () -> plot_MH_vs_AB(cosolvent; m1=AutonBolen, m2=MoeserHorinekApp); update_all)
    end

    # -----------------------------------------------------------------------
    # alpha_beta.md — Figs S42–S50
    # -----------------------------------------------------------------------
    print("\n  alpha_beta.md  (S42–S50)...")
    ref = joinpath(@__DIR__, "alfa_beta.jl")
    df = CSV.read(cath_data_file, DF.DataFrame)
    for (n, cosolvent) in zip(42:50, ["urea", "tmao", "proline", "sarcosine", "betaine",
        "sorbitol", "sucrose", "glycerol", "trehalose"])
        save(ref, "fig_S$(lpad(n,2,'0'))_alpha_beta_$(cosolvent).svg",
            () -> plot_cosolvent(df, cosolvent); update_all)
    end

    # -----------------------------------------------------------------------
    # experimental.md — Figs S51–S60
    # -----------------------------------------------------------------------
    print("\n  experimental.md  (S51–S60)...")

    # Urea — Creamer SASAs
    ref = joinpath(@__DIR__, "plot_experimental.jl")
    save(ref, "fig_S51_experimental_mh_creamer_urea.svg",
        () -> plot_experimental(MoeserHorinek; sasas_from=LAPM.creamer_sasa); update_all)
    save(ref, "fig_S52_experimental_ab_creamer_urea.svg",
        () -> plot_experimental(AutonBolen; sasas_from=LAPM.creamer_sasa); update_all)

    # Urea — server SASAs
    save(ref, "fig_S53_experimental_mh_server_urea.svg",
        () -> plot_experimental(MoeserHorinek; sasas_from=LAPM.server_sasa); update_all)
    save(ref, "fig_S54_experimental_ab_server_urea.svg",
        () -> plot_experimental(AutonBolen; sasas_from=LAPM.server_sasa); update_all)

    # Other osmolytes (mean / max / min Creamer denatured model)
    ref = joinpath(@__DIR__, "other_osmolytes.jl")
    save(ref, "fig_S55_other_osmolytes_mean.svg", () -> other_osmolytes(; type=2); update_all)
    save(ref, "fig_S56_other_osmolytes_max.svg", () -> other_osmolytes(; type=3); update_all)
    save(ref, "fig_S57_other_osmolytes_min.svg", () -> other_osmolytes(; type=1); update_all)

    # SH3 unfolding + GB1 dimerisation — Pielak/Rydeen dataset
    ref = joinpath(@__DIR__, "rydeen.jl")
    for (n, tag, type) in [(58, "mean", 2), (59, "max", 3), (60, "min", 1)]
        save(ref, "fig_S$(n)_rydeen_$(tag).svg", () -> begin
            plt_gb1 = plot_rydeen_dimmer(read_pdb(LAPM.os_pdb_files["2RMM"]))
            plt_sh3 = plot_rydeen_folding(read_pdb(LAPM.os_pdb_files["2AZS"]); type)
            plot_rydeen_both(plt_sh3, plt_gb1)
        end; update_all)
    end

    println("\n Done — $(length(readdir(outdir))) files in $outdir")
    return nothing
end
