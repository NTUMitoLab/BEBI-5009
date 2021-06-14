### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 08516166-fbf5-4517-99da-22f8e18b269b
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
		Pkg.PackageSpec(name="StatsPlots", version="0.14"),
    ])
	using Plots, PlutoUI, StatsPlots, Statistics, Random
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ 3d486b6d-7689-45c7-a4d6-a4bb0f253078
md"""
# Box plots

## Box plots (I)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/boxplot.html)
"""

# ╔═╡ 2d302734-79e8-482a-9e44-0e52773a06b5
n = 30

# ╔═╡ a27be897-3adc-475c-a557-b1322fa239a2
science = rand(1:10, n)

# ╔═╡ e62a0a09-ba87-4efa-9bf4-af3db68278cf
median(science)

# ╔═╡ 61cafde9-7f3d-4f34-800c-5adcf6a4fd8b
boxplot(science, label=permutedims(["science"]))

# ╔═╡ 80de6507-7885-44d6-80e7-f30447ba621b
md"""
## Box plots (II)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/boxplot2.html)
"""

# ╔═╡ 7fdf2bbd-5796-4dc2-a16e-83fc3b1b489e
english = rand(1:10, n)

# ╔═╡ 4529be89-37e9-423b-a82b-8165791c92a3
median(science), median(english)

# ╔═╡ 58491863-530d-4f17-9cc3-3e77df9d7f8d
boxplot([science english], label=["science" "english"])

# ╔═╡ a0253e50-bedc-11eb-3ec3-a94494d0a05c
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═3d486b6d-7689-45c7-a4d6-a4bb0f253078
# ╠═2d302734-79e8-482a-9e44-0e52773a06b5
# ╠═a27be897-3adc-475c-a557-b1322fa239a2
# ╠═e62a0a09-ba87-4efa-9bf4-af3db68278cf
# ╠═61cafde9-7f3d-4f34-800c-5adcf6a4fd8b
# ╠═80de6507-7885-44d6-80e7-f30447ba621b
# ╠═7fdf2bbd-5796-4dc2-a16e-83fc3b1b489e
# ╠═4529be89-37e9-423b-a82b-8165791c92a3
# ╠═58491863-530d-4f17-9cc3-3e77df9d7f8d
# ╠═a0253e50-bedc-11eb-3ec3-a94494d0a05c
# ╠═08516166-fbf5-4517-99da-22f8e18b269b
