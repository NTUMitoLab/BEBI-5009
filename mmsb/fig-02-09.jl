### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 5f780c3c-27d7-492d-b7f3-76bf4d74f0b8
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

# ╔═╡ eb59c8c0-bdcc-11eb-2d91-69018c56b6b6
md"""
# Fig 2.09 Numerical Simulation of a metabolic network
"""

# ╔═╡ 2a4dd196-427f-4077-8c98-ed8b6ac8ad3b
function model!(du, u, p, t)
	@unpack a, b, c, d = u
	v1 = 2.0a
	v2 = 2.5*a*b
	v3 = 3.0c
	v4 = 3.0d

	du.a = 3.0 - v1 - v2
	du.b = v1 - v2
	du.c = v2 - v3
	du.d = v2 - v4
	return du
end

# ╔═╡ 5b04efb9-71f5-44eb-bda6-ef454e506303
u0 = LVector(a=0.0, b=0.0, c=0.0, d=0.0)

# ╔═╡ 5c846441-ee6f-4c0b-a2b3-7e8d8b2e2cf8
tend = 10.0

# ╔═╡ 01aed17a-ea97-414e-b3cf-011d0dee8ede
sol = solve(ODEProblem(model!, u0, tend));

# ╔═╡ feb6ae90-53a9-485f-a088-2f868400574e
plot(sol, xlims=(0.0, 4.0), ylims=(0.0, 1.0), 
     xlabel="Time (sec)", ylabel="Concentration (mM)", title="Figure 2.09",
     label=["A" "B" "C" "D"], legend=:bottomright)

# ╔═╡ 8fae9318-8099-41fa-a074-66bd778d37a1
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═eb59c8c0-bdcc-11eb-2d91-69018c56b6b6
# ╠═2a4dd196-427f-4077-8c98-ed8b6ac8ad3b
# ╠═5b04efb9-71f5-44eb-bda6-ef454e506303
# ╠═5c846441-ee6f-4c0b-a2b3-7e8d8b2e2cf8
# ╠═01aed17a-ea97-414e-b3cf-011d0dee8ede
# ╠═feb6ae90-53a9-485f-a088-2f868400574e
# ╠═8fae9318-8099-41fa-a074-66bd778d37a1
# ╠═5f780c3c-27d7-492d-b7f3-76bf4d74f0b8
