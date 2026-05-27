# Auton & Bolen (Creamer SASAs)

These plots validate the AutonBolen m-value predictions computed with Creamer denatured-state SASAs against those obtained from the AB server, for all nine cosolvents. The excellent agreement (R² ≈ 1) shown here corresponds to Figure 1 of the paper, confirming that the reparameterized Creamer model is a reliable surrogate for the server SASA across all cosolvents.

```julia
using LAPM
```

## Urea — Figure S10

```julia
plot_mvalue(AutonBolen, "urea")
```

![Figure S10](./figures/fig_S10_autonbolen_creamer_urea.svg)

## TMAO — Figure S11

```julia
plot_mvalue(AutonBolen, "tmao")
```

![Figure S11](./figures/fig_S11_autonbolen_creamer_tmao.svg)

## Sucrose — Figure S12

```julia
plot_mvalue(AutonBolen, "sucrose")
```

![Figure S12](./figures/fig_S12_autonbolen_creamer_sucrose.svg)

## Betaine — Figure S13

```julia
plot_mvalue(AutonBolen, "betaine")
```

![Figure S13](./figures/fig_S13_autonbolen_creamer_betaine.svg)

## Sarcosine — Figure S14

```julia
plot_mvalue(AutonBolen, "sarcosine")
```

![Figure S14](./figures/fig_S14_autonbolen_creamer_sarcosine.svg)

## Proline — Figure S15

```julia
plot_mvalue(AutonBolen, "proline")
```

![Figure S15](./figures/fig_S15_autonbolen_creamer_proline.svg)

## Sorbitol — Figure S16

```julia
plot_mvalue(AutonBolen, "sorbitol")
```

![Figure S16](./figures/fig_S16_autonbolen_creamer_sorbitol.svg)

## Glycerol — Figure S17

```julia
plot_mvalue(AutonBolen, "glycerol")
```

![Figure S17](./figures/fig_S17_autonbolen_creamer_glycerol.svg)

## Trehalose — Figure S18

```julia
plot_mvalue(AutonBolen, "trehalose")
```

![Figure S18](./figures/fig_S18_autonbolen_creamer_trehalose.svg)
