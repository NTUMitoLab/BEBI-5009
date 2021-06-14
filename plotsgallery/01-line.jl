### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 36d178f5-95fd-455f-954e-c85a5c92eebc
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI
	using Plots
	using Random
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ 8a1e5a8b-7fbd-4818-af91-a52df41e0e51
md"""
# 2D Line plots

## Line plots 2D (I)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/line_plot_2d_1.html)

`plot(xs, ys)`
"""

# ╔═╡ f27bb3ad-ba52-4334-9aac-a9fa48b07f47
x = 0:0.1:2pi

# ╔═╡ 7a692a81-a0fe-4d67-b6b1-697d976f89af
y1 = cos.(x)

# ╔═╡ 03e58a6b-02b0-4133-91f4-775a6aee6a39
y2 = sin.(x)

# ╔═╡ 9b2ea567-bdec-4211-a5d2-670a50b82c7f
begin
	p1 = plot(x, y1, c="blue", linewidth=3)
	plot!(p1, x, y2, c="red", line=:dash)
	title!(p1, "Trigonometric functions")
	xlabel!(p1, "angle")
	ylabel!(p1, "sin(x) and cos(x)")
	plot!(p1, xlims=(0,2pi), ylims=(-2, 2), size=(600, 600))
	p1
end

# ╔═╡ a8aa4f51-3e82-47d2-aa09-89ece6c7bbd4
begin
	p2 = plot(x, y1,
    		  c="blue",
    		  linewidth=3,
    		  title="Trigonometric functions",
    		  xlabel="angle",
    		  ylabel="sin(x) and cos(x)")
	plot!(p2, x, y2, c="red", line=:dash)

	plot!(p2, xlims=(0,2pi), ylims=(-2, 2), size=(600, 600))
end

# ╔═╡ e649e45c-7e3c-4b59-b0a4-7ca650077fac
md"""
## Line plots (II)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/line_plot_2d_2.html)

Plotting multiple series at once.

- One row = one observation
- One column = one species
"""

# ╔═╡ 15d78933-4ac8-4c60-b080-e8d32a5022d2
begin
	time = 30
	walker1 = cumsum(randn(time))
	walker2 = cumsum(randn(time))
	walker3 = cumsum(randn(time))
	walker4 = cumsum(randn(time))
	walker5 = cumsum(randn(time))
	plot(1:time, [walker1 walker2 walker3 walker4 walker5],
    xlabel="time",
    ylabel="position",
    label=["walker1" "walker2" "walker3" "walker4" "walker5"],
    leg=:bottomleft)
end

# ╔═╡ 4e32edc5-04a1-403b-bbd3-6fc67973b66b
md"""
## Function plots (I)

[Source](https://goropikari.github.io/PlotsGallery.jl/src/simple_fn.html)

Syntax: `plot(f, xmin, xmax)` or `plot(f, range_of_x)`
"""

# ╔═╡ 12250cdf-88a7-4c69-aff4-bdd1503d1ac9
f(x) = 5exp(-x^2)

# ╔═╡ 69321a3a-7f3e-4580-bc49-06865616a613
g(x) = x^2

# ╔═╡ 5dbc2035-2060-436d-a7ed-64c129c52968
plot([f, g], -3, 3, label=["f" "g"], legend=:top)

# ╔═╡ d18c02bc-081e-4b81-afdc-3d378136e3be
md"""
## Function plots (II)

Parametric function plots: <http://docs.juliaplots.org/latest/examples/pyplot/>
"""

# ╔═╡ 3fcf843e-35b1-4fb3-8c03-cb2ec80b415b
plot(sin, t->sin(2t), 0, 2π, leg=false, fill=(0,:orange))

# ╔═╡ 8fbe9f3e-ca21-4195-b1a6-3197ecc95ba1
md"""
# 3D line plots

3D line plots follow similar rules to 2D counterparts.

`plot(xs, ys, zs)`
"""

# ╔═╡ b0f89401-c277-449c-b5af-194be5dcd23e
md"""
## Parametric function plot in 3D

[Source](https://goropikari.github.io/PlotsGallery.jl/src/parametric3d.html)

`plot(fx, fy, fz, tmin, tmax)`
"""

# ╔═╡ 058765c0-453e-4603-80b2-bf768d72ef4c
plot(cos, sin, t->sin(5t), 0, 2pi, legend=nothing)

# ╔═╡ be3813ec-be35-11eb-0f75-956c2874118b
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═8a1e5a8b-7fbd-4818-af91-a52df41e0e51
# ╠═f27bb3ad-ba52-4334-9aac-a9fa48b07f47
# ╠═7a692a81-a0fe-4d67-b6b1-697d976f89af
# ╠═03e58a6b-02b0-4133-91f4-775a6aee6a39
# ╠═9b2ea567-bdec-4211-a5d2-670a50b82c7f
# ╠═a8aa4f51-3e82-47d2-aa09-89ece6c7bbd4
# ╠═e649e45c-7e3c-4b59-b0a4-7ca650077fac
# ╠═15d78933-4ac8-4c60-b080-e8d32a5022d2
# ╠═4e32edc5-04a1-403b-bbd3-6fc67973b66b
# ╠═12250cdf-88a7-4c69-aff4-bdd1503d1ac9
# ╠═69321a3a-7f3e-4580-bc49-06865616a613
# ╠═5dbc2035-2060-436d-a7ed-64c129c52968
# ╠═d18c02bc-081e-4b81-afdc-3d378136e3be
# ╠═3fcf843e-35b1-4fb3-8c03-cb2ec80b415b
# ╠═8fbe9f3e-ca21-4195-b1a6-3197ecc95ba1
# ╠═b0f89401-c277-449c-b5af-194be5dcd23e
# ╠═058765c0-453e-4603-80b2-bf768d72ef4c
# ╠═be3813ec-be35-11eb-0f75-956c2874118b
# ╠═36d178f5-95fd-455f-954e-c85a5c92eebc
