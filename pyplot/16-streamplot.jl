### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 7b5a05df-9f4c-4614-8d61-20905c28a421
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

# ╔═╡ 65b45253-8377-4b6c-a667-db20949406b2
md"""
# Stream Plot

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_streamplot.jl.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ f0fa1f74-b8e0-4d3d-bb5c-9c290fac8941
begin
	minval = -3
	maxval = 3
	steps = 100
	X = repeat(range(minval,stop=maxval,length=steps)',steps)
	Y = repeat(range(minval,stop=maxval,length=steps),1,steps)
	U = -1 .- X.^2 .+ Y
	V = 1 .+ X .- Y.^2
	speed = sqrt.(U.^2 .+ V.^2)
end

# ╔═╡ a844c877-2cf1-43a8-bcbd-0171a30061c3
let
	fig, axes = plt.subplots(3, 1, figsize=(10,10))
	
	axes[1].streamplot(X,Y,U,V)
	axes[2].streamplot(X,Y,U,V,color=U,linewidth=2,cmap=plt.cm.autumn)
	
	lw = 5 .* speed ./ maximum(speed) # Line Widths
	axes[3].streamplot(X,Y,U,V,density=0.6,color="k",linewidth=lw)
	
	fig.suptitle("Stream Plot Examples")
	
	fig
end

# ╔═╡ 7ae1ed20-c1ff-11eb-3cc3-259a1dfabfa7
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═65b45253-8377-4b6c-a667-db20949406b2
# ╠═f0fa1f74-b8e0-4d3d-bb5c-9c290fac8941
# ╠═a844c877-2cf1-43a8-bcbd-0171a30061c3
# ╠═7ae1ed20-c1ff-11eb-3cc3-259a1dfabfa7
# ╠═7b5a05df-9f4c-4614-8d61-20905c28a421
