mvalues_moeser_horinek["2SNS"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.904, bb=-1.062, sc=-0.893), 
)

mvalues_auton_bolen["2SNS"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/php4HDc0G. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3339       -2512         827 	 | 	 (  5924)   8220 [ 10515] 	 ( -4219)  -4530 [ -4842] 	 (  1705)   3689 [  5673] 
1M Sarcosine       1929        -696        1233 	 | 	 (  3423)   4749 [  6076] 	 (  -815)   -824 [  -834] 	 (  2608)   3925 [  5241] 
1M Betaine         2486       -3975       -1490 	 | 	 (  4410)   6119 [  7828] 	 ( -6962)  -7459 [ -7959] 	 ( -2552)  -1340 [  -131] 
1M Proline         1781       -2141        -360 	 | 	 (  3160)   4384 [  5608] 	 ( -3983)  -4293 [ -4603] 	 (  -824)     91 [  1005] 
1M Glycerol         519       -1200        -680 	 | 	 (   922)   1279 [  1636] 	 ( -2229)  -2379 [ -2528] 	 ( -1308)  -1101 [  -893] 
1M Sorbitol        1298        -865         434 	 | 	 (  2304)   3197 [  4089] 	 ( -1192)  -1245 [ -1298] 	 (  1111)   1951 [  2791] 
1M Sucrose         2300       -1490         810 	 | 	 (  4081)   5663 [  7244] 	 ( -2151)  -2253 [ -2357] 	 (  1930)   3409 [  4887] 
1M Trehalose       2300       -1423         877 	 | 	 (  4081)   5663 [  7244] 	 ( -1160)  -1120 [ -1081] 	 (  2922)   4542 [  6163] 
1M Urea           -1447         486        -961 	 | 	 ( -2567)  -3562 [ -4557] 	 (   868)    952 [  1036] 	 ( -1700)  -2610 [ -3521] 
""")


mvalues_experimental["2SNS"] = OrderedDict(
    "tmao"      => 2550.0 ,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -2380.0e-3,
)