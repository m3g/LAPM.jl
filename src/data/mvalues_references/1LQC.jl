mvalues_moeser_horinek["1LQC"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.539, bb=-0.354, sc=-0.253), 
)

mvalues_auton_bolen["1LQC"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpzp2Gtd. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            1702        -774         927 	 | 	 (  2315)   3193 [  4070] 	 ( -1210)  -1314 [ -1419] 	 (  1105)   1878 [  2651] 
1M Sarcosine        983        -250         733 	 | 	 (  1337)   1845 [  2352] 	 (  -179)   -169 [  -159] 	 (  1158)   1675 [  2193] 
1M Betaine         1267       -1264           2 	 | 	 (  1723)   2377 [  3030] 	 ( -1965)  -2132 [ -2298] 	 (  -241)    245 [   732] 
1M Proline          908        -961         -54 	 | 	 (  1235)   1703 [  2171] 	 ( -1312)  -1424 [ -1536] 	 (   -77)    279 [   635] 
1M Glycerol         265        -488        -224 	 | 	 (   360)    497 [   633] 	 (  -747)   -802 [  -857] 	 (  -387)   -305 [  -224] 
1M Sorbitol         662        -339         323 	 | 	 (   900)   1242 [  1583] 	 (  -285)   -286 [  -287] 	 (   615)    955 [  1296] 
1M Sucrose         1172        -566         606 	 | 	 (  1595)   2199 [  2804] 	 (  -539)   -551 [  -564] 	 (  1056)   1648 [  2240] 
1M Trehalose       1172        -350         823 	 | 	 (  1595)   2199 [  2804] 	 (   109)    194 [   279] 	 (  1704)   2394 [  3083] 
1M Urea            -737         208        -529 	 | 	 ( -1003)  -1383 [ -1764] 	 (   368)    409 [   451] 	 (  -635)   -974 [ -1313] 
""")

mvalues_experimental["1LQC"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -449.0e-3,
)