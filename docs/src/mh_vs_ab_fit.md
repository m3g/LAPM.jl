# Moeser & Horinek adjusted by Gly non-ideality 

```@example mvalue
using LAPM
```

## Against Moeser&Horinek

### Urea 

```@example mvalue
plot_MH_vs_AB("urea"; m1=MoeserHorinek, m2=MoeserHorinekFit)
```

## Against Auton&Bolen

### Urea 

```@example mvalue
plot_MH_vs_AB("urea"; m1=AutonBolen, m2=MoeserHorinekFit)
```

### TMAO

```@example mvalue
plot_MH_vs_AB("tmao"; m1=AutonBolen, m2=MoeserHorinekFit)
```

### Sarcosine

```@example mvalue
plot_MH_vs_AB("sarcosine"; m1=AutonBolen, m2=MoeserHorinekFit)
```

### Proline

```@example mvalue
plot_MH_vs_AB("proline"; m1=AutonBolen, m2=MoeserHorinekFit)
```

### Sorbitol

```@example mvalue
plot_MH_vs_AB("sorbitol"; m1=AutonBolen, m2=MoeserHorinekFit)
```

### Sucrose

```@example mvalue
plot_MH_vs_AB("sucrose"; m1=AutonBolen, m2=MoeserHorinekFit)
```

### Betaine

```@example mvalue
plot_MH_vs_AB("sucrose"; m1=AutonBolen, m2=MoeserHorinekFit)
```
