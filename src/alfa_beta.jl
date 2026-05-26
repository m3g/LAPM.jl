using PDBTools
import CSV
import DataFrames as DF
using ProgressMeter
using Plots
using StatsPlots
using Base.Threads
using LaTeXStrings

export plot_cosolvent
export cath_data_file
const cath_data_file = joinpath(@__DIR__, "data/cath_S20.csv")

#
# How to run:
# Download a CATH dataset of structures from: https://download.cathdb.info/cath/releases/
#
# The results (data/cath_S20.csv) stored here correspond to the latest release of 
# /cath/releases/latest-release/non-redundant-data-sets/cath-dataset-nonredundant-S20.pdb.tgz
#
# Download on May 26th, 2026.
# 
# Extract the files and provide the files as the cath_pdb_dir argument of the following function.
#
function alpha_beta(cath_pdb_dir)
    cosolvents = ["betaine", "proline", "sarcosine", "sorbitol", "sucrose", "tmao", "urea", "glycerol", "trehalose"]
    files = readdir(cath_pdb_dir)
    cosolvent_cols = [(Symbol(c, "_tot"), Symbol(c, "_bb"), Symbol(c, "_sc")) for c in cosolvents]
    df = DF.DataFrame(
        :entry => String[],
        :length => Int[],
        :class => Int[],
        (col => Float32[] for (tot, bb, sc) in cosolvent_cols for col in (tot, bb, sc))...
    )
    list = CSV.read(
        "./cath-domain-list.txt", DF.DataFrame; 
        header=false, select=[1,2],
        comment="#", delim=' ', ignorerepeated=true
    )
    rename!(list, [:name, :class])
    lk = ReentrantLock()
    prg = Progress(length(files))
    @threads for file in files
        c = list.class[findfirst(==(file), list.name)]
        p = read_pdb(joinpath("./pdbs", file))
        for at in p
            n = resname(at)
            if length(n) == 4
                at.resname = resname(at)[2:end]
            end
        end
        try 
            cm = CreamerDenaturedModel(p)
            isnothing(cm) && continue
            row = Dict{Symbol,Any}(
                :entry => file,
                :length => length(eachresidue(p)),
                :class => c,
            )
            for c in cosolvents
                m = mvalue(cm, c; model=MoeserHorinekFit)
                row[Symbol(c, "_tot")] = m.tot
                row[Symbol(c, "_bb")] = m.bb
                row[Symbol(c, "_sc")] = m.sc
            end
            @lock lk push!(df, row)
        catch 
            println("Failed creating model for: $file") 
            nothing
        end
        next!(prg)
    end
    CSV.write("./data/cath_S20.csv", df)
    return df
end

#
# Run with: 
#
# df = CSV.read("./data/cath_S20.csv")
# plot_cosolvent(df, "urea")
#
function plot_cosolvent(df, cosolvent; 
    legend=[:outertopright, :outertopright, :outertopright],
    ylabel="Density",
)
    class_names  = Dict(1 => "Mainly α", 2 => "Mainly β")
    class_colors = Dict(1 => :crimson,   2 => :steelblue)

    subsets = [(Symbol(cosolvent, "_tot"), "Total"),
               (Symbol(cosolvent, "_bb"),  "Backbone"),
               (Symbol(cosolvent, "_sc"),  "Side Chain")]

    bbsc_cols = [Symbol(cosolvent, "_bb"), Symbol(cosolvent, "_sc")]
    bbsc_vals = [df[df.class .== cls, col] ./ df[df.class .== cls, :length]
                 for col in bbsc_cols for cls in [1, 2]]
    bbsc_xlims = (minimum(minimum.(bbsc_vals)), maximum(maximum.(bbsc_vals)))

    icol = 0
    subplots = map(subsets) do (col, label)
        icol += 1
        p = vline([0]; linestyle=:dash, label="", lc=:black)
        plot!(p;
            xlabel= label == "Side Chain" ? 
                    L"m\textrm{-value~per~residue~/~kcal~mol^{-1}~M^{-1}}" :
                    "",
            ylabel=ylabel,
            legend_title=label,
            legend=legend[icol],
            framestyle=:box,
            fontfamily="Computer Modern",
            margin=0Plots.Measures.cm,
            leftmargin=0.5Plots.Measures.cm,
            xlims=(col in bbsc_cols ? bbsc_xlims : :auto),
        )
        for cls in [1, 2]
            rows = df.class .== cls
            vals = df[rows, col] ./ df[rows, :length]
            density!(p, vals; label=class_names[cls], color=class_colors[cls], lw=2, fill=(0, 0.15, class_colors[cls]))
        end
        p
    end

    plot(subplots...; layout=(3, 1), size=(800, 800), fontfamily="Computer Modern")
end

function plot2cosolvents(df, c1, c2)
    p1 = plot_cosolvent(df, c1; 
        legend=[:topright, :topright, :topright],
    )
    p2 = plot_cosolvent(df, c2; 
        legend=[:topleft, :topleft, :topright],
        ylabel="",
    )
    p = plot([p1, p2]...; layout=@layout([a{0.5w} b]))
    annotate!(p, -0.0550, 545, text("A)", "Computer Modern", 12), subplot=6)
    annotate!(p, -0.0550, 345, text("B)", "Computer Modern", 12), subplot=6)
    annotate!(p, -0.0550, 150, text("C)", "Computer Modern", 12), subplot=6)
    annotate!(p, -0.0195, 545, text("D)", "Computer Modern", 12), subplot=6)
    annotate!(p, -0.0195, 345, text("E)", "Computer Modern", 12), subplot=6)
    annotate!(p, -0.0195, 150, text("F)", "Computer Modern", 12), subplot=6)
end