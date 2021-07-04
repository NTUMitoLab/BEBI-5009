### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ af7d7414-fd27-428b-8d15-fe257171235a
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

# ╔═╡ 31db8eee-bdcd-11eb-0551-550c86cfaf1d
md"""
# Figure 2.11-14 Model reduction
"""

# ╔═╡ d586f4bf-04ad-4a1d-9342-8be444b14cc0
md"""
## Figure 2.11 : Full model

The full biochemical reaction model
"""

# ╔═╡ 6e39ed5d-21e3-4c9d-8d4b-fb30c8bf555c
# Fig 2.11: Full model
function fullmodel!(du, u, p, t)
	@unpack K0, K1, KM1, K2 = p
	@unpack a, b = u
	vAB = K1 * a - KM1 * b
	du.a = K0 - vAB
	du.b = vAB - K2 * b
	return du
end

# ╔═╡ f856c00b-af34-49b4-a4aa-c1f16aac26dc
# Figure 2.14: Quasi-steady state assumption(QSSA)
function qssmodel!(du, u, p, t)
	@unpack K0, K2 = p
	du.b = K0 - K2 * u.b
end

# ╔═╡ 1586dd9d-7bb7-41e0-90c3-fd9b5d25b1e6
p1 = (K0=0, K1=9, KM1=12, K2=2)

# ╔═╡ 995aabe8-1cb4-4c51-8d83-e57b64db61de
u0 = LVector(a=0.0, b=10.0)

# ╔═╡ 43e4e3fd-881d-4556-927b-3acf715a97a0
sol1 = solve(ODEProblem(fullmodel!, u0, 3.0, p1));

# ╔═╡ 09e0bd1f-8c5c-45cd-b15e-36a473cb8bb7
plot(sol1, xlabel="Time (arbitrary units)", ylabel="Concentration (arbitrary units)", title="Fig. 2.11 (Full model)", label=["A" "B"])

# ╔═╡ a5205bb5-5bd5-4481-b02d-a41b4fa1c0c4
md"""
## Figure 2.12 : Rapid equilibrium
"""

# ╔═╡ dad21a13-b6cd-42e9-9e91-7d1cad429a2f
u0re = LVector(b=sum(u0))

# ╔═╡ 04c217c0-b45a-424d-9177-ba7572234683
md"""
## Figure 2.13: Rapid equilibrium 

with another set of parameters
"""

# ╔═╡ 04496970-ea81-4e8c-b118-1a0be3333f43
p2 = (K0=9, K1=20, KM1=12, K2=2)

# ╔═╡ a6a3c147-ea6a-48c7-953e-658e66308c8c
u1 = LVector(a=8.0, b=4.0)

# ╔═╡ 1b7435f1-b60b-45d5-b647-d725c4f6d923
u1re = LVector(b=sum(u1))

# ╔═╡ fb63ca02-c5cd-4a1d-af76-9df041f0878a
sol3full = solve(ODEProblem(fullmodel!, u1, 3.0, p2));

# ╔═╡ 626bdf4b-909d-42d3-aacd-6e30fc207494
md"""
## Figure 2.14 : QSSA

Quasi-steady state assumption on species A
"""

# ╔═╡ e4c8977b-5953-4155-bb10-b0da46080448
u1qss = LVector(b = (p2.K1 * sum(u1) - p2.K0) / (p2.K1 + p2.KM1))

# ╔═╡ 5dba1b2f-92fc-4790-b42d-44506f1e7c32
sol4 = solve(ODEProblem(qssmodel!, u1qss, 3.0, p2));

# ╔═╡ ef9ad709-6ba6-47f4-989d-d1e885b6b8a9
let tspan = 3.0
	ts = 0.0:0.1:tspan
	btilde = sol4(ts, idxs=1)
	pl4 = plot(sol3full, line=(:dash, 2), xlims=tspan,
     xlabel="Time (arbitrary units)",
     ylabel="Concentration (arbitrary units)",
     title="Figure 2.14: Ref vs QSSA")

	plot!(pl4, sol4, label="B (QSSA)", line=(2, :red))
	plot!(pl4, ts, (p2.K0 .+ p2.KM1 .* btilde) ./ p2.K1, label="A (QSSA)", line=(2, :blue))
	
	pl4
end

# ╔═╡ cd91c608-8b31-4fa3-9e22-176b58d89872
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 3653bbec-0e6e-40de-b926-4bb757213ad8
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ d0392260-fbf8-4caa-baaa-4b282c45be5c
# Fig 2.12: rapid equilibrium
function remodel!(du, u, p, t)
	@unpack K0, K1, KM1, K2 = p
	kb = K2 * hill(K1, KM1)
	du.b = K0 - kb * u.b
end

# ╔═╡ d081fbfb-38e5-41f3-a7df-15aeaad241d5
sol2 = solve(ODEProblem(remodel!, u0re, 3.0, p1));

# ╔═╡ e62303ee-bfc2-4739-937a-0b3dcfb2fd70
let tspan = 3.0
	ts = 0.0:0.1:tspan
	btilde = sol2(ts, idxs=1)
	pl2 = plot(sol1, line=(:dash, 1),label=["A (full solution)" "B (full solution)"])
	plot!(pl2, ts, (p1.KM1 / (p1.KM1 + p1.K1)) .* btilde, lab="A (rapid equilibrium)")
	plot!(pl2, ts, (p1.K1 / (p1.KM1 + p1.K1))  .* btilde, lab="B (rapid equilibrium)")
	plot!(pl2, title="Fig. 2.12 (Rapid equilibrium model)", xlabel="Time (arbitrary units)", ylabel="Concentration (arbitrary units)")
	pl2
end

# ╔═╡ 2c7610b1-6c25-40a3-8744-4ac561a8404a
sol3re = solve(ODEProblem(remodel!, u0re, 3.0, p2));

# ╔═╡ 7848a37a-ba43-4157-a2ce-97646ebf9e16
let tspan = 3.0
	ts = 0.0:0.1:tspan
	btilde = sol3re(ts, idxs=1)
	pl3 = plot(title="Fig. 2.13 Ref vs Fast equlibrium", xlabel="Time (arbitrary units)", ylabel="Concentration (arbitrary units)")
	plot!(pl3, sol3full, line=(:dash, 1),label=["A (full solution)" "B (full solution)"])
	plot!(pl3, ts, (p2.KM1 / (p2.KM1 + p2.K1)) .* btilde, lab="A (rapid equilibrium)")
	plot!(pl3, ts, (p2.K1 / (p2.KM1 + p2.K1))  .* btilde, lab="B (rapid equilibrium)")
	pl3
end

# ╔═╡ Cell order:
# ╠═31db8eee-bdcd-11eb-0551-550c86cfaf1d
# ╠═d586f4bf-04ad-4a1d-9342-8be444b14cc0
# ╠═6e39ed5d-21e3-4c9d-8d4b-fb30c8bf555c
# ╠═d0392260-fbf8-4caa-baaa-4b282c45be5c
# ╠═f856c00b-af34-49b4-a4aa-c1f16aac26dc
# ╠═1586dd9d-7bb7-41e0-90c3-fd9b5d25b1e6
# ╠═995aabe8-1cb4-4c51-8d83-e57b64db61de
# ╠═43e4e3fd-881d-4556-927b-3acf715a97a0
# ╠═09e0bd1f-8c5c-45cd-b15e-36a473cb8bb7
# ╠═a5205bb5-5bd5-4481-b02d-a41b4fa1c0c4
# ╠═dad21a13-b6cd-42e9-9e91-7d1cad429a2f
# ╠═d081fbfb-38e5-41f3-a7df-15aeaad241d5
# ╠═e62303ee-bfc2-4739-937a-0b3dcfb2fd70
# ╠═04c217c0-b45a-424d-9177-ba7572234683
# ╠═04496970-ea81-4e8c-b118-1a0be3333f43
# ╠═a6a3c147-ea6a-48c7-953e-658e66308c8c
# ╠═1b7435f1-b60b-45d5-b647-d725c4f6d923
# ╠═fb63ca02-c5cd-4a1d-af76-9df041f0878a
# ╠═2c7610b1-6c25-40a3-8744-4ac561a8404a
# ╠═7848a37a-ba43-4157-a2ce-97646ebf9e16
# ╠═626bdf4b-909d-42d3-aacd-6e30fc207494
# ╠═e4c8977b-5953-4155-bb10-b0da46080448
# ╠═5dba1b2f-92fc-4790-b42d-44506f1e7c32
# ╠═ef9ad709-6ba6-47f4-989d-d1e885b6b8a9
# ╠═cd91c608-8b31-4fa3-9e22-176b58d89872
# ╠═3653bbec-0e6e-40de-b926-4bb757213ad8
# ╠═af7d7414-fd27-428b-8d15-fe257171235a
