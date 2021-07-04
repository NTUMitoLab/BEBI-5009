### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 4fc6ce8c-bd32-4a84-9b77-b8dc2faa81ce
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

# ╔═╡ 2e1253e8-2aca-4d2b-950d-31e0ac0befac
md"""
# Figure 4.11

Surface plots.

Reference: [surface plots @ PlotsGallery.jl](https://goropikari.github.io/PlotsGallery.jl/src/surface.html)
"""

# ╔═╡ 0073304f-63e2-4e30-8358-e056362536e2
x1 = y1 = range(-1.0, 1.0, length=51)

# ╔═╡ 6ad81170-fe26-4bda-a326-494699938661
z1(x, y) = x^2 + 0.5y^2

# ╔═╡ 4f28ccba-f9c7-4068-88e8-37848e4061a1
x2 = range(-2.75, 2.75, length=80)

# ╔═╡ 89346c28-6c84-4204-8dff-6bac59de8bd5
y2 = range(-0.75, 0.75, length=80)

# ╔═╡ 6bbb0bf2-ae1f-4790-8847-dac28a74dd0d
z2(x, y) = (.2x^2-1)^2 + y^2

# ╔═╡ 646f3b77-a4bf-4a3c-b971-85a2841b4543
begin
	p1 = surface(x1, y1, z1, title="Single-well potential")
	p2= contourf(x1, y1, z1)
	p3 = surface(x2, y2, z2, title="Double-well potential")
	p4 = contourf(x2, y2, z2)

	plot(p1, p2, p3, p4,size=(1000, 800))
end

# ╔═╡ 460b4f90-bdec-11eb-2a85-0d7050badf3b
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 375b4858-0248-49dd-bc35-4da8e461f0b2
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ Cell order:
# ╠═2e1253e8-2aca-4d2b-950d-31e0ac0befac
# ╠═0073304f-63e2-4e30-8358-e056362536e2
# ╠═6ad81170-fe26-4bda-a326-494699938661
# ╠═4f28ccba-f9c7-4068-88e8-37848e4061a1
# ╠═89346c28-6c84-4204-8dff-6bac59de8bd5
# ╠═6bbb0bf2-ae1f-4790-8847-dac28a74dd0d
# ╠═646f3b77-a4bf-4a3c-b971-85a2841b4543
# ╠═460b4f90-bdec-11eb-2a85-0d7050badf3b
# ╠═375b4858-0248-49dd-bc35-4da8e461f0b2
# ╠═4fc6ce8c-bd32-4a84-9b77-b8dc2faa81ce
