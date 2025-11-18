module LAPM

using Plots
using StatsPlots
using PDBTools
using OrderedCollections
# At the end, qualify everything and remove the above using
using PDBTools: 
    PDBTools,
    MValueModel,
    mvalue_delta_sasa,
    parse_mvalue_server_sasa,
    read_pdb

export MoeserHorinek, AutonBolen
export plot_mvalue
export plot_MH_vs_AB

data_dir = joinpath(@__DIR__, "data")

creamer_sasa(_, atoms) = creamer_sasa_restype(atoms)
server_sasa(str::String, _) = sasa_server[str]
#
# predict m-value using a model, for a specific structure
#
function predict_mvalue(
    str::AbstractString;
    model::Type{<:PDBTools.MValueModel}=MoeserHorinek,
    cosolvent::String="urea",
    type::Int=2,
    sasas_from::Function=creamer_sasa,
)
    atoms = read_pdb(pdb_files[str])
    m = mvalue_delta_sasa(;
        model=model,
        cosolvent=cosolvent,
        atoms=atoms,
        sasas=sasas_from(str, atoms),
        type=type,
    )
    return (tot = m.tot, bb = m.bb, sc = m.sc)
end

mvalues_ref(::Type{MoeserHorinek}) = mvalues_moeser_horinek
mvalues_ref(::Type{AutonBolen}) = mvalues_auton_bolen
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
    ls=(lw=2, ls=:dash, label="", lc=:lightgrey)
    for sp in 1:3
        plot!(plt, [-100,100], [-100,100]; ls..., subplot=sp)
    end
    ls=(lw=2, lc=:black, label="", legend=:topleft)
    lims = (minimum(vcat(tot, tot_ref)), maximum(vcat(tot, tot_ref)))
    lims = (lims[1] - 0.1*abs(lims[1]), lims[2] + 0.1 * abs(lims[2]))
    scatter!(plt, tot_ref, tot; 
        ls..., 
        legend_title="Total", 
        xlims=lims,
        ylims=lims,
        subplot=1,
        series_annotations=text.("\n\n" .* example_structs, 8)
    )
    lims = (minimum(vcat(bb, bb_ref)), maximum(vcat(bb, bb_ref)))
    lims = (lims[1] - 0.1*abs(lims[1]), lims[2] + 0.1 * abs(lims[2]))
    scatter!(plt, bb_ref, bb; 
        ls..., 
        legend_title="Backbone", 
        xlims=lims,
        ylims=lims,
        subplot=2,
        series_annotations=text.("\n\n" .* example_structs, 8)
    )
    lims = (minimum(vcat(sc, sc_ref)), maximum(vcat(sc, sc_ref)))
    lims = (lims[1] - 0.1*abs(lims[1]), lims[2] + 0.1 * abs(lims[2]))
    scatter!(plt, sc_ref, sc; 
        ls..., 
        legend_title="Sidechain", 
        xlims=lims,
        ylims=lims,
        subplot=3,
        series_annotations=text.("\n\n" .* example_structs, 8)
    )
    xlab(::Type{MoeserHorinek}) = "Moeser&Horinek"
    xlab(::Type{AutonBolen}) = "Auton&Bolen"
    plot!(plt, 
        size=(1200,800),
        xlabel=xlab(model),
        ylabel=nothing,
        aspect_ratio=1,
        leftmargin=0.5Plots.Measures.cm,
        bottommargin=0.5Plots.Measures.cm,
    )
    plot!(plt,
        ylabel="LAPM prediction",
        subplot=1
    )
    
    ys =(maximum(vcat(tot, sc, bb)) - minimum(vcat(tot, sc, bb)))
    groupedbar!(
        string.(example_structs),
        hcat(tot, bb, sc); 
        label=["Total" "BB" "SC"], 
        #title="Contributions",
        xlabel="Structure",
        ylabel="m-value / (kcal/mol)",
        subplot=4,
        ylims=(minimum(vcat(tot, sc, bb, 0)) - 0.1*abs(ys), maximum(vcat(tot, sc, bb, 0)) + 0.1*abs(ys)),
        xrotation=60,
    )
    return plt
end

#=

Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpBBRfgT. 
            Native State (cal/mol/M)                             Denatured State (cal/mol/M) 
Osmolyte     Backbone   Sidechains    Total      |       Backbone            Sidechains              Total 
1M TMAO            1244       -1042         202      |   (  6503)   9027 [ 11551]    ( -3897)  -4183 [ -4470]    (  2606)   4844 [  7081] 
1M Sarcosine        719        -383         335      |   (  3758)   5216 [  6674]    (  -998)  -1000 [ -1001]    (  2759)   4216 [  5673] 
1M Betaine          926       -1825        -899      |   (  4841)   6720 [  8599]    ( -6816)  -7264 [ -7713]    ( -1975)   -544 [   886] 
1M Proline          663       -1168        -504      |   (  3468)   4815 [  6161]    ( -4337)  -4651 [ -4966]    (  -869)    164 [  1195] 
1M Glycerol         193        -563        -369      |   (  1012)   1404 [  1797]    ( -2356)  -2497 [ -2637]    ( -1344)  -1092 [  -840] 
1M Sorbitol         484        -552         -68      |   (  2529)   3511 [  4492]    ( -1321)  -1375 [ -1430]    (  1208)   2135 [  3062] 
1M Sucrose          857        -963        -106      |   (  4480)   6219 [  7957]    ( -2764)  -2877 [ -2992]    (  1716)   3341 [  4966] 
1M Trehalose        857        -769          88      |   (  4480)   6219 [  7957]    ( -1496)  -1445 [ -1394]    (  2985)   4774 [  6563] 
1M Urea            -539         240        -299      |   ( -2818)  -3912 [ -5005]    (   497)    582 [   666]    ( -2321)  -3330 [ -4340] 
"""


This functions parses the above part of the server output and returns a dictionary
with the estimated m-values for the second denatured state relative to the native state.

=#
function parse_mvalue_server(str)
    str = replace(str, r"[\(\)\|\[\]]" => "")
    m = OrderedDict{String,@NamedTuple{tot::Float64, bb::Float64, sc::Float64}}()
    for line in split(str, '\n')
        ldata = split(line)
        if length(ldata) > 0 && ldata[1] == "1M"
            m[lowercase(ldata[2])] = (
                tot = 1e-3 * (parse(Float64,ldata[13]) - parse(Float64,ldata[5])),
                bb = 1e-3 * (parse(Float64,ldata[7]) - parse(Float64,ldata[3])),
                sc = 1e-3 * (parse(Float64,ldata[10]) - parse(Float64,ldata[4]))
            )
        end
    end
    return m
end

#
# SASAs
#
# Each file contains the data for SASAs by residue type, provided by the server:
#
# http://best.bio.jhu.edu/mvalue/
#
# The data is added to the following dictionary:
const sasa_server = OrderedDict{String,Dict}()

#
# Results obtained from the references 
#
const mvalues_auton_bolen = OrderedDict{String,Dict}()
const mvalues_moeser_horinek = OrderedDict{String,Dict}()


# Input data for examples
include("./data/load_data.jl")
include("./data/sasa_auton_bolen_server/creamer.jl")

function plot_MH_vs_AB(cosolvent::String="urea")
    cosolvent = lowercase(cosolvent)
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot_mh, bb_mh, sc_mh = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    tot_ab, bb_ab, sc_ab = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        p_mh = predict_mvalue(str; model=MoeserHorinek, cosolvent)
        tot_mh[i] = p_mh.tot
        bb_mh[i] = p_mh.bb
        sc_mh[i] = p_mh.sc
        p_ab = predict_mvalue(str; model=AutonBolen, cosolvent)
        tot_ab[i] = p_ab.tot
        bb_ab[i] = p_ab.bb
        sc_ab[i] = p_ab.sc
    end

    l = @layout [a b c; d; e]
    plt = plot(layout=l, framestyle=:box, fontfamily="Computer Modern")
    ls=(lw=2, ls=:dash, label="", lc=:lightgrey)
    for sp in 1:3
        plot!(plt, [-100,100], [-100,100]; ls..., subplot=sp)
    end
    ls=(lw=2, lc=:black, label="", legend=:topleft)
    lims = (minimum(vcat(tot_mh, tot_ab)), maximum(vcat(tot_mh, tot_ab)))
    lims = (lims[1] - 0.1*abs(lims[1]), lims[2] + 0.1 * abs(lims[2]))
    scatter!(plt, tot_ab, tot_mh; 
        ls..., 
        legend_title="Total", 
        xlims=lims,
        ylims=lims,
        subplot=1,
        series_annotations=text.("\n\n" .* example_structs, 8)
    )
    lims = (minimum(vcat(bb_mh, bb_ab)), maximum(vcat(bb_mh, bb_ab)))
    lims = (lims[1] - 0.1*abs(lims[1]), lims[2] + 0.1 * abs(lims[2]))
    scatter!(plt, bb_ab, bb_mh; 
        ls..., 
        legend_title="Backbone", 
        xlims=lims,
        ylims=lims,
        subplot=2,
        series_annotations=text.("\n\n" .* example_structs, 8)
    )
    lims = (minimum(vcat(sc_mh, sc_ab)), maximum(vcat(sc_ab, sc_mh)))
    lims = (lims[1] - 0.1*abs(lims[1]), lims[2] + 0.1 * abs(lims[2]))
    scatter!(plt, sc_ab, sc_mh; 
        ls..., 
        legend_title="Sidechain", 
        xlims=lims,
        ylims=lims,
        subplot=3,
        series_annotations=text.("\n\n" .* example_structs, 8)
    )
    plot!(plt, 
        size=(1200,1200),
        xlabel="Auton&Bolen",
        ylabel=nothing,
        aspect_ratio=1,
        leftmargin=0.5Plots.Measures.cm,
        bottommargin=0.5Plots.Measures.cm,
    )
    plot!(plt,
        ylabel="Moeser&Horniek",
        subplot=1
    )
    
    ys =(maximum(vcat(tot_ab, sc_ab, bb_ab)) - minimum(vcat(tot_ab, sc_ab, bb_ab)))
    groupedbar!(
        string.(example_structs),
        hcat(tot_ab, bb_ab, sc_ab); 
        label=["Total" "BB" "SC"], 
        #title="Contributions",
        xlabel="Structure",
        ylabel="m-value (Auton&Bolen) / (kcal/mol)",
        subplot=4,
        ylims=(
            minimum(vcat(tot_ab, sc_ab, bb_ab, 0)) - 0.1*abs(ys), 
            maximum(vcat(tot_ab, sc_ab, bb_ab, 0)) + 0.1*abs(ys)
        ),
        fontfamily="Computer Modern",
        xrotation=60,
    )

    ys =(maximum(vcat(tot_mh, sc_mh, bb_mh)) - minimum(vcat(tot_mh, sc_mh, bb_mh)))
    groupedbar!(
        string.(example_structs),
        hcat(tot_mh, bb_mh, sc_mh); 
        label=["Total" "BB" "SC"], 
        #title="Contributions",
        xlabel="Structure",
        ylabel="m-value (Moeser&Horinek) / (kcal/mol)",
        subplot=5,
        ylims=(
            minimum(vcat(tot_mh, sc_mh, bb_mh, 0)) - 0.1*abs(ys), 
            maximum(vcat(tot_mh, sc_mh, bb_mh, 0)) + 0.1*abs(ys)
        ),
        fontfamily="Computer Modern",
    )

    return plt
end

end
