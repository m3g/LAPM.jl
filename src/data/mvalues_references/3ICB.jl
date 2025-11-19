mvalues_moeser_horinek["3ICB"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.096, bb=-0.506, sc=-0.640), 
)

mvalues_auton_bolen["3ICB"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpfeRPQj. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2097       -1565         532 	 | 	 (  3188)   4437 [  5686] 	 ( -2224)  -2396 [ -2568] 	 (   964)   2042 [  3119] 
1M Sarcosine       1212        -441         770 	 | 	 (  1842)   2564 [  3285] 	 (  -312)   -324 [  -337] 	 (  1530)   2239 [  2949] 
1M Betaine         1561       -2277        -715 	 | 	 (  2374)   3303 [  4233] 	 ( -3792)  -4091 [ -4393] 	 ( -1419)   -788 [  -160] 
1M Proline         1118       -1429        -311 	 | 	 (  1700)   2367 [  3033] 	 ( -2242)  -2434 [ -2628] 	 (  -542)    -67 [   405] 
1M Glycerol         326        -867        -541 	 | 	 (   496)    690 [   885] 	 ( -1342)  -1450 [ -1557] 	 (  -846)   -760 [  -672] 
1M Sorbitol         815        -742          73 	 | 	 (  1240)   1726 [  2211] 	 (  -730)   -791 [  -851] 	 (   510)    935 [  1361] 
1M Sucrose         1445        -816         628 	 | 	 (  2196)   3057 [  3917] 	 ( -1073)  -1146 [ -1221] 	 (  1123)   1911 [  2696] 
1M Trehalose       1445       -1049         396 	 | 	 (  2196)   3057 [  3917] 	 (  -735)   -768 [  -802] 	 (  1462)   2289 [  3115] 
1M Urea            -909         515        -394 	 | 	 ( -1382)  -1923 [ -2464] 	 (   544)    597 [   649] 	 (  -837)  -1326 [ -1815] 
""")


mvalues_experimental["3ICB"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1140.0e-3,
)