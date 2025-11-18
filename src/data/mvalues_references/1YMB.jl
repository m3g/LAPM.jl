mvalues_moeser_horinek["1YMB"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.579, bb=-1.230, sc=-1.416), 
)

mvalues_auton_bolen["1YMB"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpTEvBc9. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3113       -2098        1016 	 | 	 (  6409)   8942 [ 11475] 	 ( -3436)  -3702 [ -3968] 	 (  2972)   5240 [  7506] 
1M Sarcosine       1799        -565        1234 	 | 	 (  3703)   5166 [  6630] 	 (  -451)   -425 [  -400] 	 (  3252)   4741 [  6230] 
1M Betaine         2318       -3536       -1218 	 | 	 (  4771)   6657 [  8542] 	 ( -6535)  -7000 [ -7470] 	 ( -1764)   -343 [  1073] 
1M Proline         1660       -2251        -590 	 | 	 (  3418)   4769 [  6120] 	 ( -3856)  -4158 [ -4462] 	 (  -438)    611 [  1658] 
1M Glycerol         484       -1290        -805 	 | 	 (   997)   1391 [  1785] 	 ( -1968)  -2090 [ -2210] 	 (  -971)   -699 [  -425] 
1M Sorbitol        1211       -1222         -12 	 | 	 (  2492)   3477 [  4462] 	 ( -1064)  -1105 [ -1145] 	 (  1428)   2372 [  3317] 
1M Sucrose         2145       -1454         691 	 | 	 (  4415)   6160 [  7905] 	 ( -2331)  -2439 [ -2551] 	 (  2084)   3721 [  5354] 
1M Trehalose       2145       -1615         529 	 | 	 (  4415)   6160 [  7905] 	 ( -1175)  -1130 [ -1084] 	 (  3239)   5030 [  6820] 
1M Urea           -1349         695        -655 	 | 	 ( -2777)  -3875 [ -4972] 	 (   575)    645 [   712] 	 ( -2202)  -3230 [ -4260] 
""")