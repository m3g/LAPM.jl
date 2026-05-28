# Moeser & Horinek adjusted by Gly non-ideality

These plots show the MoeserHorinekApp model, which extends the MH to all cosolvents covered by the AB parameterization. Comparisons against AutonBolen correspond to Figure 3 of the paper.

```julia
using LAPM, PDBTools
```

## Against Moeser & Horinek

### Urea — Figure S32

```julia
plot_MH_vs_AB("urea"; m1=MoeserHorinek, m2=MoeserHorinekApp)
```

![Figure S32](./figures/fig_S32_mhapp_vs_mh_urea.svg)

## Against Auton & Bolen

### Urea — Figure S33

```julia
plot_MH_vs_AB("urea"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S33](./figures/fig_S33_mhapp_vs_ab_urea.svg)

### TMAO — Figure S34

```julia
plot_MH_vs_AB("tmao"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S34](./figures/fig_S34_mhapp_vs_ab_tmao.svg)

### Sarcosine — Figure S35

```julia
plot_MH_vs_AB("sarcosine"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S35](./figures/fig_S35_mhapp_vs_ab_sarcosine.svg)

### Proline — Figure S36

```julia
plot_MH_vs_AB("proline"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S36](./figures/fig_S36_mhapp_vs_ab_proline.svg)

### Sorbitol — Figure S37

```julia
plot_MH_vs_AB("sorbitol"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S37](./figures/fig_S37_mhapp_vs_ab_sorbitol.svg)

### Sucrose — Figure S38

```julia
plot_MH_vs_AB("sucrose"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S38](./figures/fig_S38_mhapp_vs_ab_sucrose.svg)

### Betaine — Figure S39

```julia
plot_MH_vs_AB("betaine"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S39](./figures/fig_S39_mhapp_vs_ab_betaine.svg)

### Glycerol — Figure S40

```julia
plot_MH_vs_AB("glycerol"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S40](./figures/fig_S40_mhapp_vs_ab_glycerol.svg)

### Trehalose — Figure S41

```julia
plot_MH_vs_AB("trehalose"; m1=AutonBolen, m2=MoeserHorinekApp)
```

![Figure S41](./figures/fig_S41_mhapp_vs_ab_trehalose.svg)
