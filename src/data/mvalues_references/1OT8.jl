mvalues_moeser_horinek["1OT8"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.618, bb=-0.994, sc=-0.674), 
)

mvalues_auton_bolen["1OT8"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpVL2csC. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2411       -1296        1114 	 | 	 (  4856)   6864 [  8873] 	 ( -2322)  -2553 [ -2784] 	 (  2534)   4312 [  6089] 
1M Sarcosine       1393        -447         945 	 | 	 (  2806)   3966 [  5127] 	 (  -271)   -247 [  -223] 	 (  2534)   3719 [  4903] 
1M Betaine         1794       -2433        -638 	 | 	 (  3615)   5110 [  6605] 	 ( -3937)  -4267 [ -4598] 	 (  -322)    843 [  2008] 
1M Proline         1286       -1924        -639 	 | 	 (  2590)   3661 [  4732] 	 ( -2848)  -3097 [ -3347] 	 (  -259)    564 [  1386] 
1M Glycerol         375       -1030        -655 	 | 	 (   755)   1068 [  1380] 	 ( -1513)  -1623 [ -1733] 	 (  -758)   -555 [  -353] 
1M Sorbitol         937       -1055        -117 	 | 	 (  1888)   2669 [  3451] 	 (  -887)   -927 [  -967] 	 (  1001)   1742 [  2483] 
1M Sucrose         1661       -1328         332 	 | 	 (  3345)   4729 [  6112] 	 ( -1410)  -1466 [ -1523] 	 (  1935)   3263 [  4589] 
1M Trehalose       1661       -1126         535 	 | 	 (  3345)   4729 [  6112] 	 (  -283)   -206 [  -128] 	 (  3062)   4523 [  5984] 
1M Urea           -1045         526        -518 	 | 	 ( -2104)  -2975 [ -3845] 	 (   744)    828 [   912] 	 ( -1360)  -2146 [ -2933] 
""")

mvalues_experimental["1OT8"] = OrderedDict(
    "tmao"      => 3741.0,
    "sarcosine" => 2793.0,
    "betaine"   => 1570.0, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => 2049.0, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1938.0e-3,
)
