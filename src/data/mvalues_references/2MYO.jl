mvalues_moeser_horinek["2MYO"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.551, bb=-0.910, sc=-0.691), 
)

mvalues_auton_bolen["2MYO"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpvzU1YM. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2785       -1571        1214 	 | 	 (  4919)   6863 [  8807] 	 ( -2664)  -2874 [ -3085] 	 (  2255)   3988 [  5722] 
1M Sarcosine       1609        -438        1171 	 | 	 (  2842)   3965 [  5088] 	 (  -212)   -187 [  -162] 	 (  2630)   3778 [  4926] 
1M Betaine         2074       -2947        -873 	 | 	 (  3662)   5109 [  6556] 	 ( -4758)  -5114 [ -5471] 	 ( -1096)     -5 [  1085] 
1M Proline         1486       -1933        -448 	 | 	 (  2623)   3660 [  4697] 	 ( -2811)  -3037 [ -3263] 	 (  -188)    624 [  1434] 
1M Glycerol         433       -1271        -837 	 | 	 (   765)   1068 [  1370] 	 ( -1948)  -2091 [ -2234] 	 ( -1183)  -1024 [  -864] 
1M Sorbitol        1083       -1051          33 	 | 	 (  1913)   2669 [  3425] 	 (  -827)   -868 [  -909] 	 (  1085)   1800 [  2516] 
1M Sucrose         1919       -1141         778 	 | 	 (  3388)   4728 [  6067] 	 ( -1207)  -1250 [ -1293] 	 (  2182)   3478 [  4774] 
1M Trehalose       1919       -1167         752 	 | 	 (  3388)   4728 [  6067] 	 (  -381)   -317 [  -252] 	 (  3007)   4411 [  5815] 
1M Urea           -1207         452        -754 	 | 	 ( -2131)  -2974 [ -3816] 	 (   640)    710 [   780] 	 ( -1491)  -2264 [ -3037]
""")

mvalues_experimental["2MYO"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1580.0,
)