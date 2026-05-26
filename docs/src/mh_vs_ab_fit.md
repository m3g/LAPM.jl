# Moeser & Horinek adjusted by Gly non-ideality

These plots show the novel MoeserHorinekFit model, which extends the MH glycine-activity correction to all cosolvents covered by the AB parameterization. For each cosolvent, a single correction constant $$\gamma$$ is fit so that MoeserHorinekFit total m-value predictions reproduce those of AutonBolen across 36 reference proteins, while retaining the MH universal backbone treatment. The fitted urea correction (≈15 cal mol⁻¹ M⁻¹) closely reproduces the theoretical Moeser–Horinek value, validating the approach. Comparisons against AutonBolen correspond to Figure 3 of the paper; fitted $$\gamma$$ values for all cosolvents are listed in Table 1 of the paper.

```julia
using LAPM, PDBTools
```

## Against Moeser & Horinek

### Urea — Figure S30

```julia
plot_MH_vs_AB("urea"; m1=MoeserHorinek, m2=MoeserHorinekFit)
```

![Figure S30](./figures/fig_S30_mhfit_vs_mh_urea.svg)

## Against Auton & Bolen

### Urea — Figure S31

```julia
plot_MH_vs_AB("urea"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S31](./figures/fig_S31_mhfit_vs_ab_urea.svg)

### TMAO — Figure S32

```julia
plot_MH_vs_AB("tmao"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S32](./figures/fig_S32_mhfit_vs_ab_tmao.svg)

### Sarcosine — Figure S33

```julia
plot_MH_vs_AB("sarcosine"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S33](./figures/fig_S33_mhfit_vs_ab_sarcosine.svg)

### Proline — Figure S34

```julia
plot_MH_vs_AB("proline"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S34](./figures/fig_S34_mhfit_vs_ab_proline.svg)

### Sorbitol — Figure S35

```julia
plot_MH_vs_AB("sorbitol"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S35](./figures/fig_S35_mhfit_vs_ab_sorbitol.svg)

### Sucrose — Figure S36

```julia
plot_MH_vs_AB("sucrose"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S36](./figures/fig_S36_mhfit_vs_ab_sucrose.svg)

### Betaine — Figure S37

```julia
plot_MH_vs_AB("betaine"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S37](./figures/fig_S37_mhfit_vs_ab_betaine.svg)

### Glycerol — Figure S38

```julia
plot_MH_vs_AB("glycerol"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S38](./figures/fig_S38_mhfit_vs_ab_glycerol.svg)

### Trehalose — Figure S39

```julia
plot_MH_vs_AB("trehalose"; m1=AutonBolen, m2=MoeserHorinekFit)
```

![Figure S39](./figures/fig_S39_mhfit_vs_ab_trehalose.svg)
