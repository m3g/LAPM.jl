# Auton & Bolen (Creamer SASAs)

```@example mvalue
using LAPM
```

These plots validate the AutonBolen m-value predictions computed with Creamer denatured-state SASAs against those obtained from the AB server, for all nine cosolvents. The excellent agreement (R² ≈ 1) shown here corresponds to Figure 1 of the paper, confirming that the reparameterized Creamer model is a reliable surrogate for the server SASA across all cosolvents.

## Urea — Figure S3

```@example mvalue
plot_mvalue(AutonBolen, "urea")
```

## TMAO — Figure S4

```@example mvalue
plot_mvalue(AutonBolen, "tmao")
```

## Sucrose — Figure S5

```@example mvalue
plot_mvalue(AutonBolen, "sucrose")
```

## Betaine — Figure S6

```@example mvalue
plot_mvalue(AutonBolen, "betaine")
```

## Sarcosine — Figure S7

```@example mvalue
plot_mvalue(AutonBolen, "sarcosine")
```

## Proline — Figure S8

```@example mvalue
plot_mvalue(AutonBolen, "proline")
```

## Sorbitol — Figure S9

```@example mvalue
plot_mvalue(AutonBolen, "sorbitol")
```

## Glycerol — Figure S10

```@example mvalue
plot_mvalue(AutonBolen, "glycerol")
```

## Trehalose — Figure S11

```@example mvalue
plot_mvalue(AutonBolen, "trehalose")
```


