mvalues_moeser_horinek["2RN2"] = Dict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.364, bb=-1.120, sc=-1.165), 
)

mvalues_auton_bolen["2RN2"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/php1s2keG. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3573       -1945        1629 	 | 	 (  6503)   9027 [ 11551] 	 ( -3897)  -4183 [ -4470] 	 (  2606)   4844 [  7081] 
1M Sarcosine       2065        -715        1349 	 | 	 (  3758)   5216 [  6674] 	 (  -998)  -1000 [ -1001] 	 (  2759)   4216 [  5673] 
1M Betaine         2660       -3334        -674 	 | 	 (  4841)   6720 [  8599] 	 ( -6816)  -7264 [ -7713] 	 ( -1975)   -544 [   886] 
1M Proline         1906       -2207        -301 	 | 	 (  3468)   4815 [  6161] 	 ( -4337)  -4651 [ -4966] 	 (  -869)    164 [  1195] 
1M Glycerol         556       -1093        -537 	 | 	 (  1012)   1404 [  1797] 	 ( -2356)  -2497 [ -2637] 	 ( -1344)  -1092 [  -840] 
1M Sorbitol        1390       -1011         379 	 | 	 (  2529)   3511 [  4492] 	 ( -1321)  -1375 [ -1430] 	 (  1208)   2135 [  3062] 
1M Sucrose         2462       -1698         764 	 | 	 (  4480)   6219 [  7957] 	 ( -2764)  -2877 [ -2992] 	 (  1716)   3341 [  4966] 
1M Trehalose       2462       -1341        1121 	 | 	 (  4480)   6219 [  7957] 	 ( -1496)  -1445 [ -1394] 	 (  2985)   4774 [  6563] 
1M Urea           -1548         445       -1104 	 | 	 ( -2818)  -3912 [ -5005] 	 (   497)    582 [   666] 	 ( -2321)  -3330 [ -4340] 
""")

mvalues_experimental["2RN2"] = Dict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1930.0,
)
