### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 9f227048-d9c6-48c1-818f-ccdf9027ffd5
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI
	import PyPlot as plt
	PlutoUI.TableOfContents()
end

# ╔═╡ 0e2f7db0-c1ef-11eb-0311-91e9054aaaa9
md"""

# Histogram

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_histogram.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 73646f70-3c34-45c1-a73d-c73ed9792bc2
x = randn(1000) # Values

# ╔═╡ 3fd5cfd6-28e5-449f-b237-40c8525422ab
nbins = 50; # Number of bins

# ╔═╡ bdd2a683-9085-49a0-8895-0356ca1bdf44
begin
	fig, ax = plt.subplots(figsize=(10,10))
	
	ax.hist(x,nbins) # Histogram
	
	ax.grid("on")
	ax.set_xlabel("X")
	ax.set_ylabel("Y")
	ax.set_title("Histogram")
	
	fig
end

# ╔═╡ a2a90dbc-1143-4059-be64-ba91d7615b62
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═0e2f7db0-c1ef-11eb-0311-91e9054aaaa9
# ╠═73646f70-3c34-45c1-a73d-c73ed9792bc2
# ╠═3fd5cfd6-28e5-449f-b237-40c8525422ab
# ╠═bdd2a683-9085-49a0-8895-0356ca1bdf44
# ╠═a2a90dbc-1143-4059-be64-ba91d7615b62
# ╠═9f227048-d9c6-48c1-818f-ccdf9027ffd5
