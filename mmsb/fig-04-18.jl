### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 819e0a72-cc97-4910-8f05-91ebbb2273d8
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

# ╔═╡ bb2a66f4-1c5e-4a4a-a0e6-965e0996eae7
md"""
# Figure 4.18 Continuation diagram

**NOTE**

[Bifurcations.jl](https://github.com/tkf/Bifurcations.jl) does not work on Julia v1.6 (As I am writing this). 
And [BifurcationKit.jl](https://github.com/rveltz/BifurcationKit.jl) might be too complex for this example.

"""

# ╔═╡ 0549e1c5-16b5-4b3e-aca2-75d41ee93451
p = (K1=20.0, K2=5.0, K3=5.0, K4=5.0, K5=2.0, N=4)

# ╔═╡ a80a7285-da0b-463e-8d69-165d2b797c3b
k1Range = LinRange(0.0, 1000.0, 100)

# ╔═╡ a32c3e1e-eac7-47fa-b9cb-2ac919cd4c56
u0 = LVector(A=0.0, B=0.0)

# ╔═╡ c4725c60-bded-11eb-2b5a-c57f48c64c55
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ a05c0b69-f761-4920-ac17-ebf437f2862e
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ 2c15803d-104a-4b87-8556-0238ce4042a2
function model!(du, u, p, t)
    @unpack K1, K2, K3, K4, K5, N = p
    @unpack A, B = u
    
    v1 = K1 * hill(1, B, N)
    v5 = K5 * A
    
    du.A = v1 - v5 - K3 * A
    du.B = K2 + v5 - K4 * B
end

# ╔═╡ 4577a459-7151-4e53-a235-1f35ffa49eff
# See also : 
# Ensemble analysis: https://diffeq.sciml.ai/stable/features/ensemble/
a = map(k1Range) do k1
	p1 = @set p.K1 = k1
	prob = SteadyStateProblem(model!, u0, p1)
	sol = solve(prob)
	sol[1]
end

# ╔═╡ a9766d07-4ed0-40b5-a00d-a1694413e289
plot(k1Range, a, title = "Fig 4.18 Continuation diagram", xlabel = "K1" , ylabel= "Steady state [A]", leg=nothing, ylim=(0.0, 4.0))

# ╔═╡ Cell order:
# ╠═bb2a66f4-1c5e-4a4a-a0e6-965e0996eae7
# ╠═2c15803d-104a-4b87-8556-0238ce4042a2
# ╠═0549e1c5-16b5-4b3e-aca2-75d41ee93451
# ╠═a80a7285-da0b-463e-8d69-165d2b797c3b
# ╠═a32c3e1e-eac7-47fa-b9cb-2ac919cd4c56
# ╠═4577a459-7151-4e53-a235-1f35ffa49eff
# ╠═a9766d07-4ed0-40b5-a00d-a1694413e289
# ╠═c4725c60-bded-11eb-2b5a-c57f48c64c55
# ╠═a05c0b69-f761-4920-ac17-ebf437f2862e
# ╠═819e0a72-cc97-4910-8f05-91ebbb2273d8
