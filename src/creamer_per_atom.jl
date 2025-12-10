
import JSON
using PDBTools: mvalue_delta_sasa

#
# These are the Creamer SASAs per atom type, for sequence length=17
#
creamer_sasa_per_type =
    JSON.parsefile(
        "$(@__DIR__)/data/creamer_per_atom.json",
        OrderedDict{StringType,
            OrderedDict{StringType,
                OrderedDict{StringType,Float32}
            }
        }
    )

function get_creamer_per_type(at)
    atname = name(at)
    if atname in ("OXT", "OT1", "OT2")
        rname = "TER"
    else
        rname = resname(at)
    end
    return creamer_sasa_per_type[rname][atname]
end

best = [
  0.00015979700642654524
  0.0005561056819540963
 -0.0003058517067961322
  1.399083730796221e-5
 -0.0009427217840670309
  0.00016019453217010256
  0.0013427539992481017
  0.0
]

best1 = [ # 1.179
  0.00017587922951490016
  0.0005462404117427902
 -0.00031728282745437575
  1.572518127600035e-5
 -0.000954010816066578
  0.00025329956066883375
  0.0012581533721238805
]

best2 = [ # 1.1785
  0.0001618456904936583
  0.0005556277063871981
 -0.00030610196806583943
  1.3739633441417058e-5
 -0.0009427482491063103
  0.00015979028078426792
  0.0013450842716237529 
]

function contribution_factor_per_type(type)
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

function contribution_per_atom(iat, at, s::PDBTools.SASA; type=2, delta)
    atom_type = creamer_atom_type(at)
    iδ = contribution_factor_per_type(atom_type)
    if iδ <= 7
        δ = delta[iδ]
    else
        δ = 0.0
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

export mvalue_per_atom
function mvalue_per_atom(atoms; type=2, delta)
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

export mvalue_ua
mvalue_ua(atoms, delta) = sum(at.beta for at in mvalue_per_atom(atoms; delta))

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

function run14()
    best = 1.178513819593714
    xbest = [ # 1.1785
        0.0001618456904936583
        0.0005556277063871981
        -0.00030610196806583943
        1.3739633441417058e-5
        -0.0009427482491063103
        0.00015979028078426792
        0.0013450842716237529 
    ]
    lk = ReentrantLock()
    Threads.@threads for i in 1:1400
        if isfile("stop.stop")
            break
        end
        println("trial $i")
        s = run_simplex() 
        lock(lk) do
            if s.minimizer < best
                best = s.minimum
                xbest .= s.minimizer
                @show best
                JSON.json("best.dat", xbest)
            end
        end
        println("from trial $i ; s.minimum = $(s.minimum)")
    end
    return best, xbest
end


function plot_ua(pdbs, minimizer)
    cosolvent = "urea"
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot_pred = zeros(nexamples)
    tot_exp = zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        p = mvalue_ua(pdbs[i], minimizer)
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
    pdbs, minimizer,
    model::Type{<:PDBTools.MValueModel}=MoeserHorinek,
    cosolvent="urea";
)
    cosolvent = lowercase(cosolvent)
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot, bb, sc = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    tot_ref, bb_ref, sc_ref = zeros(nexamples), zeros(nexamples), zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        mvalue_per_atom(pdbs[i]; delta=minimizer) 
        tot[i] = sum(at.beta for at in pdbs[i])
        bb[i] = sum(at.beta for at in pdbs[i] if isbackbone(at))
        sc[i] = sum(at.beta for at in pdbs[i] if (!isbackbone(at)))
        tot_ref[i] = mvalues_ref(model)[str][cosolvent].tot
        bb_ref[i] = mvalues_ref(model)[str][cosolvent].bb
        sc_ref[i] = mvalues_ref(model)[str][cosolvent].sc
    end

    l = @layout [a b c; d]
    plt = plot(layout=l, framestyle=:box, fontfamily="Computer Modern")
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)
    for sp in 1:3
        plot!(plt, [-100, 100], [-100, 100]; ls..., subplot=sp)
    end
    _scatter!(plt, tot_ref, tot, example_structs; legend_title="Total", subplot=1)
    _scatter!(plt, bb_ref, bb, example_structs; legend_title="Backbone", subplot=2)
    _scatter!(plt, sc_ref, sc, example_structs; legend_title="Sidechain", subplot=3)
    xlab(::Type{MoeserHorinek}) = "Moeser&Horinek"
    xlab(::Type{AutonBolen}) = "Auton&Bolen"

    plot!(plt, xlabel=xlab(model), ylabel=nothing)
    plot!(plt, ylabel="LAPM prediction", subplot=1)

    ys = (maximum(vcat(tot, sc, bb)) - minimum(vcat(tot, sc, bb)))
    groupedbar!(
        string.(example_structs),
        hcat(tot, bb, sc);
        label=["Total" "BB" "SC"],
        xlabel="Structure",
        ylabel="m-value / (kcal/mol)",
        subplot=4,
        ylims=(minimum(vcat(tot, sc, bb, 0)) - 0.1 * abs(ys), maximum(vcat(tot, sc, bb, 0)) + 0.1 * abs(ys)),
        xrotation=60,
        #bottommargin=0.5Plots.Measures.cm,
    )

    plot!(plt,
        size=(1200, 800),
        rightmargin=0.2Plots.Measures.cm,
        leftmargin=0.5Plots.Measures.cm,
    )

    return plt
end

function delta_residue_type(resname::String)


end
