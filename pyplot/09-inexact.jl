### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ df68e06d-5c06-41bb-99da-c9aa6d8340db
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI
	import PyPlot as plt
	plt.xkcd()
	PlutoUI.TableOfContents()
end

# ╔═╡ dc9f3d20-c1ef-11eb-39e7-91af84eaed03
md"""

# Demonstrate XKCD style inexact plots

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_inexact.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 0c6ab8ad-6710-43ae-8c0f-911a2559ed9a
x = [1:1:100;]

# ╔═╡ 06623f38-6025-43d4-9a00-9608c123761f
begin
	y = ones(100)
	for i=70:1:100
		y[i] = y[i] - (0.7/30)*(i-70)
	end
end

# ╔═╡ c960719a-01eb-4209-9b72-827b6892ea7f
begin
	fig, ax = plt.subplots(figsize=(10,10))
	ax.plot(x,y)
	ax.set_ylim([0.2;1.1])
	ax.annotate("THE DAY I REALIZED\nI COULD COOK BACON\nWHENEVER I WANTED",xy=[70;1],arrowprops=Dict("arrowstyle"=>"->"),xytext=[25;0.8])
	
	ax.set_xticks([])
	ax.set_yticks([])
	ax.set_xlabel("TIME")
	ax.set_ylabel("MY OVERALL HEALTH")
	ax.set_title("Stove Owndership\nhttp://xkcd.com/418/")
	ax.spines["top"].set_color("none") # Remove the top axis boundary
	ax.spines["right"].set_color("none") # Remove the right axis boundary
	
	fig
end

# ╔═╡ 00ce6e6f-137b-480f-9079-eb19ef90c23c
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═dc9f3d20-c1ef-11eb-39e7-91af84eaed03
# ╠═0c6ab8ad-6710-43ae-8c0f-911a2559ed9a
# ╠═06623f38-6025-43d4-9a00-9608c123761f
# ╠═c960719a-01eb-4209-9b72-827b6892ea7f
# ╠═00ce6e6f-137b-480f-9079-eb19ef90c23c
# ╠═df68e06d-5c06-41bb-99da-c9aa6d8340db
