mvalues_moeser_horinek["1EDH"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.300, bb=-1.298, sc=-0.590), 
)

mvalues_auton_bolen["1EDH"] = parse_mvalue_server("""
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2739       -1403        1335 	 | 	 (  4540)   6158 [  7776] 	 ( -2078)  -2263 [ -2449] 	 (  2463)   3895 [  5327] 
1M Sarcosine       1582        -369        1213 	 | 	 (  2623)   3558 [  4493] 	 (  -243)   -221 [  -200] 	 (  2380)   3337 [  4293] 
1M Betaine         2039       -2278        -240 	 | 	 (  3380)   4584 [  5789] 	 ( -3467)  -3771 [ -4076] 	 (   -87)    814 [  1713] 
1M Proline         1461       -1649        -189 	 | 	 (  2422)   3284 [  4147] 	 ( -2418)  -2629 [ -2842] 	 (     3)    655 [  1305] 
1M Glycerol         426        -974        -548 	 | 	 (   706)    958 [  1210] 	 ( -1151)  -1237 [ -1321] 	 (  -445)   -279 [  -112] 
1M Sorbitol        1065        -733         333 	 | 	 (  1766)   2395 [  3024] 	 (  -513)   -524 [  -534] 	 (  1253)   1871 [  2489] 
1M Sucrose         1887        -610        1277 	 | 	 (  3128)   4242 [  5357] 	 (  -701)   -706 [  -713] 	 (  2427)   3536 [  4644] 
1M Trehalose       1887        -520        1367 	 | 	 (  3128)   4242 [  5357] 	 (   160)    294 [   428] 	 (  3288)   4536 [  5785] 
1M Urea           -1187         689        -497 	 | 	 ( -1968)  -2669 [ -3370] 	 (   853)    947 [  1041] 	 ( -1114)  -1721 [ -2329] 
""")