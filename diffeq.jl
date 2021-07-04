### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ b28e37b3-7623-4f3a-be77-f3af975b4cbe
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="Plots", version="1"),
		Pkg.PackageSpec(name="DifferentialEquations", version="6"),
		Pkg.PackageSpec(name="Parameters", version="0.12"),
        Pkg.PackageSpec(name="LabelledArrays", version="1"),
    ])
	using Plots, PlutoUI, DifferentialEquations, Parameters, LabelledArrays

	# Backends and default options (optional)
	Plots.gr(fmt=:png, lw=2)
	
	PlutoUI.TableOfContents()
end

# ╔═╡ a26286e0-dca6-11eb-1a5e-bfc7cdfb69df
md"""
# Solving differential equations in Julia
"""

# ╔═╡ ae97df87-b19a-43be-a496-4c8d8b177232
md"""
## Define your model

For example, the [SIR model](https://www.maa.org/press/periodicals/loci/joma/the-sir-model-for-spread-of-disease-the-differential-equation-model) is a simple model of spreading of an contagious disease:

```math
\begin{align}
\frac{d}{dt}s(t) &= - \beta s(t)i(t)  \\
\frac{d}{dt}i(t) &= \beta s(t)i(t)  - \gamma i(t)  \\
\frac{d}{dt}r(t) &= \gamma i(t)
\end{align}
```

``s(t)`` is the proportion of susceptible people, ``i(t)`` is the proportion of infectious people, and ``r(t)`` is the proportion of recovered (or removed) people.
"""

# ╔═╡ 041b126d-1fc1-4daf-8d57-8353d04d9586
function sir(u, p ,t)
	s, i, r = u
	@unpack β, γ = p
	v1 = β * s * i
	v2 = γ * i
	return [-v1, v1-v2, v2]
end

# ╔═╡ c64e8eb5-63c4-4f3d-8444-b0a07ea3516b
## Parameters, initital conditions, and simulation time

# ╔═╡ 315d1a2c-5e22-433f-ae5a-b63f1390ab7f
p = (β = 1.0, γ = 0.3)

# ╔═╡ 57dcb8e9-72a8-484b-9183-1ed76433a558
u0 = [0.99, 0.01, 0.00]  # s, i, r

# ╔═╡ 29eba68c-92b4-47ec-a2f1-983b214439f0
tspan = (0.0, 20.0)

# ╔═╡ 78a6ab16-3158-466e-9038-c9cd274a9710
md"""
## In house algorithms

### The forward Euler method

In each step of the (forward) [Euler method](https://en.wikipedia.org/wiki/Euler_method), the next state variables ($\vec{u}_{n+1}$) are accumulated by the product of the time step (dt) and the derivatives at the current state ($\vec{u}_{n}$):

```math
\vec{u}_{n+1} = \vec{u}_{n} + dt \cdot f(\vec{u}_{n}, t_{n})
```
"""

# ╔═╡ c6dfd5fe-5994-42cf-bf4f-c262946ee04b
# ODE stepper
step_euler(f, u, p, t, dt) = u .+ dt .* f(u, p, t)

# ╔═╡ a54d5153-ee7e-46be-bdff-a8e0e3e74cae
# ODE solver
function mysolve(f, u0, tspan, p; dt=0.1, stepper=step_euler)
    ts = tspan[1]:dt:tspan[end]
    us = zeros(length(ts), length(u0))
    us[1, :] .= u0
    for i in 1:length(ts)-1
        us[i+1, :] .= stepper(f, us[i, :], p, ts[i], dt)
    end
    return (t = ts, u = us)
end

# ╔═╡ c1cbf2cb-8488-4a97-b643-986dd5270f9d
solFE = mysolve(sir, u0, tspan, p, dt=0.1, stepper=step_euler)

# ╔═╡ a4a02eba-e908-40a3-8fa0-6af585394c30
plot(solFE.t, solFE.u, label=["S" "I" "R"], legend=:right, )

# ╔═╡ ffed8a50-e307-4dac-8a1c-2d037d95ab60
md"""
### The fourth order Runge-Kutta (RK4) method

One famous ODE-solving method is the fourth order Runge-Kutta ([RK4](https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods)) method.

In each step, the next state is calculated in 5 steps with 4 intermediate steps.

```math
\begin{align}
k_1 &= dt \cdot f(\vec{u}_{n}, t_n)  \\
k_2 &= dt \cdot f(\vec{u}_{n} + 0.5k_1, t_n + 0.5dt)  \\
k_3 &= dt \cdot f(\vec{u}_{n} + 0.5k_2, t_n + 0.5dt)  \\
k_4 &= dt \cdot f(\vec{u}_{n} + k_3, t_n + dt)  \\
u_{n+1} &= \vec{u}_{n} + (k_1 + 2k_2 + 2k_3 + k_4)/6
\end{align}
```
"""

# ╔═╡ dc08c495-6f3c-48f2-b3e8-b9b5fee70089
# TODO 
step_rk4(f, u, p, t, dt) = nothing

# ╔═╡ 5a4e7187-a696-4af1-b1cd-7c7e9548ef45
md"""
## Use DifferentialEquations.jl package
"""

# ╔═╡ adfeb74c-072a-41e4-a032-6808d6ad0d09
prob = ODEProblem(sir, u0, tspan, p)

# ╔═╡ 80c95a60-5ff6-44f1-bf42-b12b79f24561
sol = solve(prob)

# ╔═╡ bcea934c-13fb-4808-bdfa-ae46d0f7fc7d
plot(sol, label=["S" "I" "R"], legend=:right)

# ╔═╡ 948bd931-0527-44c5-a5ce-1c1b8c953042
md"""
# Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═a26286e0-dca6-11eb-1a5e-bfc7cdfb69df
# ╠═ae97df87-b19a-43be-a496-4c8d8b177232
# ╠═041b126d-1fc1-4daf-8d57-8353d04d9586
# ╠═c64e8eb5-63c4-4f3d-8444-b0a07ea3516b
# ╠═315d1a2c-5e22-433f-ae5a-b63f1390ab7f
# ╠═57dcb8e9-72a8-484b-9183-1ed76433a558
# ╠═29eba68c-92b4-47ec-a2f1-983b214439f0
# ╠═78a6ab16-3158-466e-9038-c9cd274a9710
# ╠═c6dfd5fe-5994-42cf-bf4f-c262946ee04b
# ╠═a54d5153-ee7e-46be-bdff-a8e0e3e74cae
# ╠═c1cbf2cb-8488-4a97-b643-986dd5270f9d
# ╠═a4a02eba-e908-40a3-8fa0-6af585394c30
# ╠═ffed8a50-e307-4dac-8a1c-2d037d95ab60
# ╠═dc08c495-6f3c-48f2-b3e8-b9b5fee70089
# ╠═5a4e7187-a696-4af1-b1cd-7c7e9548ef45
# ╠═adfeb74c-072a-41e4-a032-6808d6ad0d09
# ╠═80c95a60-5ff6-44f1-bf42-b12b79f24561
# ╠═bcea934c-13fb-4808-bdfa-ae46d0f7fc7d
# ╠═948bd931-0527-44c5-a5ce-1c1b8c953042
# ╠═b28e37b3-7623-4f3a-be77-f3af975b4cbe
