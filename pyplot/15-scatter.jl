### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 6a265f59-444f-4d6d-8dc8-a21b8f6cc57d
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI, Random
	import PyPlot as plt
	Random.seed!(2021)
	PlutoUI.TableOfContents()
end

# ╔═╡ f7085260-c1f8-11eb-2b11-71467c0f822e
md"""

# Scatter Plot

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_scatterplot.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 2706d103-6130-4d28-bb20-d9a3085c210b
x = 100*rand(50)

# ╔═╡ e0470203-ac21-46b4-82c2-16f36ba305ce
y = 100*rand(50)

# ╔═╡ 0dc3ba07-a997-4d40-b338-f31a563540c1
areas = 800*rand(50)

# ╔═╡ a082e7ac-67fa-4dac-bd8d-5528c43b2ccf
let
	fig, ax = plt.subplots(figsize=(10,10))
	ax.scatter(x,y,s=areas,alpha=0.5)
	
	ax.set_title("Scatter Plot")
	ax.set_xlabel("X")
	ax.set_ylabel("Y")
	ax.grid("on")
	
	fig
end

# ╔═╡ 1e26e597-7804-44ac-bf9e-2748c7b5ec59
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═f7085260-c1f8-11eb-2b11-71467c0f822e
# ╠═2706d103-6130-4d28-bb20-d9a3085c210b
# ╠═e0470203-ac21-46b4-82c2-16f36ba305ce
# ╠═0dc3ba07-a997-4d40-b338-f31a563540c1
# ╠═a082e7ac-67fa-4dac-bd8d-5528c43b2ccf
# ╠═1e26e597-7804-44ac-bf9e-2748c7b5ec59
# ╠═6a265f59-444f-4d6d-8dc8-a21b8f6cc57d
