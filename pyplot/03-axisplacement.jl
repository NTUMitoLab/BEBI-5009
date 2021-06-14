### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ b8329bcb-b280-4d8c-8b05-67a92a6e11ef
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="LaTeXStrings", version="1"),
    ])
    using PlutoUI, Dates, LaTeXStrings
	import PyPlot as plt
	PlutoUI.TableOfContents()
end

# ╔═╡ 5d000a10-c120-11eb-15be-393d9949bdab
md"""
# Axis placement

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_axis_placement.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 20a3a64e-4081-43b2-bac2-382de45a3b41
md"""
Generate Data
"""

# ╔═╡ 9a3e7c72-f8f7-4e32-8ba0-5e86792995d0
x = 0:pi/50:2pi

# ╔═╡ 56229857-d4b0-492d-8e06-f7ce2d1e84a8
y = sin.(x)

# ╔═╡ e67fd1e6-2679-46d8-8b0a-1f92bc7b3d57
md"""
Plot data
"""

# ╔═╡ b0cd08d2-1034-4ba4-a1b8-ec348f56e0c0
begin
	fig, axs = plt.subplots(2, 1, figsize = (10, 10))
	
	ax = axs[1]
	
	ax.plot(x,y)
	ax.axis("tight")
	ax.spines["top"].set_visible(false) # Hide the top edge of the axis
	ax.spines["right"].set_visible(false) # Hide the right edge of the axis
	ax.spines["left"].set_position("center") # Move the right axis to the center
	ax.spines["bottom"].set_position("center") # Most the bottom axis to the center
	ax.xaxis.set_ticks_position("bottom") # Set the x-ticks to only the bottom
	ax.yaxis.set_ticks_position("left") # Set the y-ticks to only the left
	
	ax = axs[2]
	
	ax.plot(x,y)
	ax.axis("tight")
	ax.spines["top"].set_visible(false) # Hide the top edge of the axis
	ax.spines["right"].set_visible(false) # Hide the right edge of the axis
	ax.xaxis.set_ticks_position("bottom")
	ax.yaxis.set_ticks_position("left")
	ax.spines["left"].set_position(("axes",-0.03)) # Offset the left scale from the axis
	ax.spines["bottom"].set_position(("axes",-0.05)) # Offset the bottom scale from the axis
	ax.set_xlabel("X Axis")
	ax.set_ylabel("Y Axis")
	
	fig
end

# ╔═╡ ebf43d8c-dc7b-48fb-b7ab-853de73d3640
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═5d000a10-c120-11eb-15be-393d9949bdab
# ╠═20a3a64e-4081-43b2-bac2-382de45a3b41
# ╠═9a3e7c72-f8f7-4e32-8ba0-5e86792995d0
# ╠═56229857-d4b0-492d-8e06-f7ce2d1e84a8
# ╠═e67fd1e6-2679-46d8-8b0a-1f92bc7b3d57
# ╠═b0cd08d2-1034-4ba4-a1b8-ec348f56e0c0
# ╠═ebf43d8c-dc7b-48fb-b7ab-853de73d3640
# ╠═b8329bcb-b280-4d8c-8b05-67a92a6e11ef
