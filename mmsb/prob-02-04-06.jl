### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 4f0c141c-8ff2-4db7-b580-5f5b45762e26
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
	    Pkg.PackageSpec(name="DifferentialEquations", version="6"),
	    Pkg.PackageSpec(name="Parameters", version="0.12"),
        Pkg.PackageSpec(name="LabelledArrays", version="1"),
        Pkg.PackageSpec(name="Setfield", version="0.7"),
    ])
    using Plots, PlutoUI, LinearAlgebra, DifferentialEquations, Parameters, LabelledArrays, Setfield
	
	Plots.gr(fmt=:png, lw=2)
	
	PlutoUI.TableOfContents()
end

# ╔═╡ 6ae7ec6a-bb4f-4e81-9766-8d0c4c191e82
md"""
# Problem 2.4.6
"""

# ╔═╡ 5dbb3805-6829-46ef-9ea1-cfd84d47e738
# Model
f(u, p, t) = p * (1.0-u)

# ╔═╡ 10097777-e4de-4d43-9342-87beabd7cb22
p = 1.0

# ╔═╡ 8e6e75ec-dc50-4b3d-a2f4-0f038f199bcc
u0 = 0.0

# ╔═╡ 4d91851b-4f1c-4d1b-a764-552a037166c3
tspan = 10.0

# ╔═╡ a8387560-b8cf-4331-a282-bd9b9625a739
prob = ODEProblem(f, u0, tspan, p)

# ╔═╡ e851eab8-e596-4dc8-8ac4-65e5d91bc6de
sol = solve(prob)

# ╔═╡ 350ddcf9-7a56-4530-8c95-bc2666460e74
plot(sol, xlabel="Time (arbitrary units)", ylabel="Concentration (arbitrary units)", legend=:bottomright)

# ╔═╡ 117275d0-bde0-11eb-2527-87d1644a8e38
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 19afef49-0616-473e-a515-b495b6e435ce
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ Cell order:
# ╠═6ae7ec6a-bb4f-4e81-9766-8d0c4c191e82
# ╠═5dbb3805-6829-46ef-9ea1-cfd84d47e738
# ╠═10097777-e4de-4d43-9342-87beabd7cb22
# ╠═8e6e75ec-dc50-4b3d-a2f4-0f038f199bcc
# ╠═4d91851b-4f1c-4d1b-a764-552a037166c3
# ╠═a8387560-b8cf-4331-a282-bd9b9625a739
# ╠═e851eab8-e596-4dc8-8ac4-65e5d91bc6de
# ╠═350ddcf9-7a56-4530-8c95-bc2666460e74
# ╠═117275d0-bde0-11eb-2527-87d1644a8e38
# ╠═19afef49-0616-473e-a515-b495b6e435ce
# ╠═4f0c141c-8ff2-4db7-b580-5f5b45762e26
