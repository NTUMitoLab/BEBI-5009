### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ bd4d278a-6f1e-4dbe-bfb9-147fe3d45aca
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

# ╔═╡ 5a6e9bd0-bf96-11eb-3558-d3aa5bd2608e
md"""
# Subplots


## Simple subplots

[Source](https://goropikari.github.io/PlotsGallery.jl/src/subplot1.html)

`plot(p1, p2, p3, ...)`
"""

# ╔═╡ 14044b4f-ea08-474f-b3c0-27404dff8e25
a = plot(sin, 0, 2pi, xlabel="x1")

# ╔═╡ c92e2c27-855c-4110-b3aa-840f2c4f348e
b = plot(cos, 0, 2pi, xlabel="x2")

# ╔═╡ 53272e62-ce2c-405f-b7b4-e4ace06ea9cb
c = histogram(randn(1000), xlabel="x3")

# ╔═╡ 7d2f24c7-8328-46e8-98ef-f728bb9e5e5c
d = plot(x->exp(-x^2), -3, 3, xlabel="x4")

# ╔═╡ 68816e8e-cf20-48f1-b484-1fa8da8420f0
plot(a, b, c, d)

# ╔═╡ 76fc6438-72c3-412d-82d6-4af9e6e8063d
md"""
## Subplots with custom layouts

[Source](https://goropikari.github.io/PlotsGallery.jl/src/subplot2.html)
[Source](https://goropikari.github.io/PlotsGallery.jl/src/subplot3.html)

`plot(..., layout=(nrow, ncol))`
"""

# ╔═╡ d85ed381-fa58-497a-aea3-3a802442fca7
plot(a, b, c, d, layout=(1,4), size=(1000, 300))

# ╔═╡ 5948bc7e-48b1-4edd-81b2-4df67a45797f
plot(a, b, c, d, layout=(4,1), size=(300, 800))

# ╔═╡ af5a7c9e-68a3-4be7-85ce-8ce4b9c3d620
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═5a6e9bd0-bf96-11eb-3558-d3aa5bd2608e
# ╠═14044b4f-ea08-474f-b3c0-27404dff8e25
# ╠═c92e2c27-855c-4110-b3aa-840f2c4f348e
# ╠═53272e62-ce2c-405f-b7b4-e4ace06ea9cb
# ╠═7d2f24c7-8328-46e8-98ef-f728bb9e5e5c
# ╠═68816e8e-cf20-48f1-b484-1fa8da8420f0
# ╠═76fc6438-72c3-412d-82d6-4af9e6e8063d
# ╠═d85ed381-fa58-497a-aea3-3a802442fca7
# ╠═5948bc7e-48b1-4edd-81b2-4df67a45797f
# ╠═af5a7c9e-68a3-4be7-85ce-8ce4b9c3d620
# ╠═bd4d278a-6f1e-4dbe-bfb9-147fe3d45aca
