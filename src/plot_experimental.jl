plot_experimental(
    model::Type{<:PDBTools.MValueModel},
    cosolvent="urea";
    sasas_from::Function=creamer_sasa,
    labels=true,
    type=2,
) = plot_experimental([model], cosolvent; sasas_from, labels, type)

function plot_experimental(
    models::Vector=[AutonBolen, MoeserHorinek, Accessibility],
    cosolvent="urea";
    sasas_from::Function=creamer_sasa,
    labels=true,
    type,
)
    scalefontsizes()
    plt = plot(layout=(1,length(models)))
    cosolvent = lowercase(cosolvent)
    cosolvent_exp = cosolvent in ("urea-app", "urea-mh") ? "urea" : cosolvent
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    sp=0
    for model in models
        sp += 1
        tot_pred = zeros(nexamples)
        tot_exp = zeros(nexamples)
        for (i, str) in enumerate(example_structs)
            p = predict_mvalue(str, model; cosolvent, sasas_from, type)
            tot_pred[i] = p.tot
            tot_exp[i] = mvalues_experimental[str][cosolvent_exp]
        end
        plot!(plt,framestyle=:box, fontfamily="Computer Modern", subplot=sp)
        ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
        plot!(plt, [-100, 100], [-100, 100]; subplot=sp, ls...,
            extra_kwargs=Dict(:subplot=>Dict(:legend_hfactor=>0.7)),
        )
        @show length(tot_pred)
        if labels
            _scatter!(plt, tot_exp, tot_pred, example_structs; legend_title="", subplot=sp)
        else
            scatter!(plt, tot_exp, tot_pred; legend_title="", subplot=sp, label="")
        end
        plot!(plt, xlabel=L"\textrm{Experimental~/~kcal~mol^{-1}~M^{-1}}", subplot=sp)
        plot!(plt, ylabel=modelname(model), subplot=sp)
        fit = fitlinear(tot_exp, tot_pred)
        mse = sqrt(mean((tot_pred .- tot_exp) .^ 2))
        lines = []
        push!(lines, latexstring(
            "RMSE="*string(round(mse; digits=2))*"\\textrm{~kcal~mol^{-1}~M^{-1}}"*" / "*
            "R^2="*string(round(fit.R2; digits=3))
        ))
        push!(lines, latexstring(
            "a="*string(round(fit.a; digits=3))*" / "*"b="*string(round(fit.b; digits=3))
        ))
        plot!(plt,
            subplot=sp,
            legend_title=join(lines, "\n"),
            legend=:bottom,
            legend_title_font_pointsize=9,
            background_color_legend=RGBA(1, 1, 1, 0.7),
            foreground_color_legend=RGBA(0, 0, 0, 0.3),
        )
        plot!(plt,xlims=(-5.0,0.4), ylims=(-5.0,0.4), subplot=sp)
    end
    plot!(plt, 
        size=(length(models) * 400,400),
        leftmargin=0.6Plots.Measures.cm,
        bottomargin=0.5Plots.Measures.cm,
    )
    return plt
end


#=

Plot the difference between prdictd and experimental m-values for 
denatuation, for 

=#
function plot_experimental_boxplot()

end


