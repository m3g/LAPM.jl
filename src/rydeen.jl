
using Measurements 

const rydeen = OrderedDict(
    "TMAO" =>      ( 0.4 ±   0.1,  0.46 ± 0.02 ),
#    "trehalose" => ( 0.26 ± 0.06,  0.45 ± 0.05 ),
    "sarcosine" => ( 0.24 ± 0.03,  0.45 ± 0.02 ),
    "betaine" =>   ( 0.13 ± 0.05,  0.21 ± 0.06 ),
    "proline" =>   ( 0.02 ± 0.07,  0.31 ±0.02 ),
    "sorbitol" =>  (-0.07 ± 0.03,  0.42 ± 0.03 ),
    "sucrose" =>   (-0.08 ± 0.04,  0.38 ± 0.02 ),
#    "glycerol" =>  (-0.10 ± 0.07,  0.16 ± 0.03 ),
    "urea" =>      (-0.11 ± 0.02,  -0.31 ± 0.04 ),
)

function plot_rydeen(
    prot=read_pdb(joinpath(@__DIR__ ,"/data/pdb/2AZS.cif"))
)
    predictions = OrderedDict()
    for cosolvent in keys(rydeen) 
        m_ab = zeros(length(eachmodel(prot)))
        m_mhfit = copy(m_ab)
        if cosolvent == "urea"
            m_mh = copy(m_ab)
        end
        for (i, model) in enumerate(eachmodel(prot))
            c = CreamerDenaturedModel(model)
            m_ab[i] = mvalue(c, cosolvent; model=AutonBolen).tot
            m_mhfit[i] = mvalue(c, cosolvent; model=MoeserHorinekFit).tot
            if cosolvent == "urea"
                m_mh[i] = mvalue(c, cosolvent; model=MoeserHorinekFit).tot
            end
        end
        if cosolvent != "urea"
            predictions[cosolvent] = (
                0.4 * (mean(m_ab) ± std(m_ab)),
                0.4 * (mean(m_mhfit) ± std(m_mhfit)),
            ) 
        else
            predictions[cosolvent] = (
                0.4 * (mean(m_ab) ± std(m_ab)),
                0.4 * (mean(m_mhfit) ± std(m_mhfit)),
                0.4 * (mean(m_mh) ± std(m_mh)),
            ) 
        end
    end
    plt = plot(MolSimStyle)

    exp = [ val[2] for (key, val) in rydeen ]
    preds = [ val[1] for (key, val) in predictions ]
    scatter!(plt, exp, preds, 
        label="AutonBolen", 
        markeralpha=1,
        markercolor=1,
    )
    f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    plot!(plt, f.x, f.y, 
        label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
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
    )
    for (i, c) in enumerate(keys(rydeen))
        annotate!(plt, (exp[i].val + s[c][1], preds[i].val + s[c][2], text(c, 8)))
    end

    exp = [ rydeen["urea"][2] ]
    preds =  [ predictions["urea"][3] ] 
    scatter!(plt, exp, preds, label="MoeserHorinek",
        markeralpha=1,
        markersize=8,
        markercolor=2,
    )

    exp = [ val[2] for (key, val) in rydeen ] 
    preds = [ val[2] for (key, val) in predictions ]
    scatter!(plt, exp, preds, label="MoeserHorinekFit",
        markeralpha=1,
        markercolor=3,
    )
    f = fitlinear(getfield.(exp, :val), getfield.(preds, :val))
    plot!(plt, f.x, f.y, 
        label=latexstring("a=$(round(f.a,digits=2)), R^2=$(round(f.R2; digits=2))"),
        linecolor=3,
    )

    plot!(plt, [-0.4, 0.5], [-0.4, 0.5], 
        linecolor=:black,
        linealpha=0.5,
        label="",
        aspect_ratio=1,
        linestyle=:dash,
        xlims=(-0.4, 0.5),
        ylims=(-0.4, 0.5),
        xlabel=L"\textrm{Experimental~/~kcal~mol^{-1}}",
        ylabel=L"\textrm{Predicted~/~kcal~mol^{-1}}",
    )


    return plt
end


