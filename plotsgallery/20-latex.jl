### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 9ad26901-863f-4b2c-9371-9e169d4a5c31
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="LaTeXStrings", version="1"),
        Pkg.PackageSpec(name="Measures", version="0.3"),
		Pkg.PackageSpec(name="PyPlot", version="2"),
    ])
    using Plots, PlutoUI, LaTeXStrings, Measures
	PlutoUI.TableOfContents()
end

# ╔═╡ 2549c7bb-55c8-48c3-8d65-b3d96aa5614c
md"""
# LaTeX in plots

## GR backend

[Source](https://goropikari.github.io/PlotsGallery.jl/src/latex1.html)
"""

# ╔═╡ 2ed80141-f9e5-4c25-bcf4-f9cb5bb8ba5d
fib = [(((1+sqrt(5))/2)^i - ((1-sqrt(5))/2)^i)/sqrt(5) for i in 1:12]

# ╔═╡ 0d6f4c52-48d5-4a15-a4ac-811956a01681
xl = L"n"

# ╔═╡ aa949ed3-b570-404e-95a4-172774389a66
yl = L"F_n"

# ╔═╡ 15d1c5d1-6a3b-47eb-b96d-11792518cb42
ann = L"F_n = \frac{1}{\sqrt{5}} \left[\left( \frac{1+\sqrt{5}}{2} \right)^n - \left( \frac{1-\sqrt{5}}{2} \right)^n \right]"

# ╔═╡ 97c39903-6e32-47f3-b7d1-c17867b40814
plot(fib,
    marker=:circle,
    xlabel=xl,
    ylabel=yl,
    annotation=(5, 100, ann))

# ╔═╡ 938dc567-3a59-4cae-9c80-4183debffcb0
md"""
## PyPlot backend
"""

# ╔═╡ e98584d2-de03-44b0-ab12-66191ab6190f
begin
	Plots.pyplot()
	plot(fib,
		marker=:circle,
		xlabel=xl,
		ylabel=yl,
		annotation=(5, 100, ann))
end

# ╔═╡ 44dfdd00-c05f-11eb-0b30-2dfdb70e9409
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═2549c7bb-55c8-48c3-8d65-b3d96aa5614c
# ╠═2ed80141-f9e5-4c25-bcf4-f9cb5bb8ba5d
# ╠═0d6f4c52-48d5-4a15-a4ac-811956a01681
# ╠═aa949ed3-b570-404e-95a4-172774389a66
# ╠═15d1c5d1-6a3b-47eb-b96d-11792518cb42
# ╠═97c39903-6e32-47f3-b7d1-c17867b40814
# ╠═938dc567-3a59-4cae-9c80-4183debffcb0
# ╠═e98584d2-de03-44b0-ab12-66191ab6190f
# ╠═44dfdd00-c05f-11eb-0b30-2dfdb70e9409
# ╠═9ad26901-863f-4b2c-9371-9e169d4a5c31
