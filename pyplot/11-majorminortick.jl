### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 663cd2f5-927a-4408-b852-d4d49ff173b3
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

# ╔═╡ caaeedbb-b9e6-473f-9dcb-26fce25b9b75
md"""

# Plot annotations

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_annotation.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ d0eedccd-d0a2-4f3d-8f94-d2e102474545
x = collect(0.0:0.01:100.0)

# ╔═╡ 309c116b-31d4-42ab-83a6-fc6f08153da7
y = @. sin(0.1pi*x) * exp(-0.01x)

# ╔═╡ 45d28378-2f0f-499b-8668-78772d5406ce
let
	fig, ax = plt.subplots(figsize=(10,10))
	
	ax.plot(x,y)
	ax.set_xlabel("X Axis")
	ax.set_ylabel("Y Axis")
	ax.grid("on")
	ax.set_title("Major and Minor Ticks")
	
	###########################
	#  Set the tick interval  #
	###########################
	Mx = matplotlib.ticker.MultipleLocator(20) # Define interval of major ticks
	f = matplotlib.ticker.FormatStrFormatter("%1.2f") # Define format of tick labels
	ax.xaxis.set_major_locator(Mx) # Set interval of major ticks
	ax.xaxis.set_major_formatter(f) # Set format of tick labels

	mx = matplotlib.ticker.MultipleLocator(5) # Define interval of minor ticks
	ax.xaxis.set_minor_locator(mx) # Set interval of minor ticks

	My = matplotlib.ticker.MultipleLocator(0.5) # Define interval of major ticks
	ax.yaxis.set_major_locator(My) # Set interval of major ticks

	my = matplotlib.ticker.MultipleLocator(0.1) # Define interval of minor ticks
	ax.yaxis.set_minor_locator(my) # Set interval of minor ticks
	
	ax.xaxis.set_tick_params(which="major",length=10,width=2,labelsize=16)
	ax.xaxis.set_tick_params(which="minor",length=5,width=2)

	fig
end

# ╔═╡ 083b772f-b465-43cb-b4bf-7b1b605fd9a8
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═caaeedbb-b9e6-473f-9dcb-26fce25b9b75
# ╠═d0eedccd-d0a2-4f3d-8f94-d2e102474545
# ╠═309c116b-31d4-42ab-83a6-fc6f08153da7
# ╠═45d28378-2f0f-499b-8668-78772d5406ce
# ╠═083b772f-b465-43cb-b4bf-7b1b605fd9a8
# ╠═663cd2f5-927a-4408-b852-d4d49ff173b3
