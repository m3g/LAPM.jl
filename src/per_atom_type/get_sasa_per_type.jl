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
function run_get_creamer_sasa(; proteins=protein_list_original(), sasa_parameterization)
    mean_asa_restype = creamer_data_per_residue(;proteins=proteins)
    JSON.json("$(@__DIR__)/output/creamer_per_residue.json", mean_asa_restype; pretty=true)
    #
    # Function that reproduces Figure 2 of Creamer paper:
    #
    plt = plot_cd_creamer(mean_asa_restype)
    savefig("$(@__DIR__)/output/creamer_fig2.svg")
    #
    # Comparing the ASAs obtained here with those reported by Creamer:
    #
    plt = scatter_creamer_vs_current(mean_asa_restype; n=17)
    savefig("$(@__DIR__)/output/ASA_creamer_vs_LAPM.svg")
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
function protein_list_cath_s20()
    dir = "/home/leandro/Downloads/dompdb/pdbs"
    files = readdir(dir)
    list = OrderedDict{String, Vector{Atom{Nothing}}}()
    for file in files
        list[file] = read_pdb(joinpath(dir, file))
    end
    return list
end
#
# The list of proteins is that listed in the Creamer paper. 
#
function protein_list_original()
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

    ip = 0
    @showprogress for (pname, p) in pairs(proteins)
        try 
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
            ip += 1
        catch
        end
    end
    @show ip

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

function load_creamer_per_residue(;
    cath_s20 = false,
    jsonfile = joinpath(@__DIR__, "output",
        cath_s20 ? "creamer_per_residue_cath_s20.json" : "creamer_per_residue.json")
)
    raw = JSON.parsefile(jsonfile)
    OrderedDict(
        parse(Int, lk) => OrderedDict(
            rk => (
                bb_lower = rv["bb_lower"],
                bb_upper = rv["bb_upper"],
                sc_lower = rv["sc_lower"],
                sc_upper = rv["sc_upper"],
            )
            for (rk, rv) in sort(collect(lv); by=p -> p.first)
        )
        for (lk, lv) in sort(collect(raw); by=p -> parse(Int, p.first))
    )
end

function plot_cd_creamer(mean_asa_restype; title="")
    plt = plot(MolSimStyle; layout=(2, 1), plot_title=title)
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
function scatter_creamer_vs_current(cd; n=17, title="")

    creamer_sasas = PDBTools._sasa_parameterization(:original)

    plt = plot(MolSimStyle; layout=(2,2), plot_title=title)
    ls = (lw=2, ls=:dash, label="", lc=:lightgrey)

    x = [ creamer_sasas[key].bb_lower for key in keys(creamer_sasas) ]
    lims=collect(extrema(x) .+ (-0.2,0.2) .* extrema(x))
    plot!(plt, lims, lims; ls..., subplot=1)
    scatter!(plt,
        title="BB lower",
        [ creamer_sasas[key].bb_lower for key in keys(creamer_sasas) ], 
        [ cd[n][key].bb_lower for key in keys(cd[n]) ],
        subplot=1,
        xlabel="Creamer ASA / Å",
        ylabel="Current ASA / Å",
        label="",
        lims=lims,
    )
    x = [ creamer_sasas[key].bb_upper for key in keys(creamer_sasas) ]
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
    x = [ creamer_sasas[key].sc_lower for key in keys(creamer_sasas) ]
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
    x = [ creamer_sasas[key].sc_upper for key in keys(creamer_sasas) ] 
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
        try
            #println("Running for: $pname")
            for (i, at) in enumerate(p)
                at.index = i
            end
            r = collect(eachresidue(p))
            p_max = copy.(p)
            set_phi_psi!(p_max, -120, 120)
            set_chi1_to_180!(p_max)
#            s_max = sasa_particles(p_max)
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
        catch
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

const n_atoms_side_chain = Dict{String,Int}(
    "ALA" => 1,  # CB
    "PHE" => 7,  # CB CG CD1 CD2 CE1 CE2 CZ
    "LEU" => 4,  # CB CG CD1 CD2
    "ILE" => 4,  # CB CG1 CG2 CD1
    "VAL" => 3,  # CB CG1 CG2
    "PRO" => 3,  # CB CG CD
    "MET" => 4,  # CB CG SD CE
    "TRP" => 10, # CB CG CD1 CD2 NE1 CE2 CE3 CZ2 CZ3 CH2
    "GLY" => 0,  # no side chain heavy atoms
    "SER" => 2,  # CB OG
    "THR" => 3,  # CB OG1 CG2
    "TYR" => 8,  # CB CG CD1 CD2 CE1 CE2 CZ OH
    "GLN" => 5,  # CB CG CD OE1 NE2
    "ASN" => 4,  # CB CG OD1 ND2
    "ASP" => 4,  # CB CG OD1 OD2
    "GLU" => 5,  # CB CG CD OE1 OE2
    "HIS" => 6,  # CB CG ND1 CD2 CE1 NE2
    "LYS" => 5,  # CB CG CD CE NZ
    "ARG" => 7,  # CB CG CD NE CZ NH1 NH2
    "CYS" => 2,  # CB SG
)

#
# Read all proteins from a database:
# proteins = read_pdb.(joinpath.("/home/leandro/Downloads/dompdb/pdbs", readdir("/home/leandro/Downloads/dompdb/pdbs")))
#
function compute_accessible_fractions(; proteins=proteins)
    f = OrderedDict{String,OrderedDict{String,Float32}}(
        "ALA" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0),
        "PHE" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0),
        "LEU" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0),
        "ILE" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0),   
        "VAL" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "PRO" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "MET" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "TRP" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "GLY" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "SER" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "THR" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "TYR" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "GLN" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "ASN" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "ASP" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "GLU" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "HIS" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "LYS" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "ARG" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
        "CYS" => OrderedDict("n"=>0.f0, "sc"=>0.f0, "sc_pure"=>0.f0, "bb" => 0.f0, "bb_pure"=>0.f0, "f_bb" => 0.0, "f_sc" => 0.0), 
    )
    @showprogress for (_, prot) in pairs(proteins)
        prot_no_H = select(prot, "not element H")
        rs = collect(eachresidue(prot_no_H))
        for ir in firstindex(rs)+1:lastindex(rs)-1
            r = rs[ir]
            rname = resname(r)
            if !(rname in keys(n_atoms_side_chain))
                continue
            end
            bb0 = select(rs[ir-1], isbackbone)
            bb1 = select(r, isbackbone)
            bb2 = select(rs[ir+1], isbackbone)
            bb = vcat(bb0, bb1, bb2)
            if length(bb) != 12
                continue
            end
            bb_pure = sasa(sasa_particles_ua(bb), at -> at in r) 
            if rname == "GLY"
                f["GLY"]["n"] += 1
                f["GLY"]["bb"] += bb_pure
                f["GLY"]["bb_pure"] += bb_pure
                continue
            end
            sc_only = select(r, issidechain)
            if length(sc_only) != n_atoms_side_chain[rname] 
                continue
            end
            fragment = vcat(bb0, r, bb2)
            bb = sasa(sasa_particles_ua(fragment), at -> isbackbone(at) && at in r)
            sc_pure = sasa(sasa_particles_ua(select(r, issidechain)))
            sc = sasa(sasa_particles_ua(r), issidechain)
            f[rname]["n"] += 1
            f[rname]["bb"] += bb
            f[rname]["bb_pure"] += bb_pure
            f[rname]["sc"] += sc
            f[rname]["sc_pure"] += sc_pure
        end
    end
    for rname in keys(f)
        n = f[rname]["n"]
        f[rname]["bb"] /= n 
        f[rname]["bb_pure"] /= n 
        f[rname]["sc"] /= n 
        f[rname]["sc_pure"] /= n 
        f[rname]["f_bb"] = f[rname]["bb"]/f[rname]["bb_pure"]
        f[rname]["f_sc"] = f[rname]["sc"]/f[rname]["sc_pure"]
    end
    return f
end

# Result from the above function computed over the full CATH 20 database using sasa_particles()
const f_acc_Gromacs = OrderedDict{String, OrderedDict{String, Float32}}(
  "ALA" => OrderedDict("n"=>178636.0, "sc"=>62.147, "sc_pure"=>120.728, "bb"=>52.93, "bb_pure"=>87.459, "f_bb"=>0.605198, "f_sc"=>0.514768),
  "PHE" => OrderedDict("n"=>91160.0, "sc"=>180.799, "sc_pure"=>237.736, "bb"=>42.2336, "bb_pure"=>86.2234, "f_bb"=>0.489816, "f_sc"=>0.760502),
  "LEU" => OrderedDict("n"=>212344.0, "sc"=>144.686, "sc_pure"=>200.589, "bb"=>42.3231, "bb_pure"=>86.9463, "f_bb"=>0.486774, "f_sc"=>0.721302),
  "ILE" => OrderedDict("n"=>126302.0, "sc"=>144.897, "sc_pure"=>201.34, "bb"=>40.0158, "bb_pure"=>86.3755, "f_bb"=>0.463277, "f_sc"=>0.719663),
  "VAL" => OrderedDict("n"=>152561.0, "sc"=>120.343, "sc_pure"=>177.027, "bb"=>41.3333, "bb_pure"=>86.1337, "f_bb"=>0.479873, "f_sc"=>0.6798),
  "PRO" => OrderedDict("n"=>97658.0, "sc"=>115.728, "sc_pure"=>175.361, "bb"=>42.857, "bb_pure"=>90.3427, "f_bb"=>0.474383, "f_sc"=>0.659941),
  "MET" => OrderedDict("n"=>36817.0, "sc"=>155.679, "sc_pure"=>212.483, "bb"=>44.0675, "bb_pure"=>86.7157, "f_bb"=>0.508184, "f_sc"=>0.732663),
  "TRP" => OrderedDict("n"=>31439.0, "sc"=>222.825, "sc_pure"=>279.907, "bb"=>41.012, "bb_pure"=>86.8561, "f_bb"=>0.472184, "f_sc"=>0.796068),
  "GLY" => OrderedDict("n"=>151206.0, "sc"=>0.0, "sc_pure"=>0.0, "bb"=>86.3549, "bb_pure"=>86.3549, "f_bb"=>1.0, "f_sc"=>NaN),
  "SER" => OrderedDict("n"=>129548.0, "sc"=>83.0034, "sc_pure"=>141.191, "bb"=>48.602, "bb_pure"=>86.5017, "f_bb"=>0.561862, "f_sc"=>0.587879),
  "THR" => OrderedDict("n"=>118271.0, "sc"=>111.981, "sc_pure"=>168.956, "bb"=>42.4243, "bb_pure"=>85.8036, "f_bb"=>0.494435, "f_sc"=>0.662778),
  "TYR" => OrderedDict("n"=>78108.0, "sc"=>198.268, "sc_pure"=>255.194, "bb"=>42.4376, "bb_pure"=>86.1911, "f_bb"=>0.492366, "f_sc"=>0.77693),
  "GLN" => OrderedDict("n"=>82374.0, "sc"=>151.399, "sc_pure"=>208.416, "bb"=>44.3666, "bb_pure"=>87.068, "f_bb"=>0.509563, "f_sc"=>0.726426),
  "ASN" => OrderedDict("n"=>93050.0, "sc"=>126.426, "sc_pure"=>184.088, "bb"=>44.2684, "bb_pure"=>87.562, "f_bb"=>0.505566, "f_sc"=>0.686771),
  "ASP" => OrderedDict("n"=>125402.0, "sc"=>124.667, "sc_pure"=>182.223, "bb"=>44.11, "bb_pure"=>87.8884, "f_bb"=>0.501887, "f_sc"=>0.684146),
  "GLU" => OrderedDict("n"=>141726.0, "sc"=>149.409, "sc_pure"=>206.402, "bb"=>44.8279, "bb_pure"=>87.6843, "f_bb"=>0.511242, "f_sc"=>0.723873),
  "HIS" => OrderedDict("n"=>50912.0, "sc"=>157.599, "sc_pure"=>214.954, "bb"=>43.8755, "bb_pure"=>86.5002, "f_bb"=>0.50723, "f_sc"=>0.733173),
  "LYS" => OrderedDict("n"=>117097.0, "sc"=>165.952, "sc_pure"=>223.125, "bb"=>46.1709, "bb_pure"=>87.3999, "f_bb"=>0.528271, "f_sc"=>0.743764),
  "ARG" => OrderedDict("n"=>109623.0, "sc"=>198.673, "sc_pure"=>256.034, "bb"=>45.7085, "bb_pure"=>87.0432, "f_bb"=>0.525124, "f_sc"=>0.775961),
  "CYS" => OrderedDict("n"=>29486.0, "sc"=>103.039, "sc_pure"=>160.6, "bb"=>46.205, "bb_pure"=>85.928, "f_bb"=>0.537717, "f_sc"=>0.641584),
)

# Result from the above function computed over the original database using sasa_particles()
const f_acc_Creamer_Original = OrderedDict{String, OrderedDict{String, Float32}}(
  "ALA" => OrderedDict("n"=>510.0, "sc"=>70.7682, "sc_pure"=>135.195, "bb"=>48.8059, "bb_pure"=>88.7686, "f_bb"=>0.549811, "f_sc"=>0.523454),
  "PHE" => OrderedDict("n"=>239.0, "sc"=>188.069, "sc_pure"=>249.27, "bb"=>37.9977, "bb_pure"=>86.988, "f_bb"=>0.436816, "f_sc"=>0.75448),
  "LEU" => OrderedDict("n"=>482.0, "sc"=>159.294, "sc_pure"=>219.433, "bb"=>37.2531, "bb_pure"=>87.9102, "f_bb"=>0.423763, "f_sc"=>0.725938),
  "ILE" => OrderedDict("n"=>338.0, "sc"=>161.215, "sc_pure"=>221.398, "bb"=>35.3786, "bb_pure"=>87.2734, "f_bb"=>0.405377, "f_sc"=>0.728168),
  "VAL" => OrderedDict("n"=>456.0, "sc"=>134.406, "sc_pure"=>194.903, "bb"=>36.6472, "bb_pure"=>86.8897, "f_bb"=>0.421768, "f_sc"=>0.689603),
  "PRO" => OrderedDict("n"=>280.0, "sc"=>130.883, "sc_pure"=>193.711, "bb"=>39.2122, "bb_pure"=>90.5509, "f_bb"=>0.43304, "f_sc"=>0.675662),
  "MET" => OrderedDict("n"=>112.0, "sc"=>162.016, "sc_pure"=>223.705, "bb"=>40.2403, "bb_pure"=>86.7075, "f_bb"=>0.464092, "f_sc"=>0.724239),
  "TRP" => OrderedDict("n"=>100.0, "sc"=>230.384, "sc_pure"=>291.275, "bb"=>37.0716, "bb_pure"=>88.244, "f_bb"=>0.420103, "f_sc"=>0.79095),
  "GLY" => OrderedDict("n"=>582.0, "sc"=>0.0, "sc_pure"=>0.0, "bb"=>87.2487, "bb_pure"=>87.2487, "f_bb"=>1.0, "f_sc"=>1.0),
  "SER" => OrderedDict("n"=>491.0, "sc"=>85.2914, "sc_pure"=>148.748, "bb"=>45.6889, "bb_pure"=>87.7386, "f_bb"=>0.520739, "f_sc"=>0.573396),
  "THR" => OrderedDict("n"=>397.0, "sc"=>118.429, "sc_pure"=>179.464, "bb"=>39.2553, "bb_pure"=>86.303, "f_bb"=>0.454854, "f_sc"=>0.659903),
  "TYR" => OrderedDict("n"=>297.0, "sc"=>202.526, "sc_pure"=>263.883, "bb"=>38.7576, "bb_pure"=>86.623, "f_bb"=>0.447429, "f_sc"=>0.767481),
  "GLN" => OrderedDict("n"=>236.0, "sc"=>156.148, "sc_pure"=>217.884, "bb"=>39.75, "bb_pure"=>86.8252, "f_bb"=>0.457816, "f_sc"=>0.716656),
  "ASN" => OrderedDict("n"=>315.0, "sc"=>129.592, "sc_pure"=>191.577, "bb"=>40.1319, "bb_pure"=>88.1341, "f_bb"=>0.45535, "f_sc"=>0.676448),
  "ASP" => OrderedDict("n"=>396.0, "sc"=>121.913, "sc_pure"=>184.115, "bb"=>40.6571, "bb_pure"=>88.7731, "f_bb"=>0.457989, "f_sc"=>0.662155),
  "GLU" => OrderedDict("n"=>335.0, "sc"=>149.3, "sc_pure"=>211.099, "bb"=>40.8324, "bb_pure"=>88.1362, "f_bb"=>0.463287, "f_sc"=>0.70725),
  "HIS" => OrderedDict("n"=>154.0, "sc"=>165.917, "sc_pure"=>227.457, "bb"=>38.8932, "bb_pure"=>86.1819, "f_bb"=>0.451292, "f_sc"=>0.729445),
  "LYS" => OrderedDict("n"=>389.0, "sc"=>178.029, "sc_pure"=>240.14, "bb"=>40.85, "bb_pure"=>87.9932, "f_bb"=>0.46424, "f_sc"=>0.741355),
  "ARG" => OrderedDict("n"=>225.0, "sc"=>210.998, "sc_pure"=>273.052, "bb"=>40.493, "bb_pure"=>87.3891, "f_bb"=>0.463365, "f_sc"=>0.772739),
  "CYS" => OrderedDict("n"=>156.0, "sc"=>92.5422, "sc_pure"=>155.873, "bb"=>44.8147, "bb_pure"=>87.2341, "f_bb"=>0.513729, "f_sc"=>0.593704),
)

