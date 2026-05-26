# Reproduction of Creamer ASA

This section validates the from-scratch reproduction of the Creamer denatured-state SASA model. The Creamer model estimates backbone and side-chain SASAs of a central residue by extracting overlapping fragments of five consecutive residues from folded protein structures, computing the average over all occurrences of each residue type in both as-found and extended conformations. Agreement between our computed values and Creamer's published backbone and side-chain lower and upper bounds validates both the fragment extraction procedure and the SASA implementation (Supplementary Figures S1 and S2 of the paper).

## Figure 2 of Creamer

![./figures/creamer_fig2.png](./figures/creamer_fig2.png)

## Comparison of BB and SC ASAs

![./figures/ASA_creamer_vs_LAPM.png](./figures/ASA_creamer_vs_LAPM.png)

## Using the parameterized united atom model

### For a single structure:

```@example creamerua
using LAPM
using PDBTools
pdb = read_pdb(LAPM.pdb_files["1AO3"], "protein and not element H")
LAPM.mvalue_ua(pdb)
```

### All results vs. experimental values

```@example creamerua
LAPM.plot_ua()
```

### All results vs. other models

```@example creamerua
LAPM.plot_mvalue_ua()
```


