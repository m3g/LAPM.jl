mvalues_moeser_horinek["1FTG"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-3.017, bb=-1.483, sc=-1.601), 
)

mvalues_auton_bolen["1FTG"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpbblaNQ. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3337       -1818        1519 	 | 	 (  7163)   9870 [ 12576] 	 ( -3678)  -3987 [ -4296] 	 (  3485)   5883 [  8280] 
1M Sarcosine       1928        -649        1278 	 | 	 (  4139)   5702 [  7266] 	 (  -760)   -757 [  -754] 	 (  3379)   4946 [  6512] 
1M Betaine         2484       -3212        -728 	 | 	 (  5333)   7347 [  9362] 	 ( -7218)  -7771 [ -8329] 	 ( -1885)   -423 [  1033] 
1M Proline         1780       -2389        -609 	 | 	 (  3821)   5264 [  6707] 	 ( -4807)  -5196 [ -5588] 	 (  -987)     68 [  1119] 
1M Glycerol         519       -1405        -886 	 | 	 (  1114)   1535 [  1956] 	 ( -2540)  -2723 [ -2902] 	 ( -1426)  -1187 [  -946] 
1M Sorbitol        1298       -1485        -187 	 | 	 (  2786)   3838 [  4891] 	 ( -1628)  -1727 [ -1825] 	 (  1158)   2111 [  3065] 
1M Sucrose         2299       -1147        1151 	 | 	 (  4935)   6799 [  8663] 	 ( -2356)  -2471 [ -2590] 	 (  2579)   4328 [  6073] 
1M Trehalose       2299       -1397         902 	 | 	 (  4935)   6799 [  8663] 	 ( -1172)  -1136 [ -1101] 	 (  3763)   5663 [  7563] 
1M Urea           -1446         799        -646 	 | 	 ( -3104)  -4277 [ -5449] 	 (   755)    864 [   971] 	 ( -2349)  -3413 [ -4479] 
""")

mvalues_experimental["1FTG"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -2550.0e-3,
)