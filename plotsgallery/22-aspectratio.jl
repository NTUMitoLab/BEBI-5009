### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 290d46a2-d775-4402-ab48-981d854f5b33
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI
	using Plots
	using Random
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ b3f8a860-c10f-11eb-07cc-9d2fa87a70a0
md"""
# Aspect ratio

[Source](https://goropikari.github.io/PlotsGallery.jl/src/aspect_ratio.html)


"""

# ╔═╡ 40d0de0b-bd94-45b6-86e9-f080fd762f94
s = bitrand(10, 10)

# ╔═╡ a0d1a288-c388-4ab8-9e02-db6538f1af21
heatmap(s,
        aspect_ratio=:equal,
        c=:blues,
        colorbar=false)

# ╔═╡ 262117cd-bee6-4087-860c-699521b2c8d2
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═b3f8a860-c10f-11eb-07cc-9d2fa87a70a0
# ╠═40d0de0b-bd94-45b6-86e9-f080fd762f94
# ╠═a0d1a288-c388-4ab8-9e02-db6538f1af21
# ╠═262117cd-bee6-4087-860c-699521b2c8d2
# ╠═290d46a2-d775-4402-ab48-981d854f5b33
