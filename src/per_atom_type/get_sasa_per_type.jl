#
# These scripts are to reproduce the SASA per residue (BB and SC) from Creamer
# articles, and then compute the contribution split by atom type
#
using PDBTools
using PDBTools: StringType
using ProgressMeter
using JSON
using OrderedCollections
using Statistics
using LinearAlgebra: normalize, cross, dot
using MolSimToolkit: MolSimStyle

# Function that runs everything and output the results:
#
# The creamer_per_atom.json file, which is the result actually used by other 
# functions and methods.
#
# And validation plots:
#
# creamer_fig2.png
# ASA_creamer_vs_LAPM.png
#
function run_get_creamer_sasa()
    proteins = protein_list()
    mean_asa_restype = creamer_data_per_residue(;proteins=proteins)
    JSON.json("$(@__DIR__)/output/creamer_per_residue.json", mean_asa_restype; pretty=true)
    #
    # Function that reproduces Figure 2 of Creamer paper:
    #
    plt = plot_cd_creamer(mean_asa_restype)
    savefig("$(@__DIR__)/output/creamer_fig2.png")
    #
    # Comparing the ASAs obtained here with those reported by Creamer:
    #
    plt = scatter_cremer_vs_current(mean_asa_restype; n=17)
    savefig("$(@__DIR__)/output/ASA_creamer_vs_LAPM.png")
    # This will be used to generate the atom-type model
    mean_asa_atomtype = creamer_data_per_atom(;proteins=proteins)
    JSON.json("$(@__DIR__)/output/creamer_per_atom.json", mean_asa_atomtype; pretty=true)
end

# Functions to generate the extended protein structures
include("./extended_pdb.jl")

#
# Compute SASA using Creamer atom types
#
function sasa_particles_ua(ats)
    sasa_particles(ats,
        atom_type=PDBTools.creamer_atom_type,
        atom_radius_from_type=at -> PDBTools.creamer_atomic_radii[at],
    )
end

#
# The list of proteins is that listed in the Creamer paper. 
#
function protein_list()
    OrderedDict(
        "1bp2" => wget("1bp2", "protein"),
        "1crn" => wget("1crn", "protein"),
        "1ecd" => wget("1ecd", "protein"),
        "1gcr" => wget("1gcr", "protein"),
        "1gd1" => wget("1gd1", "protein and chain A"),
        "1gp1" => wget("1gp1", "protein and chain A"), # paper says chain O 
        "1hmq" => wget("1hmq", "protein and chain A"),
        "1hoe" => wget("1hoe", "protein"),
        "1lz1" => wget("1lz1", "protein"),
        "1mbo" => wget("1mbo", "protein"),
        "1ppt" => wget("1ppt", "protein"),
        "1rdg" => wget("1rdg", "protein"),
        "1sn3" => wget("1sn3", "protein"),
        "1snc" => wget("1snc", "protein"),
        "1tpp" => wget("1tpp", "protein"),
        "1ubq" => wget("1ubq", "protein"),
        "2act" => wget("2act", "protein"),
        "2aza" => wget("2aza", "protein and chain B"),
        "2ca2" => wget("2ca2", "protein"),
        "2cdv" => wget("2cdv", "protein"),
        "2cts" => wget("2cts", "protein"),
        "2lhb" => wget("2lhb", "protein"),
        "2ovo" => wget("2ovo", "protein"),
        "2pcy" => wget("2pcy", "protein"),
        "2rhe" => wget("2rhe", "protein"),
        "2wrp" => wget("2wrp", "protein and chain A"), # paper says chain R 
        "351c" => wget("351c", "protein"),
        "3app" => wget("3app", "protein"),
        "3grs" => wget("3grs", "protein"),
        "3ins" => wget("3ins", "protein and chain C and element N C O S"),
        "3ins" => wget("3ins", "protein and chain D and element N C O S"),
        "3lzm" => wget("3lzm", "protein"),
        "3rnt" => wget("3rnt", "protein"),
        "3tln" => wget("3tln", "protein"),
        "4dfr" => wget("4dfr", "protein and chain B"),
        "4fxn" => wget("4fxn", "protein"),
        "4pep" => wget("4pep", "protein"),
        "5cha" => wget("5cha", "protein and chain A"),
        "5cpa" => wget("5cpa", "protein"),
        "5cyt" => wget("5cyt", "protein"), # paper says chain R
        "5pti" => wget("5pti", "protein and element N C O S"),
        "7rsa" => wget("7rsa", "protein"),
        "9pap" => wget("9pap", "protein")
    )
end

# This function will create slices of the structures from 3 to 17 residues,
# and obtain the SASA of the slices, to estimate the lower bound for the
# unfolded SASA (which is the result from the 17-mer slices, for compatibility
# with the Creamer paper) 
#
# The function also creates the upper bound unfolded state, by generating an
# extended chain with χ₁ = 180 (the papers uses all side-chain angles at 180,
# apparently, but the results are not sensitive to this as far as tested).
# The SASAS of this extended state are also computed and used to estimate 
# the upper bound of unfolding.
#
function creamer_data_per_residue(;proteins=protein_list)

    asa_restype = OrderedDict(
        3 => OrderedDict{String,Any}(),
        5 => OrderedDict{String,Any}(),
        7 => OrderedDict{String,Any}(),
        9 => OrderedDict{String,Any}(),
        11 => OrderedDict{String,Any}(),
        13 => OrderedDict{String,Any}(),
        15 => OrderedDict{String,Any}(),
        17 => OrderedDict{String,Any}(),
    )


    for (pname, p) in pairs(proteins)
        println("Running for: $pname")
        for (i, at) in enumerate(p)
            at.index = i
        end
        r = collect(eachresidue(p))
        # Extended state for upper bound for unfolding
        p_max = copy.(p)
        set_phi_psi!(p_max, -120, 120)
        set_chi1_to_180!(p_max)
        # One can interpret that the sasa of the extended state was computed
        # only once, or for the fragments. The result is essentially the same,
        # so we decided here to use the fragments. 
        # s_max = sasa_particles(p_max)
        for l in keys(asa_restype)
            mid = l ÷ 2
            # skip first and last 3 residues
            for i in (mid+1+1):(length(r)-mid-1)
                rn = resname(r[i])
                ifirst = index(first(r[i-mid]))
                ilast = index(last(r[i+mid]))
                # s_min will be the lower bound for the accessible surface areas 
                s_min = sasa_particles_ua(p[ifirst:ilast])
                # s_max computed for the fragments
                s_max = sasa_particles_ua(p_max[ifirst:ilast])
                if !haskey(asa_restype[l], rn)
                    asa_restype[l][rn] = (n=0, bb_lower=0.0, bb_upper=0.0, sc_lower=0.0, sc_upper=0.0)
                end
                asa_restype[l][rn] = (
                    n= asa_restype[l][rn].n + 1,
                    bb_lower = asa_restype[l][rn].bb_lower + sasa(s_min, at -> isbackbone(at) && (at in r[i])),
                    bb_upper = asa_restype[l][rn].bb_upper + sasa(s_max, at -> isbackbone(at) && (at in r[i])),
                    sc_lower = asa_restype[l][rn].sc_lower + sasa(s_min, at -> !isbackbone(at) && (at in r[i])),
                    sc_upper = asa_restype[l][rn].sc_upper + sasa(s_max, at -> !isbackbone(at) && (at in r[i])),
                )
            end
        end
    end

    #
    # Averaging over all types
    #
    mean_asa_restype = OrderedDict(
        3 => OrderedDict(),
        5 => OrderedDict(),
        7 => OrderedDict(),
        9 => OrderedDict(),
        11 => OrderedDict(),
        13 => OrderedDict(),
        15 => OrderedDict(),
        17 => OrderedDict(),
    )
    for l in keys(mean_asa_restype)
        for rn in keys(asa_restype[l])
            if !haskey(mean_asa_restype[l], rn)
                mean_asa_restype[l][rn] = (bb_lower=0.0, sc_lower=0.0, bb_upper=0.0, sc_upper=0.0)
            end
            mean_asa_restype[l][rn] = (
                bb_lower=asa_restype[l][rn].bb_lower / asa_restype[l][rn].n,
                bb_upper=asa_restype[l][rn].bb_upper / asa_restype[l][rn].n,
                sc_lower=asa_restype[l][rn].sc_lower / asa_restype[l][rn].n,
                sc_upper=asa_restype[l][rn].sc_upper / asa_restype[l][rn].n,
            )
        end
    end

    for l in keys(mean_asa_restype)
        mean_asa_restype[l] = OrderedDict(sort(collect(mean_asa_restype[l]); by=first))
    end

    return mean_asa_restype
end

function plot_cd_creamer(mean_asa_restype)
    plt = plot(MolSimStyle; layout=(2, 1))
    for l in keys(mean_asa_restype)
        plot!(plt, getproperty.(values(mean_asa_restype[l]), :bb_lower); label="$l", lw=2, subplot=1)
        plot!(plt, getproperty.(values(mean_asa_restype[l]), :sc_lower); label="", lw=2, subplot=2)
    end
    plot!(plt,
        xlabel=nothing,
        ylabel="Backbone ASA / Å",
        subplot=1,
        xticks=(1:length(keys(mean_asa_restype[3])), keys(mean_asa_restype[3])), xrotation=60,
    )
    plot!(plt,
        xlabel="residue type",
        xticks=(1:length(keys(mean_asa_restype[3])), keys(mean_asa_restype[3])), xrotation=60,
        ylabel="Sidechain ASA / Å",
        subplot=2,
        topmargin=-0.5Plots.Measures.cm,
    )
    plot!(plt,
        size=(600, 600),
    )
    return plt
end

#
# Plot the obtained SASAs vs. the results reported by Creamer
#
function scatter_cremer_vs_current(cd; n=17)
    plt = plot(MolSimStyle; layout=(2,2))
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)

    x = [ PDBTools.creamer_sasas[key].bb_lower for key in keys(PDBTools.creamer_sasas) ]
    lims=collect(extrema(x) .+ (-0.2,0.2) .* extrema(x))
    plot!(plt, lims, lims; ls..., subplot=1)
    scatter!(plt,
        title="BB lower",
        [ PDBTools.creamer_sasas[key].bb_lower for key in keys(PDBTools.creamer_sasas) ], 
        [ cd[n][key].bb_lower for key in keys(cd[n]) ],
        subplot=1,
        xlabel="Creamer ASA / Å",
        ylabel="Current ASA / Å",
        label="",
        lims=lims,
    )
    x = [ PDBTools.creamer_sasas[key].bb_upper for key in keys(PDBTools.creamer_sasas) ]
    lims=collect(extrema(x) .+ (-0.2,0.2) .* extrema(x))
    plot!(plt, lims, lims; ls..., subplot=2)
    scatter!(plt,
        title="BB upper",
        x,
        [ cd[n][key].bb_upper for key in keys(cd[n]) ],
        subplot=2,
        xlabel="Creamer ASA / Å",
        ylabel="Current ASA / Å",
        label="",
        lims=lims,
    )
    x = [ PDBTools.creamer_sasas[key].sc_lower for key in keys(PDBTools.creamer_sasas) ]
    lims=collect(extrema(x) .+ (-0.2,0.2) .* extrema(x))
    plot!(plt, lims, lims; ls..., subplot=3)
    scatter!(plt,
        title="SC lower",
        x,
        [ cd[n][key].sc_lower for key in keys(cd[n]) ],
        subplot=3,
        xlabel="Creamer ASA / Å",
        ylabel="Current ASA / Å",
        label="",
        lims=lims,
    )
    x = [ PDBTools.creamer_sasas[key].sc_upper for key in keys(PDBTools.creamer_sasas) ] 
    lims=collect(extrema(x) .+ (-0.2,0.2) .* extrema(x))
    plot!(plt, lims, lims; ls..., subplot=4)
    scatter!(plt,
        title="SC upper",
        x,
        [ cd[n][key].sc_upper for key in keys(cd[n]) ],
        subplot=4,
        xlabel="Creamer ASA / Å",
        ylabel="Current ASA / Å",
        label="",
        lims=lims,
    )
    plot!(plt, size=(600,600), topmargin=0.0Plots.Measures.cm)
    return plt
end

#
# Split per atom type
#
function creamer_data_per_atom(;proteins=protein_list)

    asa_restype = OrderedDict(
        3 => OrderedDict{String,Dict{String,Any}}(),
        5 => OrderedDict{String,Dict{String,Any}}(),
        7 => OrderedDict{String,Dict{String,Any}}(),
        9 => OrderedDict{String,Dict{String,Any}}(),
        11 => OrderedDict{String,Dict{String,Any}}(),
        13 => OrderedDict{String,Dict{String,Any}}(),
        15 => OrderedDict{String,Dict{String,Any}}(),
        17 => OrderedDict{String,Dict{String,Any}}(),
    )

    for (pname, p) in pairs(proteins)
        println("Running for: $pname")
        for (i, at) in enumerate(p)
            at.index = i
        end
        r = collect(eachresidue(p))
        p_max = copy.(p)
        set_phi_psi!(p_max, -120, 120)
        set_chi1_to_180!(p_max)
#        s_max = sasa_particles(p_max)
        for l in keys(asa_restype)
            mid = l ÷ 2
            # skip first and last 3 residues
            for i in (mid+1+1):(length(r)-mid-1)
                rn = resname(r[i])
                if !haskey(asa_restype[l], rn)
                    asa_restype[l][rn] = OrderedDict{String,Any}()
                end
                ifirst = index(first(r[i-mid]))
                ilast = index(last(r[i+mid]))
                s_min = sasa_particles_ua(p[ifirst:ilast])
                s_max = sasa_particles_ua(p_max[ifirst:ilast])
                for at in r[i]
                    atn = name(at)
                    iat = index(at)
                    if !haskey(asa_restype[l][rn], atn)
                        asa_restype[l][rn][atn] = (n=0, lower=0.0, upper=0.0)
                    end
                    asa_restype[l][rn][atn] = (
                        n= asa_restype[l][rn][atn].n + 1,
                        lower = asa_restype[l][rn][atn].lower + sasa(s_min, at -> index(at) == iat),
                        upper = asa_restype[l][rn][atn].upper + sasa(s_max, at -> index(at) == iat),
                    )
                end
            end
        end
    end

    mean_asa_restype = OrderedDict(
        3 => OrderedDict(),
        5 => OrderedDict(),
        7 => OrderedDict(),
        9 => OrderedDict(),
        11 => OrderedDict(),
        13 => OrderedDict(),
        15 => OrderedDict(),
        17 => OrderedDict(),
    )
    for l in keys(mean_asa_restype)
        for rn in keys(asa_restype[l])
            if !haskey(mean_asa_restype[l], rn)
                mean_asa_restype[l][rn] = OrderedDict{String,Any}()
            end
            for atn in keys(asa_restype[l][rn])
                if !haskey(mean_asa_restype[l], rn)
                    mean_asa_restype[l][rn][atn] = (lower=0.0, upper=0.0)
                end
                mean_asa_restype[l][rn][atn] = (
                    lower=asa_restype[l][rn][atn].lower / asa_restype[l][rn][atn].n,
                    upper=asa_restype[l][rn][atn].upper / asa_restype[l][rn][atn].n,
                )
            end
        end
        # Define terminal oxygens with the same values as GLU oxygen atoms
        mean_asa_restype[l]["TER"] = OrderedDict{String,Any}()
        mean_asa_restype[l]["TER"]["OXT"] = mean_asa_restype[l]["GLU"]["OE2"]
        mean_asa_restype[l]["TER"]["OT1"] = mean_asa_restype[l]["GLU"]["OE2"]
        mean_asa_restype[l]["TER"]["OT2"] = mean_asa_restype[l]["GLU"]["OE2"]
        # Add CD to ILE to avoid name issues
        mean_asa_restype[l]["ILE"]["CD"] = mean_asa_restype[l]["ILE"]["CD1"]
    end

    for l in keys(mean_asa_restype)
        mean_asa_restype[l] = OrderedDict(sort(collect(mean_asa_restype[l]); by=first))
    end

    return mean_asa_restype
end
