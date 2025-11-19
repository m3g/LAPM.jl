mvalues_moeser_horinek["1HCE"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.601, bb=-0.910, sc=-0.758), 
)

mvalues_auton_bolen["1HCE"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpTbS3ip. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2798        -374        2424 	 | 	 (  4829)   6816 [  8802] 	 ( -1133)  -1249 [ -1366] 	 (  3697)   5566 [  7436] 
1M Sarcosine       1617        -569        1048 	 | 	 (  2790)   3938 [  5086] 	 (  -599)   -618 [  -638] 	 (  2191)   3319 [  4447] 
1M Betaine         2083       -2444        -361 	 | 	 (  3595)   5074 [  6553] 	 ( -4109)  -4445 [ -4785] 	 (  -514)    628 [  1768] 
1M Proline         1492       -1969        -476 	 | 	 (  2576)   3635 [  4694] 	 ( -2938)  -3183 [ -3431] 	 (  -363)    452 [  1264] 
1M Glycerol         435        -997        -562 	 | 	 (   751)   1060 [  1369] 	 ( -1211)  -1298 [ -1383] 	 (  -460)   -238 [   -14] 
1M Sorbitol        1088       -1369        -281 	 | 	 (  1878)   2651 [  3423] 	 ( -1297)  -1375 [ -1452] 	 (   581)   1276 [  1971] 
1M Sucrose         1928       -2610        -683 	 | 	 (  3327)   4695 [  6064] 	 ( -3024)  -3224 [ -3426] 	 (   302)   1471 [  2638] 
1M Trehalose       1928       -2308        -381 	 | 	 (  3327)   4695 [  6064] 	 ( -1974)  -2051 [ -2129] 	 (  1353)   2644 [  3935] 
1M Urea           -1213         212       -1001 	 | 	 ( -2093)  -2953 [ -3814] 	 (   344)    389 [   433] 	 ( -1749)  -2565 [ -3382] 
""")

mvalues_experimental["1HCE"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1610.0e-3,
)