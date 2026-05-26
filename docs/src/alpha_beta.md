# Relation to secondary structure

Using the `MoeserHorinekFit` model, these plots show the distribution of total, backbone, and side-chain m-value contributions per residue across the full set of non-homologous proteins from the CATH-S20 database (~15k domains), classified into mainly-α (3936 models) and mainly-β (3131 models) folds. The analysis reveals that urea interacts similarly with both fold classes, while proline shows an asymmetry in side-chain interactions that leads to stronger favorable interactions with β-folds than with helical structures. These results correspond to Figure 7 of the paper.

```@example ab
using LAPM
using DataFrames
using CSV
df = CSV.read(cath_data_file, DataFrame);
```

## Urea

```@example ab
plot_cosolvent(df, "urea")
```

## TMAO

```@example ab
plot_cosolvent(df, "tmao")
```

## Proline

```@example ab
plot_cosolvent(df, "proline")
```

## Sarcosine

```@example ab
plot_cosolvent(df, "sarcosine")
```

## Betaine

```@example ab
plot_cosolvent(df, "betaine")
```

## Sorbitol

```@example ab
plot_cosolvent(df, "sorbitol")
```

## Sucrose

```@example ab
plot_cosolvent(df, "sucrose")
```

## Glycerol

```@example ab
plot_cosolvent(df, "glycerol")
```

## Trehalose

```@example ab
plot_cosolvent(df, "trehalose")
```