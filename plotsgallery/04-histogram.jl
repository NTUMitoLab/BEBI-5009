### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 68e14c5f-4cea-4c3c-9756-bc50da5c0b6c
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

# ╔═╡ b647f9c8-b8af-4ae5-81e5-adf7396efb8a
md"""
# Histogram Plot

[Source](https://goropikari.github.io/PlotsGallery.jl/src/histogram_plot.html)

`histogram(data, bins=N)`
"""

# ╔═╡ bc8c1881-f1e4-4c7c-a342-cb94c2debea3
x = randn(1000)

# ╔═╡ e593d6f8-5b03-4c24-ac2a-fbcb5b697c1d
y = randn(1000)

# ╔═╡ df9ee4df-3fee-4271-9cd5-ed3fa562049d
z = randn(1000)

# ╔═╡ f96eefb7-604a-49ad-893e-a04e162fb242
begin
	histogram(x, bins=20, alpha=0.4, label="A")
	histogram!(y, bins=20, alpha=0.6, label="B")
	histogram!(z, bins=20, alpha=0.8, label="C")
end

# ╔═╡ bba46e90-bed1-11eb-0fa2-793900e63b4d
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═b647f9c8-b8af-4ae5-81e5-adf7396efb8a
# ╠═bc8c1881-f1e4-4c7c-a342-cb94c2debea3
# ╠═e593d6f8-5b03-4c24-ac2a-fbcb5b697c1d
# ╠═df9ee4df-3fee-4271-9cd5-ed3fa562049d
# ╠═f96eefb7-604a-49ad-893e-a04e162fb242
# ╠═bba46e90-bed1-11eb-0fa2-793900e63b4d
# ╠═68e14c5f-4cea-4c3c-9756-bc50da5c0b6c
