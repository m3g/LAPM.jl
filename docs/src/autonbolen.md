# Auton & Bolen (Creamer SASAs)

```@example mvalue
using LAPM
```

These plots validate the AutonBolen m-value predictions computed with Creamer denatured-state SASAs against those obtained from the AB server, for all nine cosolvents. The excellent agreement (R² ≈ 1) shown here corresponds to Figure 1 of the paper, confirming that the reparameterized Creamer model is a reliable surrogate for the server SASA across all cosolvents.

## Urea

```@example mvalue
plot_mvalue(AutonBolen, "urea")
```

## TMAO

```@example mvalue
plot_mvalue(AutonBolen, "tmao")
```

## Sucrose

```@example mvalue
plot_mvalue(AutonBolen, "sucrose")
```

## Betaine 

```@example mvalue
plot_mvalue(AutonBolen, "betaine")
```

## Sarcosine

```@example mvalue
plot_mvalue(AutonBolen, "sarcosine")
```

## Proline

```@example mvalue
plot_mvalue(AutonBolen, "proline")
```

## Sorbitol

```@example mvalue
plot_mvalue(AutonBolen, "sorbitol")
```

## Glycerol

```@example mvalue
plot_mvalue(AutonBolen, "glycerol")
```

## Trehalose

```@example mvalue
plot_mvalue(AutonBolen, "trehalose")
```


