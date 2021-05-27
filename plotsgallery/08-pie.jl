### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ b1664e87-0aee-41af-9348-b88814cadd96
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

# ╔═╡ 2a63639d-a00a-4471-9101-008116ac7ee4
md"""
# Pie chart

[Source](https://goropikari.github.io/PlotsGallery.jl/src/pie.html)
"""

# ╔═╡ 70b05318-0890-43db-9309-4b249c2e73eb
x = ["Nerds","Hackers","Scientists"]

# ╔═╡ 616d1345-9523-4668-9c82-cd6b671fef27
y = [0.4,0.35,0.25]

# ╔═╡ f5e2c2e6-6a0f-4219-a771-765392f559a8
pie(x, y, title="The Julia Community",l = 0.5)

# ╔═╡ 9d2416ce-bedd-11eb-0f1d-99410b333caa

md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═2a63639d-a00a-4471-9101-008116ac7ee4
# ╠═70b05318-0890-43db-9309-4b249c2e73eb
# ╠═616d1345-9523-4668-9c82-cd6b671fef27
# ╠═f5e2c2e6-6a0f-4219-a771-765392f559a8
# ╠═9d2416ce-bedd-11eb-0f1d-99410b333caa
# ╠═b1664e87-0aee-41af-9348-b88814cadd96
