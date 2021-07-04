### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ cabdb8f7-3d78-422f-bc78-b87fd22eb1d8
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using Plots, PlutoUI
	
	Plots.gr(fmt=:png, lw=2)
	
	PlutoUI.TableOfContents()
end

# ╔═╡ 73adcc40-bdcc-11eb-06eb-970be2047c7c
md"""
# Fig 2.04 Exponential decay
"""

# ╔═╡ ad29e65b-99e2-4fe9-af31-4c29c97aed9b
plot([t-> 3 * exp(-t) t->3 * exp(-2t) t-> 3 * exp(-3t)], 0.0, 5.0, xlim = (0, 5), ylim=(0, 3.2), xlabel="Time", ylabel="Concentration", label = ["exp(-t)" "exp(-2t)" "exp(-3t)"], title= "Figure 2.4")

# ╔═╡ 0f5b8cf2-9b58-40d2-8db1-f61baaf353fe
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═73adcc40-bdcc-11eb-06eb-970be2047c7c
# ╠═ad29e65b-99e2-4fe9-af31-4c29c97aed9b
# ╠═0f5b8cf2-9b58-40d2-8db1-f61baaf353fe
# ╠═cabdb8f7-3d78-422f-bc78-b87fd22eb1d8
