### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ b35d034a-7f8c-40c7-b992-970686916f47
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI, Dates
	import PyPlot as plt
	PlutoUI.TableOfContents()
end

# ╔═╡ b8bc21de-c125-11eb-31d0-1b07a1a9f8f1
md"""
# Error bar

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_errorbar.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ e71e8ea1-9121-4be4-b6c1-81ba3772031c
# Data
x = collect(DateTime(2013,10,4):Dates.Day(1):DateTime(2013,10,9))

# ╔═╡ c172330f-5e71-42cf-bc4d-25188c0e0efa
y = [0.9;0.75;0.5;0.4;0.35;0.3]

# ╔═╡ 59cd6df3-e6b2-4f93-b14e-1a1c43de57b5
uppererror = [0.05 0.05 0.05 0.03 0.15 0.05;]

# ╔═╡ 1f1096f2-46c8-48ba-aadb-382a0db0290d
lowererror = [0.15 0.2 0.05 0.1 0.05 0.05;]

# ╔═╡ 6865dcea-a177-4100-9614-4a36345fc183
errs = [lowererror;uppererror]

# ╔═╡ 7a0d4f62-0603-4be3-9af1-3facc30644e6
# Plot

let 
	fig, ax = plt.subplots(figsize=(10,10))
	ax.plot_date(x,y,linestyle="-",marker="None",label="Base Plot") # Basic line plot
	ax.errorbar(x,y,yerr=errs,fmt="o") # Plot irregular error bars
	ax.axis("tight")
	
	ax.set_title("Error Bar Example")
	ax.set_xlabel("Time")
	ax.set_ylabel("Some Data")
	ax.grid("on")
	
	fig.autofmt_xdate(bottom=0.2,rotation=30,ha="right") # Autoformat the time format and rotate the labels so they don't overlap
	fig
end

# ╔═╡ 112ed0a1-6452-4718-9b3d-d202327d68fa
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═b8bc21de-c125-11eb-31d0-1b07a1a9f8f1
# ╠═e71e8ea1-9121-4be4-b6c1-81ba3772031c
# ╠═c172330f-5e71-42cf-bc4d-25188c0e0efa
# ╠═59cd6df3-e6b2-4f93-b14e-1a1c43de57b5
# ╠═1f1096f2-46c8-48ba-aadb-382a0db0290d
# ╠═6865dcea-a177-4100-9614-4a36345fc183
# ╠═7a0d4f62-0603-4be3-9af1-3facc30644e6
# ╠═112ed0a1-6452-4718-9b3d-d202327d68fa
# ╠═b35d034a-7f8c-40c7-b992-970686916f47
