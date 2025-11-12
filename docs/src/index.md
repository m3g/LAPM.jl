# Installation

```
import Pkg
Pkg.dev(url="https://github.com/m3g/LAPM.jl")
```

The package will be downloaded at the `.julia/dev/` folder, and the files
can then be edited there.

# Examples

```@example mvalue
using LAPM
```

Compute and compare predictions with the Moeser & Horinek model, for urea:

```@example mvalue
plot_mvalue(MoeserHorinek, "urea")
```

Plot comparison with Auton & Bolen, for urea:

```@example mvalue
plot_mvalue(AutonBolen, "urea")
```

Plot comparison with Auton & Bolen, for another solvent (TMAO):

```@example mvalue
plot_mvalue(AutonBolen, "tmao")
```



