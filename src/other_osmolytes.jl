
#
# Data from the supplementary material table at: 10.1016/j.bpc.2011.05.012
#
# fields of tuple are:
#
# 1 - selection required from the PDB to obtain the proper protein atoms
# 2 - number of residues
# 3 - experimental m-value (cal/mol/M)
# 4 - AutonBolen prediciton, as reported.
#
# The structures in src/data/pdb have the atoms filtered already considering the 
# selections defined in (1)
#
ab_table = OrderedDict(
    "tmao" => OrderedDict(
        "1BTA" =>  ("protein", 89, 2420,  2312),
        "2BU4" => ("protein", 104, 1780,  1785),
        "2BU4_2" => ("protein", 104, 1480, 1785),
        "1RNB" => ("protein", 109, 1660,  1578),
        "1A6F" => ("protein", 113, 2960, 2986), 
        "2SNS" => ("protein", 141, 2550, 2856),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 2752, 3489),
        "1OT8_1-7" => ("protein and chain B", 204, 6520, 5642),
        "1OT8_4-7" => ("protein and chain B and resnum >= 117", 123, 3741, 3280),
    ), 
    "sarcosine" => OrderedDict(
        "1BTA" => ("protein", 89, 2330, 2008),
        "2BU4" => ("protein", 104, 1780, 1495),
        "1OT8" => ("protein", 123, 2793, 2798),
        "1IL8" => ("protein", 142, 451, 134),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 1581, 3518),
    ),
    "betaine" => OrederedDict(
        "2BU4" => ("protein", 104, 440, -232),
        "1OT8" => ("protein", 123, 1570, 1515), 
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 1041, 951),
    ),
    "proline" => OrderedDict(
        "2BU4" => ("protein", 104, 620, -34),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 467, 1029),
    ),
    "sorbitol" => OrederedDict(
        "2BU4" => ("protein", 104, 1380, 815),
        "1OT8" => ("protein", 123, 2049, 1821), 
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 2139, 2331),
    ),
    "sucrose" => OrderedDict(
        "2BU4" => ("protein", 104, 1550, 1058),
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 2992, 3372),
    ),
    "glycerol" => OrderedDict(
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 771, -81),
    ),
    "sorbitol" => OrderedDict(
        "1AKE" => ("protein and chain A and not resnum 110 to 164", 159, 4435, 4741),
    ),
)
