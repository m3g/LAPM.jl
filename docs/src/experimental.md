# Experimental

These plots benchmark model predictions against experimental m-values. The urea sections (Figures 4 and 5 of the paper) compare MH, AB, and MoeserHorinekApp predictions against a 36-protein test set, showing that all models correlate well with experiment (slopes within ~15% of unity). The other-osmolyte section validates the AB and MoeserHorinekApp models against experimental data for the full set of AB cosolvents. The SH3/GB1 section (Figure 6) compares predictions against the Rydeen et al. (2018) dataset for SH3 unfolding and GB1 dimer dissociation.

```julia
using LAPM
```

## Urea (Creamer)

### MoeserHorinek — Figure S51

```julia
plot_experimental(MoeserHorinek; sasas_from=LAPM.creamer_sasa)
```

![Figure S51](./figures/fig_S51_experimental_mh_creamer_urea.svg)

### AutonBolen — Figure S52

```julia
plot_experimental(AutonBolen; sasas_from=LAPM.creamer_sasa)
```

![Figure S52](./figures/fig_S52_experimental_ab_creamer_urea.svg)

## Urea (Server)

### MoeserHorinek — Figure S53

```julia
plot_experimental(MoeserHorinek; sasas_from=LAPM.server_sasa)
```

![Figure S53](./figures/fig_S53_experimental_mh_server_urea.svg)

### AutonBolen — Figure S54

```julia
plot_experimental(AutonBolen; sasas_from=LAPM.server_sasa)
```

![Figure S54](./figures/fig_S54_experimental_ab_server_urea.svg)

## Other osmolytes

### Using mean denatured Creamer model — Figure S55

```julia
other_osmolytes(; type=2)
```

![Figure S55](./figures/fig_S55_other_osmolytes_mean.svg)

### Using maximally denatured Creamer model — Figure S56

```julia
other_osmolytes(; type=3)
```

![Figure S56](./figures/fig_S56_other_osmolytes_max.svg)

### Using minimally denatured Creamer model — Figure S57

```julia
other_osmolytes(; type=1)
```

![Figure S57](./figures/fig_S57_other_osmolytes_min.svg)

## SH3 and GB1 — Pielak data

Panel A is for unfolding of SH3, panel B for the dissociation of the GB1 dimer.

```julia
using PDBTools
using LAPM: os_pdb_files
```

### Using mean unfolded Creamer model — Figure S58

```julia
plt1 = plot_rydeen_folding(read_pdb(os_pdb_files["2AZS"]); type=2)
plt2 = plot_rydeen_dimmer(read_pdb(os_pdb_files["2RMM"]))
plot_rydeen_both(plt1, plt2)
```

![Figure S58](./figures/fig_S58_rydeen_mean.svg)

### Using maximally unfolded Creamer model — Figure S59

```julia
plt1 = plot_rydeen_folding(read_pdb(os_pdb_files["2AZS"]); type=3)
plt2 = plot_rydeen_dimmer(read_pdb(os_pdb_files["2RMM"]))
plot_rydeen_both(plt1, plt2)
```

![Figure S59](./figures/fig_S59_rydeen_max.svg)

### Using minimally unfolded Creamer model — Figure S60

```julia
plt1 = plot_rydeen_folding(read_pdb(os_pdb_files["2AZS"]); type=1)
plt2 = plot_rydeen_dimmer(read_pdb(os_pdb_files["2RMM"]))
plot_rydeen_both(plt1, plt2)
```

![Figure S60](./figures/fig_S60_rydeen_min.svg)
