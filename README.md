[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://m3g.github.io/LAPM.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://m3g.github.io/LAPM.jl/dev)
[![Tests](https://img.shields.io/badge/build-passing-green)](https://github.com/m3g/LAPM.jl/actions)
[![Build Status](https://github.com/m3g/LAPM.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/m3g/LAPM.jl/actions/workflows/CI.yml?query=branch%3Amain)

# LAPM.jl

Supplementary information repository for the paper:

> A. B. B. Lima, A. F. Pereira, L. V. Araújo, W. Tárraga, C. A. Tavares, J. de Oliveira Araújo, L. Martínez,
> **Osmolyte Effects on Protein Conformations: Self-contained, Free, Fast Implementations of Additive Transfer Models with Novel Glycine-Activity Corrections for Multi-Cosolvent Predictions**, 2026.

This package contains the validation scripts, reference datasets, and analysis code used to benchmark the Auton–Bolen (AB), Moeser–Horinek (MH), and MoeserHorinekApp implementations available in [PDBTools.jl](https://m3g.github.io/PDBTools.jl).

## Contents

- **Validation against the AB server** — m-value predictions for 36 protein structures compared against outputs of the Auton–Bolen web server, using both server SASAs and Creamer-model SASAs.
- **Reproduction of the Creamer denatured-state SASA model** — from-scratch computation of backbone and side-chain SASA statistics for all 20 residue types, validated against Creamer's published values for 43 reference proteins.
- **MH vs AB comparison** — systematic comparison of total, backbone, and side-chain m-value contributions, revealing large model differences in backbone/side-chain partitioning despite good agreement in total m-values.
- **MoeserHorinekApp model** — The MH universal backbone treatment to all nine cosolvents covered by the AB parameterization, using apparent transfer free energies.
- **Comparison with experimental m-values** — benchmark of MH, AB, and MoeserHorinekApp predictions against experimental urea m-values and other osmolytes, including the Rydeen et al. (2018) dataset for SH3 unfolding and GB1 dimer dissociation.
- **Backbone and side-chain contributions across fold families** — analysis of per-residue m-value contributions across ~15k non-homologous domains from the CATH-S20 database, classified by secondary structure content.

## Installation

Julia 1.10 or greater is required. Install [Julia](https://julialang.org) or use [juliaup](https://github.com/JuliaLang/juliaup) to manage versions.

```julia-repl
julia> import Pkg

julia> Pkg.develop(url="https://github.com/m3g/LAPM.jl")

julia> using LAPM
```

## Documentation

Full documentation with all validation plots is available at:
https://m3g.github.io/LAPM.jl

The transfer free energy models themselves are documented in PDBTools.jl:
https://m3g.github.io/PDBTools.jl

## Reference

The implementations benchmarked here are part of PDBTools.jl:

> L. Martínez, A. B. B. Lima, **PDBTools.jl: A Lightweight and High-Performance Julia Package for Molecular Structure File Handling and Analysis**, *J. Chem. Inf. Model.*, 2026. https://doi.org/10.1021/acs.jcim.6c00847
