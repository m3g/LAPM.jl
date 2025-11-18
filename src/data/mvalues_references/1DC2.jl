mvalues_moeser_horinek["1DC2"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.517, bb=-0.927, sc=-0.657), 
)

mvalues_auton_bolen["1DC2"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpRMSfuR. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO            4791       -3259        1533 	 | 	 (  6522)   8987 [ 11452] 	 ( -4068)  -4418 [ -4767] 	 (  2454)   4569 [  6684] 
1M Sarcosine       2768        -864        1905 	 | 	 (  3768)   5192 [  6617] 	 (  -505)   -487 [  -469] 	 (  3263)   4705 [  6148] 
1M Betaine         3567       -4295        -729 	 | 	 (  4855)   6690 [  8525] 	 ( -5452)  -5879 [ -6307] 	 (  -597)    811 [  2219] 
1M Proline         2555       -2903        -348 	 | 	 (  3478)   4793 [  6108] 	 ( -3568)  -3861 [ -4155] 	 (   -90)    932 [  1953] 
1M Glycerol         745       -1801       -1055 	 | 	 (  1015)   1398 [  1781] 	 ( -2349)  -2511 [ -2672] 	 ( -1334)  -1113 [  -891] 
1M Sorbitol        1863       -1140         724 	 | 	 (  2536)   3495 [  4453] 	 (  -773)   -793 [  -813] 	 (  1763)   2701 [  3640] 
1M Sucrose         3301       -2063        1238 	 | 	 (  4493)   6191 [  7889] 	 ( -1984)  -2053 [ -2122] 	 (  2509)   4138 [  5767] 
1M Trehalose       3301       -1873        1428 	 | 	 (  4493)   6191 [  7889] 	 (  -746)   -645 [  -543] 	 (  3747)   5546 [  7346] 
1M Urea           -2076         723       -1353 	 | 	 ( -2826)  -3894 [ -4962] 	 (   957)   1065 [  1174] 	 ( -1869)  -2829 [ -3788]  
""")