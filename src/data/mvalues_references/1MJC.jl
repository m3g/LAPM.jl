mvalues_moeser_horinek["1MJC"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.847, bb=-0.441, sc=-0.441), 
)

mvalues_auton_bolen["1MJC"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpFEMg4i. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2245        -952        1293 	 | 	 (  3003)   4056 [  5108] 	 ( -1487)  -1603 [ -1720] 	 (  1517)   2453 [  3388] 
1M Sarcosine       1297        -359         938 	 | 	 (  1735)   2343 [  2951] 	 (  -392)   -395 [  -399] 	 (  1344)   1948 [  2552] 
1M Betaine         1671       -1723         -51 	 | 	 (  2236)   3019 [  3803] 	 ( -2789)  -2994 [ -3203] 	 (  -553)     25 [   599] 
1M Proline         1197       -1119          79 	 | 	 (  1602)   2163 [  2724] 	 ( -1723)  -1858 [ -1996] 	 (  -121)    304 [   728] 
1M Glycerol         349        -363         -14 	 | 	 (   467)    631 [   795] 	 (  -420)   -436 [  -451] 	 (    47)    195 [   344] 
1M Sorbitol         873        -457         416 	 | 	 (  1168)   1577 [  1986] 	 (  -373)   -381 [  -388] 	 (   795)   1196 [  1599] 
1M Sucrose         1547        -613         934 	 | 	 (  2069)   2794 [  3519] 	 (  -946)   -984 [ -1026] 	 (  1123)   1810 [  2493] 
1M Trehalose       1547        -531        1016 	 | 	 (  2069)   2794 [  3519] 	 (  -355)   -313 [  -271] 	 (  1714)   2481 [  3247] 
1M Urea            -973         252        -721 	 | 	 ( -1301)  -1757 [ -2213] 	 (   288)    325 [   361] 	 ( -1014)  -1433 [ -1853] 
""")

mvalues_experimental["1MJC"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -710.0,
)
