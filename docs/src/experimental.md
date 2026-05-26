# Experimental

```@example mvalue
using LAPM
```

These plots benchmark model predictions against experimental m-values. The urea sections (Figures 4 and 5 of the paper) compare MH, AB, and MoeserHorinekFit predictions against a 36-protein test set, showing that all models correlate well with experiment (slopes within ~15% of unity). The other-osmolyte section validates the AB and MoeserHorinekFit models against experimental data for the full set of AB cosolvents. The SH3/GB1 section (Figure 6) compares predictions against the Rydeen et al. (2018) dataset for SH3 unfolding and GB1 dimer dissociation.

## Urea (Creamer)

```@example mvalue
plot_experimental(MoeserHorinek; sasas_from=LAPM.creamer_sasa)
```

```@example mvalue
plot_experimental(AutonBolen; sasas_from=LAPM.creamer_sasa)
```

## Urea (Server)

```@example mvalue
plot_experimental(MoeserHorinek; sasas_from=LAPM.server_sasa)
```

```@example mvalue
plot_experimental(AutonBolen; sasas_from=LAPM.server_sasa)
```

## Other osmolytes

### Using mean denatured Creamer model

```@example mvalue
other_osmolytes(; type=2)
```

### Using maximally denatured Creamer model

```@example mvalue
other_osmolytes(; type=3)
```

### Using minimially denatured Creamer model

```@example mvalue
other_osmolytes(; type=1)
```

## SH3 and DM1 - Pielak data.

Pannel A is for unfolding of SH3, pannel B for the dissociation of the GB1 dimer.

```@example mvalue
using PDBTools
using LAPM: os_pdb_files
```

### Using mean unfolded Creamer model (in A) 

```@example mvalue
plt1 = plot_rydeen_folding(read_pdb(os_pdb_files["2AZS"]); type=2)
plt2 = plot_rydeen_dimmer(read_pdb(os_pdb_files["2RMM"]))
plot_rydeen_both(plt1, plt2)
```

### Using maximally unfolded Creamer model (in A) 

```@example mvalue
plt1 = plot_rydeen_folding(read_pdb(os_pdb_files["2AZS"]); type=3)
plt2 = plot_rydeen_dimmer(read_pdb(os_pdb_files["2RMM"]))
plot_rydeen_both(plt1, plt2)
```

### Using minimally unfolded Creamer model (in A) 

```@example mvalue
plt1 = plot_rydeen_folding(read_pdb(os_pdb_files["2AZS"]); type=1)
plt2 = plot_rydeen_dimmer(read_pdb(os_pdb_files["2RMM"]))
plot_rydeen_both(plt1, plt2)
```






