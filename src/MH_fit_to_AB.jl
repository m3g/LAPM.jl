#
# deprecated
#
export fit_mh_to_ab

const tfe_sc_bb_MoeserHorinekFit0 = Dict{String,NTuple{9,Float32}}(
#                TMAO   Sarcosine     Betaine     Proline    Sorbitol    Sucrose    UreaAPP    Glycerol  Trehalose
    "ALA" => ( -14.64,      10.91,       4.77,      -0.07,      16.57,      22.05,     -4.69,      7.76,     33.25),
    "PHE" => (  -9.32,     -12.64,    -112.93,     -71.26,      26.38,     -96.35,    -83.11,     59.77,    -17.88),
    "LEU" => (  11.62,      38.33,     -17.73,       4.77,      39.07,      37.11,    -54.57,    -34.42,     96.18),
    "ILE" => ( -25.43,      39.98,      -1.27,      -2.72,      36.90,      28.12,    -38.43,     36.23,     79.66),
    "VAL" => (  -1.02,      29.32,     -19.63,       7.96,      24.65,      33.92,    -21.65,     -1.37,     96.79),
    "PRO" => (-137.73,     -34.23,    -125.16,     -63.96,      -4.48,     -73.02,    -17.65,    -60.55,    -94.67),
    "MET" => (  -7.65,       8.18,     -14.16,     -35.12,      20.97,      -6.66,    -48.34,     13.87,     29.19),
    "TRP" => (-152.87,    -113.03,    -369.93,    -198.37,     -67.23,    -215.27,   -141.46,   -122.65,   -206.30),
    "GLY" => (      0,          0,          0,          0,          0,          0,      0.00,      0.00,      0.00),
    "SER" => ( -39.04,     -27.98,     -41.85,     -33.49,      -1.58,      -2.79,    -20.56,      6.31,     -0.98),
    "THR" => (   3.57,      -7.54,       0.33,     -18.33,      13.20,      20.82,    -22.09,     17.53,     26.32),
    "TYR" => (-114.32,     -26.37,    -213.09,    -138.41,     -53.50,     -78.41,    -45.08,   -149.50,    -80.32),
    "GLN" => (  41.41,     -10.19,       7.57,     -32.26,     -23.98,     -40.87,    -54.81,     -2.76,    -36.34),
    "ASN" => (  55.69,     -40.93,      33.17,     -17.71,     -21.21,     -28.28,    -38.79,     51.57,     48.67),
    "ASP" => ( -66.67,     -14.20,    -116.56,     -90.51,     -83.88,     -37.17,      3.55,    -85.46,    -96.54),
    "GLU" => ( -83.25,     -12.61,    -112.08,     -89.17,     -70.05,     -41.65,      0.62,    -74.20,    -85.92),
    "HIS" => (  42.07,     -20.80,     -35.97,     -45.10,     -42.45,    -118.66,    -50.51,    -17.17,    -98.75),
    "LYS" => (-110.23,     -27.42,    -171.99,     -59.87,     -32.47,     -39.60,    -22.76,    -34.01,    -50.07),
    "ARG" => (-109.27,     -32.24,    -109.45,     -60.18,     -24.65,     -79.32,    -21.17,    -30.74,    -50.33),
    "CYS" => (      0,          0,          0,          0,          0,          0,      0.00,      0.00,      0.00), # not reported
    "BB"  => (     90,         52,         67,         48,         35,         62,       -39,        14,        62),
)

function gly_correction(x; cosolvent="urea", fit=true)
    cosolvent_fit = cosolvent == "urea-app" ? "urea" : cosolvent
    tfe_sc_bb = PDBTools.tfe_sc_bb(MoeserHorinekFit)
    col = PDBTools.cosolvent_column(MoeserHorinekFit)[cosolvent_fit]
    for key in keys(tfe_sc_bb)
        if !(key in ("BB", "GLY", "CYS"))
            vals = tfe_sc_bb_MoeserHorinekFit0[key]
            vals_updated = ntuple(i -> i == col ? Float32(vals[i] + x[1]) : vals[i], 9)
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
        p_mh_fit = mvalue(cmodel, cosolvent_fit; model=MoeserHorinekFit)
        tot_mh_fit[i] = p_mh_fit.tot
    end
    if !fit
        f = fitlinear(tot_ab, tot_mh_fit)
        return tot_ab, tot_mh_fit, f
    end
    return sum(abs2, tot_ab .- tot_mh_fit)
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


#
# Fit varying the backbone accessibilities
#
# Default accessibilites from surface areas - we will vary "f_bb", for urea
#
const f_acc0 = OrderedDict{String, OrderedDict{String, Float32}}(
    "ALA" => OrderedDict("n"=>179233, "sc"=>70.878, "sc_pure"=>135.348, "bb"=>49.0121, "bb_pure"=>88.8883, "f_bb"=>0.55139, "f_sc"=>0.523674),
    "PHE" => OrderedDict("n"=>91323, "sc"=>187.587, "sc_pure"=>248.851, "bb"=>38.6632, "bb_pure"=>87.374, "f_bb"=>0.442502, "f_sc"=>0.753811),
    "LEU" => OrderedDict("n"=>213010, "sc"=>159.14, "sc_pure"=>219.486, "bb"=>37.3229, "bb_pure"=>88.2639, "f_bb"=>0.422855, "f_sc"=>0.725056),
    "ILE" => OrderedDict("n"=>126589, "sc"=>159.817, "sc_pure"=>220.105, "bb"=>35.3226, "bb_pure"=>87.5728, "f_bb"=>0.403351, "f_sc"=>0.726092),
    "VAL" => OrderedDict("n"=>153028, "sc"=>133.941, "sc_pure"=>194.604, "bb"=>36.6751, "bb_pure"=>87.2728, "f_bb"=>0.420236, "f_sc"=>0.688274),
    "PRO" => OrderedDict("n"=>97983, "sc"=>130.021, "sc_pure"=>192.851, "bb"=>39.646, "bb_pure"=>91.4236, "f_bb"=>0.433651, "f_sc"=>0.674206),
    "MET" => OrderedDict("n"=>36719, "sc"=>161.456, "sc_pure"=>222.969, "bb"=>39.909, "bb_pure"=>87.8564, "f_bb"=>0.454253, "f_sc"=>0.724115),
    "TRP" => OrderedDict("n"=>31497, "sc"=>230.509, "sc_pure"=>291.634, "bb"=>37.4479, "bb_pure"=>88.0122, "f_bb"=>0.425485, "f_sc"=>0.790406),
    "GLY" => OrderedDict("n"=>151702, "sc"=>0.0, "sc_pure"=>0.0, "bb"=>87.4824, "bb_pure"=>87.4824, "f_bb"=>1.0, "f_sc"=>1.0),
    "SER" => OrderedDict("n"=>129971, "sc"=>85.2744, "sc_pure"=>148.711, "bb"=>45.9041, "bb_pure"=>87.7078, "f_bb"=>0.523376, "f_sc"=>0.573423),
    "THR" => OrderedDict("n"=>118719, "sc"=>117.741, "sc_pure"=>179.107, "bb"=>39.4432, "bb_pure"=>87.0271, "f_bb"=>0.453229, "f_sc"=>0.657378),
    "TYR" => OrderedDict("n"=>78202, "sc"=>202.043, "sc_pure"=>263.305, "bb"=>38.86, "bb_pure"=>87.3211, "f_bb"=>0.445025, "f_sc"=>0.767335),
    "GLN" => OrderedDict("n"=>82612, "sc"=>156.603, "sc_pure"=>218.196, "bb"=>40.2219, "bb_pure"=>88.4311, "f_bb"=>0.454839, "f_sc"=>0.717718),
    "ASN" => OrderedDict("n"=>93411, "sc"=>129.155, "sc_pure"=>191.405, "bb"=>40.9267, "bb_pure"=>88.7074, "f_bb"=>0.461367, "f_sc"=>0.674776),
    "ASP" => OrderedDict("n"=>125837, "sc"=>121.985, "sc_pure"=>184.224, "bb"=>41.1593, "bb_pure"=>89.0758, "f_bb"=>0.46207, "f_sc"=>0.662158),
    "GLU" => OrderedDict("n"=>142356, "sc"=>149.532, "sc_pure"=>211.134, "bb"=>40.8443, "bb_pure"=>89.038, "f_bb"=>0.458729, "f_sc"=>0.708232),
    "HIS" => OrderedDict("n"=>51092, "sc"=>165.044, "sc_pure"=>226.829, "bb"=>40.172, "bb_pure"=>87.7198, "f_bb"=>0.457958, "f_sc"=>0.727611),
    "LYS" => OrderedDict("n"=>117537, "sc"=>178.395, "sc_pure"=>240.241, "bb"=>41.6446, "bb_pure"=>88.6705, "f_bb"=>0.469655, "f_sc"=>0.742567),
    "ARG" => OrderedDict("n"=>110038, "sc"=>210.225, "sc_pure"=>272.22, "bb"=>41.319, "bb_pure"=>88.3584, "f_bb"=>0.467629, "f_sc"=>0.772262),
    "CYS" => OrderedDict("n"=>29556, "sc"=>92.4815, "sc_pure"=>155.731, "bb"=>44.936, "bb_pure"=>87.0777, "f_bb"=>0.516044, "f_sc"=>0.593854),
)

#residue = ["A",  "D",   "E", "G", "H",   "I", "K",   "L", "N",   "P",   "Q", "R", "S", "T",   "V"]
#          1.07, 1.00, 1.00, 1.00, 0.36, 0.93, 0.93, 1.07, 0.86, 1.00, 1.00, 1.07, 1.00, 0.86, 1.21

h_bonds_ratio = [
    1.07, # "ALA"
    1.00, # "PHE"
    1.07, # "LEU"
    0.93, # "ILE"
    1.21, # "VAL"
    1.00, # "PRO"
    1.00, # "MET"
    1.00, # "TRP"
    1.00, # "GLY"
    1.00, # "SER"
    0.86, # "THR"
    1.00, # "TYR"
    0.86, # "GLN"
    0.86, # "ASN"
    1.00, # "ASP"
    1.00, # "GLU"
    0.36, # "HIS"
    0.93, # "LYS"
    1.07, # "ARG"
    1.00, # "CYS"
]



#
# x in a vector of f_bb accessibilities, with 20 entries, in the order above
#
function f_bb_fit(x; cosolvent="urea", model=Accessibility, restore=false, plot=false)
    if restore
        for key in keys(PDBTools._f_acc)
            #PDBTools._f_acc[key]["f_bb"] = f_acc0[key]["f_bb"]
            PDBTools._f_acc[key]["f_bb"] = 1.0
        end
        return plot_experimental(Accessibility)
    end
    for (i, key) in enumerate(("PHE", "TYR", "TRP"))
        PDBTools._f_acc[key]["f_bb"] = x[i]
    end
    #for (i, key) in enumerate(keys(f_acc0))
    #    PDBTools._f_acc[key]["f_bb"] = x[i]
    #end
    example_structs = keys(sasa_server)
    err = 0.0
    for str in example_structs
        p = predict_mvalue(str; cosolvent, model, sasas_from=creamer_sasa)
        tot_pred = p.tot
        tot_exp = mvalues_experimental[str]["urea"]
        err += (tot_pred - tot_exp)^2
    end
    if plot
        return plot_experimental(Accessibility)
    end
    return err
end


