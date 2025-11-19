mvalues_moeser_horinek["1XOA"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.601, bb=-0.775, sc=-0.893), 
)

mvalues_auton_bolen["1XOA"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpAI43MI. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2749       -1568        1181 	 | 	 (  4547)   6282 [  8018] 	 ( -2582)  -2780 [ -2979] 	 (  1965)   3502 [  5038] 
1M Sarcosine       1589        -417        1172 	 | 	 (  2627)   3630 [  4632] 	 (  -219)   -181 [  -144] 	 (  2408)   3448 [  4489] 
1M Betaine         2047       -2445        -398 	 | 	 (  3385)   4677 [  5969] 	 ( -4377)  -4680 [ -4985] 	 (  -992)     -3 [   983] 
1M Proline         1466       -1581        -115 	 | 	 (  2425)   3351 [  4276] 	 ( -2611)  -2808 [ -3007] 	 (  -186)    542 [  1269] 
1M Glycerol         428        -960        -532 	 | 	 (   707)    977 [  1247] 	 ( -1404)  -1482 [ -1560] 	 (  -696)   -505 [  -313] 
1M Sorbitol        1069        -769         300 	 | 	 (  1768)   2443 [  3118] 	 (  -551)   -557 [  -564] 	 (  1217)   1886 [  2554] 
1M Sucrose         1894        -917         977 	 | 	 (  3132)   4328 [  5523] 	 ( -1097)  -1116 [ -1136] 	 (  2035)   3212 [  4387] 
1M Trehalose       1894       -1095         799 	 | 	 (  3132)   4328 [  5523] 	 (  -248)   -149 [   -50] 	 (  2884)   4179 [  5473] 
1M Urea           -1191         435        -756 	 | 	 ( -1970)  -2722 [ -3474] 	 (   477)    535 [   592] 	 ( -1494)  -2188 [ -2883] 
""")

mvalues_experimental["1XOA"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1300.0,
)