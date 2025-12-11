#=

The Creamer paper says it uses the radii reported by Richards. Richards
says it uses the radii reported by Bondi. 

Nevertheless, the results of Cremaer, Auton and Bolen, etc, are better reproduced
with the atomic radii by hibridization, which are implemented in PDBTools.jl as 
the default Creamer atomic radii. 

Nevertheless, this was an attempt to use the Bondi radii and see if the results
matched the reported SASAs per residue type (BB and SC) by Creamer. But the results
are worse than those using the united atom types by hydbridization.

The functions here are similar to those of get_sasa_per_type.jl but using different
atomic radii.

=#
#
# References:
#
# Bondi, A. (1964). J. Phys. Chem. 68, 441.
# Lee & Richards, J. Mol. Biol. (1971) 55, 379-400.
#

function bondi_atom_type(at::Atom)
    types = Dict{StringType,StringType}(
        "N" => "N",
        "CA" => "CA",
        "C" => "C",
        "O" => "O",
    )
    nat = name(at)
    type = if haskey(types, nat)
        types[name(at)]
    elseif element(at) == "H"
        "H"
    elseif element(at) == "Fe"
        "Fe"
    else
        "side-chain"
    end
    return type
end

function bondi_atom_radii(at_type::AbstractString) 
    radii = Dict{StringType,Float32}(
        "N" => 1.55,
        "CA" => 1.70,
        "C" => 1.80,
        "O" => 1.52,
        "Fe" => 0.64,
        "side-chain" => 1.80,
        "H" => 0.0,
    )
    return radii[at_type]
end

function sasa_particles_bondi(ats)
    sasa_particles(ats,
        atom_type=bondi_atom_type,
        atom_radius_from_type=bondi_atom_radii,
    )
end

#
# Split per atom type
#

function creamer_data_atoms(;
    proteins = OrderedDict(
        "1bp2" => wget("1bp2", "protein and not element H"),
        "1crn" => wget("1crn", "protein and not element H"),
        "1ecd" => wget("1ecd", "protein and not element H"),
        "1gcr" => wget("1gcr", "protein and not element H"),
        "1gd1" => wget("1gd1", "protein and chain A and not element H"),
        "1gp1" => wget("1gp1", "protein and chain A and not element H"), # paper says chain O 
        "1hmq" => wget("1hmq", "protein and chain A and not element H"),
        "1hoe" => wget("1hoe", "protein and not element H"),
        "1lz1" => wget("1lz1", "protein and not element H"),
        "1mbo" => wget("1mbo", "protein and not element H"),
        "1ppt" => wget("1ppt", "protein and not element H"),
        "1rdg" => wget("1rdg", "protein and not element H"),
        "1sn3" => wget("1sn3", "protein and not element H"),
        "1snc" => wget("1snc", "protein and not element H"),
        "1tpp" => wget("1tpp", "protein and not element H"),
        "1ubq" => wget("1ubq", "protein and not element H"),
        "2act" => wget("2act", "protein and not element H"),
        "2aza" => wget("2aza", "protein and chain B and not element H"),
        "2ca2" => wget("2ca2", "protein and not element H"),
        "2cdv" => wget("2cdv", "protein and not element H"),
        "2cts" => wget("2cts", "protein and not element H"),
        "2lhb" => wget("2lhb", "protein and not element H"),
        "2ovo" => wget("2ovo", "protein and not element H"),
        "2pcy" => wget("2pcy", "protein and not element H"),
        "2rhe" => wget("2rhe", "protein and not element H"),
        "2wrp" => wget("2wrp", "protein and chain A and not element H"), # paper says chain R 
        "351c" => wget("351c", "protein and not element H"),
        "3app" => wget("3app", "protein and not element H"),
        "3grs" => wget("3grs", "protein and not element H"),
        "3ins" => wget("3ins", "protein and chain C and element N C O S"),
        "3ins" => wget("3ins", "protein and chain D and element N C O S"),
        "3lzm" => wget("3lzm", "protein and not element H"),
        "3rnt" => wget("3rnt", "protein and not element H"),
        "3tln" => wget("3tln", "protein and not element H"),
        "4dfr" => wget("4dfr", "protein and chain B and not element H"),
        "4fxn" => wget("4fxn", "protein and not element H"),
        "4pep" => wget("4pep", "protein and not element H"),
        "5cha" => wget("5cha", "protein and chain A and not element H"),
        "5cpa" => wget("5cpa", "protein and not element H"),
        "5cyt" => wget("5cyt", "protein and not element H"), # paper says chain R
        "5pti" => wget("5pti", "protein and element N C O S and not element H"),
        "7rsa" => wget("7rsa", "protein and not element H"),
        "9pap" => wget("9pap", "protein and not element H")
    )
)

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
    end

    for l in keys(mean_asa_restype)
        mean_asa_restype[l] = OrderedDict(sort(collect(mean_asa_restype[l]); by=first))
    end

    return mean_asa_restype
end