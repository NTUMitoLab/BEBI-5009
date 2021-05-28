### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 26236190-9ff8-4a27-99ba-49c6bc310bce
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

# ╔═╡ 1e96864f-c970-4995-8cfe-704ce472eaf3
md"""
# Stem plot

[Source](https://goropikari.github.io/PlotsGallery.jl/src/stem.html)

`plot(..., line=:stem, marker=:star)`
"""

# ╔═╡ 15398e90-4a67-4b38-9724-33b17a38fb84
plot(sin.(0:0.3:2pi), line=:stem, marker=:star, markersize=20, ylims=(-1.1, 1.1), label="Stars")

# ╔═╡ f3dbfb30-bf93-11eb-1d78-c1da65f78509
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═1e96864f-c970-4995-8cfe-704ce472eaf3
# ╠═15398e90-4a67-4b38-9724-33b17a38fb84
# ╠═f3dbfb30-bf93-11eb-1d78-c1da65f78509
# ╠═26236190-9ff8-4a27-99ba-49c6bc310bce
