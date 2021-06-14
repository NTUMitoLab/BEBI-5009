### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 4f3d5530-c74e-4ab1-8629-7fb022fcbe9a
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Measures", version="0.3"),
    ])
    using Plots, PlutoUI, Measures
	PlutoUI.TableOfContents()
end

# ╔═╡ 6745ede0-c068-11eb-1db5-ed8cceaf21bd
md"""
# Axis

## Tick size

[Source]()
"""

# ╔═╡ c807a5b5-b0fa-4b47-9455-903f9e596c19
plot(sin, 0, 2π,
    xticks=0:0.5:2π,
    xrotation=60,
    xtickfont=font(30),
    bottom_margin=15mm)

# ╔═╡ f15c5894-4883-46d1-bd31-a7dd59d8305e
md"""
## No axis

[Source](https://goropikari.github.io/PlotsGallery.jl/src/no_axis.html)

`plot(..., axis=false)`
"""

# ╔═╡ 31f4439c-fab2-4151-8180-a1fd6d958811
plot(sin, 0, 2π, axis=false)

# ╔═╡ 891336e0-eb28-4c66-a749-eddbccb11502
md"""
## Ticks

[Source](https://goropikari.github.io/PlotsGallery.jl/src/ticks.html)
"""

# ╔═╡ 6713a15f-0273-4065-960d-96c5df4fad41
plot(sin, 0, 2π,
    xtick=(0:0.5:2π, ["$i a" for i in 0:0.5:2π]),
    ytick=-1:0.2:1,
    xrotation=60, ## -> rotate xticks 60 degree
    yrotation=90,
    # rotation=60, # x,y ticks rotation
)

# ╔═╡ 8f94b118-6a44-4bc6-afeb-8633ef051aac
md"""
## Axis range

[Source](https://goropikari.github.io/PlotsGallery.jl/src/axis_range.html)
"""

# ╔═╡ 949a0e5e-f129-4188-b248-fd68a22804e9
plot(sin, 0, 2π, xlims=(-10, 10), ylims=(-2,2))

# ╔═╡ 3e65f930-33dc-477f-a2af-ed62e25b6502
md"""
## Formatter

[Source](https://goropikari.github.io/PlotsGallery.jl/src/formatter.html)
"""

# ╔═╡ a710d5c3-7621-4921-a942-36267f21bebb
plot(exp, 0, 10, yformatter=:scientific)

# ╔═╡ 356afcb2-37d0-43ee-9772-d3b6c795f863
md"""
## Axis flip

[Source](https://goropikari.github.io/PlotsGallery.jl/src/axis_flip.html)
"""

# ╔═╡ f2fcd1e3-5f9b-4514-9e26-bb87e0fb7ceb
plot(x->x, 0:0.01:2π,
    proj=:polar,
    xflip=true,
    yflip=true,
    # flip=true # x,y-flip
)

# ╔═╡ e7611359-ebec-4946-b6f8-33c54d36993c
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═6745ede0-c068-11eb-1db5-ed8cceaf21bd
# ╠═c807a5b5-b0fa-4b47-9455-903f9e596c19
# ╠═f15c5894-4883-46d1-bd31-a7dd59d8305e
# ╠═31f4439c-fab2-4151-8180-a1fd6d958811
# ╠═891336e0-eb28-4c66-a749-eddbccb11502
# ╠═6713a15f-0273-4065-960d-96c5df4fad41
# ╠═8f94b118-6a44-4bc6-afeb-8633ef051aac
# ╠═949a0e5e-f129-4188-b248-fd68a22804e9
# ╠═3e65f930-33dc-477f-a2af-ed62e25b6502
# ╠═a710d5c3-7621-4921-a942-36267f21bebb
# ╠═356afcb2-37d0-43ee-9772-d3b6c795f863
# ╠═f2fcd1e3-5f9b-4514-9e26-bb87e0fb7ceb
# ╠═e7611359-ebec-4946-b6f8-33c54d36993c
# ╠═4f3d5530-c74e-4ab1-8629-7fb022fcbe9a
