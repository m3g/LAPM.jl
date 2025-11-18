mvalues_moeser_horinek["2AFG"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-2.191, bb=-1.146, sc=-1.112), 
)

mvalues_auton_bolen["2AFG"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpGDMjqO. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            9442       -6654        2788 	 | 	 ( 21778)  30100 [ 38423] 	 (-12155) -13097 [-14039] 	 (  9623)  17004 [ 24384] 
1M Sarcosine       5455       -2176        3279 	 | 	 ( 12583)  17391 [ 22200] 	 ( -2759)  -2857 [ -2955] 	 (  9823)  14535 [ 19245] 
1M Betaine         7029      -10533       -3505 	 | 	 ( 16213)  22408 [ 28604] 	 (-21726) -23385 [-25053] 	 ( -5514)   -976 [  3551] 
1M Proline         5036       -6822       -1787 	 | 	 ( 11615)  16054 [ 20492] 	 (-13873) -14999 [-16131] 	 ( -2258)   1055 [  4361] 
1M Glycerol        1469       -4231       -2762 	 | 	 (  3388)   4682 [  5977] 	 ( -8050)  -8632 [ -9208] 	 ( -4663)  -3950 [ -3232] 
1M Sorbitol        3672       -3063         608 	 | 	 (  8469)  11706 [ 14942] 	 ( -3836)  -4081 [ -4322] 	 (  4633)   7625 [ 10620] 
1M Sucrose         6504       -4696        1808 	 | 	 ( 15003)  20736 [ 26469] 	 ( -8219)  -8720 [ -9230] 	 (  6784)  12016 [ 17239] 
1M Trehalose       6504       -4072        2432 	 | 	 ( 15003)  20736 [ 26469] 	 ( -3810)  -3826 [ -3843] 	 ( 11193)  16910 [ 22626] 
1M Urea           -4091        1875       -2217 	 | 	 ( -9437) -13044 [-16650] 	 (  2356)   2611 [  2862] 	 ( -7081) -10433 [-13788] 
""")