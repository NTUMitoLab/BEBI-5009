### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ e0898bb3-af51-4da4-b786-dda0225b9cac
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

# ╔═╡ 7855e1b0-bfa7-11eb-2975-53bc5895a665
md"""
# Surface plots

## Surface (I)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/surface.html)

`surface(x, y, z)`
"""

# ╔═╡ e4fac4c5-8ab3-48d9-8e9b-08ff59a077aa
f(x,y) = x^2 + y^2

# ╔═╡ 3ca9bd7b-d999-4c5c-98b5-e2dfbbe6a909
x = -10:10

# ╔═╡ 9845d277-a8ad-4a3b-96df-cb97f0279fb0
y = x

# ╔═╡ e05624f3-b38e-4970-ac17-ce75470e0e9c
surface(x, y, f)

# ╔═╡ 89db143f-d4b7-41ec-86ab-baf1990674f1
md"""
## Surface (II)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/surface2.html)

`plot(x, y, z, linetype=:surface)`
"""

# ╔═╡ 9dc2d389-d93c-4a88-be0e-a16ad9e322a6
plot(x, y, f, linetype=:surface)

# ╔═╡ 99439d0a-c3bb-4516-bc75-cb27953f6370
md"""
## Surface (III)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/surface3.html)

Wires only: `plot(x, y, z, linetype=:wireframe)`
"""

# ╔═╡ a4076901-7ed3-42f8-871a-7a7e926a4288
plot(x, y, f, linetype=:wireframe)

# ╔═╡ 773a9ef8-c3e5-42cf-ba51-f4cc62be6e18
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═7855e1b0-bfa7-11eb-2975-53bc5895a665
# ╠═e4fac4c5-8ab3-48d9-8e9b-08ff59a077aa
# ╠═3ca9bd7b-d999-4c5c-98b5-e2dfbbe6a909
# ╠═9845d277-a8ad-4a3b-96df-cb97f0279fb0
# ╠═e05624f3-b38e-4970-ac17-ce75470e0e9c
# ╠═89db143f-d4b7-41ec-86ab-baf1990674f1
# ╠═9dc2d389-d93c-4a88-be0e-a16ad9e322a6
# ╠═99439d0a-c3bb-4516-bc75-cb27953f6370
# ╠═a4076901-7ed3-42f8-871a-7a7e926a4288
# ╠═773a9ef8-c3e5-42cf-ba51-f4cc62be6e18
# ╠═e0898bb3-af51-4da4-b786-dda0225b9cac
