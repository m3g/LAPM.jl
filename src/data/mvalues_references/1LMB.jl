mvalues_moeser_horinek["1LMB"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.146, bb=-0.624, sc=-0.590), 
)

mvalues_auton_bolen["1LMB"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/php2VBEfx. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2056       -1363         692 	 | 	 (  3378)   4681 [  5984] 	 ( -1800)  -1960 [ -2121] 	 (  1578)   2721 [  3863] 
1M Sarcosine       1188        -398         790 	 | 	 (  1952)   2705 [  3457] 	 (  -177)   -164 [  -152] 	 (  1775)   2540 [  3306] 
1M Betaine         1530       -1992        -462 	 | 	 (  2515)   3485 [  4455] 	 ( -2886)  -3120 [ -3355] 	 (  -371)    365 [  1099] 
1M Proline         1096       -1350        -254 	 | 	 (  1802)   2497 [  3192] 	 ( -1830)  -1991 [ -2152] 	 (   -29)    506 [  1039] 
1M Glycerol         320        -746        -426 	 | 	 (   525)    728 [   931] 	 (  -915)   -978 [ -1040] 	 (  -390)   -250 [  -109] 
1M Sorbitol         799        -601         199 	 | 	 (  1314)   1820 [  2327] 	 (  -369)   -377 [  -384] 	 (   945)   1444 [  1943] 
1M Sucrose         1416        -763         653 	 | 	 (  2327)   3225 [  4122] 	 (  -704)   -731 [  -760] 	 (  1624)   2493 [  3362] 
1M Trehalose       1416        -637         779 	 | 	 (  2327)   3225 [  4122] 	 (   156)    233 [   310] 	 (  2483)   3458 [  4433] 
1M Urea            -891         375        -516 	 | 	 ( -1464)  -2028 [ -2593] 	 (   405)    447 [   488] 	 ( -1059)  -1582 [ -2105] 
""")

mvalues_experimental["1LMB"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -990.0e-3,
)