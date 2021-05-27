### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 254313f1-29dc-44e8-81dc-4b7b4e69770b
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

# ╔═╡ ba257c70-bee1-11eb-112c-4d4215e50eb7
md"""
# Scatter Plots (2D)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/scatter2d.html)

`scatter(xpos, ypos)`
"""

# ╔═╡ 316e203a-b8ab-4b36-9d4d-601b951d6c95
n = 50

# ╔═╡ acccc84e-df8e-46ff-8b32-e5116a624eeb
x = rand(n)

# ╔═╡ 6787b927-2b3d-4b3c-af54-c355f2239fa9
y = rand(n)

# ╔═╡ 56dc4552-18f6-499d-9fe4-1ca71bd3dcfe
ms = rand(50) * 30

# ╔═╡ 481e51c0-9aae-4f4c-a9ed-cc4583c9412b
scatter(x, y, markersize=ms)

# ╔═╡ be81f8d5-e07e-4cdf-95b9-486632819924
md"""
# Scatter Plots (3D)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/scatter3d.html)

`scatter(xpos, ypos, zpos)`
"""

# ╔═╡ c0658880-3a91-4aa8-83a0-33abb28fdd6d
z = rand(n)

# ╔═╡ 242643d6-f145-4b43-ba66-e1a5a7682db6
scatter(x, y, z, markersize=ms)

# ╔═╡ d7212ef8-c8df-4b58-a552-88df4cedba21
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═ba257c70-bee1-11eb-112c-4d4215e50eb7
# ╠═316e203a-b8ab-4b36-9d4d-601b951d6c95
# ╠═acccc84e-df8e-46ff-8b32-e5116a624eeb
# ╠═6787b927-2b3d-4b3c-af54-c355f2239fa9
# ╠═56dc4552-18f6-499d-9fe4-1ca71bd3dcfe
# ╠═481e51c0-9aae-4f4c-a9ed-cc4583c9412b
# ╠═be81f8d5-e07e-4cdf-95b9-486632819924
# ╠═c0658880-3a91-4aa8-83a0-33abb28fdd6d
# ╠═242643d6-f145-4b43-ba66-e1a5a7682db6
# ╠═d7212ef8-c8df-4b58-a552-88df4cedba21
# ╠═254313f1-29dc-44e8-81dc-4b7b4e69770b
