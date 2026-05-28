#
# run all predictions and plot
#
function plot_mvalue(
    model::Type{<:PDBTools.MValueModel}=MoeserHorinek,
    cosolvent="urea";
    sasas_from::Function=creamer_sasa
)
    cosolvent = lowercase(cosolvent)
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot, bb, sc = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    tot_ref, bb_ref, sc_ref = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        p = predict_mvalue(str; cosolvent, model, sasas_from)
        tot[i] = p.tot
        bb[i] = p.bb
        sc[i] = p.sc
        tot_ref[i] = mvalues_ref(model)[str][cosolvent].tot
        bb_ref[i] = mvalues_ref(model)[str][cosolvent].bb
        sc_ref[i] = mvalues_ref(model)[str][cosolvent].sc
    end

    l = @layout [a b c; d]
    plt = plot(layout=l, framestyle=:box, fontfamily="Computer Modern")
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
    for sp in 1:3
        plot!(plt, [-100, 100], [-100, 100]; ls..., subplot=sp)
    end
    _scatter!(plt, tot_ref, tot, example_structs; legend_title="Total", subplot=1)
    _scatter!(plt, bb_ref, bb, example_structs; legend_title="Backbone", subplot=2)
    _scatter!(plt, sc_ref, sc, example_structs; legend_title="Sidechain", subplot=3)

    plot!(plt, xlabel=modelname(model), ylabel=nothing)
    plot!(plt, ylabel=L"\textrm{Current~implementation~/~kcal~mol^{-1}}", subplot=1)

    ys = (maximum(vcat(tot, sc, bb)) - minimum(vcat(tot, sc, bb)))
    groupedbar!(
        string.(example_structs),
        hcat(tot, bb, sc);
        label=["Total" "BB" "SC"],
        xlabel="Structure",
        ylabel=mvaluelabel(),
        subplot=4,
        ylims=(minimum(vcat(tot, sc, bb, 0)) - 0.1 * abs(ys), maximum(vcat(tot, sc, bb, 0)) + 0.1 * abs(ys)),
        xrotation=60,
        #bottommargin=0.5Plots.Measures.cm,
    )

    plot!(plt,
        size=(1200, 830),
        rightmargin=0.2Plots.Measures.cm,
        leftmargin=0.5Plots.Measures.cm,
        bottommargin=0.5Plots.Measures.cm,
    )

    return plt
end