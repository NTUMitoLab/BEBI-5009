### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ a29cbf4d-6a3f-4deb-bd9f-8f8baf825b9c
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Measures", version="0.3"),
		Pkg.PackageSpec(name="LaTeXStrings", version="1"),
    ])
    using Plots, PlutoUI, Measures, LaTeXStrings
	PlutoUI.TableOfContents()
end

# ╔═╡ f0f0df80-c10f-11eb-2167-cd6d2b534d6b
md"""
# Fonts

[Source](https://goropikari.github.io/PlotsGallery.jl/src/font.html)
"""

# ╔═╡ 1dd75a2d-ace6-47a8-bf9d-1383325f3604
plot(sin, 0, 2π,
    title=L"y = \sin(x)",
    titlefont=font(40), ## title

    xlabel=L"x",
    ylabel="y",
    xguidefont=font(30), ## x-label
    yguidefont=font(20), ## x-label
    # guidefont=font(20), # x,y-label

    xtick=(0:0.5:2π, ["\$ $(i) \$" for i in 0:0.5:2π]),
    ytick=-1:0.5:1,
    xtickfont=font(15),
    ytickfont=font(20),
    # tickfont=font(10), # x,y-ticks font

    label="Sin function",
    legendfont=font(12),

    xlims=(0,2π),
    ylims=(-1,1),
    bottom_margin=5mm,
    left_margin=10mm,
    top_margin=15mm
)

# ╔═╡ 60333047-027c-4d45-a1db-a995c83832e8
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═f0f0df80-c10f-11eb-2167-cd6d2b534d6b
# ╠═1dd75a2d-ace6-47a8-bf9d-1383325f3604
# ╠═60333047-027c-4d45-a1db-a995c83832e8
# ╠═a29cbf4d-6a3f-4deb-bd9f-8f8baf825b9c
