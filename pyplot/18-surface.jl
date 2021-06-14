### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 8e6402d8-0efd-4cb1-b37a-6bbb28d4311b
begin
    import Pkg
    Pkg.activate(mktempdir())
   	Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="Distributions", version="0.25"),
    ])
    using PlutoUI, Distributions, LinearAlgebra
	import PyPlot as plt
	plt.using3D() # Needed to create a 3D subplot
	PlutoUI.TableOfContents()
end

# ╔═╡ 1a450240-c204-11eb-2976-5193c346dcbc
md"""
# Surface plot

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_subplot.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ d93cbb81-85c1-4866-b95c-fc42115530be
begin
	n = 100
	x = range(-3,stop=3,length=n)
	y = range(-3,stop=3,length=n)

	xgrid = repeat(x',n,1)
	ygrid = repeat(y,1,n)

	z = zeros(n,n)

	for i in 1:n
		for j in 1:n
			z[i:i,j:j] .= pdf(MvNormal(Matrix(1.0I,2,2)),[x[i];y[j]])
		end
	end
end

# ╔═╡ 903c572d-00f1-4259-abfe-15ec0c8b3f05
let
	fig = plt.figure("pyplot_surfaceplot",figsize=(10,10))
	
	ax = fig.add_subplot(2,1,1,projection="3d")
	ax.plot_surface(xgrid, ygrid, z, rstride=2,edgecolors="k", cstride=2, cmap=plt.ColorMap("gray"), alpha=0.8, linewidth=0.25)
	ax.set_xlabel("X")
	ax.set_ylabel("Y")
	ax.set_title("Surface Plot")
	
	ax = fig.add_subplot(2,1,2)
	cp = ax.contour(xgrid, ygrid, z, colors="black", linewidth=2.0)
	ax.clabel(cp, inline=1, fontsize=10)
	ax.set_xlabel("X")
	ax.set_ylabel("Y")
	ax.set_title("Contour Plot")
	fig.tight_layout()
	
	fig
end

# ╔═╡ 7dc58932-e3a2-4d03-9935-dc1b83e09f1e
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═1a450240-c204-11eb-2976-5193c346dcbc
# ╠═d93cbb81-85c1-4866-b95c-fc42115530be
# ╠═903c572d-00f1-4259-abfe-15ec0c8b3f05
# ╠═7dc58932-e3a2-4d03-9935-dc1b83e09f1e
# ╠═8e6402d8-0efd-4cb1-b37a-6bbb28d4311b
