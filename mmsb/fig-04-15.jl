### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 660bbe15-74ae-4e61-9a7e-6b2bf1b1e1f5
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

# ╔═╡ a65fcaa1-6d49-4121-b644-2e8945763fd2
md"""
# Figure 4.15, 4.16, and 4.17

Oscillatory network.
"""

# ╔═╡ 3fa4e3bb-2fa5-4f99-9e2d-e41936cd8e6d
"""
Model of oscillatory network from Figure 4.14. This code generates Figures
4.15, 4.16, and 4.17
"""
function model!(du, u, p, t)
    @unpack s1, s2 = u
    @unpack K0, K1, K2, N = p
    v0 = K0
    v1 = K1 * s1 * (1 + s2^N)
    v2 = K2 * s2
	du.s1 = v0 - v1
	du.s2 = v1 - v2
    return du
end

# ╔═╡ cf4047c0-bdec-11eb-0bcd-d958a6ba03d6
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 7abc2f61-a1ed-4e61-bfa8-e557f944f615
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ c37327cf-a798-4820-8304-36966ac64e56
function figure0415(; param = (K0 = 8.0, K1 = 1.0, K2 = 5.0, N = 2),
	                  r = LinRange(0.0, 4.0, 20),
	                  tend = 8.0,
	                  figtitle="Fig 4.15")

	u0s = ( LVector(s1=1.5, s2=1.0), LVector(s1=0.0, s2=1.0),
        	LVector(s1=0.0, s2=3.0), LVector(s1=2.0, s2=0.0))
	sols = map(u0 -> solve(ODEProblem(model!, u0, tend, param)), u0s)

	# Fig 4.15 A
	p1 = plot(sols[1], xlabel="Time", ylabel="Concentration", title ="$figtitle (A)", xlims=(0.0, 8.0))
	
	# Fig 4.15 B: Vetor field
	function ∂F(x, y)
		u = LVector(s1=x, s2=y)
		dxdy = model!(similar(u), u, param, 0.0)
		return dxdy ./ (norm(dxdy)^0.5 * 20)
	end
	
	nullcline_s1(s2, p=param) = (p.K0 / p.K1) * hill(1, s2, p.N)
	nullcline_s2(s2, p=param) = (p.K2 * s2) / (p.K1 * (1 + s2^p.N))
	
	
	xx = [x for y in r, x in r]
	yy = [y for y in r, x in r]
	p2 = quiver(xx, yy, quiver=∂F, line=(:lightblue))

	for sol in sols
		plot!(p2, sol, vars=(1, 2), label=nothing)
	end
	
	rMin, rMax = r[1], r[end]
	
	plot!(p2, nullcline_s1, identity, rMin, rMax, label="Nullcline S1", line=(:dash, :red))
	plot!(p2, nullcline_s2, identity, rMin, rMax, label="Nullcline S2", line=(:dash, :blue))
	plot!(p2, title = "$figtitle (B)", xlabel="[S1]", ylabel="[S2]", 
      xlims=(rMin, rMax), ylims=(rMin, rMax), aspect_ratio=:equal, size=(700, 700))
	
	return (p1, p2)
end

# ╔═╡ 497e9b54-40c1-493b-aabe-f6ad66120389
fig415a, fig415b = figure0415()

# ╔═╡ c72c49a8-c718-419b-aca6-31853282b150
fig415a

# ╔═╡ 934f6dc0-5c24-466e-b07c-879efbfd1f72
fig415b

# ╔═╡ 21027a60-2903-49d1-ba10-4c19f944fbb0
fig416a, fig416b = figure0415(param = (K0 = 8.0, K1 = 1.0, K2 = 5.0, N = 2.5), tend = 1000.0, figtitle="Fig 4.16")

# ╔═╡ 39d5557b-430b-4074-8944-94f21efcab7e
fig416a

# ╔═╡ 747493eb-9196-4c6b-b70c-42c6167c0b9f
fig416b

# ╔═╡ 6553c713-9663-4260-a416-5d0c8590ea97
let
	param = (K0 = 8.0, K1 = 1.0, K2 = 5.0, N = 2.5)
	sol417 = solve(ODEProblem(model!, LVector(s1=2.0, s2=1.5), 10.0, param))
	r = LinRange(0.0, 4.0, 20)
	xx = [x for y in r, x in r]
	yy = [y for y in r, x in r]
	
	"Vetor field"
	function ∂F(x, y)
		u = LVector(s1=x, s2=y)
		dxdy = model!(similar(u), u, param, 0.0)
		return dxdy ./ (norm(dxdy)^0.5 * 20)
	end
	
	nullcline_s1(s2, p=param) = (p.K0 / p.K1) * hill(1, s2, p.N)
	nullcline_s2(s2, p=param) = (p.K2 * s2) / (p.K1 * (1 + s2^p.N))
	
	
	xx = [x for y in r, x in r]
	yy = [y for y in r, x in r]
	p2 = quiver(xx, yy, quiver=∂F, line=(:lightblue))
	
	
	quiver(xx, yy, quiver=∂F, line=(:lightblue))
	plot!(sol417, vars=(1, 2), label=nothing, line=(:black), arrow=0.4)


	plot!(nullcline_s1, identity, 0.0, 4.0, label="Nullcline S1", line=(:dash, :red))
	plot!(nullcline_s2, identity, 0.0, 4.0, label="Nullcline S2", line=(:dash, :blue))
	plot!(title = "Fig. 4.17", xlabel="[S1]", ylabel="[S2]", 
		  xlims=(1.0, 3.0), ylims=(1.0, 3.0), aspect_ratio=:equal, size=(700, 700))
end

# ╔═╡ Cell order:
# ╠═a65fcaa1-6d49-4121-b644-2e8945763fd2
# ╠═3fa4e3bb-2fa5-4f99-9e2d-e41936cd8e6d
# ╠═c37327cf-a798-4820-8304-36966ac64e56
# ╠═497e9b54-40c1-493b-aabe-f6ad66120389
# ╠═c72c49a8-c718-419b-aca6-31853282b150
# ╠═934f6dc0-5c24-466e-b07c-879efbfd1f72
# ╠═21027a60-2903-49d1-ba10-4c19f944fbb0
# ╠═39d5557b-430b-4074-8944-94f21efcab7e
# ╠═747493eb-9196-4c6b-b70c-42c6167c0b9f
# ╠═6553c713-9663-4260-a416-5d0c8590ea97
# ╠═cf4047c0-bdec-11eb-0bcd-d958a6ba03d6
# ╠═7abc2f61-a1ed-4e61-bfa8-e557f944f615
# ╠═660bbe15-74ae-4e61-9a7e-6b2bf1b1e1f5
