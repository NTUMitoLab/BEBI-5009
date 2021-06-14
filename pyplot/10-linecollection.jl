### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 09edaf1e-58fc-4327-a990-a7f3ef7514b5
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PyCall", version="1"),
    ])
    using PlutoUI
	import PyPlot as plt
	using PyCall
	
	matplotlib = pyimport("matplotlib")
	PlutoUI.TableOfContents()
end

# ╔═╡ a9372f50-c1f0-11eb-3ab7-5d08fba45fff
md"""

# Line collections

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_linecollection.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ ae494907-a6db-4865-ab87-c2e35ce43a95
begin
	lines = Any[collect(zip([1.,3.,5.,0.],[2.,4.,.06,0.]))]
	push!(lines,collect(zip([3.,4],[5.,6])))
	push!(lines,collect(zip([8.,2],[2.,4])))
end

# ╔═╡ 574ee5f1-5394-4fa5-86a9-b6528592cfb6
##############
##  Colors  ##
##############
# Line segments will be plotted with the following order of colors and will
# cycle back to the beginning of the array when it has gone through all of them
c = Vector{Int}[[1,0,0],[0,1,0],[0,0,1]]

# ╔═╡ fb1130c7-2515-4440-b3ad-ba3f0327f51c
let
	# Assemble everything into a LineCollection
	line_segments = matplotlib.collections.LineCollection(lines,colors=c)
	
	fig, ax = plt.subplots(figsize=(10,10))
	ax.add_collection(line_segments)
	ax.axis("image") # Tight axis and 1:1 aspect ratio
	fig
end

# ╔═╡ 79d23b42-735a-4a17-97e8-a8cddb7a9ae3
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═a9372f50-c1f0-11eb-3ab7-5d08fba45fff
# ╠═ae494907-a6db-4865-ab87-c2e35ce43a95
# ╠═574ee5f1-5394-4fa5-86a9-b6528592cfb6
# ╠═fb1130c7-2515-4440-b3ad-ba3f0327f51c
# ╠═79d23b42-735a-4a17-97e8-a8cddb7a9ae3
# ╠═09edaf1e-58fc-4327-a990-a7f3ef7514b5
