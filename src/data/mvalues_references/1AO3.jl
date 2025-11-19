mvalues_moeser_horinek["1AO3"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.983, bb=-1.584, sc=-1.466), 
)

mvalues_auton_bolen["1AO3"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpWCjn0g. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3599       -2165        1434 	 | 	 (  7909)  10789 [ 13670] 	 ( -3959)  -4294 [ -4628] 	 (  3950)   6496 [  9042] 
1M Sarcosine       2079        -635        1444 	 | 	 (  4570)   6234 [  7898] 	 (  -321)   -267 [  -214] 	 (  4249)   5967 [  7684] 
1M Betaine         2679       -3026        -347 	 | 	 (  5888)   8032 [ 10176] 	 ( -6276)  -6784 [ -7296] 	 (  -388)   1248 [  2880] 
1M Proline         1919       -2108        -188 	 | 	 (  4218)   5754 [  7290] 	 ( -3940)  -4267 [ -4597] 	 (   279)   1487 [  2694] 
1M Glycerol         560       -1082        -523 	 | 	 (  1230)   1678 [  2126] 	 ( -1843)  -1950 [ -2055] 	 (  -613)   -272 [    72] 
1M Sorbitol        1400        -799         600 	 | 	 (  3076)   4196 [  5316] 	 (  -361)   -324 [  -286] 	 (  2715)   3872 [  5030] 
1M Sucrose         2479       -1314        1165 	 | 	 (  5449)   7433 [  9417] 	 ( -1650)  -1680 [ -1714] 	 (  3798)   5753 [  7703] 
1M Trehalose       2479       -1063        1416 	 | 	 (  5449)   7433 [  9417] 	 (   465)    734 [  1002] 	 (  5914)   8167 [ 10418] 
1M Urea           -1560         735        -824 	 | 	 ( -3427)  -4675 [ -5924] 	 (   991)   1108 [  1224] 	 ( -2436)  -3567 [ -4700] 
""")

mvalues_experimental["1AO3"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -2190.0,
)