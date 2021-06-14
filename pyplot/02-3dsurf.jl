### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ e7933edd-2101-4ce6-a76f-273752e958f8
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI
	import PyPlot as plt
	PlutoUI.TableOfContents()
end

# ╔═╡ 9da4c253-b288-4fa5-913d-c7fe099d8576
md"""
# 3D surface plot

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_3d_surf_plot.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ e364f144-9d1d-4e19-9f5b-0a858319aa34
md"""
## Data
"""

# ╔═╡ 15330c5c-6826-44ac-905c-d39ecec4bc44
us = range(0.0,stop=2pi,length=300)

# ╔═╡ f9edf279-ff7b-4729-9387-db80fa687f5f
vs = range(0.0,stop=pi,length=300)

# ╔═╡ e23d2117-1ca0-44ae-91bc-71a6aec4b507
x = [cos(u) * sin(v) for u in us, v in vs]

# ╔═╡ e6578b41-9f84-472f-a778-a831b9498536
y = [sin(u) * sin(v) for u in us, v in vs]

# ╔═╡ 7cad0a3a-2b02-4aff-b7b7-3209dac89def
z = [cos(v) for u in us, v in vs]

# ╔═╡ f0892f1a-4676-4719-86fc-a6327e96129c
colors = rand(length(us),length(vs),3)

# ╔═╡ 4c709b36-59d1-4527-b315-33465dbfbb58
md"""
## Plot
"""

# ╔═╡ 4dc40178-edf3-437e-b890-ee9156fbd7f7
begin
	plt.surf(x,y,z,facecolors=colors)
	plt.gcf()
end

# ╔═╡ 07548a60-c11f-11eb-2f6e-f153197b42ce
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═9da4c253-b288-4fa5-913d-c7fe099d8576
# ╠═e364f144-9d1d-4e19-9f5b-0a858319aa34
# ╠═15330c5c-6826-44ac-905c-d39ecec4bc44
# ╠═f9edf279-ff7b-4729-9387-db80fa687f5f
# ╠═e23d2117-1ca0-44ae-91bc-71a6aec4b507
# ╠═e6578b41-9f84-472f-a778-a831b9498536
# ╠═7cad0a3a-2b02-4aff-b7b7-3209dac89def
# ╠═f0892f1a-4676-4719-86fc-a6327e96129c
# ╠═4c709b36-59d1-4527-b315-33465dbfbb58
# ╠═4dc40178-edf3-437e-b890-ee9156fbd7f7
# ╠═07548a60-c11f-11eb-2f6e-f153197b42ce
# ╠═e7933edd-2101-4ce6-a76f-273752e958f8
