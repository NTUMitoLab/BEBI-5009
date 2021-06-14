### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 3b449a60-2b1c-49a4-b337-056bc78e6502
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

# ╔═╡ 757627de-c1f8-11eb-068b-7d5b958b1f6d
md"""
# Quiver plots

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_quiverplot.jl.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 2858df73-2d64-4bba-b76c-23d87b698d92
R = -10:1:9

# ╔═╡ 46cd303d-02eb-41fe-a56a-3a8e81c76b21
X = [R;]'

# ╔═╡ eb2cafca-3df1-4da2-9d85-2b84b88ebf5a
Y = [R;]

# ╔═╡ 15769f1c-3e40-4852-9430-b06ef32e05c9
U = repeat([R;]',length(X))

# ╔═╡ 2774704b-5034-4b44-89bf-e36dddf42afe
V = repeat([R;],1,length(Y))

# ╔═╡ 398e9b26-c373-4a75-ac13-51552f721d01
let
	fig, ax = plt.subplots(figsize=(10,10))
	
	q = ax.quiver(X,Y,U,V)
	ax.quiverkey(q,X=0.07,Y = 0.05, U = 10,coordinates="figure", label="Quiver key, length = 10",labelpos = "E")
	ax.set_title("Quiver Plot Example")
	fig
end

# ╔═╡ 5afef89c-f891-4811-a82c-1d8edc29eb89
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═757627de-c1f8-11eb-068b-7d5b958b1f6d
# ╠═2858df73-2d64-4bba-b76c-23d87b698d92
# ╠═46cd303d-02eb-41fe-a56a-3a8e81c76b21
# ╠═eb2cafca-3df1-4da2-9d85-2b84b88ebf5a
# ╠═15769f1c-3e40-4852-9430-b06ef32e05c9
# ╠═2774704b-5034-4b44-89bf-e36dddf42afe
# ╠═398e9b26-c373-4a75-ac13-51552f721d01
# ╠═5afef89c-f891-4811-a82c-1d8edc29eb89
# ╠═3b449a60-2b1c-49a4-b337-056bc78e6502
