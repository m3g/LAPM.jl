mvalues_moeser_horinek["9RSA"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.551, bb=-0.876, sc=-0.742), 
)

mvalues_auton_bolen["9RSA"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpqnPo0Y. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2936       -1520        1415 	 | 	 (  5186)   7139 [  9092] 	 ( -2433)  -2639 [ -2845] 	 (  2754)   4501 [  6247] 
1M Sarcosine       1696        -764         932 	 | 	 (  2997)   4125 [  5253] 	 (  -943)   -986 [ -1030] 	 (  2054)   3139 [  4224] 
1M Betaine         2185       -2405        -220 	 | 	 (  3861)   5315 [  6769] 	 ( -4254)  -4598 [ -4944] 	 (  -393)    716 [  1824] 
1M Proline         1566       -1675        -109 	 | 	 (  2766)   3808 [  4849] 	 ( -3026)  -3285 [ -3546] 	 (  -260)    522 [  1303] 
1M Glycerol         457        -533         -77 	 | 	 (   807)   1111 [  1414] 	 (  -960)  -1023 [ -1085] 	 (  -153)     88 [   329] 
1M Sorbitol        1142        -627         514 	 | 	 (  2017)   2776 [  3536] 	 (  -862)   -899 [  -935] 	 (  1155)   1878 [  2601] 
1M Sucrose         2022        -968        1054 	 | 	 (  3573)   4918 [  6264] 	 ( -1641)  -1727 [ -1815] 	 (  1932)   3191 [  4449] 
1M Trehalose       2022        -560        1463 	 | 	 (  3573)   4918 [  6264] 	 (  -545)   -489 [  -434] 	 (  3028)   4429 [  5829] 
1M Urea           -1272         508        -764 	 | 	 ( -2247)  -3094 [ -3940] 	 (   763)    840 [   916] 	 ( -1484)  -2254 [ -3024] 
""")


mvalues_experimental["9RSA"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1280.0e-3,
)