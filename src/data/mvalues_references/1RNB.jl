mvalues_moeser_horinek["1RNB"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.652, bb=-0.792, sc=-0.944), 
)

mvalues_auton_bolen["1RNB"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpXiTPfN. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2915       -1218        1697 	 | 	 (  4656)   6380 [  8104] 	 ( -2879)  -3105 [ -3332] 	 (  1777)   3274 [  4772] 
1M Sarcosine       1684        -503        1182 	 | 	 (  2690)   3686 [  4682] 	 (  -811)   -830 [  -850] 	 (  1879)   2856 [  3832] 
1M Betaine         2170       -2125          45 	 | 	 (  3466)   4749 [  6033] 	 ( -5039)  -5395 [ -5754] 	 ( -1573)   -646 [   279] 
1M Proline         1555       -1486          68 	 | 	 (  2483)   3403 [  4322] 	 ( -3239)  -3484 [ -3731] 	 (  -756)    -82 [   591] 
1M Glycerol         453        -584        -130 	 | 	 (   724)    992 [  1261] 	 ( -1538)  -1629 [ -1719] 	 (  -814)   -637 [  -458] 
1M Sorbitol        1134        -582         551 	 | 	 (  1810)   2481 [  3152] 	 (  -907)   -947 [  -987] 	 (   904)   1534 [  2164] 
1M Sucrose         2008        -838        1170 	 | 	 (  3207)   4395 [  5583] 	 ( -1873)  -1961 [ -2051] 	 (  1334)   2434 [  3532] 
1M Trehalose       2008        -648        1361 	 | 	 (  3207)   4395 [  5583] 	 (  -953)   -930 [  -906] 	 (  2254)   3465 [  4676] 
1M Urea           -1263         401        -862 	 | 	 ( -2017)  -2765 [ -3512] 	 (   435)    497 [   557] 	 ( -1582)  -2268 [ -2955] 
""")

mvalues_experimental["1RNB"] = OrderedDict(
    "tmao"      => 1660.0,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1940.0e-3,
)