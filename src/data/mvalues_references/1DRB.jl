mvalues_moeser_horinek["1DRB"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.461, bb=-1.096, sc=-1.449), 
)

mvalues_auton_bolen["1DRB"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpUSzy1r. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            4142       -2312        1830 	 | 	 (  6662)   9201 [ 11740] 	 ( -4451)  -4797 [ -5143] 	 (  2211)   4404 [  6596] 
1M Sarcosine       2393        -636        1757 	 | 	 (  3849)   5316 [  6783] 	 (  -845)   -826 [  -806] 	 (  3004)   4490 [  5977] 
1M Betaine         3083       -3539        -456 	 | 	 (  4959)   6849 [  8740] 	 ( -7161)  -7669 [ -8180] 	 ( -2202)   -819 [   560] 
1M Proline         2209       -2531        -322 	 | 	 (  3553)   4907 [  6261] 	 ( -4608)  -4959 [ -5311] 	 ( -1055)    -52 [   950] 
1M Glycerol         644       -1540        -895 	 | 	 (  1036)   1431 [  1826] 	 ( -2382)  -2518 [ -2652] 	 ( -1346)  -1087 [  -825] 
1M Sorbitol        1611       -1322         289 	 | 	 (  2591)   3578 [  4565] 	 ( -1200)  -1241 [ -1281] 	 (  1390)   2337 [  3285] 
1M Sucrose         2853       -1643        1211 	 | 	 (  4589)   6338 [  8087] 	 ( -2853)  -2967 [ -3084] 	 (  1736)   3371 [  5004] 
1M Trehalose       2853       -1832        1021 	 | 	 (  4589)   6338 [  8087] 	 ( -1584)  -1509 [ -1434] 	 (  3006)   4830 [  6653] 
1M Urea           -1795         776       -1019 	 | 	 ( -2887)  -3987 [ -5087] 	 (   730)    834 [   938] 	 ( -2157)  -3153 [ -4149] 
""")

mvalues_experimental["1DRB"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1900.0,
)