# Moeser & Horinek

```@example mvalue
import Pkg
Pkg.develop(url="https://github.com/m3g/LAPM.jl")
using LAPM
```

The package will be downloaded at the `.julia/dev/` folder, and the files
can then be edited there.

## Urea

Compute and compare predictions with the Moeser & Horinek model, for urea:

```@example mvalue
plot_mvalue(MoeserHorinek, "urea")
```

