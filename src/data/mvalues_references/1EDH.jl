mvalues_moeser_horinek["1EDH"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.298, bb=-0.775, sc=-0.590), 
)

mvalues_auton_bolen["1EDH"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpePCeTG. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3057       -2112         945 	 | 	 (  4447)   6034 [  7621] 	 ( -3096)  -3334 [ -3572] 	 (  1351)   2701 [  4050] 
1M Sarcosine       1766        -654        1112 	 | 	 (  2570)   3486 [  4403] 	 (  -551)   -538 [  -525] 	 (  2019)   2949 [  3879] 
1M Betaine         2276       -2988        -712 	 | 	 (  3311)   4492 [  5674] 	 ( -4565)  -4907 [ -5251] 	 ( -1254)   -415 [   422] 
1M Proline         1630       -1941        -311 	 | 	 (  2372)   3218 [  4065] 	 ( -2879)  -3105 [ -3332] 	 (  -507)    113 [   733] 
1M Glycerol         476       -1010        -534 	 | 	 (   692)    939 [  1186] 	 ( -1362)  -1441 [ -1519] 	 (  -670)   -502 [  -333] 
1M Sorbitol        1189        -849         339 	 | 	 (  1730)   2347 [  2964] 	 (  -783)   -811 [  -839] 	 (   947)   1536 [  2125] 
1M Sucrose         2106       -1311         795 	 | 	 (  3064)   4157 [  5250] 	 ( -1552)  -1611 [ -1671] 	 (  1511)   2546 [  3579] 
1M Trehalose       2106       -1169         936 	 | 	 (  3064)   4157 [  5250] 	 (  -749)   -675 [  -600] 	 (  2315)   3482 [  4650] 
1M Urea           -1325         632        -692 	 | 	 ( -1927)  -2615 [ -3303] 	 (   821)    907 [   993] 	 ( -1106)  -1707 [ -2309] 
""")

mvalues_experimental["1EDH"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1400.0e-3,
)