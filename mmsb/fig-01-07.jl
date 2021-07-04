### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 7357f256-ead0-401c-9cff-1aa099b67aa0
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

# ╔═╡ 0e455e50-bdcb-11eb-08b9-8d2d26788d14
md"""
# Fig 1.07 Collins toggle switch

For Figures 1.7, 7.13, 7.14, 7.15
"""

# ╔═╡ 30cdc452-ff17-4b08-939a-98c7dbc0c674
# Initial conditions
u0 = LVector(s1=0.075, s2=2.5)

# ╔═╡ 520f36c3-e164-459e-8869-99a8421774f6
# Simulation time
tend = 50.0

# ╔═╡ f47e84f9-7ff5-4c32-996a-47c600b1a71a
# Parameters
p = (a1 = 3.0, a2 = 2.5, β = 4.0, γ = 4.0, i1 = 0.0, i2 = 0.0)

# ╔═╡ 463ef6e7-73db-4b55-b97f-71e90c2f14f4
begin
	# Events and callbacks
    on_i1!(integrator) = integrator.p = @set p.i1 = 10.0
    off_i1!(integrator) = integrator.p = @set p.i1 = 0.0
    on_i2!(integrator) = integrator.p = @set p.i2 = 10.0
    off_i2!(integrator) = integrator.p = @set p.i2 = 0.0

    cbs = CallbackSet(PresetTimeCallback([10.0], on_i2!),
                  PresetTimeCallback([20.0], off_i2!),
                  PresetTimeCallback([30.0], on_i1!),
                  PresetTimeCallback([40.0], off_i1!))
end

# ╔═╡ d29832bb-74f9-443a-af7f-a12e7ae652c3
md"""
# Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 796ff12c-b74d-4fcf-b228-4e3c6fed2a89
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ 34178e95-cff5-400e-a5a6-bdbcf8326214
# The model
	function collins!(du, u, p, t)
		@unpack a1, a2, β, γ, i1, i2 = p
		@unpack s1, s2 = u
		du.s1 = a1 * hill(1 + i2, s2, β) - s1
		du.s2 = a2 * hill(1 + i1, s1, γ) - s2
    	return du
	end

# ╔═╡ 759580e6-0910-43a2-b81a-cdaa3bf34441
sol = solve(ODEProblem(collins!, u0, tend, p), callback=cbs)

# ╔═╡ b922fac1-e43c-45eb-a6db-0a9b18f541aa
plot(sol, legend=:right, xlabel="Time", ylabel="Concentration", title="Figure 1.7")

# ╔═╡ Cell order:
# ╠═0e455e50-bdcb-11eb-08b9-8d2d26788d14
# ╠═34178e95-cff5-400e-a5a6-bdbcf8326214
# ╠═463ef6e7-73db-4b55-b97f-71e90c2f14f4
# ╠═30cdc452-ff17-4b08-939a-98c7dbc0c674
# ╠═520f36c3-e164-459e-8869-99a8421774f6
# ╠═f47e84f9-7ff5-4c32-996a-47c600b1a71a
# ╠═759580e6-0910-43a2-b81a-cdaa3bf34441
# ╠═b922fac1-e43c-45eb-a6db-0a9b18f541aa
# ╠═d29832bb-74f9-443a-af7f-a12e7ae652c3
# ╠═796ff12c-b74d-4fcf-b228-4e3c6fed2a89
# ╠═7357f256-ead0-401c-9cff-1aa099b67aa0
