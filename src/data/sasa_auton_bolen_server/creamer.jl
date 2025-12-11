struct _Selector{F,T} <: Function
    f::F
    residue::Ref{T}
end
(s::_Selector)(at::Atom) = s.f(at) && (at in s.residue[])

#
# This will use the creamer ASAs as reported in the paper, and
# currently implemented in PDBTools
#
creamer_sasa(_, atoms) = creamer_sasa_restype(atoms)
function creamer_sasa_restype(atoms::AbstractVector{<:PDBTools.Atom})
    sasas = Dict{String,Dict}()
    sasa_atoms = sasa_particles(atoms;
        atom_type = PDBTools.creamer_atom_type,
        atom_radius_from_type = type -> PDBTools.creamer_atomic_radii[type],
    )
    sel_bb = _Selector(isbackbone, Ref(first(eachresidue(atoms))))
    sel_sc = _Selector(issidechain, Ref(first(eachresidue(atoms))))
    for res in eachresidue(atoms)
        rname = resname(res)
        if !haskey(sasas, rname)
            sasas[rname] = Dict(:sc => (0.0, 0.0, 0.0), :bb => (0.0, 0.0, 0.0))
        end
    end
    for res in eachresidue(atoms)
        sel_bb.residue[] = res
        sel_sc.residue[] = res
        sasa_res_bb = sasa(sasa_atoms, sel_bb)
        sasa_res_sc = sasa(sasa_atoms, sel_sc)
        rname = resname(res)
        cr = PDBTools.creamer_sasas[rname]
        csc = sasas[rname][:sc]
        cbb = sasas[rname][:bb]
        sasas[rname] = Dict(
            :sc => (
                csc[1] + cr.sc_lower - sasa_res_sc,
                csc[2] + 0.5 * (cr.sc_lower + cr.sc_upper) - sasa_res_sc,
                csc[3] + cr.sc_upper - sasa_res_sc,
            ),
            :bb => (
                cbb[1] + cr.bb_lower - sasa_res_bb,
                cbb[2] + 0.5 * (cr.bb_lower + cr.bb_upper) - sasa_res_bb,
                cbb[3] + cr.bb_upper - sasa_res_bb,
            )
        )
    end
    return sasas
end

#
# These will use the new set of ASAs, obtained by trying to reproduce the Creamer
# paper data.
#
const creamer_sasas_new = Dict{
    String,
    @NamedTuple{bb_lower::Float64, bb_upper::Float64, sc_lower::Float64, sc_upper::Float64}
}(
  "ALA" => (bb_lower = 20.7273, bb_upper = 38.2849, sc_lower = 43.4031, sc_upper = 58.0849),
  "ARG" => (bb_lower = 18.3347, bb_upper = 33.3763, sc_lower = 148.83, sc_upper = 168.118),
  "ASN" => (bb_lower = 18.9146, bb_upper = 33.7982, sc_lower = 83.1922, sc_upper = 95.0593),
  "ASP" => (bb_lower = 19.4371, bb_upper = 34.6858, sc_lower = 78.5996, sc_upper = 89.4861),
  "CYS" => (bb_lower = 20.9307, bb_upper = 37.608, sc_lower = 54.5206, sc_upper = 70.6493),
  "GLN" => (bb_lower = 17.7608, bb_upper = 33.6317, sc_lower = 102.378, sc_upper = 118.62),
  "GLU" => (bb_lower = 19.0967, bb_upper = 33.4637, sc_lower = 100.832, sc_upper = 113.39),
  "GLY" => (bb_lower = 54.2184, bb_upper = 74.7222, sc_lower = 0.0, sc_upper = 0.0),
  "HIS" => (bb_lower = 15.4983, bb_upper = 32.6304, sc_lower = 103.378, sc_upper = 118.486),
  "ILE" => (bb_lower = 16.6421, bb_upper = 31.0321, sc_lower = 97.4824, sc_upper = 117.418),
  "LEU" => (bb_lower = 15.8228, bb_upper = 31.9691, sc_lower = 96.9378, sc_upper = 117.052),
  "LYS" => (bb_lower = 19.636, bb_upper = 34.4396, sc_lower = 130.759, sc_upper = 138.781),
  "MET" => (bb_lower = 17.9485, bb_upper = 32.8476, sc_lower = 99.2576, sc_upper = 125.076),
  "PHE" => (bb_lower = 16.2814, bb_upper = 31.5632, sc_lower = 116.243, sc_upper = 137.095),
  "PRO" => (bb_lower = 19.9066, bb_upper = 27.257, sc_lower = 80.2617, sc_upper = 95.5204),
  "SER" => (bb_lower = 24.9099, bb_upper = 37.2971, sc_lower = 56.0964, sc_upper = 66.5874),
  "THR" => (bb_lower = 19.7255, bb_upper = 32.0237, sc_lower = 72.6126, sc_upper = 85.7771),
  "TRP" => (bb_lower = 16.8528, bb_upper = 29.9011, sc_lower = 149.543, sc_upper = 167.217),
  "TYR" => (bb_lower = 18.8791, bb_upper = 31.7213, sc_lower = 127.086, sc_upper = 146.505),
  "VAL" => (bb_lower = 16.8794, bb_upper = 32.0856, sc_lower = 78.1454, sc_upper = 94.0587),
)

creamer_sasa_new(_, atoms) = creamer_sasa_restype_new(atoms)
function creamer_sasa_restype_new(atoms::AbstractVector{<:PDBTools.Atom})
    sasas = Dict{String,Dict}()
    sasa_atoms = sasa_particles(atoms;
        atom_type = PDBTools.creamer_atom_type,
        atom_radius_from_type = type -> PDBTools.creamer_atomic_radii[type],
    )
    sel_bb = _Selector(isbackbone, Ref(first(eachresidue(atoms))))
    sel_sc = _Selector(issidechain, Ref(first(eachresidue(atoms))))
    for res in eachresidue(atoms)
        rname = resname(res)
        if !haskey(sasas, rname)
            sasas[rname] = Dict(:sc => (0.0, 0.0, 0.0), :bb => (0.0, 0.0, 0.0))
        end
    end
    for res in eachresidue(atoms)
        sel_bb.residue[] = res
        sel_sc.residue[] = res
        sasa_res_bb = sasa(sasa_atoms, sel_bb)
        sasa_res_sc = sasa(sasa_atoms, sel_sc)
        rname = resname(res)
        cr = creamer_sasas_new[rname]
        csc = sasas[rname][:sc]
        cbb = sasas[rname][:bb]
        sasas[rname] = Dict(
            :sc => (
                csc[1] + cr.sc_lower - sasa_res_sc,
                csc[2] + 0.5 * (cr.sc_lower + cr.sc_upper) - sasa_res_sc,
                csc[3] + cr.sc_upper - sasa_res_sc,
            ),
            :bb => (
                cbb[1] + cr.bb_lower - sasa_res_bb,
                cbb[2] + 0.5 * (cr.bb_lower + cr.bb_upper) - sasa_res_bb,
                cbb[3] + cr.bb_upper - sasa_res_bb,
            )
        )
    end
    return sasas
end
