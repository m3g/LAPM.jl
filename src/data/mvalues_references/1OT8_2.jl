mvalues_moeser_horinek["1OT8_2"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.899, bb=-1.719, sc=-1.247), 
)

mvalues_auton_bolen["1OT8_2"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpm4aGIb. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            3913       -1806        2107 	 | 	 (  8509)  11973 [ 15438] 	 ( -3403)  -3753 [ -4103] 	 (  5106)   8221 [ 11335] 
1M Sarcosine       2261        -651        1609 	 | 	 (  4916)   6918 [  8920] 	 (  -385)   -346 [  -307] 	 (  4532)   6572 [  8613] 
1M Betaine         2913       -3272        -360 	 | 	 (  6335)   8914 [ 11493] 	 ( -5806)  -6299 [ -6794] 	 (   529)   2615 [  4698] 
1M Proline         2087       -2619        -533 	 | 	 (  4538)   6386 [  8234] 	 ( -4340)  -4727 [ -5116] 	 (   199)   1659 [  3118] 
1M Glycerol         609       -1165        -556 	 | 	 (  1324)   1863 [  2401] 	 ( -1982)  -2123 [ -2262] 	 (  -658)   -260 [   139] 
1M Sorbitol        1522       -1315         207 	 | 	 (  3309)   4656 [  6004] 	 ( -1039)  -1066 [ -1092] 	 (  2271)   3591 [  4911] 
1M Sucrose         2695       -1672        1024 	 | 	 (  5862)   8248 [ 10635] 	 ( -1912)  -1976 [ -2042] 	 (  3950)   6273 [  8593] 
1M Trehalose       2695       -1115        1580 	 | 	 (  5862)   8248 [ 10635] 	 (   284)    471 [   657] 	 (  6146)   8719 [ 11292] 
1M Urea           -1695         727        -968 	 | 	 ( -3687)  -5189 [ -6690] 	 (  1115)   1238 [  1360] 	 ( -2572)  -3951 [ -5330] 
""")