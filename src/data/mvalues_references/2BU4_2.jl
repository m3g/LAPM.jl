mvalues_moeser_horinek["2BU4_2"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.331, bb=-0.708, sc=-0.691), 
)

mvalues_auton_bolen["2BU4_2"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpiP4Lkn. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2856        -993        1863 	 | 	 (  4406)   5910 [  7415] 	 ( -2165)  -2354 [ -2542] 	 (  2241)   3557 [  4873] 
1M Sarcosine       1650        -579        1071 	 | 	 (  2546)   3415 [  4284] 	 (  -802)   -842 [  -881] 	 (  1744)   2573 [  3403] 
1M Betaine         2126       -1623         503 	 | 	 (  3280)   4400 [  5520] 	 ( -3802)  -4117 [ -4434] 	 (  -522)    283 [  1085] 
1M Proline         1523       -1328         196 	 | 	 (  2350)   3152 [  3954] 	 ( -2732)  -2958 [ -3186] 	 (  -382)    194 [   768] 
1M Glycerol         444        -415          29 	 | 	 (   685)    919 [  1153] 	 ( -1271)  -1367 [ -1462] 	 (  -585)   -447 [  -308] 
1M Sorbitol        1111        -513         598 	 | 	 (  1713)   2298 [  2883] 	 (  -804)   -851 [  -898] 	 (   909)   1447 [  1985] 
1M Sucrose         1968        -454        1513 	 | 	 (  3035)   4071 [  5108] 	 ( -1310)  -1373 [ -1438] 	 (  1725)   2698 [  3669] 
1M Trehalose       1968        -222        1746 	 | 	 (  3035)   4071 [  5108] 	 (  -528)   -496 [  -465] 	 (  2507)   3575 [  4643] 
1M Urea           -1238         514        -724 	 | 	 ( -1909)  -2561 [ -3213] 	 (   589)    661 [   732] 	 ( -1321)  -1901 [ -2481] 
""")


mvalues_experimental["2BU4_2"] = OrderedDict(
    "tmao"      => 1780.0,
    "sarcosine" => 1780.0,
    "betaine"   => 440.0, 
    "proline"   => 620.0, 
    "glycerol"  => NaN, 
    "sorbitol"  => 1380.0, 
    "sucrose"   => 1550.0, 
    "trehalose" => NaN, 
    "urea"      => -1850.0e-3,
)