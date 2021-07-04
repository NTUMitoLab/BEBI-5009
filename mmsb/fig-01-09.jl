### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 0279facc-3f77-401b-ab39-352a6ac9bc9f
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

# ╔═╡ f0ab21d0-bdcb-11eb-39e8-59f7ff34b88c
md"""
# Fig 1.09 Hodgkin-Huxley model
"""

# ╔═╡ 51592b89-56fc-40b3-be86-8ae48241a80b
# Parameters for Hodgkin-Huxley model
    p = (E_N = 55.0,       # Reversal potential of Na (mV)
		 E_K = -72.0,      # Reversal potential of K (mV)
		 E_LEAK = -49.0,   # Reversal potential of leaky channels (mV)
		 G_N_BAR = 120.0,  # Max. Na channel conductance (mS/cm^2)
		 G_K_BAR = 36.0,   # Max. K channel conductance (mS/cm^2)
		 G_LEAK = 0.30,    # Max. leak channel conductance (mS/cm^2)
		 C_M = 1.0,        # membrane capacitance (uF/cm^2)
		 I_STIM = 0.0     # Stimulus current (uA/cm^2)
    )
	

# ╔═╡ 8018875c-258e-4516-a36c-2413fee97ccd
begin
	# Events and callbacks
	on_i1!(integrator) = integrator.p = @set p.I_STIM = -6.80
    off_i1!(integrator) = integrator.p = @set p.I_STIM = 0.0
    on_i2!(integrator) = integrator.p = @set p.I_STIM = -6.90

    cbs = CallbackSet(PresetTimeCallback([20.0], on_i1!),
                  PresetTimeCallback([21.0, 61.0], off_i1!),
                  PresetTimeCallback([60.0], on_i2!))
end

# ╔═╡ 999aae28-fe75-4a2f-a55d-12360b647f05
u0 = LVector(v=-59.8977, m=0.0536, h=0.5925, n=0.3192)

# ╔═╡ 23ec33a8-b6f3-4a89-bc24-95474ed5a9cb
tend = 100.0

# ╔═╡ 8e7633bb-1d79-43cc-81ec-8fc740ba13ff
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 94adbc56-8f68-4048-bfbc-326acb359fde
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
end

# ╔═╡ 31549c4b-2aec-4c09-9888-a15b2b0ebbd6
"ODE system of HH model"
	function hh!(du, u, p, t)
		@unpack E_N, E_K, E_LEAK, G_N_BAR, G_K_BAR, G_LEAK, C_M, I_STIM = p
		@unpack v, m, h, n = u

		mαV = -0.10 * (v + 35)
		mα = exprel(mαV)
		mβ = 4.0 * exp(-(v + 60) / 18.0)

		hα = 0.07 * exp(-(v+60)/20)
		hβ = 1 / (exp(-(v+30)/10) + 1)

		nαV = -0.1 * (v+50)
		nα = 0.1 * exprel(nαV)
		nβ = 0.125 * exp( -(v+60) / 80)

		iNa = G_N_BAR * (v - E_N) * (m^3) * h
		iK  = G_K_BAR * (v - E_K) * (n^4)
		iLeak = G_LEAK * (v - E_LEAK)
		du.v = -(iNa + iK + iLeak + I_STIM) / C_M
		du.m = -(mα + mβ) * m + mα
		du.h = -(hα + hβ) * h + hα
		du.n = -(nα + nβ) * n + nα
		return du
	end

# ╔═╡ 2e369b99-0f70-4ff2-be75-d3eec6c46777
sol = solve(ODEProblem(hh!, u0, tend, p), callback = cbs)

# ╔═╡ 2cec94d6-fcc8-49b6-970c-b84f8a736f61
plot(sol, vars=(0, 1), ylabel="Membrane potential (mV)", xlabel="Time (ms)", legend=false, title="Figure 1.9")

# ╔═╡ Cell order:
# ╠═f0ab21d0-bdcb-11eb-39e8-59f7ff34b88c
# ╠═31549c4b-2aec-4c09-9888-a15b2b0ebbd6
# ╠═8018875c-258e-4516-a36c-2413fee97ccd
# ╠═51592b89-56fc-40b3-be86-8ae48241a80b
# ╠═999aae28-fe75-4a2f-a55d-12360b647f05
# ╠═23ec33a8-b6f3-4a89-bc24-95474ed5a9cb
# ╠═2e369b99-0f70-4ff2-be75-d3eec6c46777
# ╠═2cec94d6-fcc8-49b6-970c-b84f8a736f61
# ╠═8e7633bb-1d79-43cc-81ec-8fc740ba13ff
# ╠═94adbc56-8f68-4048-bfbc-326acb359fde
# ╠═0279facc-3f77-401b-ab39-352a6ac9bc9f
