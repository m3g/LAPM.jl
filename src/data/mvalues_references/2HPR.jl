mvalues_moeser_horinek["2HPR"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.163, bb=-0.725, sc=-0.489), 
)

mvalues_auton_bolen["2HPR"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpJddvAq. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            1927        -921        1006 	 | 	 (  3664)   5001 [  6338] 	 ( -1591)  -1742 [ -1893] 	 (  2074)   3259 [  4445] 
1M Sarcosine       1113        -378         736 	 | 	 (  2117)   2890 [  3662] 	 (  -133)   -110 [   -87] 	 (  1984)   2780 [  3575] 
1M Betaine         1435       -1555        -120 	 | 	 (  2728)   3723 [  4718] 	 ( -2609)  -2828 [ -3047] 	 (   119)    896 [  1671] 
1M Proline         1028       -1171        -143 	 | 	 (  1954)   2667 [  3380] 	 ( -1732)  -1884 [ -2037] 	 (   223)    783 [  1343] 
1M Glycerol         300        -477        -177 	 | 	 (   570)    778 [   986] 	 (  -748)   -799 [  -849] 	 (  -178)    -21 [   137] 
1M Sorbitol         749        -634         116 	 | 	 (  1425)   1945 [  2465] 	 (  -380)   -381 [  -383] 	 (  1045)   1564 [  2082] 
1M Sucrose         1327        -539         788 	 | 	 (  2524)   3445 [  4366] 	 (  -381)   -371 [  -363] 	 (  2144)   3074 [  4004] 
1M Trehalose       1327        -471         857 	 | 	 (  2524)   3445 [  4366] 	 (   365)    481 [   596] 	 (  2889)   3926 [  4962] 
1M Urea            -835         435        -400 	 | 	 ( -1588)  -2167 [ -2747] 	 (   602)    666 [   729] 	 (  -986)  -1502 [ -2017]  
""")

mvalues_experimental["2HPR"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1050.0,
)