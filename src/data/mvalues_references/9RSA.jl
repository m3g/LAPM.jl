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
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpXzkatK. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            5117       -2518        2598 	 | 	 ( 10373)  14279 [ 18185] 	 ( -4865)  -5277 [ -5690] 	 (  5507)   9001 [ 12495] 
1M Sarcosine       2956       -1443        1513 	 | 	 (  5993)   8250 [ 10507] 	 ( -1885)  -1972 [ -2060] 	 (  4108)   6278 [  8447] 
1M Betaine         3809       -4133        -324 	 | 	 (  7722)  10630 [ 13537] 	 ( -8508)  -9197 [ -9889] 	 (  -786)   1433 [  3648] 
1M Proline         2729       -3003        -274 	 | 	 (  5532)   7615 [  9698] 	 ( -6052)  -6571 [ -7092] 	 (  -520)   1044 [  2607] 
1M Glycerol         796        -878         -82 	 | 	 (  1614)   2221 [  2829] 	 ( -1920)  -2046 [ -2170] 	 (  -306)    175 [   659] 
1M Sorbitol        1990       -1187         803 	 | 	 (  4034)   5553 [  7072] 	 ( -1724)  -1798 [ -1870] 	 (  2310)   3755 [  5201] 
1M Sucrose         3525       -1740        1785 	 | 	 (  7146)   9836 [ 12527] 	 ( -3282)  -3454 [ -3629] 	 (  3864)   6382 [  8898] 
1M Trehalose       3525       -1069        2455 	 | 	 (  7146)   9836 [ 12527] 	 ( -1089)   -979 [  -869] 	 (  6057)   8858 [ 11659] 
1M Urea           -2217         876       -1342 	 | 	 ( -4495)  -6187 [ -7880] 	 (  1526)   1680 [  1833] 	 ( -2969)  -4507 [ -6047] 
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