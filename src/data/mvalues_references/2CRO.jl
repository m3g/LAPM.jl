mvalues_moeser_horinek["2CRO"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.927, bb=-0.506, sc=-0.489), 
)

mvalues_auton_bolen["2CRO"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpBzNRtD. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            1649        -812         837 	 | 	 (  2705)   3784 [  4864] 	 ( -1489)  -1602 [ -1715] 	 (  1216)   2183 [  3149] 
1M Sarcosine        953        -251         702 	 | 	 (  1563)   2187 [  2810] 	 (  -168)   -156 [  -144] 	 (  1394)   2030 [  2666] 
1M Betaine         1228       -1509        -281 	 | 	 (  2014)   2817 [  3621] 	 ( -2442)  -2615 [ -2788] 	 (  -429)    203 [   832] 
1M Proline          880        -981        -101 	 | 	 (  1443)   2018 [  2594] 	 ( -1511)  -1634 [ -1757] 	 (   -69)    385 [   837] 
1M Glycerol         257        -308         -52 	 | 	 (   421)    589 [   757] 	 (  -648)   -680 [  -711] 	 (  -227)    -91 [    45] 
1M Sorbitol         641        -260         381 	 | 	 (  1052)   1472 [  1891] 	 (  -151)   -141 [  -132] 	 (   901)   1330 [  1760] 
1M Sucrose         1136        -604         533 	 | 	 (  1863)   2607 [  3351] 	 (  -740)   -772 [  -804] 	 (  1123)   1835 [  2547] 
1M Trehalose       1136        -291         845 	 | 	 (  1863)   2607 [  3351] 	 (    -4)     58 [   120] 	 (  1860)   2665 [  3471] 
1M Urea            -715         133        -582 	 | 	 ( -1172)  -1640 [ -2108] 	 (   196)    219 [   242] 	 (  -976)  -1420 [ -1865] 
""")

mvalues_experimental["2CRO"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1000.0e-3,
)