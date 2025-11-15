#
# To add a new protein to the list, update the following three lists, including in
# each case the appropriate files, following the examples.
#
# Server for SASA and m-value calculations: http://best.bio.jhu.edu/mvalue/
#

#
# PDB files
#
# IMPORTANT: provide "clean" files, without anything else but the protein.
#            the server to fill the SASA and m-values must be run with the 
#            same "clean" structure. 
#
const pdb_files = OrderedDict{String,String}(
    "1CQU" => joinpath(@__DIR__, "pdb", "1CQU_clean.pdb"),
    "1LQC" => joinpath(@__DIR__, "pdb", "1LQC_clean.pdb"),
    "1HYW" => joinpath(@__DIR__, "pdb", "1HYW_clean.pdb"),
    "1MJC" => joinpath(@__DIR__, "pdb", "1MJC_clean.pdb"),
    "2CRO" => joinpath(@__DIR__, "pdb", "2CRO_clean.pdb"),
    "3ICB" => joinpath(@__DIR__, "pdb", "3ICB_clean.pdb"),
    "1O6X" => joinpath(@__DIR__, "pdb", "1O6X_clean.pdb"),

    "1POH" => joinpath(@__DIR__, "pdb", "1POH_clean.pdb"),
    "2HPR" => joinpath(@__DIR__, "pdb", "2HPR_clean.pdb"),
    "1BTA" => joinpath(@__DIR__, "pdb", "1BTA_clean.pdb"),
    "1K8M" => joinpath(@__DIR__, "pdb", "1K8M_clean.pdb"),

    "1HRC" => joinpath(@__DIR__, "pdb", "1HRC_clean.pdb"),

    "1F2F" => joinpath(@__DIR__, "pdb", "1F2F_clean.pdb"),

    "1EDH" => joinpath(@__DIR__, "pdb", "1EDH_clean.pdb"),
    "1FKD" => joinpath(@__DIR__, "pdb", "1FKD_clean.pdb"),
    "1YCC" => joinpath(@__DIR__, "pdb", "1YCC_clean.pdb"),
    "1XOA" => joinpath(@__DIR__, "pdb", "1XOA_clean.pdb"),
    "1RNB" => joinpath(@__DIR__, "pdb", "1RNB_clean.pdb"),
    "2MYO" => joinpath(@__DIR__, "pdb", "2MYO_clean.pdb"),
    "1HCE" => joinpath(@__DIR__, "pdb", "1HCE_clean.pdb"),
    "9RSA" => joinpath(@__DIR__, "pdb", "9RSA_clean.pdb"),
    "3CHY" => joinpath(@__DIR__, "pdb", "3CHY_clean.pdb"),

    "2AFG" => joinpath(@__DIR__, "pdb", "2AFG_clean.pdb"),
    "2SNS" => joinpath(@__DIR__, "pdb", "2SNS_clean.pdb"),
    "1YMB" => joinpath(@__DIR__, "pdb", "1YMB_clean.pdb"),
    "2RN2" => joinpath(@__DIR__, "pdb", "2RN2_clean.pdb"),
    "1DC2" => joinpath(@__DIR__, "pdb", "1DC2_clean.pdb"),
    "1DRB" => joinpath(@__DIR__, "pdb", "1DRB_clean.pdb"),
    "1FTG" => joinpath(@__DIR__, "pdb", "1FTG_clean.pdb"),
    "1AO3" => joinpath(@__DIR__, "pdb", "1AO3_clean.pdb"),
)

#
# SASAs
#
include("./sasa_auton_bolen_server/1MJC.jl")
include("./sasa_auton_bolen_server/2RN2.jl")

#
# m-values from references
#
include("./mvalues_references/1MJC.jl")
include("./mvalues_references/2RN2.jl")

