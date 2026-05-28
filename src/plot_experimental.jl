plot_experimental(
    model::Type{<:PDBTools.MValueModel},
    cosolvent="urea";
    sasas_from::Function=creamer_sasa
) = plot_experimental([model], cosolvent; sasas_from)

function plot_experimental(
    models::Vector=[AutonBolen, MoeserHorinek, MoeserHorinekApp],
    cosolvent="urea";
    sasas_from::Function=creamer_sasa
)
    scalefontsizes()
    plt = plot(layout=(1,length(models)))
    cosolvent = lowercase(cosolvent)
    cosolvent_exp = cosolvent == "urea-app" ? "urea" : cosolvent
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    sp=0
    for model in models
        sp += 1
        tot_pred = zeros(nexamples)
        tot_exp = zeros(nexamples)
        for (i, str) in enumerate(example_structs)
            p = predict_mvalue(str; cosolvent, model, sasas_from)
            tot_pred[i] = p.tot
            tot_exp[i] = mvalues_experimental[str][cosolvent_exp]
        end
        plot!(plt,framestyle=:box, fontfamily="Computer Modern", subplot=sp)
        ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
        plot!(plt, [-100, 100], [-100, 100]; subplot=sp, ls...)
        _scatter!(plt, tot_exp, tot_pred, example_structs; legend_title="", subplot=sp)
        plot!(plt, xlabel=L"\textrm{Experimental~/~kcal~mol^{-1}}", subplot=sp)
        plot!(plt, ylabel=modelname(model), subplot=sp)
        fit = fitlinear(tot_exp, tot_pred)
        plot!(plt,
            subplot=sp,
            legend_title=latexstring(
                "a="*string(round(fit.a; digits=3))*";~"*
                "b="*string(round(fit.b; digits=3))*";~"*
                "R^2="*string(round(fit.R2; digits=3))
            ), 
            legend=:topleft
        )
        plot!(plt,xlims=(-3.5,0.2), ylims=(-3.5,0.2), subplot=sp)
    end
    plot!(plt, 
        size=(length(models) * 400,400),
        leftmargin=0.6Plots.Measures.cm,
        bottomargin=0.5Plots.Measures.cm,
    )
    return plt
end