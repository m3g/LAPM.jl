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
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpVUggEV. 
		    Native State (cal/mol/M) 							 Denatured State (cal/mol/M) 
Osmolyte 	 Backbone   Sidechains    Total 	 | 		 Backbone 			 Sidechains 			 Total 
1M TMAO             579        -439         140 	 | 	 (   268)    356 [   443] 	 (  -380)   -402 [  -423] 	 (  -112)    -46 [    20] 
1M Sarcosine        335        -134         200 	 | 	 (   155)    206 [   256] 	 (  -113)   -120 [  -128] 	 (    42)     85 [   129] 
1M Betaine          431        -594        -163 	 | 	 (   200)    265 [   330] 	 (  -516)   -546 [  -576] 	 (  -317)   -281 [  -246] 
1M Proline          309        -260          49 	 | 	 (   143)    190 [   237] 	 (  -221)   -234 [  -248] 	 (   -77)    -44 [   -11] 
1M Glycerol          90        -118         -28 	 | 	 (    42)     55 [    69] 	 (  -107)   -112 [  -117] 	 (   -65)    -56 [   -48] 
1M Sorbitol         225         -76         149 	 | 	 (   104)    138 [   172] 	 (   -70)    -73 [   -77] 	 (    35)     65 [    95] 
1M Sucrose          399        -149         250 	 | 	 (   185)    245 [   305] 	 (  -133)   -140 [  -146] 	 (    52)    105 [   159] 
1M Trehalose        399        -188         211 	 | 	 (   185)    245 [   305] 	 (  -169)   -177 [  -185] 	 (    16)     69 [   121] 
1M Urea            -251         102        -149 	 | 	 (  -116)   -154 [  -192] 	 (    83)     89 [    94] 	 (   -33)    -66 [   -98] 
""")