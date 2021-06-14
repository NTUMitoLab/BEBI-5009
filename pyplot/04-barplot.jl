### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 313c8b2e-4d7d-4fd4-b7f4-8632880bdf66
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI, Dates
	import PyPlot as plt
	PlutoUI.TableOfContents()
end

# ╔═╡ f8f8d270-c121-11eb-28b9-ebb437b1c0dd
md"""
# Bar plot

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_barplot.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)


"""

# ╔═╡ 87721773-5906-48ec-89e1-0e78cb60a56e
# Data
x = [1:1:50;]

# ╔═╡ 01debc5e-61b5-49da-b89a-c735772abace
y = 100*rand(50)

# ╔═╡ 24a84a63-1d6a-4eb3-8061-04865256c5d1
begin
	fig, axs = plt.subplots(2, 1, figsize=(10,10))
	
	ax = axs[1]
	
	ax.bar(x,y,color="#0f87bf",align="center",alpha=0.4)
	ax.axis("tight")
	ax.grid("on")
	ax.set_title("Vertical Bar Plot")
	ax.set_xlabel("X")
	ax.set_ylabel("Y")
	
	ax = axs[2]
	ax.barh(x,y,color="#0f87bf",align="center",alpha=0.4)
	ax.axis("tight")
	ax.set_title("Horizontal Bar Plot")
	ax.grid("on")
	ax.set_xlabel("X")
	ax.set_ylabel("Y")
	
	fig.suptitle("Bar Plot Examples")
	
	fig
end

# ╔═╡ c91a90ce-20b9-4386-a595-22f167ba0dd8
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═f8f8d270-c121-11eb-28b9-ebb437b1c0dd
# ╠═87721773-5906-48ec-89e1-0e78cb60a56e
# ╠═01debc5e-61b5-49da-b89a-c735772abace
# ╠═24a84a63-1d6a-4eb3-8061-04865256c5d1
# ╠═c91a90ce-20b9-4386-a595-22f167ba0dd8
# ╠═313c8b2e-4d7d-4fd4-b7f4-8632880bdf66
