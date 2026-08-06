# Relation to secondary structure

Using the `Accessibility` model, these plots show the distribution of total, backbone, and side-chain m-value contributions per residue across the full set of non-homologous proteins from the CATH-S20 database (~15k domains), classified into mainly-α (3936 models) and mainly-β (3131 models) folds. The analysis reveals that urea interacts similarly with both fold classes, while proline shows an asymmetry in side-chain interactions that leads to stronger favorable interactions with β-folds than with helical structures. These results correspond to Figure 7 of the paper.

```julia
using LAPM
import DataFrames, CSV
df = CSV.read(cath_data_file, DataFrames.DataFrame);
```

## Urea — Figure S44

```julia
plot_cosolvent(df, "urea")
```

![Figure S44](./figures/fig_S44_alpha_beta_urea.svg)

## TMAO — Figure S45

```julia
plot_cosolvent(df, "tmao")
```

![Figure S45](./figures/fig_S45_alpha_beta_tmao.svg)

## Proline — Figure S46

```julia
plot_cosolvent(df, "proline")
```

![Figure S46](./figures/fig_S46_alpha_beta_proline.svg)

## Sarcosine — Figure S47

```julia
plot_cosolvent(df, "sarcosine")
```

![Figure S47](./figures/fig_S47_alpha_beta_sarcosine.svg)

## Betaine — Figure S48

```julia
plot_cosolvent(df, "betaine")
```

![Figure S48](./figures/fig_S48_alpha_beta_betaine.svg)

## Sorbitol — Figure S49

```julia
plot_cosolvent(df, "sorbitol")
```

![Figure S49](./figures/fig_S49_alpha_beta_sorbitol.svg)

## Sucrose — Figure S50

```julia
plot_cosolvent(df, "sucrose")
```

![Figure S50](./figures/fig_S50_alpha_beta_sucrose.svg)

## Glycerol — Figure S51

```julia
plot_cosolvent(df, "glycerol")
```

![Figure S51](./figures/fig_S51_alpha_beta_glycerol.svg)

## Trehalose — Figure S52

```julia
plot_cosolvent(df, "trehalose")
```

![Figure S52](./figures/fig_S52_alpha_beta_trehalose.svg)


## Urea vs. Proline

![Figure Paper](./figures/fig_urea_proline_alpha_beta.svg)

