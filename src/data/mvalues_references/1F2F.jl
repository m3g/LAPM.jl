mvalues_moeser_horinek["1F2F"] = OrderedDict(
    "tmao"      => (tot=NaN, bb=NaN, sc=NaN),
    "sarcosine" => (tot=NaN, bb=NaN, sc=NaN),
    "betaine"   => (tot=NaN, bb=NaN, sc=NaN), 
    "proline"   => (tot=NaN, bb=NaN, sc=NaN), 
    "glycerol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sorbitol"  => (tot=NaN, bb=NaN, sc=NaN), 
    "sucrose"   => (tot=NaN, bb=NaN, sc=NaN), 
    "trehalose" => (tot=NaN, bb=NaN, sc=NaN), 
    "urea"      => (tot=-1.567, bb=-0.708, sc=-0.910), 
)

mvalues_auton_bolen["1F2F"] = parse_mvalue_server("""
Native and Denatured State Transfer Free Energy Contributions to the m-value for /tmp/phpYnSaOj.
                    Native State (cal/mol/M)                                                     Denatured State (cal/mol/M)
Osmolyte         Backbone   Sidechains    Total          |               Backbone                        Sidechains                      Total
1M TMAO            2942       -1759        1183          |       (  4362)   6064 [  7765]        ( -2703)  -2918 [ -3134]        (  1659)   3145 [  4631]
1M Sarcosine       1700        -623        1077          |       (  2520)   3503 [  4487]        (  -732)   -762 [  -793]        (  1788)   2741 [  3693]
1M Betaine         2190       -2682        -491          |       (  3247)   4514 [  5781]        ( -4787)  -5147 [ -5510]        ( -1540)   -633 [   271]
1M Proline         1569       -1757        -188          |       (  2326)   3234 [  4142]        ( -3011)  -3249 [ -3489]        (  -684)    -15 [   653]
1M Glycerol         458        -844        -386          |       (   679)    943 [  1208]        ( -1535)  -1642 [ -1747]        (  -856)   -699 [  -540]
1M Sorbitol        1144        -718         426          |       (  1696)   2358 [  3020]        (  -762)   -805 [  -846]        (   934)   1553 [  2173]
1M Sucrose         2027       -1212         815          |       (  3005)   4177 [  5350]        ( -1880)  -1990 [ -2102]        (  1124)   2187 [  3248]
1M Trehalose       2027       -1006        1021          |       (  3005)   4177 [  5350]        (  -810)   -804 [  -800]        (  2195)   3373 [  4550]
1M Urea           -1275         425        -850          |       ( -1890)  -2628 [ -3365]        (   401)    455 [   509]        ( -1489)  -2172 [ -2856]
""")

mvalues_experimental["1F2F"] = OrderedDict(
    "tmao"      => NaN,
    "sarcosine" => NaN,
    "betaine"   => NaN, 
    "proline"   => NaN, 
    "glycerol"  => NaN, 
    "sorbitol"  => NaN, 
    "sucrose"   => NaN, 
    "trehalose" => NaN, 
    "urea"      => -1200.0e-3,
)