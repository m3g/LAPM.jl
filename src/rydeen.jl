
using Measurements 
export plot_rydeen_folding
export plot_rydeen_dimmer
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

function plot_rydeen_folding(
    prot=read_pdb(joinpath(@__DIR__ ,"/data/pdb/2AZS.cif"));
    type=2,
)
    predictions = OrderedDict()
    for cosolvent in keys(rydeen) 
        m_ab = zeros(length(eachmodel(prot)))
        m_mhapp = copy(m_ab)
        if cosolvent == "urea"
            m_mh = copy(m_ab)
        end
        for (i, model) in enumerate(eachmodel(prot))
            c = CreamerDenaturedModel(model, type)
            m_ab[i] = mvalue(c, cosolvent; model=AutonBolen).tot
            m_mhapp[i] = mvalue(c, cosolvent; model=MoeserHorinekApp).tot
            if cosolvent == "urea"
                m_mh[i] = mvalue(c, cosolvent; model=MoeserHorinek).tot
            end
        end
        if cosolvent != "urea"
            predictions[cosolvent] = (
                0.4 * (mean(m_ab) ± std(m_ab)),
                0.4 * (mean(m_mhapp) ± std(m_mhapp)),
            ) 
        else
            predictions[cosolvent] = (
                0.4 * (mean(m_ab) ± std(m_ab)),
                0.4 * (mean(m_mhapp) ± std(m_mhapp)),
                0.4 * (mean(m_mh) ± std(m_mh)),
            ) 
        end
    end
    plt = plot(MolSimStyle)
#    @show extrema(val[2] - val[1] for (_, val) in predictions)

    # m_ab
    exp = [ val[2] for (key, val) in rydeen ]
    preds = [ val[1] for (key, val) in predictions ]
    scatter!(plt, exp, preds, 
        label="AutonBolen", 
        markeralpha=1,
        markercolor=1,
        markershape=:circle,
    )
    f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    plot!(plt, f.x, f.y, 
#        label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
        label="",
        linecolor=1,
    )
    
    s = Dict(
        "TMAO" =>      (-0.03, 0.05),
        "sarcosine" => (-0.15, 0.03 ),
        "betaine" =>   (0.0, -0.10),
        "proline" =>   (0.09, 0.0),
        "sorbitol" =>  (0.00, -0.08),
        "sucrose" =>   (-0.10, -0.02 ),
        "urea" =>      (0.0, 0.10),
        "glycerol" =>  (-0.05, 0.15),
        "trehalose" => (0.0, 0.05),
    )
    for (i, c) in enumerate(keys(rydeen))
        annotate!(plt, (exp[i].val + s[c][1], preds[i].val + s[c][2], text(c, 8)))
    end

    # mh
    exp = [ rydeen["urea"][2] ]
    preds =  [ predictions["urea"][3] ] 
    scatter!(plt, exp, preds, label="MoeserHorinek",
        markeralpha=1,
        markersize=8,
        markercolor=2,
        markershape=:star,
    )

    # mh_app
    exp = [ val[2] for (key, val) in rydeen ] 
    preds = [ val[2] for (key, val) in predictions ]
    scatter!(plt, exp, preds, label="MoeserHorinekApp",
        markeralpha=1,
        markercolor=4,
        markershape=:square,
    )
    f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    plot!(plt, f.x, f.y, 
        label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
#        label="",
        linecolor=4,
    )

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

function plot_rydeen_dimmer(
    prot=read_pdb(joinpath(@__DIR__ ,"/data/pdb/2RMM.cif"))
)
    predictions = OrderedDict()
    for cosolvent in keys(rydeen) 
        m_ab = zeros(length(eachmodel(prot)))
        m_mhapp = copy(m_ab)
        if cosolvent == "urea"
            m_mh = copy(m_ab)
        end
        for (i, model) in enumerate(eachmodel(prot))
            cA = select(model, "chain A")
            cB = select(model, "chain B")
            # AutonBolen
            tfeA = transfer_free_energy(cA, cosolvent; model=AutonBolen)
            tfeB = transfer_free_energy(cB, cosolvent; model=AutonBolen)
            tfe_d = transfer_free_energy(model, cosolvent; model=AutonBolen)
            m_ab[i] = tfeA.tot + tfeB.tot - tfe_d.tot 
            # MoeserHorinekApp
            tfeA = transfer_free_energy(cA, cosolvent; model=MoeserHorinekApp)
            tfeB = transfer_free_energy(cB, cosolvent; model=MoeserHorinekApp)
            tfe_d = transfer_free_energy(model, cosolvent; model=MoeserHorinekApp)
            m_mhapp[i] = tfeA.tot + tfeB.tot - tfe_d.tot 
            # MoeserHorinek
            if cosolvent == "urea"
                tfeA = transfer_free_energy(cA, cosolvent; model=MoeserHorinek)
                tfeB = transfer_free_energy(cB, cosolvent; model=MoeserHorinek)
                tfe_d = transfer_free_energy(model, cosolvent; model=MoeserHorinek)
                m_mh[i] = tfeA.tot + tfeB.tot - tfe_d.tot 
            end
        end
        if cosolvent != "urea"
            predictions[cosolvent] = (
                0.4 * (mean(m_ab) ± std(m_ab)),
                0.4 * (mean(m_mhapp) ± std(m_mhapp)),
            ) 
        else
            predictions[cosolvent] = (
                0.4 * (mean(m_ab) ± std(m_ab)),
                0.4 * (mean(m_mhapp) ± std(m_mhapp)),
                0.4 * (mean(m_mh) ± std(m_mh)),
            ) 
        end
    end
    plt = plot(MolSimStyle)
    # @show extrema(val[2] - val[1] for (_, val) in predictions)

    # m_ab
    exp = [ val[1] for (key, val) in rydeen ]
    preds = [ val[1] for (key, val) in predictions ]
    scatter!(plt, exp, preds, 
        label="AutonBolen", 
        markeralpha=1,
        markershape=:circle,
        markercolor=1,
    )
    f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    plot!(plt, f.x, f.y, 
        #label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
        label="",
        linecolor=1,
    )
    
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
    exp = [ rydeen["urea"][1] ]
    preds =  [ predictions["urea"][3] ] 
    scatter!(plt, exp, preds, label="MoeserHorinek",
        markeralpha=1,
        markersize=8,
        markershape=:star,
        markercolor=2,
    )

    # mh_app
    exp = [ val[1] for (key, val) in rydeen ] 
    preds = [ val[2] for (key, val) in predictions ]
    scatter!(plt, exp, preds, label="MoeserHorinekApp",
        markeralpha=1,
        markershape=:square,
        markercolor=4,
    )
    f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    plot!(plt, f.x, f.y, 
#        label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
        label="",
        linecolor=4,
    )

    plot!(plt, [-0.4, 0.5], [-0.4, 0.5], 
        linecolor=:black,
        linealpha=0.5,
        label="",
        aspect_ratio=1,
        linestyle=:dash,
        xlims=(-0.3, 0.55),
        ylims=(-0.3, 0.4),
        xlabel=L"\Delta \Delta G^\textrm{exp}\textrm{~/~kcal~mol^{-1}}",
        ylabel=L"\Delta \Delta G^\textrm{pred}\textrm{~/~kcal~mol^{-1}}",
        size=(500,500),
        legend=:bottomright,
    )
    return plt
end

function plot_rydeen_both(plt1, plt2)
    scalefontsizes(); scalefontsizes(1.4)
    l = @layout [ a{0.445w} b{0.555w} ]
    plt = plot(plt1, plt2; size=(1000,500), layout=l)
    annotate!(plt, -0.6, 0.63, text("A)", "Computer Modern", 14); subplot=1)
    annotate!(plt, 0.7, 0.63, text("B)", "Computer Modern", 14); subplot=1)
    return plt
end

