# Relation to secondary structure

Using the `MoeserHorinekFit` model.

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

## Betaine

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