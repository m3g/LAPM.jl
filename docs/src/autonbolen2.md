# Auton & Bolen (Server SASAs)

These plots show AutonBolen m-value predictions computed using the SASA values obtained directly from the AB server, compared against the server's own m-value outputs. Agreement is essentially exact for all seven cosolvents (R² ≈ 1), confirming that the group transfer free energy parameters and SASA decomposition are correctly implemented in PDBTools.jl.

```julia
using LAPM
```

## Urea — Figure S19

```julia
plot_mvalue(AutonBolen, "urea"; sasas_from=LAPM.server_sasa)
```

![Figure S19](./figures/fig_S19_autonbolen_server_urea.svg)

## TMAO — Figure S20

```julia
plot_mvalue(AutonBolen, "tmao"; sasas_from=LAPM.server_sasa)
```

![Figure S20](./figures/fig_S20_autonbolen_server_tmao.svg)

## Sucrose — Figure S21

```julia
plot_mvalue(AutonBolen, "sucrose"; sasas_from=LAPM.server_sasa)
```

![Figure S21](./figures/fig_S21_autonbolen_server_sucrose.svg)

## Betaine — Figure S22

```julia
plot_mvalue(AutonBolen, "betaine"; sasas_from=LAPM.server_sasa)
```

![Figure S22](./figures/fig_S22_autonbolen_server_betaine.svg)

## Sarcosine — Figure S23

```julia
plot_mvalue(AutonBolen, "sarcosine"; sasas_from=LAPM.server_sasa)
```

![Figure S23](./figures/fig_S23_autonbolen_server_sarcosine.svg)

## Proline — Figure S24

```julia
plot_mvalue(AutonBolen, "proline"; sasas_from=LAPM.server_sasa)
```

![Figure S24](./figures/fig_S24_autonbolen_server_proline.svg)

## Sorbitol — Figure S25

```julia
plot_mvalue(AutonBolen, "sorbitol"; sasas_from=LAPM.server_sasa)
```

![Figure S25](./figures/fig_S25_autonbolen_server_sorbitol.svg)

## Glycerol — Figure S26

```julia
plot_mvalue(AutonBolen, "glycerol"; sasas_from=LAPM.server_sasa)
```

![Figure S26](./figures/fig_S26_autonbolen_server_glycerol.svg)

## Trehalose — Figure S27

```julia
plot_mvalue(AutonBolen, "trehalose"; sasas_from=LAPM.server_sasa)
```

![Figure S27](./figures/fig_S27_autonbolen_server_trehalose.svg)
