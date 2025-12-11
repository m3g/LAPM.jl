# Moeser & Horinek

```@example mvalue
using LAPM
```

## Urea (Creamer)

Compute and compare predictions with the Moeser & Horinek model, for urea:

```@example mvalue
plot_mvalue(MoeserHorinek, "urea")
```

## Urea (Server)

Compute and compare predictions with the Moeser & Horinek model, for urea:

```@example mvalue
plot_mvalue(MoeserHorinek, "urea"; sasas_from=LAPM.server_sasa)
```

