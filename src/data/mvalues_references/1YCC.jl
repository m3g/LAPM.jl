mvalues_moeser_horinek["1YCC"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.652, bb=-0.860, sc=-0.860), 
)

mvalues_auton_bolen["1YCC"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/php50Br6y. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2724       -1677        1048 	 | 	 (  4394)   6053 [  7713] 	 ( -2602)  -2795 [ -2988] 	 (  1792)   3258 [  4725] 
1M Sarcosine       1574        -424        1151 	 | 	 (  2539)   3498 [  4456] 	 (  -698)   -720 [  -742] 	 (  1841)   2777 [  3714] 
1M Betaine         2028       -2553        -525 	 | 	 (  3271)   4506 [  5742] 	 ( -4571)  -4893 [ -5216] 	 ( -1300)   -386 [   525] 
1M Proline         1453       -1493         -40 	 | 	 (  2344)   3228 [  4113] 	 ( -2739)  -2949 [ -3160] 	 (  -396)    279 [   953] 
1M Glycerol         424        -719        -295 	 | 	 (   684)    942 [  1200] 	 ( -1344)  -1432 [ -1518] 	 (  -661)   -490 [  -318] 
1M Sorbitol        1059        -618         442 	 | 	 (  1709)   2354 [  2999] 	 (  -836)   -877 [  -918] 	 (   873)   1477 [  2081] 
1M Sucrose         1877        -782        1095 	 | 	 (  3027)   4170 [  5313] 	 ( -1658)  -1746 [ -1835] 	 (  1369)   2424 [  3478] 
1M Trehalose       1877        -645        1232 	 | 	 (  3027)   4170 [  5313] 	 (  -854)   -851 [  -848] 	 (  2173)   3319 [  4466] 
1M Urea           -1181         454        -726 	 | 	 ( -1904)  -2623 [ -3342] 	 (   478)    525 [   572] 	 ( -1426)  -2098 [ -2770] 
""")

mvalues_experimental["1YCC"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1430.0,
)