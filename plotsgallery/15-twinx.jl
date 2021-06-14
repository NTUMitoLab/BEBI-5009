### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ fa896250-c13a-4c99-b15a-7659a01f1950
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Measures", version="0.3"),
    ])
    using Plots, PlutoUI, Random, Measures
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ 9881ae40-bf95-11eb-04eb-5953bf3ced31
md"""
# Two Y Axis

[Source](https://goropikari.github.io/PlotsGallery.jl/src/two_y_axis.html)

`plot!(twinx())`
"""

# ╔═╡ d274fe32-53d2-4698-a25f-8c52c8f224fe
begin
	plot(randn(100), ylabel="y1", leg=:topright)
	plot!(twinx(), randn(100)*10,
		c=:red,
		ylabel="y2",
		leg=:bottomright,
		size=(600, 400))
	plot!(right_bottom=10mm)
end

# ╔═╡ 4c3c6cf7-33d9-41b6-a029-f7ea4ada5f99
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═9881ae40-bf95-11eb-04eb-5953bf3ced31
# ╠═d274fe32-53d2-4698-a25f-8c52c8f224fe
# ╠═4c3c6cf7-33d9-41b6-a029-f7ea4ada5f99
# ╠═fa896250-c13a-4c99-b15a-7659a01f1950
