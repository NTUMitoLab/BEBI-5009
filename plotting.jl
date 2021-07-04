### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 385dde55-f4b2-4e59-97e7-2293bc8668c9
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI, Plots
	PlutoUI.TableOfContents()
	
	# Backends and default options (optional)
	Plots.gr(fmt=:png, lw=2)
end

# ╔═╡ fa82e5e0-dca1-11eb-0572-b3af66be1bde
md"""
# Plotting in Julia

- [Plots.jl](https://github.com/JuliaPlots/Plots.jl): powerful and convenient visualization. Multiple backends.
- [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl): `matplotlib` in Julia.

## References

- [Plots.jl docs](http://docs.juliaplots.org/latest/)
- [Plots.jl Gallery](https://sosiristseng.github.io/plotsgallery-pluto/) in Pluto notebooks
- [PyPlot.jl Gallery](https://sosiristseng.github.io/pyplot-pluto/) in Pluto notebooks
"""

# ╔═╡ 12b2c0ce-ae51-4b8e-8401-30b2b33d203d
f(x) = sin(sin(x) + 1)

# ╔═╡ e036ab0c-14b8-4fe6-aaff-967adb23c1b1
xs = 0.0:0.1:4pi

# ╔═╡ 632aa0cc-0db5-40ce-ae6e-404d58599a92
ys = f.(xs)

# ╔═╡ f4f817d0-6c25-4a8f-95e8-01e1e1bfec98
# Line plots link the data points
plot(xs, ys)

# ╔═╡ a0fd0afb-203a-41ee-95fc-819c97d8c744
# scatter plots show the data points only
scatter(xs, ys)

# ╔═╡ 5b15c069-b707-471d-95ab-21bb3df516fd
# plot functions directly
plot(f, xs)

# ╔═╡ de89a6c5-8707-426f-bcef-011084050a43
# plot functions directly within a range
plot(f, 0.0, 4pi)

# ╔═╡ de4e0e11-7add-40e8-a0ea-3bd153d0007b
# Customizations
plot(f, xs, 
     label="My line", legend=:bottom, 
     title="My Title",  line=(:red, 3),
     xlim = (0.0, 5.0), ylim = (-1.0, 1.5),
     xlabel="time", ylabel="My Mood", border=:box)

# ╔═╡ 73fe60c7-1dc9-4f13-9997-1875f35cb4d2
# Multiple series
# each row is one observation; each column is a variable.
f2(x) = cos(cos(x) + 1)

# ╔═╡ 389d4baf-59a9-4072-932e-ea51a228568f
y2 = f2.(xs)

# ╔═╡ f5477418-e7a5-4561-9f07-ae633f9531fa
plot(xs, [ys y2])

# ╔═╡ 29097da3-a8b4-4e0d-ae98-5a3329d1b4da
# Customizations
plot(xs, [f, f2], label=["f1" "f2"], lc=[:black :green], title="Two time series")

# ╔═╡ 2de23354-8682-484a-b545-3601d85678e5
let
	# Building the plot in multiple steps
	# in the object-oriented way (recommended)
	xMin = 0.0
	xMax = 4.0pi
	p1 = plot(f, xMin, xMax, label="f1", lc=:black)
	plot!(p1 , f2, xMin, xMax, label="f2", lc=:lightsalmon)
	plot!(p1, title = "My title", legend=:outertop)
	
	p1
end

# ╔═╡ 086e8784-1a22-41e0-8a58-f2e6fdef0d4b
# Parametric function plot
let
	xₜ(t) = sin(t)
	yₜ(t) = sin(2t)

	plot(xₜ, yₜ, 0, 2π, leg=false, fill=(0,:orange))
end

# ╔═╡ dc371711-6267-4b6c-98ec-9cd12f0e4376
# Creating subplots
begin
	p1 = plot(f, xs)
	p2 = plot(f2, xs)
	plot(p1, p2)
end

# ╔═╡ c63776cb-c1c7-4725-93d5-a98a3399c125
plot(p1, p2, layout=(2, 1))

# ╔═╡ 3cdd9475-9b75-4137-af02-18f096b2f854
md"""
# Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═fa82e5e0-dca1-11eb-0572-b3af66be1bde
# ╠═12b2c0ce-ae51-4b8e-8401-30b2b33d203d
# ╠═e036ab0c-14b8-4fe6-aaff-967adb23c1b1
# ╠═632aa0cc-0db5-40ce-ae6e-404d58599a92
# ╠═f4f817d0-6c25-4a8f-95e8-01e1e1bfec98
# ╠═a0fd0afb-203a-41ee-95fc-819c97d8c744
# ╠═5b15c069-b707-471d-95ab-21bb3df516fd
# ╠═de89a6c5-8707-426f-bcef-011084050a43
# ╠═de4e0e11-7add-40e8-a0ea-3bd153d0007b
# ╠═73fe60c7-1dc9-4f13-9997-1875f35cb4d2
# ╠═389d4baf-59a9-4072-932e-ea51a228568f
# ╠═f5477418-e7a5-4561-9f07-ae633f9531fa
# ╠═29097da3-a8b4-4e0d-ae98-5a3329d1b4da
# ╠═2de23354-8682-484a-b545-3601d85678e5
# ╠═086e8784-1a22-41e0-8a58-f2e6fdef0d4b
# ╠═dc371711-6267-4b6c-98ec-9cd12f0e4376
# ╠═c63776cb-c1c7-4725-93d5-a98a3399c125
# ╠═3cdd9475-9b75-4137-af02-18f096b2f854
# ╠═385dde55-f4b2-4e59-97e7-2293bc8668c9
