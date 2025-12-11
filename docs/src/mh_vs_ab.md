# Moeser & Horinek vs Auton & Bolen

```@example mvalue
using LAPM
```

## Urea (Server) 

```@example mvalue
plot_MH_vs_AB("urea"; sasas_from=LAPM.server_sasa)
```

## Urea (Creamer)

```@example mvalue
plot_MH_vs_AB("urea"; sasas_from=LAPM.creamer_sasa)
```
