### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ af8f979d-4caf-4012-92cf-c4362ba37708
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Measures", version="0.3"),
    ])
    using Plots, PlutoUI, Measures, Random, Dates
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ cc86cb1f-639f-48e7-b178-4ba00be3e377
md"""
# Datetime plot

- [Source](https://goropikari.github.io/PlotsGallery.jl/src/datetime_plot.html)
- [Related Plots.jl issue](https://github.com/JuliaPlots/Plots.jl/issues/356)
"""

# ╔═╡ be3d90f1-e871-4de0-83a4-d9db7394a4b5
days = 31

# ╔═╡ 041055c1-3925-4a99-8a73-804e744ffd36
position = cumsum(randn(days))

# ╔═╡ 595102a6-9d2d-4694-9752-3d75c6ee8c80
x = Date(2018,1,1):Day(1):Date(2018,1,31)

# ╔═╡ 6d119cf6-5f27-48ff-8eff-1422c69af5ad
ticks = [x[i] for i in 1:5:length(x)]

# ╔═╡ 82a8033e-5379-4e4e-a1e8-6ab340394fed
plot(x, position,
     xlabel="Date",
     ylabel="Position",
     title="Track of random walker",
	 legend=nothing,
     xticks=ticks,
     xrotation=45,
     bottom_margin=15mm,
     left_margin=5mm)

# ╔═╡ 1f829730-becc-11eb-17ba-973a7055a4b9
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═cc86cb1f-639f-48e7-b178-4ba00be3e377
# ╠═be3d90f1-e871-4de0-83a4-d9db7394a4b5
# ╠═041055c1-3925-4a99-8a73-804e744ffd36
# ╠═595102a6-9d2d-4694-9752-3d75c6ee8c80
# ╠═6d119cf6-5f27-48ff-8eff-1422c69af5ad
# ╠═82a8033e-5379-4e4e-a1e8-6ab340394fed
# ╠═1f829730-becc-11eb-17ba-973a7055a4b9
# ╠═af8f979d-4caf-4012-92cf-c4362ba37708
