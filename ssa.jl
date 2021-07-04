### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ d9e151c3-8ad0-4839-942f-23f87ce9c731
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="StatsBase", version="0.33"),
    ])
	using StatsBase # Weights() and sample()
	using Random    # randexp()
	using Plots
	using PlutoUI
	PlutoUI.TableOfContents()
end

# ╔═╡ 9e992e60-dc9c-11eb-3874-5917c815366c
md"""
# Gillespie Algorithm
"""

# ╔═╡ 99194f30-e3da-4b76-9a44-de34cdf888e0
#=
Stochastic chemical reaction: Gillespie Algorithm (direct method)
Adapted from: Chemical and Biomedical Enginnering Calculations Using Python Ch.4-3
=#
function ssa_direct(model, u0, tend, p, stoich; tstart=zero(tend))
    t = tstart   # Current time
    ts = [t]     # Time points
    u = copy(u0) # Current state
    us = copy(u) # Record of states
    while t < tend
        a = model(u, p, t)               # propensities
        dt = randexp() / sum(a)          # Time step
        du = sample(stoich, Weights(a))  # Choose the stoichiometry for the next reaction
        u .+= du  # Update state
        t += dt   # Update time
        
        us = [us u]  # Append state variable to record
        push!(ts, t) # Append time point to record
    end
    # Trasnpose to make column as variables, rows as observations
    us = collect(us')
    return (t = ts, u = us)
end

# ╔═╡ c00dada7-bd85-45b6-afc4-ce4ad7af5146
#=
Stochastic chemical reaction: Gillespie Algorithm (first reaction method)
Adapted from: Chemical and Biomedical Enginnering Calculations Using Python Ch.4-3
=#
function ssa_first(model, u0, tend, p, stoich; tstart=zero(tend))
    t = tstart   # Current time
    ts = [t]     # Time points
    u = copy(u0) # Current state
    us = copy(u) # Record of states
    while t < tend
        a = model(u, p, t)  # propensities of reactions
        # dts from all reactions
        dts = randexp(length(a)) ./ a
        # Choose the reaction 
        i = argmin(dts)
        dt = dts[i]
        du = stoich[i]
        # Update state and time
        u .+= du
        t += dt
        us = [us u]  # Append state variable to record
        push!(ts, t) # Append time point to record
    end
    # Make column as variables, rows as observations
    us = collect(us')
    return (t = ts, u = us)
end

# ╔═╡ 6d4847cd-c289-462f-a90a-525fb10c111e
#=
Reaction of A <-> B with rate constants k1 & k2
=#
"Propensity model for this reaction"
model(u, p, t) = [p.k1 * u[1],  p.k2 * u[2]]

# ╔═╡ 333296be-e574-4a67-9299-dfc240187bec
parameters = (k1=1.0, k2=0.5, stoich=[[-1, 1], [1, -1]])

# ╔═╡ 5eaa4112-3b1b-4686-a350-a5e9df00420a
u0 = [200, 0]

# ╔═╡ c284f038-672c-4f28-b940-7f144d080fc4
tend = 10.0

# ╔═╡ 7c3e75cb-6270-4959-af02-4175ed7f1bcf
soldirect = ssa_direct(model, u0, tend, parameters, parameters.stoich)

# ╔═╡ a5f57b8a-1c11-4aa0-8e39-bd9d5b9174ac
solfirst = ssa_first(model, u0, tend, parameters, parameters.stoich)

# ╔═╡ b0180686-1e2f-4663-848e-c2185e1616a0
plot(soldirect.t, soldirect.u, xlabel="time", ylabel="# of molecules", title = "SSA (direct method)", label=["A" "B"])

# ╔═╡ 1627aebf-f2ea-4b8d-9af4-63ead37741ea
plot(solfirst.t, solfirst.u, xlabel="time", ylabel="# of molecules", title = "SSA (1st reaction method)", label=["A" "B"])

# ╔═╡ 8d1817db-1039-4abf-b031-97a7a0a3cbf5
let 
	# Running an ensemble of simulations
	sol = ssa_direct(model, u0, tend, parameters, parameters.stoich)
	p = plot(sol.t, sol.u, linecolor=[:blue :red], label=["A" "B"], 
		xlabel="time", ylabel="# of molecules", 
		title = "SSA (1st reaction method) ensemble")
	for i in 1:49
		sol = ssa_direct(model, u0, tend, parameters, parameters.stoich)
		plot!(p, sol.t, sol.u, linecolor=[:blue :red], linealpha=0.2, label=false)
	end

	p
end

# ╔═╡ b48dab17-7cfb-4940-9ea3-eb9f50bf44ef
md"""
# Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ b10c1834-967a-4ac8-ba0c-bd705c613f42


# ╔═╡ Cell order:
# ╠═9e992e60-dc9c-11eb-3874-5917c815366c
# ╠═99194f30-e3da-4b76-9a44-de34cdf888e0
# ╠═c00dada7-bd85-45b6-afc4-ce4ad7af5146
# ╠═6d4847cd-c289-462f-a90a-525fb10c111e
# ╠═333296be-e574-4a67-9299-dfc240187bec
# ╠═5eaa4112-3b1b-4686-a350-a5e9df00420a
# ╠═c284f038-672c-4f28-b940-7f144d080fc4
# ╠═7c3e75cb-6270-4959-af02-4175ed7f1bcf
# ╠═a5f57b8a-1c11-4aa0-8e39-bd9d5b9174ac
# ╠═b0180686-1e2f-4663-848e-c2185e1616a0
# ╠═1627aebf-f2ea-4b8d-9af4-63ead37741ea
# ╠═8d1817db-1039-4abf-b031-97a7a0a3cbf5
# ╠═b48dab17-7cfb-4940-9ea3-eb9f50bf44ef
# ╠═d9e151c3-8ad0-4839-942f-23f87ce9c731
# ╠═b10c1834-967a-4ac8-ba0c-bd705c613f42
