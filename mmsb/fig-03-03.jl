### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 59aaecb0-bde0-11eb-3d1a-496b1d550fba
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

# ╔═╡ e04166d2-a0b8-4e08-ad95-f16a151b0aba
md"""
# Figure 3.03 Michaelis-Menten kinetics
"""

# ╔═╡ 8c64a434-f663-4a26-85d3-326c6e57b1dc
# Full enzyme catalysis model
function full_model!(du, u, p, t)
	@unpack ET, K1, KM1, K2 = p
	@unpack S, ES, P = u
	freeEnz = ET - ES
	v1 = K1 * S * freeEnz - KM1 * ES
	v2 = K2 * ES
	du.S = - v1
	du.ES = v1 - v2
	du.P = v2
	return du
end

# ╔═╡ 594ae902-cc2a-42bd-b7c2-7852f66c49d1
u0 = LVector(S= 5.0, ES = 0.0, P = 0.0)

# ╔═╡ 7a2c5f66-b383-4ac8-9c09-425e9aeb0d2e
tend = 1.0

# ╔═╡ 52fde19e-0ed3-4472-81c0-37c4caca4afc
p = (ET = 1.0, K1 = 30.0, KM1 = 1.0, K2 = 10.0)

# ╔═╡ fc25f239-3f0d-4ca3-a356-95a282630f6c
sol = solve(ODEProblem(full_model!, u0, tend, p));

# ╔═╡ 47491dcd-7751-497e-bb9b-cb9097bae71c
begin
	p1 = plot(sol)
	plot!(p1, sol, vars=((t, es) -> (t, p.ET - es), 0, 2), label="E")
	plot!(p1, xlabel="Time (arbitrary units)", ylabel="Concentration (arbitrary units)", legend=:right)
	
	p1
end

# ╔═╡ ba148888-dc13-45e8-87a8-ce7bd9ecc93f
u0R = LVector(S = sum(u0))

# ╔═╡ 6056d577-a2ad-45d3-bd30-0b1df2eddbc9
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ f2ba7dc5-6556-4e4e-941b-7cc9de495e43
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ eb96706d-6f7f-4f35-b3ac-c5bfe0a71caf
# Apply QSSA on the ES complex to reduce the model complexity
function reduced_model!(du, u, p, t)
	@unpack ET, K1, KM1, K2 = p
	@unpack S = u
	km = (KM1 + K2) / K1
	du.S = -K2 * ET * hill(S, km)
	return du
end

# ╔═╡ 884dd7d7-0ef7-4fb1-8208-74d7f4ded49d
solr = solve(ODEProblem(reduced_model!, u0R, tend, p));

# ╔═╡ 57a78828-f389-4b12-ae64-5c114e01401e
begin
	p2 = plot(sol, vars=(0, [1, 3]), line=(:dash), label=["S (full)", "P (full)"])
	plot!(p2, solr, line=(:blue), lab="S (reduced)")
	plot!(p2, solr, vars=((t, s)->(t, u0R[1] - s), 0, 1), line=(:red), lab="P (reduced)")
	plot!(p2, xlabel="Time (arbitrary units)",  ylabel="Concentration (arbitrary units)", xlims=(0.0,1.0), ylims=(0.0,5.0), legend = :right)
	
	p2
end

# ╔═╡ b4121e60-6726-42c1-a9fb-489bf988bc2d


# ╔═╡ Cell order:
# ╠═e04166d2-a0b8-4e08-ad95-f16a151b0aba
# ╠═8c64a434-f663-4a26-85d3-326c6e57b1dc
# ╠═eb96706d-6f7f-4f35-b3ac-c5bfe0a71caf
# ╠═594ae902-cc2a-42bd-b7c2-7852f66c49d1
# ╠═7a2c5f66-b383-4ac8-9c09-425e9aeb0d2e
# ╠═52fde19e-0ed3-4472-81c0-37c4caca4afc
# ╠═fc25f239-3f0d-4ca3-a356-95a282630f6c
# ╠═47491dcd-7751-497e-bb9b-cb9097bae71c
# ╠═ba148888-dc13-45e8-87a8-ce7bd9ecc93f
# ╠═884dd7d7-0ef7-4fb1-8208-74d7f4ded49d
# ╠═57a78828-f389-4b12-ae64-5c114e01401e
# ╠═6056d577-a2ad-45d3-bd30-0b1df2eddbc9
# ╠═f2ba7dc5-6556-4e4e-941b-7cc9de495e43
# ╠═59aaecb0-bde0-11eb-3d1a-496b1d550fba
# ╠═b4121e60-6726-42c1-a9fb-489bf988bc2d
