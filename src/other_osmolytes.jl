export other_osmolytes

#
# Data from the supplementary material table at: 10.1016/j.bpc.2011.05.012
#
# fields of tuple are:
#
# 1 - selection required from the PDB to obtain the proper protein atoms
# 2 - number of residues
# 3 - experimental m-value (cal/mol/M)
# 4 - AutonBolen prediciton, as reported.
#
# The structures in src/data/pdb have the atoms filtered already considering the 
# selections defined in (1)
#
ab_table = OrderedDict(
    "tmao" => OrderedDict(
        "1BTA" =>  ("protein", 89, 2420,  2312),
        "2BU4" => ("protein", 104, 1780,  1785),
        "2BU4_2" => ("protein", 104, 1480, 1785),
        "1RNB" => ("protein", 109, 1660,  1578),
        "1A6F" => ("protein", 113, 2960, 2986), 
        "2SNS" => ("protein", 141, 2550, 2856),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 2752, 3489),
        "1OT8_1-7" => ("protein and chain B", 204, 6520, 5642),
        "1OT8_4-7" => ("protein and chain B and resnum >= 117", 123, 3741, 3280),
        "2AZS" => ("protein and model 1", 59, rydeen["TMAO"][2].val * 1000, NaN)
    ), 
    "sarcosine" => OrderedDict(
        "1BTA" => ("protein", 89, 2330, 2008),
        "2BU4" => ("protein", 104, 1780, 1495),
        "1OT8_4-7" => ("protein", 123, 2793, 2798),
        "1IL8" => ("protein and chain A", 71, 451, 134), 
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 1581, 3518),
        "2AZS" => ("protein and model 1", 59, rydeen["sarcosine"][2].val * 1000, NaN)
    ),
    "betaine" => OrderedDict(
        "2BU4" => ("protein", 104, 440, -232),
        "1OT8_4-7" => ("protein", 123, 1570, 1515), 
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 1041, 951),
        "2AZS" => ("protein and model 1", 59, rydeen["betaine"][2].val * 1000, NaN)
    ),
    "proline" => OrderedDict(
        "2BU4" => ("protein", 104, 620, -34),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 467, 1029),
        "2AZS" => ("protein and model 1", 59, rydeen["proline"][2].val * 1000, NaN)
    ),
    "sorbitol" => OrderedDict(
        "2BU4" => ("protein", 104, 1380, 815),
        "1OT8_4-7" => ("protein", 123, 2049, 1821), 
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 2139, 2331),
        "2AZS" => ("protein and model 1", 59, rydeen["sorbitol"][2].val * 1000, NaN)
    ),
    "sucrose" => OrderedDict(
        "2BU4" => ("protein", 104, 1550, 1058),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 2992, 3372),
        "2AZS" => ("protein and model 1", 59, rydeen["sucrose"][2].val * 1000, NaN)
    ),
    "glycerol" => OrderedDict(
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 771, -81),
        "2AZS" => ("protein and model 1", 59, rydeen["glycerol"][2].val * 1000, NaN)
    ),
)

const os_pdb_files = Dict(
    "2AZS" => joinpath(@__DIR__, "data", "pdb", "2AZS.cif"),
    "2RMM" => joinpath(@__DIR__, "data", "pdb", "2RMM.cif"),
    "1A6F" => joinpath(@__DIR__, "data", "pdb", "1A6F_clean.pdb"),
    "1AKE" => joinpath(@__DIR__, "data", "pdb", "1AKE_clean.pdb"),
    "1IL8" => joinpath(@__DIR__, "data", "pdb", "1IL8_clean.pdb"),
    "1OT8_4-7" => joinpath(@__DIR__, "data", "pdb", "1OT8_4-7_clean.pdb"),
    "1OT8_1-7" => joinpath(@__DIR__, "data", "pdb", "1OT8_1-7_clean.pdb"),
    "2BU4" => joinpath(@__DIR__, "data", "pdb", "2BU4_clean.pdb"),
    "2BU4_2" => joinpath(@__DIR__, "data", "pdb", "2BU4_2_clean.pdb"),
    "1BTA" => joinpath(@__DIR__, "data", "pdb", "1BTA_clean.pdb"),
    "1RNB" => joinpath(@__DIR__, "data", "pdb", "1RNB_clean.pdb"),
    "1A6F" => joinpath(@__DIR__, "data", "pdb", "1A6F_clean.pdb"),
    "2SNS" => joinpath(@__DIR__, "data", "pdb", "2SNS_clean.pdb"),
)

function other_osmolytes(; 
    m1=AutonBolen,
    m2=Accessibility,
    type=2,
    alpha=1.0,
)
    scalefontsizes()
    name = String[]
    osmo = String[]
    mhapp = Float64[]
    mab = Float64[]
    mab_orig = Float64[]
    exp = Float64[]
    l = Int[]
    for osm in keys(ab_table)
        for pdb in keys(ab_table[osm])
            nres = ab_table[osm][pdb][2]
            _exp = ab_table[osm][pdb][3]
            _ab_orig = ab_table[osm][pdb][4]
            p = read_pdb(os_pdb_files[pdb], ab_table[osm][pdb][1])
            if length(eachresidue(p)) != nres
                error("Wrong number of residues for $pdb")
            end
            cm1 = m1 == MTRecord ? MTRecordDenaturedModel(p) : CreamerDenaturedModel(p, type)
            cm1 = m1 == MTRecord ? MTRecordDenaturedModel(p) : CreamerDenaturedModel(p, type)
            cm2 = m2 == MTRecord ? MTRecordDenaturedModel(p) : CreamerDenaturedModel(p, type)
            cm2 = m2 == MTRecord ? MTRecordDenaturedModel(p) : CreamerDenaturedModel(p, type)
            if m1 == MTRecord 
                _m_ab = osm in lowercase.(record_cosolvents) ? mvalue(cm1, osm; alpha).tot : NaN
            else
                _m_ab = mvalue(cm1, osm; model=m1).tot
            end
            if m2 == MTRecord 
                _m_mhapp = osm in lowercase.(record_cosolvents) ? mvalue(cm2, osm; alpha).tot : NaN
            else
                _m_mhapp = mvalue(cm2, osm; model=m2).tot
            end
            push!(name, pdb)
            push!(osmo, osm)
            push!(l, nres)
            push!(exp, _exp / 1000)
            push!(mab_orig, _ab_orig / 1000)
            push!(mab, _m_ab)
            push!(mhapp, _m_mhapp)
        end
    end
    #return name, exp, mab_orig, mab, mhapp
    alldata = vcat(exp, mab, mhapp)
    ymin, ymax = extrema(alldata)
    ypad = 0.05 * (ymax - ymin)
    plt = plot(MolSimStyle, layout=(2,1))
    plot!([-10,10],[-10,10]; ls=:dash, lc=:black, subplot=1, label="")
    scatter!(plt, exp, mab; label=modelname_nu(m1), subplot=1, mc=1)
    scatter!(plt, exp, mhapp; label=modelname_nu(m2), subplot=1, mc=2)
    plot!(plt,
        xlabel=L"\textrm{Experimental~}m\textrm{-value~/~kcal~mol^{-1}}",
        ylabel=L"\textrm{Predicted~}m\textrm{-value~/~kcal~mol^{-1}}",
#        legend=:bottomright,
        subplot=1,
    )
    i_valid = findall(!isnan, mab)
    f = fitlinear(exp[i_valid], mab[i_valid])
    plot!(plt, f.x, f.y; label="", color=1, ls=:dash, subplot=1)
    i_valid = findall(!isnan, mhapp)
    f = fitlinear(exp[i_valid], mhapp[i_valid])
    plot!(plt, f.x, f.y; label="", color=2, ls=:dash, subplot=1)
#    annotate!(plt, 5.3, 4, 
#        text(
#            latexstring("y=$(round(f.a; digits=2))x+$(round(f.b; digits=2)); R^2=$(round(f.R2; digits=2))"),
#            "Computer Modern",
#            10,
#        ),
#        subplot=1,
#    )
    plot!(;
        xlims=(-0.,7),
        ylims=(ymin - ypad, ymax + ypad),
        subplot=1,
    )
    labels = ["$(name[i])-$(osmo[i])" for i in eachindex(name)]
    groupedbar!(plt,
        categorical(repeat(labels; outer=3), levels=labels),
        vcat(mab, mhapp, exp),
        group=categorical(
            repeat([ modelname_nu(m1), modelname_nu(m2), "Experimental"]; inner=length(name)),
            levels=[ modelname_nu(m1), modelname_nu(m2), "Experimental"], 
        ),
        xlabel="",
        #xticks=:none,
        ylims=(ymin - ypad, ymax + ypad),
        xrotation=70,
        topmargin=0.0Plots.Measures.cm,
        ylabel=L"m\textrm{-value~/~kcal~mol^{-1}}",
        subplot=2,
    )
    #bar!(plt, 1000 * (mab .- mhapp) ./ l; 
    #    xticks = (eachindex(name), [ "$(name[i])-$(osmo[i])" for i in eachindex(name) ]),
    #    xrotation=90,
    #    ylabel=L"\Delta m \textrm{-value~per~residue~/~cal~mol^{-1}}",
    #    ylims=(-3.0, 3.0),
    #    label="",
    #    xlabel="",
    #    subplot=2,
    #    topmargin=0.0Plots.Measures.cm,
    #)
    plot!(plt,
        size=(800,800),
    )
    if m2 == MoeserHorinek
        annotate!(plt, -3, 18.3, text("A)", "Computer Modern", 14); subplot=2)
        annotate!(plt, -3, 7.5, text("B)", "Computer Modern", 14); subplot=2)
    elseif m2 == Accessibility
        annotate!(plt, -3, 16.8, text("A)", "Computer Modern", 14); subplot=2)
        annotate!(plt, -3, 6.7, text("B)", "Computer Modern", 14); subplot=2)
    end
    return plt
end
