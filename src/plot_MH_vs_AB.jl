function plot_MH_vs_AB(
    cosolvent::String="urea"; 
    m1=AutonBolen,
    m2=MoeserHorinek,
    sasas_from=server_sasa
)
    cosolvent = lowercase(cosolvent)
    cosolvent_mh = cosolvent == "urea-app" ? "urea" : cosolvent
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot_mh, bb_mh, sc_mh = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    tot_ab, bb_ab, sc_ab = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        p_mh = predict_mvalue(str; model=m1, cosolvent, sasas_from)
        tot_mh[i] = p_mh.tot
        bb_mh[i] = p_mh.bb
        sc_mh[i] = p_mh.sc
        p_ab = predict_mvalue(str; model=m2, cosolvent=cosolvent_mh, sasas_from)
        tot_ab[i] = p_ab.tot
        bb_ab[i] = p_ab.bb
        sc_ab[i] = p_ab.sc
    end

    l = @layout [a b c; d; e]
    plt = plot(layout=l, framestyle=:box, fontfamily="Computer Modern")
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
    for sp in 1:3
        plot!(plt, [-100, 100], [-100, 100]; ls..., subplot=sp)
    end
    _scatter!(plt, tot_ab, tot_mh, example_structs; legend_title="Total", subplot=1)
    _scatter!(plt, bb_ab, bb_mh, example_structs; legend_title="Backbone", subplot=2)
    _scatter!(plt, sc_ab, sc_mh, example_structs; legend_title="Sidechain", subplot=3)
    plot!(plt,
        size=(1200, 1200),
        xlabel=modelname(m1),
        ylabel=nothing,
        leftmargin=0.5Plots.Measures.cm,
    )
    plot!(plt,
        ylabel=modelname(m2),
        subplot=1
    )

    ys = (maximum(vcat(tot_ab, sc_ab, bb_ab)) - minimum(vcat(tot_ab, sc_ab, bb_ab)))
    groupedbar!(
        string.(example_structs),
        hcat(tot_ab, bb_ab, sc_ab);
        label=["Total" "BB" "SC"],
        #title="Contributions",
        xlabel="Structure",
        ylabel=modelname(m2),
        subplot=4,
        ylims=(
            minimum(vcat(tot_ab, sc_ab, bb_ab, 0)) - 0.1 * abs(ys),
            maximum(vcat(tot_ab, sc_ab, bb_ab, 0)) + 0.1 * abs(ys)
        ),
        fontfamily="Computer Modern",
        xrotation=60,
    )

    ys = (maximum(vcat(tot_mh, sc_mh, bb_mh)) - minimum(vcat(tot_mh, sc_mh, bb_mh)))
    groupedbar!(
        string.(example_structs),
        hcat(tot_mh, bb_mh, sc_mh);
        label=["Total" "BB" "SC"],
        #title="Contributions",
        xlabel="Structure",
        ylabel=modelname(m1),
        subplot=5,
        ylims=(
            minimum(vcat(tot_mh, sc_mh, bb_mh, 0)) - 0.1 * abs(ys),
            maximum(vcat(tot_mh, sc_mh, bb_mh, 0)) + 0.1 * abs(ys)
        ),
        xrotation=60,
        fontfamily="Computer Modern",
        bottommargin=0.5Plots.Measures.cm,
    )

    return plt
end