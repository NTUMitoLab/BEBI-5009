### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 8b082b40-33a2-4d83-8c38-41226dc03763
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

# ╔═╡ 1cb9db30-c1f6-11eb-05d6-c353ad4b6554
md"""

# Pie Chart

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_annotation.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 45b6d65e-4443-4812-9e9f-04c2ba2fd6f8
labels = ["Lager";"Pilsner";"Stout";"IPA"]

# ╔═╡ 97851775-3277-4c60-aa12-027d20a85208
colors = ["yellowgreen";"gold";"lightskyblue";"lightcoral"]

# ╔═╡ 5cf6566d-32ac-4506-bef1-5d82e2d6747b
begin
	explode = zeros(length(labels))
	explode[2] = 0.1 # Move slice 2 out by 0.1
end

# ╔═╡ b30a6d51-6f8b-41ea-b72a-4255a291432f
sizes = [15; 30; 45; 10]

# ╔═╡ ff61b652-d1e3-459b-bac7-466422bc1d40
font = Dict("fontname"=>"Sans","weight"=>"semibold")

# ╔═╡ 0db088d7-145b-49a3-958e-658b4a2dd803
let
	fig, ax = plt.subplots(figsize=(10,10))
	ax.pie(sizes,
			labels=labels,
			shadow=true,
			startangle=90,
			explode=explode,
			colors=colors,
			autopct="%1.1f%%",
			textprops=font)
	ax.axis("equal")
	ax.set_title("Beer")
	fig
end

# ╔═╡ 0a813eeb-9cbc-4d1e-aaab-77fda52945bd
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═1cb9db30-c1f6-11eb-05d6-c353ad4b6554
# ╠═45b6d65e-4443-4812-9e9f-04c2ba2fd6f8
# ╠═97851775-3277-4c60-aa12-027d20a85208
# ╠═5cf6566d-32ac-4506-bef1-5d82e2d6747b
# ╠═b30a6d51-6f8b-41ea-b72a-4255a291432f
# ╠═ff61b652-d1e3-459b-bac7-466422bc1d40
# ╠═0db088d7-145b-49a3-958e-658b4a2dd803
# ╠═0a813eeb-9cbc-4d1e-aaab-77fda52945bd
# ╠═8b082b40-33a2-4d83-8c38-41226dc03763
