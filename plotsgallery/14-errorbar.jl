### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ d65c65e9-1089-4955-82dc-0eee07e15f83
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

# ╔═╡ f0ef4610-bf94-11eb-1238-2bd711dafced
md"""
# Error bar

[Source](https://goropikari.github.io/PlotsGallery.jl/src/error_bar.html)

`plots(..., xerr=xe, yerr=ye)`
"""

# ╔═╡ 0284922a-75fb-4767-8192-e378d4e1b366
f(x) = 2 * x + 1

# ╔═╡ 3871ef0a-9885-4a1f-9dd6-d0857adec2f4
x = 0:0.1:2

# ╔═╡ 8e5dd014-eea1-47d1-b80d-f6b8af898d60
n = length(x)

# ╔═╡ 785ca683-1b0f-4ae2-a99c-660bfcb8b27e
y = f.(x) + randn(n)

# ╔═╡ 43f9e140-5a38-4076-a0cb-c1fb732a53e4
plot(x, y,
    xerr=0.1 * rand(n),
    yerr=rand(n),
	legend=nothing)

# ╔═╡ c53a6aba-7cc2-4a8e-8adc-46aed3533734
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═f0ef4610-bf94-11eb-1238-2bd711dafced
# ╠═0284922a-75fb-4767-8192-e378d4e1b366
# ╠═3871ef0a-9885-4a1f-9dd6-d0857adec2f4
# ╠═8e5dd014-eea1-47d1-b80d-f6b8af898d60
# ╠═785ca683-1b0f-4ae2-a99c-660bfcb8b27e
# ╠═43f9e140-5a38-4076-a0cb-c1fb732a53e4
# ╠═c53a6aba-7cc2-4a8e-8adc-46aed3533734
# ╠═d65c65e9-1089-4955-82dc-0eee07e15f83
