import Pkg
Pkg.add("Documenter")
using Documenter
using PDBTools
using Plots
push!(LOAD_PATH, "../src/")
makedocs(
    sitename="LAPM.jl",
    pages=[
        "Introduction" => "index.md",
        #"Install and run" => Any[ 
        #    "Installation" => "installation.md",
        #    "Parallel execution" => "parallel.md",
        #    "From Python" => "python.md",
        #],
        "References" => "references.md",
    ],
)
deploydocs(
    repo="github.com/m3g/LAPM.jl.git",
    target="build",
    branch="gh-pages",
    versions=["stable" => "v^", "v#.#"],
)
