mvalues_moeser_horinek["1HYW"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.674, bb=-0.421, sc=-0.337), 
)

mvalues_auton_bolen["1HYW"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/php3Tumdt. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            1548        -869         679 	 | 	 (  2404)   3353 [  4303] 	 ( -1207)  -1318 [ -1429] 	 (  1197)   2035 [  2873] 
1M Sarcosine        894        -220         675 	 | 	 (  1389)   1937 [  2486] 	 (   -98)    -90 [   -83] 	 (  1291)   1847 [  2403] 
1M Betaine         1152       -1324        -172 	 | 	 (  1790)   2496 [  3203] 	 ( -1941)  -2109 [ -2278] 	 (  -151)    387 [   925] 
1M Proline          825       -1029        -203 	 | 	 (  1282)   1788 [  2295] 	 ( -1306)  -1428 [ -1550] 	 (   -24)    360 [   745] 
1M Glycerol         241        -465        -224 	 | 	 (   374)    522 [   669] 	 (  -655)   -706 [  -757] 	 (  -281)   -184 [   -87] 
1M Sorbitol         602        -416         186 	 | 	 (   935)   1304 [  1673] 	 (  -295)   -305 [  -315] 	 (   640)    999 [  1358] 
1M Sucrose         1066        -550         516 	 | 	 (  1656)   2310 [  2964] 	 (  -485)   -508 [  -532] 	 (  1171)   1802 [  2432] 
1M Trehalose       1066        -467         599 	 | 	 (  1656)   2310 [  2964] 	 (   -31)     14 [    58] 	 (  1625)   2324 [  3022] 
1M Urea            -671         329        -342 	 | 	 ( -1042)  -1453 [ -1864] 	 (   391)    432 [   473] 	 (  -651)  -1021 [ -1392] 
""")

mvalues_experimental["1HYW"] = OrderedDict(
    "tmao" => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -660.0,
)