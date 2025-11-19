mvalues_moeser_horinek["2AFG"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.191, bb=-1.146, sc=-1.112), 
)

mvalues_auton_bolen["2AFG"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phprhQLfa. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2564       -1825         739 	 | 	 (  5478)   7570 [  9663] 	 ( -3088)  -3326 [ -3565] 	 (  2390)   4244 [  6098] 
1M Sarcosine       1482        -598         883 	 | 	 (  3165)   4374 [  5583] 	 (  -705)   -731 [  -756] 	 (  2460)   3643 [  4827] 
1M Betaine         1909       -2913       -1004 	 | 	 (  4078)   5636 [  7194] 	 ( -5504)  -5924 [ -6345] 	 ( -1426)   -288 [   848] 
1M Proline         1368       -1900        -533 	 | 	 (  2922)   4038 [  5154] 	 ( -3497)  -3780 [ -4065] 	 (  -575)    257 [  1088] 
1M Glycerol         399       -1185        -786 	 | 	 (   852)   1178 [  1503] 	 ( -2024)  -2170 [ -2315] 	 ( -1172)   -993 [  -812] 
1M Sorbitol         997        -877         120 	 | 	 (  2130)   2944 [  3758] 	 (  -972)  -1034 [ -1095] 	 (  1159)   1911 [  2663] 
1M Sucrose         1766       -1293         474 	 | 	 (  3774)   5215 [  6657] 	 ( -2070)  -2197 [ -2325] 	 (  1703)   3019 [  4332] 
1M Trehalose       1766       -1140         626 	 | 	 (  3774)   5215 [  6657] 	 (  -972)   -977 [  -982] 	 (  2802)   4238 [  5674] 
1M Urea           -1111         530        -581 	 | 	 ( -2374)  -3281 [ -4187] 	 (   599)    664 [   727] 	 ( -1775)  -2617 [ -3460]
""")

mvalues_experimental["2AFG"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -2050.0e-3,
)