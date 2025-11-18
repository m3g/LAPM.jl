# Auton & Bolen (Server SASAs)

```@example mvalue
import Pkg
Pkg.develop(url="https://github.com/m3g/LAPM.jl")
using LAPM
```

## Urea

```@example mvalue
plot_mvalue(AutonBolen, "urea"; sasas_from=LAPM.server_sasa)
```

## TMAO

```@example mvalue
plot_mvalue(AutonBolen, "tmao"; sasas_from=LAPM.server_sasa)
```

## Sucrose

```@example mvalue
plot_mvalue(AutonBolen, "sucrose"; sasas_from=LAPM.server_sasa)
```

## Betaine 

```@example mvalue
plot_mvalue(AutonBolen, "betaine"; sasas_from=LAPM.server_sasa)
```

## Sarcosine

```@example mvalue
plot_mvalue(AutonBolen, "sarcosine"; sasas_from=LAPM.server_sasa)
```

## Proline

```@example mvalue
plot_mvalue(AutonBolen, "proline"; sasas_from=LAPM.server_sasa)
```

## Sorbitol

```@example mvalue
plot_mvalue(AutonBolen, "sorbitol"; sasas_from=LAPM.server_sasa)
```


