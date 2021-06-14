### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 071e8186-8b77-4525-8a74-d1ee39372def
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI
	using Plots
	using Random
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ 5b27aa50-bee0-11eb-22b3-099da27b84fd
md"""
# Polar Plots

[Source](https://goropikari.github.io/PlotsGallery.jl/src/polar.html)

`plot(..., proj=:polar)`
"""

# ╔═╡ e840dc7d-a696-4006-8488-682374b7cd1f
plot(θ -> 1 + cos(θ) * sin(θ)^2, 0, 2π, proj=:polar, lims=(0,1.5), legend=nothing)

# ╔═╡ a58ff241-3672-44f2-baef-084de453a040
r(θ) = 1 + cos(θ) * sin(θ)^2

# ╔═╡ 2c0c96c4-5aaa-4d45-b7ec-76c1d509f9b2
θ = range(0, stop=2π, length=50)

# ╔═╡ 506e02cf-8d05-40b2-8556-7ce19d14abe1
plot(θ, r.(θ), proj=:polar, lims=(0,1.5))

# ╔═╡ 53fa9dbe-6023-40c2-b7e8-d6408a2186e0
md"""
# Rose Plots

[Source](https://goropikari.github.io/PlotsGallery.jl/src/rose.html)

`plot(..., proj=:polar, line=:steppre)`
"""

# ╔═╡ 6f1f9d7c-1d35-469d-a7ae-c48b2626d60f
n = 24

# ╔═╡ 79573c5f-0f92-4dc7-873e-38b777197223
R = rand(n+1)

# ╔═╡ 5e31e51e-925c-4319-ae72-039c87c34274
plot(0:2pi/n:2pi, R, proj=:polar, line=:steppre, lims=(0:2), legend=nothing)

# ╔═╡ ad5c8ad4-cf40-4183-b216-7d809402615b
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═5b27aa50-bee0-11eb-22b3-099da27b84fd
# ╠═e840dc7d-a696-4006-8488-682374b7cd1f
# ╠═a58ff241-3672-44f2-baef-084de453a040
# ╠═2c0c96c4-5aaa-4d45-b7ec-76c1d509f9b2
# ╠═506e02cf-8d05-40b2-8556-7ce19d14abe1
# ╠═53fa9dbe-6023-40c2-b7e8-d6408a2186e0
# ╠═6f1f9d7c-1d35-469d-a7ae-c48b2626d60f
# ╠═79573c5f-0f92-4dc7-873e-38b777197223
# ╠═5e31e51e-925c-4319-ae72-039c87c34274
# ╠═ad5c8ad4-cf40-4183-b216-7d809402615b
# ╠═071e8186-8b77-4525-8a74-d1ee39372def
