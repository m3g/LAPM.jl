#=

Here we implement the optimization of the per-atom-type m-value contributions,
using the results of get_sasa_per_type.

=# 
import JSON
using PDBTools: mvalue_delta_sasa

#
# These are the Creamer SASAs per atom type, for sequence length=17
#
creamer_sasa_per_type = let
    cd = JSON.parsefile(
        "$(@__DIR__)/output/creamer_per_atom.json",
        OrderedDict{StringType, 
            OrderedDict{StringType, 
                OrderedDict{StringType,
                    OrderedDict{StringType,Float32}
                }
            }
        }
    )
    cd["17"]
end

#
# Final result: function that computes the m-values using contributions per atom type.
# This function returns a PDB file where the contribution of each atom the the m-value
# is stored in the beta field.
#
export mvalue_per_atom
function mvalue_per_atom(atoms; type=2, delta=nothing)
    s = sasa_particles(
        atoms;
        atom_type=PDBTools.creamer_atom_type,
        atom_radius_from_type=at -> PDBTools.creamer_atomic_radii[at]
    )
    for (iat, at) in enumerate(atoms)
        c = contribution_per_atom(iat, at, s; type, delta)
        at.beta = c
    end
    return atoms
end

# And this function reports the final mvalue, for all atoms
export mvalue_ua
mvalue_ua(atoms, delta=nothing) = sum(at.beta for at in mvalue_per_atom(atoms; delta))

#
# Get the type of atom
#
function get_creamer_per_type(at)
    atname = name(at)
    rname = if atname in ("OXT", "OT1", "OT2")
        "TER"
    else
        resname(at)
    end
    return creamer_sasa_per_type[rname][atname]
end

#
# These should be the optimized contributions per type, 
# probably to be moved to PDBTools when the method is 
# made available
#
function contribution_factor_per_type(type)
    data = Dict{StringType,Float64}(
        "Nsp2" =>  0.0001618456904936583,
        "Nsp3" =>  0.0005556277063871981,
        "Csp2" => -0.00030610196806583943,
        "Csp3" =>  1.3739633441417058e-5,
        "Osp2" => -0.0009427482491063103,
        "Osp3" =>  0.00015979028078426792,
        "Ssp3" =>  0.0013450842716237529,
        "H" => 0.0,
    )
    return data[type]
end

#
# Auxiliary function to optimize the factors as variables
#
function i_contribution_factor_per_type(type)
    data = Dict{StringType,Int}(
        "Nsp2" => 1,
        "Nsp3" => 2,
        "Csp2" => 3,
        "Csp3" => 4,
        "Osp2" => 5,
        "Osp3" => 6,
        "Ssp3" => 7,
        "H" => 8,
    )
    return data[type]
end

function contribution_per_atom(iat, at, s::PDBTools.SASA; type=2, delta=nothing)
    atom_type = PDBTools.creamer_atom_type(at)
    if isnothing(delta) # static values
        δ = contribution_factor_per_type(atom_type)
    else # for optimization of contributions
        iδ = i_contribution_factor_per_type(atom_type)
        if iδ <= 7
            δ = delta[iδ]
        else
            δ = 0.0
        end
    end
    native_sasa = s[iat]
    desnat_sasa_base = get_creamer_per_type(at)
    lower = desnat_sasa_base["lower"]
    upper = desnat_sasa_base["upper"]
    denatured_sasa = if type == 1
        lower
    elseif type == 2
        (lower + upper) / 2
    elseif type == 3
        upper
    end
    return δ * (denatured_sasa - native_sasa)
end

using Optim
struct MySimplexer <: Optim.Simplexer end
Optim.simplexer(S::MySimplexer, initial_x) = [
    (1e-4 * randn(length(initial_x))) .+ initial_x for _ = 1:length(initial_x)+1
]

function run_simplex()
    pdbs = [ read_pdb(file[2], "protein and not element H") for file in LAPM.pdb_files ]
    exp_urea = [ LAPM.mvalues_experimental[key]["urea"] for key in keys(LAPM.mvalues_experimental)]
    f(x) = sum((mvalue_ua(p, x) - exp_val)^2 for (p,exp_val) in zip(pdbs, exp_urea))
    best = [ # 1.1785
        0.0001618456904936583
        0.0005556277063871981
        -0.00030610196806583943
        1.3739633441417058e-5
        -0.0009427482491063103
        0.00015979028078426792
        0.0013450842716237529 
    ] .+ 1e-2 * randn(7)
    optimize(f, best, NelderMead(initial_simplex = MySimplexer()), Optim.Options(show_trace=false))
end

function plot_ua(;minimizer=nothing)
    cosolvent = "urea"
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot_pred = zeros(nexamples)
    tot_exp = zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        p = mvalue_ua(read_pdb(pdb_files[str], "protein and not element H"), minimizer)
        tot_pred[i] = p
        tot_exp[i] = mvalues_experimental[str][cosolvent]
    end
    plt = plot(framestyle=:box, fontfamily="Computer Modern")
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
    plot!(plt, [-100, 100], [-100, 100]; ls...)
    _scatter!(plt, tot_exp, tot_pred, example_structs; legend_title="", subplot=1)
    plot!(plt, xlabel="Experimental")
    plot!(plt, ylabel="LAPM prediction - UA")
    plot!(plt, size=(400,400))
    fit = fitlinear(tot_exp, tot_pred)
    plot!(legend_title="a=$(round(fit.a; digits=3))\nb=$(round(fit.b; digits=3))\nR2=$(round(fit.R2; digits=3))", legend=:topleft)
    plot!(xlims=(-3.5,0.2), ylims=(-3.5,0.2))
    return plt
#    return fit
end

function plot_mvalue_ua(
    cosolvent="urea";
    minimizer=nothing,
)
    cosolvent = lowercase(cosolvent)
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot, bb, sc = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    tot_mh, bb_mh, sc_mh = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    tot_ab, bb_ab, sc_ab = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        pdb = read_pdb(pdb_files[str], "protein and not element H")
        mvalue_per_atom(pdb; delta=minimizer) 
        tot[i] = sum(at.beta for at in pdb)
        bb[i] = sum(at.beta for at in pdb if isbackbone(at))
        sc[i] = sum(at.beta for at in pdb if (!isbackbone(at)))
        tot_ab[i] = mvalues_ref(AutonBolen)[str][cosolvent].tot
        bb_ab[i] = mvalues_ref(AutonBolen)[str][cosolvent].bb
        sc_ab[i] = mvalues_ref(AutonBolen)[str][cosolvent].sc
        tot_mh[i] = mvalues_ref(MoeserHorinek)[str][cosolvent].tot
        bb_mh[i] = mvalues_ref(MoeserHorinek)[str][cosolvent].bb
        sc_mh[i] = mvalues_ref(MoeserHorinek)[str][cosolvent].sc
    end

    l = @layout [a b c; d e f; g]
    plt = plot(layout=l, framestyle=:box, fontfamily="Computer Modern")
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
    for sp in 1:6
        plot!(plt, [-100, 100], [-100, 100]; ls..., subplot=sp)
    end
    _scatter!(plt, tot_ab, tot, example_structs; legend_title="Total", subplot=1)
    _scatter!(plt, bb_ab, bb, example_structs; legend_title="Backbone", subplot=2)
    _scatter!(plt, sc_ab, sc, example_structs; legend_title="Sidechain", subplot=3)
    _scatter!(plt, tot_mh, tot, example_structs; legend_title="Total", subplot=4)
    _scatter!(plt, bb_mh, bb, example_structs; legend_title="Backbone", subplot=5)
    _scatter!(plt, sc_mh, sc, example_structs; legend_title="Sidechain", subplot=6)

    for sp in 1:3
        plot!(plt, xlabel="Auton&Bolen", ylabel=nothing, subplot=sp)
        plot!(plt, xlabel="Moeser&Horinek", ylabel=nothing, subplot=sp+3)
    end
    plot!(plt, ylabel="LAPM UA prediction", subplot=1)
    plot!(plt, ylabel="LAPM UA prediction", subplot=4)

    ys = (maximum(vcat(tot, sc, bb)) - minimum(vcat(tot, sc, bb)))
    groupedbar!(
        string.(example_structs),
        hcat(tot, bb, sc);
        label=["Total" "BB" "SC"],
        xlabel="Structure",
        ylabel="m-value / (kcal/mol)",
        subplot=7,
        ylims=(minimum(vcat(tot, sc, bb, 0)) - 0.1 * abs(ys), maximum(vcat(tot, sc, bb, 0)) + 0.1 * abs(ys)),
        xrotation=60,
        #bottommargin=0.5Plots.Measures.cm,
    )

    plot!(plt,
        size=(1200, 1200),
        rightmargin=0.2Plots.Measures.cm,
        leftmargin=0.5Plots.Measures.cm,
    )

    return plt
end
