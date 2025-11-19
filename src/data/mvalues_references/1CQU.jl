mvalues_moeser_horinek["1CQU"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-0.725, bb=-0.404, sc=-0.388), 
)

mvalues_auton_bolen["1CQU"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/php3495xw.
                    Native State (cal/mol/M)                                                     Denatured State (cal/mol/M)
Osmolyte         Backbone   Sidechains    Total          |               Backbone                        Sidechains                      Total
1M TMAO            1662       -1112         550          |       (  2347)   3283 [  4218]        ( -1342)  -1443 [ -1543]        (  1005)   1840 [  2674]
1M Sarcosine        960        -339         621          |       (  1356)   1897 [  2437]        (  -204)   -197 [  -189]        (  1153)   1700 [  2247]
1M Betaine         1237       -1860        -623          |       (  1748)   2444 [  3140]        ( -2415)  -2586 [ -2760]        (  -667)   -143 [   380]
1M Proline          886       -1062        -176          |       (  1252)   1751 [  2249]        ( -1336)  -1442 [ -1549]        (   -84)    309 [   701]
1M Glycerol         258        -483        -225          |       (   365)    511 [   656]        (  -509)   -540 [  -570]        (  -144)    -29 [    87]
1M Sorbitol         646        -520         126          |       (   913)   1277 [  1640]        (  -362)   -372 [  -382]        (   551)    904 [  1258]
1M Sucrose         1145        -701         443          |       (  1617)   2261 [  2906]        (  -684)   -715 [  -748]        (   933)   1546 [  2158]
1M Trehalose       1145        -572         572          |       (  1617)   2261 [  2906]        (  -109)    -69 [   -29]        (  1509)   2193 [  2876]
1M Urea            -720         243        -477          |       ( -1017)  -1422 [ -1828]        (   232)    252 [   272]        (  -786)  -1170 [ -1556]
""")

mvalues_experimental["1CQU"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -580.0,
)

