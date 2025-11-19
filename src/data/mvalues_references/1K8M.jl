mvalues_moeser_horinek["1K8M"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.961, bb=-0.523, sc=-0.489), 
)

mvalues_auton_bolen["1K8M"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpKUA6DK. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2645       -1531        1113 	 | 	 (  3699)   5068 [  6438] 	 ( -2406)  -2609 [ -2812] 	 (  1293)   2459 [  3626] 
1M Sarcosine       1528        -302        1226 	 | 	 (  2137)   2928 [  3720] 	 (  -206)   -181 [  -157] 	 (  1931)   2747 [  3563] 
1M Betaine         1969       -2576        -607 	 | 	 (  2753)   3773 [  4793] 	 ( -4069)  -4400 [ -4732] 	 ( -1316)   -627 [    61] 
1M Proline         1411       -1664        -254 	 | 	 (  1973)   2703 [  3434] 	 ( -2485)  -2694 [ -2903] 	 (  -513)     10 [   531] 
1M Glycerol         411       -1075        -664 	 | 	 (   575)    788 [  1001] 	 ( -1560)  -1675 [ -1790] 	 (  -985)   -887 [  -788] 
1M Sorbitol        1028        -756         273 	 | 	 (  1438)   1971 [  2504] 	 (  -819)   -860 [  -901] 	 (   619)   1111 [  1602] 
1M Sucrose         1822        -775        1046 	 | 	 (  2548)   3492 [  4435] 	 (  -915)   -946 [  -978] 	 (  1633)   2545 [  3457] 
1M Trehalose       1822        -793        1029 	 | 	 (  2548)   3492 [  4435] 	 (  -412)   -343 [  -275] 	 (  2136)   3148 [  4160] 
1M Urea           -1146         445        -701 	 | 	 ( -1603)  -2196 [ -2790] 	 (   688)    770 [   852] 	 (  -915)  -1426 [ -1938] 
""")

mvalues_experimental["1K8M"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1055.0,
)