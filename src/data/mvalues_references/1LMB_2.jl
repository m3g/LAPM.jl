mvalues_moeser_horinek["1LMB_2"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.230, bb=-0.657, sc=-0.607), 
)

mvalues_auton_bolen["1LMB_2"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpiiexG4. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            2364       -1804         560 	 | 	 (  3891)   5386 [  6881] 	 ( -2310)  -2511 [ -2713] 	 (  1581)   2875 [  4169] 
1M Sarcosine       1366        -512         854 	 | 	 (  2248)   3112 [  3976] 	 (  -288)   -281 [  -275] 	 (  1960)   2831 [  3701] 
1M Betaine         1760       -2647        -887 	 | 	 (  2897)   4010 [  5123] 	 ( -3652)  -3946 [ -4241] 	 (  -756)     64 [   882] 
1M Proline         1261       -1692        -431 	 | 	 (  2075)   2873 [  3670] 	 ( -2259)  -2456 [ -2655] 	 (  -183)    416 [  1015] 
1M Glycerol         368        -892        -524 	 | 	 (   605)    838 [  1070] 	 ( -1161)  -1242 [ -1323] 	 (  -556)   -405 [  -253] 
1M Sorbitol         919        -726         193 	 | 	 (  1513)   2095 [  2676] 	 (  -529)   -546 [  -563] 	 (   984)   1548 [  2113] 
1M Sucrose         1628        -876         752 	 | 	 (  2680)   3710 [  4741] 	 (  -862)   -898 [  -936] 	 (  1819)   2812 [  3805] 
1M Trehalose       1628        -765         864 	 | 	 (  2680)   3710 [  4741] 	 (   -12)     61 [   135] 	 (  2668)   3772 [  4875] 
1M Urea           -1024         519        -506 	 | 	 ( -1686)  -2334 [ -2982] 	 (   545)    601 [   655] 	 ( -1141)  -1733 [ -2327] 
""")

mvalues_experimental["1LMB_2"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1090.0e-3,
)