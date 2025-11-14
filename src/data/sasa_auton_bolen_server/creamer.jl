
const creamer_sasa = Dict{
    String,
    @NamedTuple{bb_lower::Float64, bb_upper::Float64, sc_lower::Float64, sc_upper::Float64}
}(
    "ALA" => (bb_lower=19.8, bb_upper=35.9, sc_lower= 46.6, sc_upper= 63.6),
    "ARG" => (bb_lower=17.1, bb_upper=33.0, sc_lower=156.9, sc_upper=185.3),
    "ASN" => (bb_lower=17.6, bb_upper=32.7, sc_lower= 84.5, sc_upper= 95.6),
    "ASP" => (bb_lower=18.1, bb_upper=33.9, sc_lower= 79.2, sc_upper= 94.8),
    "CYS" => (bb_lower=18.2, bb_upper=34.5, sc_lower= 62.9, sc_upper= 83.0),
    "GLN" => (bb_lower=17.2, bb_upper=33.4, sc_lower=105.0, sc_upper=128.7),
    "GLU" => (bb_lower=17.9, bb_upper=33.5, sc_lower=102.8, sc_upper=123.9),
    "GLY" => (bb_lower=54.6, bb_upper=75.7, sc_lower=  0.0, sc_upper=  0.0),
    "HIS" => (bb_lower=14.9, bb_upper=33.4, sc_lower=103.9, sc_upper=119.1),
    "ILE" => (bb_lower=15.2, bb_upper=24.7, sc_lower=100.1, sc_upper=134.1),
    "LEU" => (bb_lower=14.7, bb_upper=30.7, sc_lower=101.4, sc_upper=117.7),
    "LYS" => (bb_lower=18.3, bb_upper=33.8, sc_lower=142.5, sc_upper=158.8),
    "MET" => (bb_lower=16.7, bb_upper=33.8, sc_lower=105.3, sc_upper=139.5),
    "PHE" => (bb_lower=15.3, bb_upper=33.3, sc_lower=118.7, sc_upper=139.8),
    "PRO" => (bb_lower=18.9, bb_upper=26.1, sc_lower= 83.5, sc_upper= 90.5),
    "SER" => (bb_lower=23.8, bb_upper=35.0, sc_lower= 59.7, sc_upper= 73.3),
    "THR" => (bb_lower=18.6, bb_upper=29.5, sc_lower= 77.3, sc_upper= 91.2),
    "TRP" => (bb_lower=15.1, bb_upper=32.0, sc_lower=154.7, sc_upper=158.4),
    "TYR" => (bb_lower=17.7, bb_upper=33.5, sc_lower=131.0, sc_upper=152.3),
    "VAL" => (bb_lower=15.9, bb_upper=24.9, sc_lower= 81.8, sc_upper=110.9),
)

struct _Selector{F,T} <: Function
    f::F
    residue::Ref{T}
end
(s::_Selector)(at::Atom) = s.f(at) && (at in s.residue[])

function creamer_sasa_restype(atoms::AbstractVector{<:PDBTools.Atom})
    sasas = Dict{String, Dict}()
    sasa_atoms = sasa_particles(atoms)
    sel_bb = _Selector(isbackbone, Ref(first(eachresidue(atoms))))
    sel_sc = _Selector(issidechain, Ref(first(eachresidue(atoms))))
    for res in eachresidue(atoms)
        sel_bb.residue[] = res
        sel_sc.residue[] = res
        sasa_res_bb = sasa(sasa_atoms, sel_bb)
        sasa_res_sc = sasa(sasa_atoms, sel_sc)
        rname = resname(res)
        cr = creamer_sasa[rname]
        if !haskey(sasas, rname)
            sasas[rname] = Dict(
                :sc => (
                    cr.sc_lower - sasa_res_sc, 
                    0.5 * (cr.sc_lower + cr.sc_upper) - sasa_res_sc,
                    cr.sc_upper - sasa_res_sc,
                ),
                :bb => (
                    cr.bb_lower - sasa_res_bb, 
                    0.5 * (cr.bb_lower + cr.bb_upper) - sasa_res_bb, 
                    cr.bb_upper - sasa_res_bb
                )
            ) 
        else
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
    end
    return sasas
end