mvalues_moeser_horinek["1POH"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.180, bb=-0.691, sc=-0.556), 
)

mvalues_auton_bolen["1POH"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phphH86ar. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            1833        -856         977 	 | 	 (  3595)   4944 [  6294] 	 ( -1394)  -1514 [ -1634] 	 (  2200)   3430 [  4660] 
1M Sarcosine       1059        -355         704 	 | 	 (  2077)   2857 [  3636] 	 (  -151)   -137 [  -124] 	 (  1926)   2719 [  3512] 
1M Betaine         1365       -1619        -254 	 | 	 (  2676)   3681 [  4685] 	 ( -2571)  -2781 [ -2993] 	 (   105)    900 [  1692] 
1M Proline          978       -1193        -215 	 | 	 (  1917)   2637 [  3357] 	 ( -1726)  -1878 [ -2032] 	 (   191)    759 [  1325] 
1M Glycerol         285        -370         -85 	 | 	 (   559)    769 [   979] 	 (  -527)   -560 [  -591] 	 (    32)    209 [   388] 
1M Sorbitol         713        -488         225 	 | 	 (  1398)   1923 [  2447] 	 (  -212)   -208 [  -203] 	 (  1185)   1714 [  2244] 
1M Sucrose         1263        -697         566 	 | 	 (  2476)   3406 [  4336] 	 (  -620)   -639 [  -660] 	 (  1856)   2767 [  3675] 
1M Trehalose       1263        -560         703 	 | 	 (  2476)   3406 [  4336] 	 (   190)    279 [   368] 	 (  2666)   3685 [  4703] 
1M Urea            -794         328        -466 	 | 	 ( -1558)  -2142 [ -2727] 	 (   457)    506 [   554] 	 ( -1101)  -1637 [ -2173] 
""")

mvalues_experimental["1POH"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1190.0,
)