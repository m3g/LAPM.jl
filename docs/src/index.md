# Introduction

This repository ([LAPM.jl](https://github.com/m3g/LAPM.jl)) is the supplementary information package for the paper *"Additive Transfer Free Energy Models of Osmolyte Effects on Protein Conformations: Self-contained, Free, Fast Implementations with a Novel Glycine-Activity Corrections for Multi-Cosolvent Predictions"* (Lima et al., 2026). It contains the validation scripts, reference datasets, and analysis code used to benchmark the implementations of the Auton–Bolen (AB), Moeser–Horinek (MH), and MoeserHorinekFit models available in [PDBTools.jl](https://m3g.github.io/PDBTools.jl).

## Installation

```@example mvalue
using LAPM
```

The package will be downloaded at the `.julia/dev/` folder, and the files
can then be edited there.

## Examples

### Moeser & Horinek: Urea

Compute and compare predictions with the Moeser & Horinek model, for urea:

```@example mvalue
plot_mvalue(MoeserHorinek, "urea")
```

### Auton & Bolen: Urea

Plot comparison with Auton & Bolen, for urea:

```@example mvalue
plot_mvalue(AutonBolen, "urea")
```

### Auton & Bolen: TMAO

Plot comparison with Auton & Bolen, for another solvent (TMAO):

```@example mvalue
plot_mvalue(AutonBolen, "tmao")
```



