### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 1ae7a28e-bedd-11eb-1520-ad10f0f4baa1
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

# ╔═╡ 8c89af75-6e4f-4e17-81e4-33acc9839f8e
md"""
# Heatmap

[Source](https://goropikari.github.io/PlotsGallery.jl/src/heatmap.html)

`heatmap(data)`
"""

# ╔═╡ 273cd9e9-9cfd-444e-9211-f8820df331c5
a = rand(5,5)

# ╔═╡ efc42b78-1d24-41b1-8cda-49a8010b7fe5
begin
	xlabel = string.(collect('A':'E'))
	ylabel = string.(collect('a':'e'))
	heatmap(a, xticks=(1:5, xlabel), 
			   yticks=(1:5, ylabel),
    		   aspect_ratio=:equal)
	
	fontsize = 15
	nrow, ncol = size(a)
	ann = [(i,j, text(round(a[i,j], digits=2), fontsize, :white, :center))
				for i in 1:nrow for j in 1:ncol]
	annotate!(ann, linecolor=:white)
end

# ╔═╡ 3fd9645d-f073-4b95-9e3f-0d0add120b54
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═8c89af75-6e4f-4e17-81e4-33acc9839f8e
# ╠═273cd9e9-9cfd-444e-9211-f8820df331c5
# ╠═efc42b78-1d24-41b1-8cda-49a8010b7fe5
# ╠═3fd9645d-f073-4b95-9e3f-0d0add120b54
# ╠═1ae7a28e-bedd-11eb-1520-ad10f0f4baa1
