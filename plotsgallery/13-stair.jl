### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 814c7a30-bf94-11eb-0528-57b42e285702
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI
	using Plots
	PlutoUI.TableOfContents()
end

# ╔═╡ c114c92b-e196-4de1-a3bb-f2f1ac65bef3
md"""
# Stairstep plot

[Source](https://goropikari.github.io/PlotsGallery.jl/src/stairstep.html)

`plot(..., line=:steppre)`
"""

# ╔═╡ 2b9cc8ae-0bf0-4581-844a-b0f7fcafd821
plot(sin.(0:0.3:2pi), line=:steppre, label="Steps")

# ╔═╡ 7ace657b-7ca1-4feb-aa1d-3837b60699d4
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═c114c92b-e196-4de1-a3bb-f2f1ac65bef3
# ╠═2b9cc8ae-0bf0-4581-844a-b0f7fcafd821
# ╠═7ace657b-7ca1-4feb-aa1d-3837b60699d4
# ╠═814c7a30-bf94-11eb-0528-57b42e285702
