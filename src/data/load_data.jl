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
    "1MJC" => "./pdb/1MJC_clean.pdb",
    "2RN2" => "./pdb/2RN2_clean.pdb",
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

