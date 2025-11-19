mvalues_moeser_horinek["1O6X"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.944, bb=-0.489, sc=-0.522), 
)

mvalues_auton_bolen["1O6X"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpkWIyN6. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2364       -1055        1309 	 | 	 (  3372)   4677 [  5981] 	 ( -1495)  -1615 [ -1734] 	 (  1877)   3062 [  4247] 
1M Sarcosine       1366        -224        1142 	 | 	 (  1948)   2702 [  3456] 	 (  -172)   -148 [  -125] 	 (  1776)   2554 [  3331] 
1M Betaine         1760       -2036        -276 	 | 	 (  2510)   3482 [  4453] 	 ( -2853)  -3082 [ -3313] 	 (  -343)    400 [  1140] 
1M Proline         1261       -1496        -235 	 | 	 (  1798)   2494 [  3190] 	 ( -1976)  -2141 [ -2308] 	 (  -178)    353 [   882] 
1M Glycerol         368        -590        -222 	 | 	 (   525)    727 [   930] 	 (  -857)   -912 [  -965] 	 (  -332)   -184 [   -35] 
1M Sorbitol         919        -476         444 	 | 	 (  1311)   1819 [  2326] 	 (  -388)   -397 [  -405] 	 (   924)   1422 [  1921] 
1M Sucrose         1629        -821         808 	 | 	 (  2323)   3222 [  4121] 	 ( -1039)  -1082 [ -1127] 	 (  1284)   2140 [  2993] 
1M Trehalose       1629        -392        1236 	 | 	 (  2323)   3222 [  4121] 	 (   -97)     -9 [    79] 	 (  2226)   3213 [  4200] 
1M Urea           -1024         325        -700 	 | 	 ( -1461)  -2027 [ -2592] 	 (   368)    418 [   466] 	 ( -1093)  -1609 [ -2126] 
""")

mvalues_experimental["1O6X"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -960.0e-3,
)