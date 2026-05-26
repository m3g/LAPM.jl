# Installation

## Install Julia

First you need to install the Julia language, version 1.10 or greater is required. 
Using the [juliaup](https://github.com/JuliaLang/juliaup) tool is a highly recommended way of installing and keeping Julia up to date.

Alternatively, you can install Julia by downloading the binaries directly from [the Julia webpage](https://julialang.org).

!!! note
    New to Julia? Julia is a modern high-level yet performant programming language. Some tips
    and a nice workflow for using it effectively can be found [here](https://m3g.github.io/JuliaNotes.jl/stable/workflow/). 

    For this specific package, following a the step-by-step examples provided here after installing Julia should be enough. 

## Install the packages

Within Julia, to install the packages required for running the examples here you need to do:

```julia-repl
julia> import Pkg

julia> Pkg.develop(url="https://github.com/m3g/LAPM.jl")

julia> using LAPM
```

## Generate all figures

The figures shown throughout this documentation are pre-generated SVG files stored in `docs/src/figures/`. To regenerate them (e.g. after modifying a plot function), run the following from the Julia REPL:

```julia-repl
julia> using LAPM

julia> generate_documentation_figures()
```

This will save all 58 supplementary figures to `docs/src/figures/`. After that, rebuild the documentation with:

```bash
julia --project=docs docs/make.jl
```

!!! note
    Generating all figures take some time because it runs the m-value calculations for all 36 test proteins, all nine cosolvents, and loads the full CATH-S20 dataset (~15k domains) for the fold-family plots.
