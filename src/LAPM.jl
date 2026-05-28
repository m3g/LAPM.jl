module LAPM

using Plots
using StatsPlots
using PDBTools
using OrderedCollections
using LaTeXStrings
using Measurements
using StatsPlots
using CategoricalArrays
using EasyFit

using PDBTools: parse_mvalue_server_sasa

export MoeserHorinek, AutonBolen, MoeserHorinekApp
export plot_mvalue
export plot_MH_vs_AB
export plot_experimental
export pdb_files

data_dir = joinpath(@__DIR__, "data")

modelname(model) = latexstring(
    "\\textrm{"*
    replace(string(model), "PDBTools." => "")
    *"~/~kcal~mol^{-1}}"
)
mvaluelabel() = latexstring("m-\\textrm{value~/~kcal~mol^{-1}}")

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
    return (tot=m.tot, bb=m.bb, sc=m.sc)
end

#
# Plot functions
#

function _lims(x, y)
    lims = (minimum(vcat(x, y)), maximum(vcat(x, y)))
    dx = lims[2] - lims[1]
    lims = (lims[1] - 0.15 * dx, lims[2] + 0.15 * dx)
    return lims
end

function _scatter!(plt, x, y, example_structs; legend_title, subplot)
    ls = (lw=2, lc=:black, label="")
    scatter!(plt, x, y;
        ls...,
        legend_title=legend_title,
        xlims=_lims(x, y),
        ylims=_lims(x, y),
        subplot=subplot,
        aspect_ratio=1,
    )
    _series_annotations!(plt, subplot, x, y, example_structs)
    return plt
end

mvalues_ref(::Type{MoeserHorinek}) = mvalues_moeser_horinek
mvalues_ref(::Type{AutonBolen}) = mvalues_auton_bolen

include("./plot_mvalue.jl")

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
                tot=1e-3 * (parse(Float64, ldata[13]) - parse(Float64, ldata[5])),
                bb=1e-3 * (parse(Float64, ldata[7]) - parse(Float64, ldata[3])),
                sc=1e-3 * (parse(Float64, ldata[10]) - parse(Float64, ldata[4]))
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
const mvalues_experimental = OrderedDict{String,Dict}()

# Input data for examples
include("./data/load_data.jl")
include("./data/sasa_auton_bolen_server/creamer.jl")

function _series_annotations!(plt, subplot, x, y, labels)
    lims = _lims(x,y)
    x_inds = collect(1:length(x))
    x_inds = sort!(x_inds; by=i -> x[i])
    w = lims[2] - lims[1]
    for (ix, s) in enumerate(labels)
        i = x_inds[ix]
        sx, sy = i % 2 == 1 ? (-0.06 * w, 0.03 * w) : (0.06 * w, -0.03 * w)
        annotate!(plt, (x[ix] + sx, y[ix] + sy, text(s, 8)); subplot=subplot)
    end
end

include("./plot_MH_vs_AB.jl")
include("./plot_experimental.jl")
include("./per_atom_type/get_sasa_per_type.jl")
include("./per_atom_type/creamer_per_atom.jl")
include("rydeen.jl")
include("./other_osmolytes.jl")
include("./alfa_beta.jl")
include("./generate_figures.jl")

end
