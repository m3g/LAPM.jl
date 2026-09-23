
using Measurements 
export plot_rydeen_folding
export plot_rydeen_folding_bar
export plot_rydeen_dimer
export plot_rydeen_dimer_bar
export plot_rydeen_both

const rydeen = OrderedDict(
    "TMAO" =>      ( 0.4 ±   0.1,  0.46 ± 0.02 ),
    "trehalose" => ( 0.26 ± 0.06,  0.45 ± 0.05 ),
    "sarcosine" => ( 0.24 ± 0.03,  0.45 ± 0.02 ),
    "betaine" =>   ( 0.13 ± 0.05,  0.21 ± 0.06 ),
    "proline" =>   ( 0.02 ± 0.07,  0.31 ±0.02 ),
    "sorbitol" =>  (-0.07 ± 0.03,  0.42 ± 0.03 ),
    "sucrose" =>   (-0.08 ± 0.04,  0.38 ± 0.02 ),
    "glycerol" =>  (-0.10 ± 0.07,  0.16 ± 0.03 ),
    "urea" =>      (-0.11 ± 0.02,  -0.31 ± 0.04 ),
)

record_cosolvents = ("urea", "betaine", "TMAO", "proline", "trehalose", "glycerol")

function rydeen_folding_predictions(
    prot=read_pdb(joinpath(@__DIR__ ,"data/pdb/2AZS.cif"), "not element H");
    type=2,
    m1=AutonBolen,
    m2=Accessibility,
    alpha=1.0,
)
    predictions = OrderedDict()
    for cosolvent in keys(rydeen)
        m_ab = zeros(length(eachmodel(prot)))
        m_mhapp = copy(m_ab)
        m_rec = copy(m_ab)
        m_mh = copy(m_ab)
        for (i, model) in enumerate(eachmodel(prot))
            c = CreamerDenaturedModel(model, type)
            m_ab[i] = mvalue(c, cosolvent; model=m1).tot
            m_mhapp[i] = mvalue(c, cosolvent; model=m2).tot
            m_mh[i] = mvalue(c, cosolvent; model=MoeserHorinek).tot
            if cosolvent in record_cosolvents
                r = MTRecordDenaturedModel(model)
                m_rec[i] = mvalue(r, cosolvent; alpha).tot
            end
        end
        mh_val = 0.4 * (mean(m_mh) ± std(m_mh))
        rec_val = cosolvent in record_cosolvents ? 0.4 * (mean(m_rec) ± std(m_rec)) : NaN ± NaN
        predictions[cosolvent] = (
            0.4 * (mean(m_ab) ± std(m_ab)),
            0.4 * (mean(m_mhapp) ± std(m_mhapp)),
            mh_val,
            rec_val,
        )
    end
    return predictions
end

function plot_rydeen_folding(
    prot=read_pdb(joinpath(@__DIR__ ,"data/pdb/2AZS.cif"), "not element H");
    type=2,
    m1=AutonBolen,
    m2=Accessibility,
    alpha=1.0,
)
    scalefontsizes(); scalefontsizes(1.2)
    predictions = rydeen_folding_predictions(prot; type, m1, m2, alpha)
    plt = plot(MolSimStyle)
#    @show extrema(val[2] - val[1] for (_, val) in predictions)

    # m_ab
    exp = [ val[2] for (key, val) in rydeen ]
    preds = [ val[1] for (key, val) in predictions ]
    scatter!(plt, exp, preds, 
        label=modelname(m1),
        markeralpha=1,
        markercolor=1,
        markershape=:circle,
    )
    #f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    #plot!(plt, f.x, f.y, 
    #    label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
    #    label="",
    #    linecolor=1,
    #)
    
    s = Dict(
        "TMAO" =>      (-0.03, 0.05),
        "sarcosine" => (0.10, 0.03),
        "betaine" =>   (0.0, -0.08),
        "proline" =>   (0.09, 0.0),
        "sorbitol" =>  (0.00, -0.08),
        "sucrose" =>   (-0.10, -0.05),
        "urea" =>      (0.0, 0.10),
        "glycerol" =>  (-0.05, -0.05),
        "trehalose" => (0.0, 0.05),
    )
    for (i, c) in enumerate(keys(rydeen))
        annotate!(plt, (exp[i].val + s[c][1], preds[i].val + s[c][2], text(c, 8)))
    end

    # mh
    exp = [ rydeen["urea"][2] ]
    preds =  [ predictions["urea"][3] ] 
    scatter!(plt, exp, preds, label=modelname(MoeserHorinek),
        markeralpha=1,
        markersize=8,
        markercolor=2,
        markershape=:star,
    )

    # Accessibility
    exp = [ val[2] for (key, val) in rydeen ] 
    preds = [ val[2] for (key, val) in predictions ]
    scatter!(plt, exp, preds, label=modelname(m2),
        markeralpha=1,
        markercolor=4,
        markershape=:square,
    )

    # Record
    exp = [ rydeen[c][2] for c in record_cosolvents ]
    preds =  [ predictions[c][4] for c in record_cosolvents ]
    scatter!(plt, exp, preds, label=modelname(MTRecord),
        markeralpha=1,
        markersize=8,
        markercolor=5,
        markershape=:star,
    )

    #f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    #plot!(plt, f.x, f.y, 
    #    label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
    #    label="",
    #    linecolor=4,
    #)

    plot!(plt, [-0.5, 0.6], [-0.5, 0.6], 
        linecolor=:black,
        linealpha=0.5,
        label="",
        aspect_ratio=1,
        linestyle=:dash,
        xlims=(-0.5, 0.6),
        ylims=(-0.5, 0.6),
        xlabel=L"\Delta \Delta G^\textrm{exp}\textrm{~/~kcal~mol^{-1}}",
        ylabel=L"\Delta \Delta G^\textrm{pred}\textrm{~/~kcal~mol^{-1}}",
        size=(500,500),
        legend=:bottomright,
    )

    return plt
end

function plot_rydeen_folding_bar(
    prot=read_pdb(joinpath(@__DIR__ ,"data/pdb/2AZS.cif"), "not element H");
    type=2,
    m1=AutonBolen,
    m2=Accessibility,
    alpha=1.0,
)
    scalefontsizes(); scalefontsizes(1.2)
    predictions = rydeen_folding_predictions(prot; type, m1, m2, alpha)

    cosolvents = collect(keys(rydeen))
    ncos = length(cosolvents)

    exp_vals = [ rydeen[c][2] for c in cosolvents ]
    m1_vals = [ predictions[c][1] for c in cosolvents ]
    m2_vals = [ predictions[c][2] for c in cosolvents ]
    mh_vals = [ predictions[c][3] for c in cosolvents ]
    rec_vals = [ predictions[c][4] for c in cosolvents ]

    labels = ["Experimental", modelname(m2), modelname(m1), modelname(MoeserHorinek), modelname(MTRecord)]
    all_vals = vcat(exp_vals, m2_vals, m1_vals, mh_vals, rec_vals)
    heights = getfield.(all_vals, :val)
    errs = getfield.(all_vals, :err)

    plt = plot(MolSimStyle)
    groupedbar!(plt,
        categorical(repeat(cosolvents; outer=length(labels)), levels=cosolvents),
        heights;
        yerror=errs,
        group=categorical(repeat(labels; inner=ncos), levels=labels),
        xlabel="",
        ylabel=L"\Delta \Delta G\textrm{~/~kcal~mol^{-1}}",
        xrotation=30,
        size=(700,500),
        legend=:topright,
    )
    return plt
end

function ec(m, exclude_cavities)
    if isnothing(exclude_cavities) 
        if m == MTRecord
            return true
        else
            return false
        end
    end
    return exclude_cavities
end

function _tfe(p, cosolvent, model, exclude_cavities)
    return transfer_free_energy(
        p, cosolvent; 
        model=model, 
        exclude_cavities=ec(model, exclude_cavities)
    )
end

function rydeen_dimer_predictions(
    prot=read_pdb(joinpath(@__DIR__ ,"data/pdb/2RMM.cif"), "not element H");
    m1=AutonBolen,
    m2=Accessibility,
    exclude_cavities=nothing,
)
    predictions = OrderedDict()
    for cosolvent in keys(rydeen)
        m_ab = zeros(length(eachmodel(prot)))
        m_mhapp = copy(m_ab)
        m_rec = copy(m_ab)
        m_mh = copy(m_ab)
        for (i, model) in enumerate(eachmodel(prot))
            cA = select(model, "chain A")
            cB = select(model, "chain B")
            # AutonBolen
            tfeA = _tfe(cA, cosolvent, m1, exclude_cavities)
            tfeB = _tfe(cB, cosolvent, m1, exclude_cavities)
            tfe_d = _tfe(model, cosolvent, m1, exclude_cavities)
            m_ab[i] = tfeA.tot + tfeB.tot - tfe_d.tot
            # Accessibility
            tfeA = _tfe(cA, cosolvent, m2, exclude_cavities)
            tfeB = _tfe(cB, cosolvent, m2, exclude_cavities)
            tfe_d = _tfe(model, cosolvent, m2, exclude_cavities)
            m_mhapp[i] = tfeA.tot + tfeB.tot - tfe_d.tot
            # MoeserHorinek
            tfeA = _tfe(cA, cosolvent, MoeserHorinek, exclude_cavities)
            tfeB = _tfe(cB, cosolvent, MoeserHorinek, exclude_cavities)
            tfe_d = _tfe(model, cosolvent, MoeserHorinek, exclude_cavities)
            m_mh[i] = tfeA.tot + tfeB.tot - tfe_d.tot
            # Record
            if cosolvent in record_cosolvents
                tfeA = _tfe(cA, cosolvent, MTRecord, exclude_cavities)
                tfeB = _tfe(cB, cosolvent, MTRecord, exclude_cavities)
                tfe_d = _tfe(model, cosolvent, MTRecord, exclude_cavities)
                m_rec[i] = tfeA.tot + tfeB.tot - tfe_d.tot
            end
        end
        mh_val = 0.4 * (mean(m_mh) ± std(m_mh))
        rec_val = cosolvent in record_cosolvents ? 0.4 * (mean(m_rec) ± std(m_rec)) : NaN ± NaN
        predictions[cosolvent] = (
            0.4 * (mean(m_ab) ± std(m_ab)),
            0.4 * (mean(m_mhapp) ± std(m_mhapp)),
            mh_val,
            rec_val,
        )
    end
    return predictions
end

function plot_rydeen_dimer(
    prot=read_pdb(joinpath(@__DIR__ ,"data/pdb/2RMM.cif"), "not element H");
    m1=AutonBolen,
    m2=Accessibility,
    exclude_cavities=nothing,
)
    scalefontsizes(); scalefontsizes(1.2)
    predictions = rydeen_dimer_predictions(prot; m1, m2, exclude_cavities)
    plt = plot(MolSimStyle)

    # @show extrema(val[2] - val[1] for (_, val) in predictions)

    # m_ab
    exp = [ val[1] for (key, val) in rydeen ]
    preds = [ val[1] for (key, val) in predictions ]
    scatter!(plt, exp, preds, 
        label=modelname(m1), 
        markeralpha=1,
        markershape=:circle,
        markercolor=1,
    )
    #f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    #plot!(plt, f.x, f.y, 
    #    #label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
    #    label="",
    #    linecolor=1,
    #)
    
    s = Dict(
        "TMAO" =>      (0.01, 0.05),
        "sarcosine" => (0.11, -0.04 ),
        "betaine" =>   (0.11, -0.02),
        "proline" =>   (0.08, -0.06),
        "sorbitol" =>  (-0.06, -0.05),
        "sucrose" =>   (0.0, 0.05 ),
        "urea" =>      (0.0, -0.03),
        "glycerol" =>  (0.0, -0.03),
        "trehalose" => (0.0, 0.03),
    )
    for (i, c) in enumerate(keys(rydeen))
        annotate!(plt, (exp[i].val + s[c][1], preds[i].val + s[c][2], text(c, 8)))
    end

    # m_mh
    exp = [ val[1] for (key, val) in rydeen ]
    preds = [ val[3] for (key, val) in predictions ]
    scatter!(plt, exp, preds, label=modelname(MoeserHorinek),
        markeralpha=1,
        markersize=8,
        markershape=:star,
        markercolor=2,
    )

    # Accessibility
    exp = [ val[1] for (key, val) in rydeen ] 
    preds = [ val[2] for (key, val) in predictions ]
    scatter!(plt, exp, preds, label=modelname(m2),
        markeralpha=1,
        markershape=:square,
        markercolor=4,
    )
    #f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    #plot!(plt, f.x, f.y, 
    #    label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
    #    label="",
    #    linecolor=4,
    #)

    # Record
    exp = [ rydeen[c][1] for c in record_cosolvents ]
    preds =  [ predictions[c][4] for c in record_cosolvents ]
    scatter!(plt, exp, preds, label=modelname(MTRecord),
        markeralpha=1,
        markersize=8,
        markershape=:star,
        markercolor=5,
    )

    plot!(plt, [-0.4, 0.5], [-0.4, 0.5], 
        linecolor=:black,
        linealpha=0.5,
        label="",
        aspect_ratio=1,
        linestyle=:dash,
#        xlims=(-0.3, 0.55),
#        ylims=(-0.3, 0.4),
        xlabel=L"\Delta \Delta G^\textrm{exp}\textrm{~/~kcal~mol^{-1}}",
        ylabel=L"\Delta \Delta G^\textrm{pred}\textrm{~/~kcal~mol^{-1}}",
        size=(600,600),
        legend=:bottomright,
    )
    return plt
end

function plot_rydeen_dimer_bar(
    prot=read_pdb(joinpath(@__DIR__ ,"data/pdb/2RMM.cif"), "not element H");
    m1=AutonBolen,
    m2=Accessibility,
    exclude_cavities=nothing,
)
    scalefontsizes(); scalefontsizes(1.2)
    predictions = rydeen_dimer_predictions(prot; m1, m2, exclude_cavities)

    cosolvents = collect(keys(rydeen))
    ncos = length(cosolvents)

    exp_vals = [ rydeen[c][1] for c in cosolvents ]
    m1_vals = [ predictions[c][1] for c in cosolvents ]
    m2_vals = [ predictions[c][2] for c in cosolvents ]
    mh_vals = [ predictions[c][3] for c in cosolvents ]
    rec_vals = [ predictions[c][4] for c in cosolvents ]

    labels = ["Experimental", modelname(m2), modelname(m1), modelname(MoeserHorinek), modelname(MTRecord)]
    all_vals = vcat(exp_vals, m2_vals, m1_vals, mh_vals, rec_vals)
    heights = getfield.(all_vals, :val)
    errs = getfield.(all_vals, :err)

    plt = plot(MolSimStyle)
    groupedbar!(plt,
        categorical(repeat(cosolvents; outer=length(labels)), levels=cosolvents),
        heights;
        yerror=errs,
        group=categorical(repeat(labels; inner=ncos), levels=labels),
        xlabel="",
        ylabel=L"\Delta \Delta G\textrm{~/~kcal~mol^{-1}}",
        xrotation=30,
        size=(700,500),
        legend=:topright,
    )
    return plt
end

function plot_rydeen_both(plt1, plt2)
    scalefontsizes(); scalefontsizes(1.4)
    l = @layout [ a{0.45w} b ]
    plt = plot(plt1, plt2; size=(1100,500), layout=l, leftmargin=1.0Plots.Measures.cm)
    annotate!(plt, -0.65, 0.61, text("A)", "Computer Modern", 14); subplot=1)
    annotate!(plt, 0.67, 0.61, text("B)", "Computer Modern", 14); subplot=1)
    plot!(plt, legend=nothing, subplot=1)
    plot!(plt, legend=:bottomright, subplot=2)
    return plt
end

