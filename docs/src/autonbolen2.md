# Auton & Bolen (Server SASAs)

```@example mvalue
using LAPM
```

These plots show AutonBolen m-value predictions computed using the SASA values obtained directly from the AB server, compared against the server's own m-value outputs. Agreement is essentially exact for all seven cosolvents (R² ≈ 1), confirming that the group transfer free energy parameters and SASA decomposition are correctly implemented in PDBTools.jl.

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

## Glycerol

```@example mvalue
plot_mvalue(AutonBolen, "glycerol"; sasas_from=LAPM.server_sasa)
```

## Trehalose

```@example mvalue
plot_mvalue(AutonBolen, "trehalose"; sasas_from=LAPM.server_sasa)
```



