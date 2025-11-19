mvalues_moeser_horinek["3CHY"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.972, bb=-1.045, sc=-0.978), 
)

mvalues_auton_bolen["3CHY"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpISn2z8. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2470       -1480         990 	 | 	 (  5051)   7019 [  8988] 	 ( -2668)  -2896 [ -3124] 	 (  2383)   4124 [  5864] 
1M Sarcosine       1427        -385        1042 	 | 	 (  2918)   4056 [  5193] 	 (  -139)    -95 [   -51] 	 (  2780)   3961 [  5142] 
1M Betaine         1839       -2228        -389 	 | 	 (  3760)   5226 [  6691] 	 ( -4498)  -4848 [ -5201] 	 (  -738)    378 [  1490] 
1M Proline         1317       -1507        -190 	 | 	 (  2694)   3744 [  4794] 	 ( -2701)  -2926 [ -3153] 	 (    -7)    818 [  1640] 
1M Glycerol         384        -595        -210 	 | 	 (   786)   1092 [  1398] 	 ( -1204)  -1282 [ -1357] 	 (  -419)   -190 [    41] 
1M Sorbitol         961        -624         337 	 | 	 (  1964)   2730 [  3495] 	 (  -449)   -443 [  -435] 	 (  1515)   2287 [  3060] 
1M Sucrose         1702        -736         966 	 | 	 (  3480)   4836 [  6192] 	 ( -1019)  -1038 [ -1059] 	 (  2461)   3798 [  5132] 
1M Trehalose       1702        -532        1169 	 | 	 (  3480)   4836 [  6192] 	 (   320)    477 [   632] 	 (  3800)   5312 [  6824] 
1M Urea           -1070         473        -597 	 | 	 ( -2189)  -3042 [ -3895] 	 (   601)    671 [   740] 	 ( -1588)  -2371 [ -3155] 
""")

mvalues_experimental["3CHY"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1600.0e-3,
)