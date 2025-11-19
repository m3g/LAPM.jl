mvalues_moeser_horinek["1FKD"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.5, bb=-0.792, sc=-0.758), 
)

mvalues_auton_bolen["1FKD"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpCEHto2. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2910       -1746        1164 	 | 	 (  4600)   6265 [  7931] 	 ( -2864)  -3078 [ -3292] 	 (  1736)   3187 [  4639] 
1M Sarcosine       1681        -500        1182 	 | 	 (  2658)   3620 [  4582] 	 (  -485)   -483 [  -481] 	 (  2173)   3137 [  4101] 
1M Betaine         2166       -2605        -439 	 | 	 (  3424)   4664 [  5904] 	 ( -4607)  -4954 [ -5304] 	 ( -1183)   -290 [   600] 
1M Proline         1552       -1645         -93 	 | 	 (  2453)   3342 [  4230] 	 ( -2817)  -3043 [ -3270] 	 (  -364)    299 [   960] 
1M Glycerol         453        -885        -432 	 | 	 (   716)    975 [  1234] 	 ( -1443)  -1535 [ -1626] 	 (  -727)   -560 [  -392] 
1M Sorbitol        1132        -695         436 	 | 	 (  1789)   2437 [  3084] 	 (  -658)   -685 [  -711] 	 (  1131)   1752 [  2374] 
1M Sucrose         2004       -1235         769 	 | 	 (  3169)   4316 [  5463] 	 ( -1715)  -1804 [ -1894] 	 (  1453)   2513 [  3569] 
1M Trehalose       2004       -1198         806 	 | 	 (  3169)   4316 [  5463] 	 (  -925)   -891 [  -858] 	 (  2244)   3425 [  4606] 
1M Urea           -1261         428        -833 	 | 	 ( -1993)  -2715 [ -3437] 	 (   589)    653 [   717] 	 ( -1404)  -2062 [ -2720] 
""")

mvalues_experimental["1FKD"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1460.0,
)