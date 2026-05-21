
export fit_mh_to_ab

const tfe_sc_bb_MoeserHorinekFit0 = Dict{String, NTuple{7,Float32}}(
#                TMAO    Sarcosine     Betaine     Proline    Sorbitol    Sucrose       Urea 
    "ALA" => ( -14.64,       10.91,       4.77,      -0.07,      16.57,      22.05,     -4.69),
    "PHE" => (  -9.32,      -12.64,    -112.93,     -71.26,      26.38,     -96.35,    -83.11),
    "LEU" => (  11.62,       38.33,     -17.73,       4.77,      39.07,      37.11,    -54.57),
    "ILE" => ( -25.43,       39.98,      -1.27,      -2.72,      36.90,      28.12,    -38.43),
    "VAL" => (  -1.02,       29.32,     -19.63,       7.96,      24.65,      33.92,    -21.65),
    "PRO" => (-137.73,      -34.23,    -125.16,     -63.96,      -4.48,     -73.02,    -17.65),
    "MET" => (  -7.65,        8.18,     -14.16,     -35.12,      20.97,      -6.66,    -48.34),
    "TRP" => (-152.87,     -113.03,    -369.93,    -198.37,     -67.23,    -215.27,   -141.46),
    "GLY" => (      0,           0,          0,          0,          0,          0,         0),
    "SER" => ( -39.04,      -27.98,     -41.85,     -33.49,      -1.58,      -2.79,    -20.56),
    "THR" => (   3.57,       -7.54,       0.33,     -18.33,      13.20,      20.82,    -22.09),
    "TYR" => (-114.32,      -26.37,    -213.09,    -138.41,     -53.50,     -78.41,    -45.08),
    "GLN" => (  41.41,      -10.19,       7.57,     -32.26,     -23.98,     -40.87,    -54.81),
    "ASN" => (  55.69,      -40.93,      33.17,     -17.71,     -21.21,     -28.28,    -38.79),
    "ASP" => ( -66.67,      -14.20,    -116.56,     -90.51,     -83.88,     -37.17,      3.55),
    "GLU" => ( -83.25,      -12.61,    -112.08,     -89.17,     -70.05,     -41.65,      0.62),
    "HIS" => (  42.07,      -20.80,     -35.97,     -45.10,     -42.45,    -118.66,    -50.51),
    "LYS" => (-110.23,      -27.42,    -171.99,     -59.87,     -32.47,     -39.60,    -22.76),
    "ARG" => (-109.27,      -32.24,    -109.45,     -60.18,     -24.65,     -79.32,    -21.17),
    "CYS" => (   0.00,           0,          0,          0,          0,          0,         0),
    "BB"  => (     90,          52,         67,         48,         35,         62,       -39),
)

function gly_correction(x; cosolvent="urea", fit=true)
    tfe_sc_bb = PDBTools.tfe_sc_bb(MoeserHorinekFit)
    col = PDBTools.cosolvent_column(MoeserHorinekFit)[cosolvent]
    for key in keys(tfe_sc_bb)
        if !(key in ("BB", "GLY", "CYS"))
            vals = tfe_sc_bb_MoeserHorinekFit0[key]
            vals_updated = ntuple(i -> i == col ? Float32(vals[i] + x[1]) : vals[i], 7)
            tfe_sc_bb[key] = vals_updated
        end
    end
    example_structs = keys(sasa_server)
    nexamples = length(example_structs)
    tot_ab = zeros(nexamples)
    tot_mh_fit = zeros(nexamples)
    for (i, str) in enumerate(example_structs)
        cmodel = CreamerDenaturedModel(read_pdb(pdb_files[str]))
        p_ab = mvalue(cmodel, cosolvent; model=AutonBolen)
        tot_ab[i] = p_ab.tot
        p_mh_fit = mvalue(cmodel, cosolvent; model=MoeserHorinekFit)
        tot_mh_fit[i] = p_mh_fit.tot
    end
    if !fit
        f = fitlinear(tot_ab, tot_mh_fit)
        return tot_ab, tot_mh_fit, f
    end
    return sum(abs2, p_ab .- tot_ab)
end

#=

using BlackBoxOptim
bboptimize(
    x -> LAPM.gly_correction(x; cosolvent="tmao"), 
    [70.0]; 
    SearchRange=(-200, 200), 
    NumDimensions=1, 
    MaxTime=600, 
)

Best fits:

# These where obtained by minmizing the sum of squared residues relative to AutonBolen predictions
# using: BlackBoxOptim.jl - BlackBoxOptim.AdaptiveDiffEvoRandBin{3}
#               TMAO  Sarcosine   Betaine    Proline    Sorbitol    Sucrose       Urea
const γG =   ( 47.74,     27.57,    35.57,     25.44,      18.57,     32.91,     14.74)

=#
