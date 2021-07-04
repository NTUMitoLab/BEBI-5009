### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 0d8949bb-f1b5-4c29-91d9-47276619bff3
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

# ╔═╡ 514362bc-8708-4256-a592-37592fd7e2d6
md"""
# Figure 4.7, 4.8, 4.9, and 4.19A

Symmetric (bistable) biological networks.
"""

# ╔═╡ cc86896a-1624-438a-8e81-cbd284f0c144
p1 = (K1=20.0, K2=20.0, K3=5.0, K4=5.0, N1=1.0, N2=4.0)

# ╔═╡ 841e6858-46b3-43ea-abdc-79fc1fb8cf1b
u0s = (LVector(s1=3.0, s2=1.0), LVector(s1=1.0, s2=3.0))

# ╔═╡ ef41caa5-af55-4b26-83c9-115d37145c48
# Symmetric inhibition
p2 = (K1=20.0, K2=20.0, K3=5.0, K4=5.0, N1=4.0, N2=4.0)

# ╔═╡ 5b65d460-bde6-11eb-204f-9755e44085cf
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 5016f59c-0a95-468a-b72c-2a6fc45b81b1
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ 3d9a046d-889e-4217-b22a-2c25f10fca1c
"Model of symmetric network from Figure 4.6. This code generates Figures 4.7, 4.8, 4.9, and 4.19A"
function model!(du, u, p, t)
    @unpack K1, K2, K3, K4, N1, N2 = p
    @unpack s1, s2 = u
    du.s1 = K1 * hill(1, s2, N2) - K3 * s1
    du.s2 = K2 * hill(1, s1, N1) - K4 * s2
    return du
end

# ╔═╡ 4acf70b7-dbed-4c98-93d9-9ef685e80093
function df(x, y, p = p1)
	u = LVector(s1=x, s2=y)
	du = similar(u)
	model!(du, u, p, 0.0)

	# Tweaking arrow length
	du ./ (norm(du)^0.5 * 20)
end

# ╔═╡ 920bd9af-b2af-41e5-b510-6f0e945592e8
fig47a = let
	tend = 4.0
	sols = map(u0 -> solve(ODEProblem(model!, u0, tend, p1)), u0s)
	
	p1 = plot(sols[1], xlabel="Time", ylabel="Concentration", legend=:right, title= "Fig 4.7A (1)")
    p2 = plot(sols[2], xlabel="Time", ylabel="Concentration", legend=:right, title= "Fig 4.7A (2)")
    fig47a = plot(p1, p2, layout=(2, 1), size=(600, 600))
end

# ╔═╡ 571a67aa-7bd5-476f-90ca-082321f6b65c
fig48a = let tend = 4.0
	
	sols = map(u0 -> solve(ODEProblem(model!, u0, tend, p2)), u0s)
	pl1 = plot(sols[1], xlabel="Time", ylabel="Concentration", legend=:right, title= "Fig 4.8A (1)")
    pl2 = plot(sols[2], xlabel="Time", ylabel="Concentration", legend=:right, title= "Fig 4.8A (2)")
    fig48a = plot(pl1, pl2, layout=(2, 1), size=(600, 600))
end

# ╔═╡ 83392c9a-76e9-4806-b397-0086c8aa8e10
begin
	nullclineS1(s2, p) = p.K1 / p.K3 * hill(1, s2, p.N2)
	nullclineS1(s2) = nullclineS1(s2, p1)
	nullclineS2(s1, p) = p.K2 / p.K4 * hill(1, s1, p.N1)
	nullclineS2(s1) = nullclineS2(s1, p1)
end

# ╔═╡ bc40e7ef-4286-45de-a3d6-07ddafa67c1d
fig47b = let
	r = LinRange(0.0, 5.0, 20)
	xx = [x for y in r, x in r]
	yy = [y for y in r, x in r]
	pl = quiver(xx, yy, quiver=df, line=(:lightblue))

	plot!(pl, nullclineS1, identity, 0.0, 5.0, lab="Nullcline S1", line=(:dash, :red))
	plot!(pl, identity, nullclineS2, 0.0, 5.0, lab="Nullcline S2", line=(:dash, :blue))
	plot!(pl, title="Fig 4.7 B", xlim=(0.0, 5.0), ylim=(0.0, 5.0), aspect_ratio = 1.0, size = (600, 600))
	
	pl
end

# ╔═╡ 53ada46f-4036-4c42-b1ec-ce7ca7ac0775
fig48b = let
	df2(x, y) = df(x, y, p2)
	
	r = LinRange(0.0, 5.0, 20)
	xx = [x for y in r, x in r]
	yy = [y for y in r, x in r]
	
	fig48b = quiver(xx, yy, quiver=df2, line=(:lightblue))
	
	plot!(fig48b, s2 -> nullclineS1(s2, p2) , identity, r[1], r[end], lab="Nullcline S1", line=(:dash, :red))
	plot!(fig48b, identity, s1 -> nullclineS2(s1, p2), r[1], r[end], lab="Nullcline S2", line=(:dash, :blue))
	plot!(fig48b, title="Fig 4.8 B", xlim=(r[1], r[end]), ylim=(r[1], r[end]), aspect_ratio = :equal)
	
	
	r2 = LinRange(1.0, 1.5, 20)
	xx2 = [x for y in r2, x in r2]
	yy2 = [y for y in r2, x in r2]
	
	pl2 = quiver(xx2, yy2, quiver=(x, y) -> df(x,y, p2) ./ 5, line=(:lightblue))
	
	plot!(pl2, s2 -> nullclineS1(s2, p2), identity, r2[1], r2[end], lab="Nullcline S1", line=(:dash, :red))
	plot!(pl2, identity, s1 -> nullclineS2(s1, p2), r2[1], r2[end], lab="Nullcline S2", line=(:dash, :blue))
	plot!(pl2, title="Fig 4.8 B (close up)", xlim=(r2[1], r2[end]), ylim=(r2[1], r2[end]), aspect_ratio = :equal, xlabel="[S1]", ylabel="[S2]")
	
	plot(fig48b, pl2, size=(1000, 500))
end

# ╔═╡ 74e5e25d-815f-4f0d-99ab-4a78764deb94
let
	
	pls = map((8.0, 16.0, 20.0, 35.0)) do k1
		p = (K1=k1, K2=20.0, K3=5.0, K4=5.0, N1=4.0, N2=4.0)
		plot(s2 -> nullclineS1(s2, p), s2 -> s2, 0.0, 7.0, lab="Nullcline S1")
		plot!(s1 -> s1, s1 -> nullclineS2(s1, p), 0.0, 7.0, lab="Nullcline S2")
		plot!(title = "K1 = $k1", xlim=(0.0, 7.0), ylim=(0.0, 7.0), 
		  aspect_ratio = 1.0, size = (800, 800), xlabel="[S1]", ylabel="[S2]")
	end
	
	plot(pls...)
end

# ╔═╡ Cell order:
# ╠═514362bc-8708-4256-a592-37592fd7e2d6
# ╠═3d9a046d-889e-4217-b22a-2c25f10fca1c
# ╠═4acf70b7-dbed-4c98-93d9-9ef685e80093
# ╠═cc86896a-1624-438a-8e81-cbd284f0c144
# ╠═841e6858-46b3-43ea-abdc-79fc1fb8cf1b
# ╠═920bd9af-b2af-41e5-b510-6f0e945592e8
# ╠═83392c9a-76e9-4806-b397-0086c8aa8e10
# ╠═bc40e7ef-4286-45de-a3d6-07ddafa67c1d
# ╠═ef41caa5-af55-4b26-83c9-115d37145c48
# ╠═571a67aa-7bd5-476f-90ca-082321f6b65c
# ╠═53ada46f-4036-4c42-b1ec-ce7ca7ac0775
# ╠═74e5e25d-815f-4f0d-99ab-4a78764deb94
# ╠═5b65d460-bde6-11eb-204f-9755e44085cf
# ╠═5016f59c-0a95-468a-b72c-2a6fc45b81b1
# ╠═0d8949bb-f1b5-4c29-91d9-47276619bff3
