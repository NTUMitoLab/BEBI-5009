### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ f963216e-db98-4ee4-b3ec-ec62c929525a
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    	Pkg.PackageSpec(name="SpecialFunctions", version="1"),
    ])
    using Plots, PlutoUI, SpecialFunctions
	PlutoUI.TableOfContents()
end

# ╔═╡ 10816ae0-bfa8-11eb-1c8e-e1650db06688
md"""
# Standard Line Colors and styles

## Line colors

[Source](https://goropikari.github.io/PlotsGallery.jl/src/standard_line_colors.html)
"""

# ╔═╡ c32a4dc6-d14e-430e-95e2-7f301743305b
begin
	x = 0:0.2:10
	y0 = besselj.(0,x)
	y1 = besselj.(1,x)
	y2 = besselj.(2,x)
	y3 = besselj.(3,x)
	y4 = besselj.(4,x)
	y5 = besselj.(5,x)
	y6 = besselj.(6,x)
end

# ╔═╡ fe436d1d-c0fd-43de-9918-6daeec925c44
plot(x, [y0 y1 y2 y3 y4 y5 y6], c=[:red :green :blue :cyan :magenta :yellow :black])

# ╔═╡ 58f1fe74-3dad-4ca5-90e3-4c62c7c04d50
md"""
## Line styles 
"""

# ╔═╡ 31ad18c6-2bef-4291-825e-18bb8ec67351
Plots.supported_styles()

# ╔═╡ 42fef942-a708-4bfc-aaff-655d24174281
style = let
	style = Plots.supported_styles()[2:end]
	style = reshape(style, 1, length(style))
end

# ╔═╡ 27304d60-c1ec-42e5-9b71-c782fcdcd909
plot(x, [y0 y1 y2 y3 y4], line=(3, style))

# ╔═╡ 2c66a2a3-c14b-4b53-a9df-b6bba35cfb59
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═10816ae0-bfa8-11eb-1c8e-e1650db06688
# ╠═c32a4dc6-d14e-430e-95e2-7f301743305b
# ╠═fe436d1d-c0fd-43de-9918-6daeec925c44
# ╠═58f1fe74-3dad-4ca5-90e3-4c62c7c04d50
# ╠═31ad18c6-2bef-4291-825e-18bb8ec67351
# ╠═42fef942-a708-4bfc-aaff-655d24174281
# ╠═27304d60-c1ec-42e5-9b71-c782fcdcd909
# ╠═2c66a2a3-c14b-4b53-a9df-b6bba35cfb59
# ╠═f963216e-db98-4ee4-b3ec-ec62c929525a
