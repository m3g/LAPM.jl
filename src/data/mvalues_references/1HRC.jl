mvalues_moeser_horinek["1HRC"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.584, bb=-0.860, sc=-0.775), 
)

mvalues_auton_bolen["1HRC"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpjNG6mc. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2272       -1882         391 	 | 	 (  4453)   6137 [  7821] 	 ( -2999)  -3213 [ -3426] 	 (  1454)   2924 [  4395] 
1M Sarcosine       1313        -492         821 	 | 	 (  2573)   3546 [  4519] 	 (  -665)   -677 [  -689] 	 (  1908)   2869 [  3830] 
1M Betaine         1692       -2987       -1295 	 | 	 (  3315)   4569 [  5822] 	 ( -5116)  -5465 [ -5817] 	 ( -1801)   -897 [     5] 
1M Proline         1212       -1686        -474 	 | 	 (  2375)   3273 [  4171] 	 ( -2925)  -3146 [ -3369] 	 (  -550)    127 [   802] 
1M Glycerol         353        -857        -504 	 | 	 (   693)    955 [  1217] 	 ( -1366)  -1450 [ -1532] 	 (  -674)   -495 [  -315] 
1M Sorbitol         884        -824          60 	 | 	 (  1732)   2387 [  3041] 	 (  -919)   -964 [ -1009] 	 (   812)   1422 [  2033] 
1M Sucrose         1565        -962         603 	 | 	 (  3068)   4228 [  5388] 	 ( -1711)  -1800 [ -1892] 	 (  1357)   2427 [  3496] 
1M Trehalose       1565       -1011         555 	 | 	 (  3068)   4228 [  5388] 	 ( -1091)  -1097 [ -1103] 	 (  1977)   3131 [  4285] 
1M Urea            -985         531        -454 	 | 	 ( -1930)  -2659 [ -3389] 	 (   559)    611 [   662] 	 ( -1371)  -2048 [ -2727] 
""")

mvalues_experimental["1HRC"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1200.0e-3,
)