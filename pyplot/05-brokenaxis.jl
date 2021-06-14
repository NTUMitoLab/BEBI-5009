### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ a95a594c-cdf4-4107-bae9-18b0a019fa2e
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="PyCall", version="1"),
    ])
    using PlutoUI, PyCall
	import PyPlot as plt
	
	axes_grid1 = pyimport("mpl_toolkits.axes_grid1")

	PlutoUI.TableOfContents()
end

# ╔═╡ 9c7feb90-c122-11eb-2d75-093b53e37d26
md"""
# Broken Axis Subplots

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_brokenAxisSubplot.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 9aba48bf-96f9-4fe1-be6a-6c8bd1eef9e4
# Data
begin
	x = rand(100)
	y = rand(100)
	y2 = rand(100).+10
end;

# ╔═╡ 1c98d1f9-466f-4a24-a342-44ceca173321
let
	fig, axes = plt.subplots(2, 1, figsize=(10,10), sharex=true)
	
	ax = axes[1]
	divider = axes_grid1.make_axes_locatable(ax)
	ax2 = divider.new_vertical(size="100%", pad=0.1)
	fig.add_axes(ax2)
	
	# Lower Portion of First Plot
	ax.scatter(x, y)
	ax.set_ylim(0, 1)
	ax.spines["top"].set_visible(false)
	
	# Upper Portion of First Plot
	ax2.scatter(x, y2)
	ax2.set_ylim(10, 11)
	ax2.tick_params(bottom="off", labelbottom="off")
	ax2.spines["bottom"].set_visible(false)
	
	###############################
	##  Add Line Break Markings  ##
	###############################
	# From https://matplotlib.org/examples/pylab_examples/broken_axis.html
	
	# Upper Line Break Markings
	d = 0.015  # how big to make the diagonal lines in axes coordinates
	ax2.plot((-d, +d), (-d, +d), transform=ax2.transAxes, color="k", clip_on=false,linewidth=0.8)        # Left diagonal
	ax2.plot((1 - d, 1 + d), (-d, +d), transform=ax2.transAxes, color="k", clip_on=false,linewidth=0.8)  # Right diagonal

	# Lower Line Break Markings
	ax.plot((-d, +d), (1 - d, 1 + d), transform=ax.transAxes, color="k", clip_on=false,linewidth=0.8)  # Left diagonal
	ax.plot((1 - d, 1 + d), (1 - d, 1 + d), transform=ax.transAxes, color="k", clip_on=false,linewidth=0.8)  # Right diagonal
	
	###################
	##  Second Plot  ##
	###################
	axes[2].scatter(x, y)


	fig
end

# ╔═╡ 3d118dfa-95d2-4f8d-8d06-f284608756c3
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═9c7feb90-c122-11eb-2d75-093b53e37d26
# ╠═9aba48bf-96f9-4fe1-be6a-6c8bd1eef9e4
# ╠═1c98d1f9-466f-4a24-a342-44ceca173321
# ╠═3d118dfa-95d2-4f8d-8d06-f284608756c3
# ╠═a95a594c-cdf4-4107-bae9-18b0a019fa2e
