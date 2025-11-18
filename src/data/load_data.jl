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
    "1LMB" => joinpath(@__DIR__, "pdb", "1LMB_clean.pdb"),
    "1POH" => joinpath(@__DIR__, "pdb", "1POH_clean.pdb"),
    "2HPR" => joinpath(@__DIR__, "pdb", "2HPR_clean.pdb"),
    "1BTA" => joinpath(@__DIR__, "pdb", "1BTA_clean.pdb"),
    "1K8M" => joinpath(@__DIR__, "pdb", "1K8M_clean.pdb"),
    "1LMB_2" => joinpath(@__DIR__, "pdb", "1LMB_2_clean.pdb"),
    "1HRC" => joinpath(@__DIR__, "pdb", "1HRC_clean.pdb"),
    "2BU4" => joinpath(@__DIR__, "pdb", "2BU4_clean.pdb"),
    "1F2F" => joinpath(@__DIR__, "pdb", "1F2F_clean.pdb"),
    "2BU4_2" => joinpath(@__DIR__, "pdb", "2BU4_2_clean.pdb"),
    "1EDH" => joinpath(@__DIR__, "pdb", "1EDH_clean.pdb"),
    "1FKD" => joinpath(@__DIR__, "pdb", "1FKD_clean.pdb"),
    "1YCC" => joinpath(@__DIR__, "pdb", "1YCC_clean.pdb"),
    "1XOA" => joinpath(@__DIR__, "pdb", "1XOA_clean.pdb"),
    "1RNB" => joinpath(@__DIR__, "pdb", "1RNB_clean.pdb"),
    "2MYO" => joinpath(@__DIR__, "pdb", "2MYO_clean.pdb"),
    "1HCE" => joinpath(@__DIR__, "pdb", "1HCE_clean.pdb"),
    "9RSA" => joinpath(@__DIR__, "pdb", "9RSA_clean.pdb"),
    "3CHY" => joinpath(@__DIR__, "pdb", "3CHY_clean.pdb"),
    "1OT8" => joinpath(@__DIR__, "pdb", "1OT8_clean.pdb"),
    "2AFG" => joinpath(@__DIR__, "pdb", "2AFG_clean.pdb"),
    "2SNS" => joinpath(@__DIR__, "pdb", "2SNS_clean.pdb"),
    "1YMB" => joinpath(@__DIR__, "pdb", "1YMB_clean.pdb"),
    "2RN2" => joinpath(@__DIR__, "pdb", "2RN2_clean.pdb"),
    "1DC2" => joinpath(@__DIR__, "pdb", "1DC2_clean.pdb"),
    "1DRB" => joinpath(@__DIR__, "pdb", "1DRB_clean.pdb"),
    "1FTG" => joinpath(@__DIR__, "pdb", "1FTG_clean.pdb"),
    "1AO3" => joinpath(@__DIR__, "pdb", "1AO3_clean.pdb"),
    "1OT8_2" => joinpath(@__DIR__, "pdb", "1OT8_2_clean.pdb"),
)

#
# SASAs
#
include("./sasa_auton_bolen_server/1CQU.jl")
include("./sasa_auton_bolen_server/1LQC.jl")
include("./sasa_auton_bolen_server/1HYW.jl")
include("./sasa_auton_bolen_server/1MJC.jl")
include("./sasa_auton_bolen_server/2CRO.jl")
include("./sasa_auton_bolen_server/3ICB.jl")
include("./sasa_auton_bolen_server/1O6X.jl")
include("./sasa_auton_bolen_server/1LMB.jl")
include("./sasa_auton_bolen_server/1POH.jl")
include("./sasa_auton_bolen_server/2HPR.jl")
include("./sasa_auton_bolen_server/1BTA.jl")
include("./sasa_auton_bolen_server/1K8M.jl")
include("./sasa_auton_bolen_server/1LMB_2.jl")
include("./sasa_auton_bolen_server/1HRC.jl")
include("./sasa_auton_bolen_server/2BU4.jl")
include("./sasa_auton_bolen_server/1F2F.jl")
include("./sasa_auton_bolen_server/2BU4_2.jl")
include("./sasa_auton_bolen_server/1EDH.jl")
include("./sasa_auton_bolen_server/1FKD.jl")
include("./sasa_auton_bolen_server/1YCC.jl")
include("./sasa_auton_bolen_server/1XOA.jl")
include("./sasa_auton_bolen_server/1RNB.jl")
include("./sasa_auton_bolen_server/2MYO.jl")
include("./sasa_auton_bolen_server/1HCE.jl")
include("./sasa_auton_bolen_server/9RSA.jl")
include("./sasa_auton_bolen_server/3CHY.jl")
include("./sasa_auton_bolen_server/1OT8.jl")
include("./sasa_auton_bolen_server/2AFG.jl")
include("./sasa_auton_bolen_server/2SNS.jl")
include("./sasa_auton_bolen_server/1YMB.jl")
include("./sasa_auton_bolen_server/2RN2.jl")
include("./sasa_auton_bolen_server/1DC2.jl")
include("./sasa_auton_bolen_server/1DRB.jl")
include("./sasa_auton_bolen_server/1FTG.jl")
include("./sasa_auton_bolen_server/1AO3.jl")
include("./sasa_auton_bolen_server/1OT8_2.jl")    




#
# m-values from references
#
include("./mvalues_references/1CQU.jl")
include("./mvalues_references/1LQC.jl")
include("./mvalues_references/1HYW.jl")
include("./mvalues_references/1MJC.jl")
include("./mvalues_references/2CRO.jl")
include("./mvalues_references/3ICB.jl")
include("./mvalues_references/1O6X.jl")
include("./mvalues_references/1LMB.jl")
include("./mvalues_references/1POH.jl")
include("./mvalues_references/2HPR.jl")
include("./mvalues_references/1BTA.jl")
include("./mvalues_references/1K8M.jl")
include("./mvalues_references/1LMB_2.jl")
include("./mvalues_references/1HRC.jl")
include("./mvalues_references/2BU4.jl")
include("./mvalues_references/1F2F.jl")
include("./mvalues_references/2BU4_2.jl")
include("./mvalues_references/1EDH.jl")
include("./mvalues_references/1FKD.jl")
include("./mvalues_references/1YCC.jl")
include("./mvalues_references/1XOA.jl")
include("./mvalues_references/1RNB.jl")
include("./mvalues_references/2MYO.jl")
include("./mvalues_references/1HCE.jl")
include("./mvalues_references/9RSA.jl")
include("./mvalues_references/3CHY.jl")
include("./mvalues_references/1OT8.jl")
include("./mvalues_references/2AFG.jl")
include("./mvalues_references/2SNS.jl")
include("./mvalues_references/1YMB.jl")
include("./mvalues_references/2RN2.jl")
include("./mvalues_references/1DC2.jl")
include("./mvalues_references/1DRB.jl")
include("./mvalues_references/1FTG.jl")
include("./mvalues_references/1AO3.jl")
include("./mvalues_references/1OT8_2.jl")


