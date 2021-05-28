### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 74752c55-473f-4441-b6a1-7584cc054603
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI
	using Plots
	PlutoUI.TableOfContents()
end

# ╔═╡ 2eb01818-2b95-4bd2-9028-c80b49f40dd5
md"""
# Contour Plots

## Function Contour plot

`contour(x1d, y1d, f)` where `f(x, y) = ...`

- [Source 1](https://goropikari.github.io/PlotsGallery.jl/src/contour_plot.html)
- [Source 2](https://goropikari.github.io/PlotsGallery.jl/src/fn_contour_plot.html)
"""

# ╔═╡ a45d1c9a-90f8-41fa-b3bf-3c270833746f
xs = range(0, stop=2, length=50)

# ╔═╡ dd45446f-96d5-4637-92c8-c3d05d40d306
ys = range(0, stop=2, length=50)

# ╔═╡ 77769100-0886-45f2-9a35-e22799f73fb6
f(x , y) = x^2 + y^2

# ╔═╡ 770da5b7-f215-4694-9dc3-2add86f6dfcd
contour(xs, ys, f)

# ╔═╡ 75ca8af7-33fa-4cd2-851d-0938a7690e38
md"""
## Contour plots with full matrices

[Source](https://goropikari.github.io/PlotsGallery.jl/src/contour_plot.html)

`contour(x1d, y1d, xy2d)`
"""

# ╔═╡ 456370cf-d6de-4564-9290-13a3345c038b
xx = [x for y in ys, x in xs]

# ╔═╡ b102bd3e-c0fc-4cca-acc4-4eac7b5c4a46
yy = [y for y in ys, x in xs]

# ╔═╡ a506fe4f-a01c-44d3-bf67-8a88a16f9279
contour(xs, ys, f.(xx, yy))

# ╔═╡ dac4181c-7771-4f08-8816-ebc2f2181ce7
md"""
# Filled Contour Plots

- `contour(xs, ys, f, fill=true)`
- `contourf(xs, ys, f)`
"""

# ╔═╡ 09138552-77a2-4937-b15b-a0c88bea1bc5
contour(0:0.01:5, 0:0.01:5, 
		(x, y) -> sin(3x) * cos(x+y), 
	    xlabel="x", ylabel="y", fill=true)

# ╔═╡ 8646c898-0d13-4f98-83fa-92d4bc57f9c9
contourf(0:0.01:5, 0:0.01:5, 
		(x, y) -> sin(3x) * cos(x+y), 
	    xlabel="x", ylabel="y")

# ╔═╡ 4c1edbc0-bede-11eb-2e76-a3b545f2ea00
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═2eb01818-2b95-4bd2-9028-c80b49f40dd5
# ╠═a45d1c9a-90f8-41fa-b3bf-3c270833746f
# ╠═dd45446f-96d5-4637-92c8-c3d05d40d306
# ╠═77769100-0886-45f2-9a35-e22799f73fb6
# ╠═770da5b7-f215-4694-9dc3-2add86f6dfcd
# ╠═75ca8af7-33fa-4cd2-851d-0938a7690e38
# ╠═456370cf-d6de-4564-9290-13a3345c038b
# ╠═b102bd3e-c0fc-4cca-acc4-4eac7b5c4a46
# ╠═a506fe4f-a01c-44d3-bf67-8a88a16f9279
# ╠═dac4181c-7771-4f08-8816-ebc2f2181ce7
# ╠═09138552-77a2-4937-b15b-a0c88bea1bc5
# ╠═8646c898-0d13-4f98-83fa-92d4bc57f9c9
# ╠═4c1edbc0-bede-11eb-2e76-a3b545f2ea00
# ╠═74752c55-473f-4441-b6a1-7584cc054603
