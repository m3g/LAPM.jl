mvalues_moeser_horinek["1BTA"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.5, bb=-0.708, sc=-0.843), 
)

mvalues_auton_bolen["1BTA"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpMBn9np.
                    Native State (cal/mol/M)                                                     Denatured State (cal/mol/M)
Osmolyte         Backbone   Sidechains    Total          |               Backbone                        Sidechains                      Total
1M TMAO            1990       -1478         512          |       (  3721)   5197 [  6674]        ( -2201)  -2373 [ -2545]        (  1520)   2824 [  4128]
1M Sarcosine       1150        -483         667          |       (  2150)   3003 [  3856]        (  -342)   -329 [  -315]        (  1807)   2674 [  3541]
1M Betaine         1481       -2384        -902          |       (  2770)   3869 [  4968]        ( -3954)  -4232 [ -4512]        ( -1184)   -363 [   456]
1M Proline         1061       -1696        -635          |       (  1984)   2772 [  3559]        ( -2502)  -2693 [ -2885]        (  -517)     79 [   674]
1M Glycerol         310       -1000        -690          |       (   579)    808 [  1038]        ( -1519)  -1619 [ -1719]        (  -940)   -811 [  -681]
1M Sorbitol         774        -945        -171          |       (  1447)   2021 [  2595]        (  -721)   -757 [  -793]        (   726)   1264 [  1802]
1M Sucrose         1371       -1025         346          |       (  2563)   3580 [  4597]        ( -1256)  -1304 [ -1354]        (  1307)   2276 [  3244]
1M Trehalose       1371       -1149         222          |       (  2563)   3580 [  4597]        (  -541)   -499 [  -458]        (  2022)   3081 [  4140]
1M Urea            -862         450        -412          |       ( -1612)  -2252 [ -2892]        (   329)    383 [   436]        ( -1284)  -1869 [ -2456]
""")

mvalues_experimental["1BTA"] = OrderedDict(
    "tmao"      => 2420.0,
    "sarcosine" => 2330.0,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1250.0,
)