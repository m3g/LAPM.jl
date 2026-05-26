# Relation to secondary structure

Using the `MoeserHorinekFit` model, these plots show the distribution of total, backbone, and side-chain m-value contributions per residue across the full set of non-homologous proteins from the CATH-S20 database (~15k domains), classified into mainly-α (3936 models) and mainly-β (3131 models) folds. The analysis reveals that urea interacts similarly with both fold classes, while proline shows an asymmetry in side-chain interactions that leads to stronger favorable interactions with β-folds than with helical structures. These results correspond to Figure 7 of the paper.

```@example ab
using LAPM
import DataFrames
import CSV
df = CSV.read(cath_data_file, DataFrames.DataFrame);
```

## Urea — Figures S30–S31

```@example ab
plot_cosolvent(df, "urea")
```

## TMAO — Figures S32–S33

```@example ab
plot_cosolvent(df, "tmao")
```

## Proline — Figures S34–S35

```@example ab
plot_cosolvent(df, "proline")
```

## Sarcosine — Figures S36–S37

```@example ab
plot_cosolvent(df, "sarcosine")
```

## Betaine — Figures S38–S39

```@example ab
plot_cosolvent(df, "betaine")
```

## Sorbitol — Figures S40–S41

```@example ab
plot_cosolvent(df, "sorbitol")
```

## Sucrose — Figures S42–S43

```@example ab
plot_cosolvent(df, "sucrose")
```

## Glycerol — Figures S44–S45

```@example ab
plot_cosolvent(df, "glycerol")
```

## Trehalose — Figures S46–S47

```@example ab
plot_cosolvent(df, "trehalose")
```