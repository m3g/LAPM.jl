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
            legend=cosolvent=="urea" ? :bottom : :top,
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

# Combine single-panel plots in one row, with A, B, C... panel labels
function _compose_panels(panels; panel_size=(400, 400))
    n = length(panels)
    plt = plot(panels...; layout=(1, n), size=(n * panel_size[1], panel_size[2]),
        leftmargin=0.8Plots.Measures.cm, bottommargin=0.8Plots.Measures.cm,
        topmargin=0.1Plots.Measures.cm,
    )
    for (sp, label) in enumerate('A':'Z')
        sp > n && break
        # label outside the axes, left of the y tick labels, aligned with the top axis line
        annotate!(plt, -6.2, 0.4, text(label * ")", 12, :left, :top, "Computer Modern"); subplot=sp)
    end
    return plt
end

"""
    plot_figure1(; sasas_from=creamer_sasa)

Figure 1 of the paper: experimental and predicted denaturation m-values in urea.
A) Established model with apparent transfer free energies.
B) Established model with the (incorrect) glycine-activity correction.
C) Established model with the correct glycine-activity correction.
D) Universal-backbone model with the correct glycine-activity correction.
"""
function plot_figure1(; sasas_from::Function=creamer_sasa)
    panels = [
        plot_experimental(AutonBolen, "urea-app"; sasas_from, labels=false),
        plot_experimental(AutonBolen, "urea"; sasas_from, labels=false),
        plot_experimental(AutonBolen, "urea-mh"; sasas_from, labels=false),
        plot_experimental(MoeserHorinek, "urea"; sasas_from, labels=false),
    ]
    return _compose_panels(panels)
end

"""
    plot_figure5(; sasas_from=creamer_sasa)

Figure 5 of the paper: Accessibility model predictions of urea denaturation m-values,
A) with the ASA-based backbone accessibility of each residue type, and
B) with unit backbone accessibility for all residues.
"""
function plot_figure5(; sasas_from::Function=creamer_sasa)
    # The default urea backbone accessibility parameter is 1 (panel B);
    # temporarily set it to 0 to use the ASA-ratio-based accessibilities (panel A).
    acc_default = PDBTools.acc["urea"]
    local pltA
    try
        PDBTools.acc["urea"] = 0.0f0
        pltA = plot_experimental(Accessibility, "urea"; sasas_from, labels=false)
        plot!(pltA, legend=:top)
    finally
        PDBTools.acc["urea"] = acc_default
    end
    pltB = plot_experimental(Accessibility, "urea"; sasas_from, labels=false)
    return _compose_panels([pltA, pltB])
end

export plot_figure1, plot_figure5
