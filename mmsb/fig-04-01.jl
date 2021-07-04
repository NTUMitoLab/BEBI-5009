### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 755e081d-7176-4325-b481-d5d67db6176c
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

# ╔═╡ 4a209b69-b1b4-4a63-8786-c2b2a1a9b6ee
md"""
# Figure 4.1 to 4.5

## Figure 4.1, 4.2, and 4.3

Steady states and phase plots in an assymetric network
"""

# ╔═╡ 9b0868de-687e-44f0-a3b8-2321cebd3a52
params = (K1=20.0, K2=5.0, K3=5.0, K4=5.0, K5=2.0, N=4)

# ╔═╡ 69f0e704-2a02-430d-97fd-4a7e5b1fc031
u0s = (LVector(A=0.0, B=0.0), 
       LVector(A=0.5, B=0.6),
       LVector(A=0.17, B=1.1),
       LVector(A=0.25, B=1.9),
       LVector(A=1.85, B=1.70))

# ╔═╡ 298447c2-7e64-422c-9d25-9fb4dee35441
md"""
## Figure 4.4, 4.5 

Vector fields
"""

# ╔═╡ 0b3412c0-bde3-11eb-0869-17548acad535
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 3d3f9ef7-4195-413a-a4d4-563f327ccda4
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ f8ff273a-e1c7-4f00-9f9d-0ecb99f90b1e
function model!(du, u, p, t)
    @unpack K1, K2, K3, K4, K5, N = p
    @unpack A, B = u
    
    v1 = K1 * hill(1, B, N)
    v5 = K5 * A
    
    du.A = v1 - v5 - K3 * A
    du.B = K2 + v5 - K4 * B
end

# ╔═╡ 632c9de0-dc67-4a7f-882d-e04403d24d0e
sols = map(u0 -> solve(ODEProblem(model!, u0, 1.5, params)), u0s);

# ╔═╡ 8d6fb7a3-b5b0-4d49-9b07-8dcb1e2105cc
plot(sols[1], xlabel="Time", ylabel="Concentration", title="Fig. 4.2A (Time series)")

# ╔═╡ afed1e2a-40a6-4ddf-8988-6a66661e5063
plot(sols[1], vars=(1, 2), xlabel="[A]", ylabel="[B]", aspect_ratio=:equal,
     title="Fig. 4.2B (Phase plot)", ylims=(0.0, 2.0), xlims=(0.0, 2.0), 
     legend=nothing)

# ╔═╡ ff7eed37-4569-45c1-af5c-aebda8fb2003
begin
	p3 = plot()
	
	for sol in sols
		plot!(p3, sol, linealpha=0.5, legend = nothing)
	end
	
	plot!(p3, xlabel="Time", ylabel="Concentration", title="Fig. 4.3A (Time series)")
end

# ╔═╡ d9295b32-da22-45e6-910b-6bd1126bb92b
begin
	p4 = plot()

	for sol in sols
		plot!(p4, sol, vars=(1, 2), linealpha=0.7, legend = nothing)
	end

	plot!(p4, aspect_ratio=:equal, title="Fig. 4.3B (Phase plot)", xlabel="[A]", ylabel="[B]", ylims=(0.0, 2.0), xlims=(0.0, 2.0), size=(600, 600))
end

# ╔═╡ a243b6e3-dd6b-47d0-b807-db88622bb3a4
# vector field
function df(x, y, p = params, scale=20)
	u = LVector(A=x, B=y)
	du = similar(u)
	model!(du, u, p, 0.0)
	return du ./ (norm(du)^0.5 * scale)
end

# ╔═╡ 0dd10ca8-71eb-4f68-89d7-a4717e06afc1
begin
	xx = [x for y in 0.0:0.1:2.0, x in 0.0:0.1:2.0]
	yy = [y for y in 0.0:0.1:2.0, x in 0.0:0.1:2.0]
	p1 = quiver(xx, yy, quiver=df, line=(:lightblue))
	
	for sol in sols
		plot!(p1, sol, vars=(1, 2), legend = nothing, line=(:green))
	end
	
	plot!(p1, aspect_ratio=:equal, title="Fig. 4.4A (Phase Plot with vector field)", 
      xlabel="[A]", ylabel="[B]", xlim=(0.0, 2.0), ylim=(0.0, 2.0), size=(600, 600))
	p1
end

# ╔═╡ 799cb2ff-a7a2-4947-99c2-d23c06f0b920
# Nullclines
begin
	nullcline_a(b, p) = p.K1 / (p.K5 + p.K4)  * hill(1, b, p.N)
	nullcline_a(b) = nullcline_a(b, params)
	nullcline_b(b, p) = (p.K4*b - p.K2) / p.K5
	nullcline_b(b) = nullcline_b(b, params)
end

# ╔═╡ 160b9f34-e089-40b1-8976-b1a168da2044
begin
	# Figure 4.5A
	p45a = plot(aspect_ratio=:equal, title="Fig. 4.5A, Phase plot with nullclines")
	
	# Phase plots
	for sol in sols
		plot!(p45a, sol, vars=(1, 2), linealpha=0.7, lab=nothing)
	end

	# Parametric plotting for nullcline
	plot!(p45a, nullcline_a, identity, 0.0, 2.0, label="A nullcline", line=(:black, :dot))
	plot!(p45a, nullcline_b, identity, 0.0, 2.0, label="B nullcline", line=(:black, :dash))
	plot!(p45a, xlim=(0.0, 2.0), ylim=(0.0, 2.0), legend=:bottomright, size=(600, 600), xlabel="[A]", ylabel="[B]")
	
	p45a
end

# ╔═╡ 30ecb42b-ed42-455a-a933-2f00a4495907
begin
	p45b = quiver(xx, yy, quiver=df, line=(:lightblue), title="Fig. 4.5B, Vector field with nullclines", xlabel="[A]", ylabel="[B]")
	plot!(p45b, nullcline_a, identity, 0.0, 2.0, label="A nullcline", line=(:black, :dot))
	plot!(p45b, nullcline_b, identity, 0.0, 2.0, label="B nullcline", line=(:black, :dash))
	plot!(p45b, aspect_ratio=1.0, xlim=(0.0, 2.0), ylim=(0.0, 2.0), legend=:bottomright, size=(600, 600))
	
	p45b
end

# ╔═╡ Cell order:
# ╠═4a209b69-b1b4-4a63-8786-c2b2a1a9b6ee
# ╠═f8ff273a-e1c7-4f00-9f9d-0ecb99f90b1e
# ╠═9b0868de-687e-44f0-a3b8-2321cebd3a52
# ╠═69f0e704-2a02-430d-97fd-4a7e5b1fc031
# ╠═632c9de0-dc67-4a7f-882d-e04403d24d0e
# ╠═8d6fb7a3-b5b0-4d49-9b07-8dcb1e2105cc
# ╠═afed1e2a-40a6-4ddf-8988-6a66661e5063
# ╠═ff7eed37-4569-45c1-af5c-aebda8fb2003
# ╠═d9295b32-da22-45e6-910b-6bd1126bb92b
# ╠═298447c2-7e64-422c-9d25-9fb4dee35441
# ╠═799cb2ff-a7a2-4947-99c2-d23c06f0b920
# ╠═a243b6e3-dd6b-47d0-b807-db88622bb3a4
# ╠═0dd10ca8-71eb-4f68-89d7-a4717e06afc1
# ╠═160b9f34-e089-40b1-8976-b1a168da2044
# ╠═30ecb42b-ed42-455a-a933-2f00a4495907
# ╠═0b3412c0-bde3-11eb-0869-17548acad535
# ╠═3d3f9ef7-4195-413a-a4d4-563f327ccda4
# ╠═755e081d-7176-4325-b481-d5d67db6176c
