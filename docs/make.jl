using Documenter
using ConstrainedDynamicsVis

makedocs(;
    modules = [ConstrainedDynamicsVis],
    format = Documenter.HTML(
        canonical = "https://janbruedigam.github.io/ConstrainedDynamicsVis.jl/stable/",
        assets = ["assets/favicon.ico"],
    ),
    pages = [
        "Home" => "index.md",
    ],
    sitename = "ConstrainedDynamicsVis.jl"
)

deploydocs(; repo = "github.com/janbruedigam/ConstrainedDynamicsVis.jl")