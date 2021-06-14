### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 082dc2dd-ecb8-4109-9ddf-aa16758fa49d
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

# ╔═╡ 035788be-c207-11eb-1bef-bf3f4c61d70b
md"""
# Windrose bar and line plots

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_windrose.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ d7d52aee-0474-4099-81f6-412debda859f
theta = collect(0:2pi/30:2pi)

# ╔═╡ 18b20aef-af2d-4073-a0b0-124c7f7f7b83
r = rand(length(theta))

# ╔═╡ 1c5c799b-e84d-4fd7-89cf-7a8b8941c0a9
# Desired width of each bar in the bar plot
width = 2pi/length(theta)

# ╔═╡ 16fd84fa-69ad-43f6-ace1-b5d2042bc3bc
##########################
##  Windrose Line Plot  ##
##########################
let
	fig = plt.figure(figsize=(10,10)) # Create a new figure
	ax = plt.axes(polar="true") # Create a polar axis
	
	ax.set_title("Wind Rose - Line")
	ax.plot(theta,r,linestyle="-",marker="None") # Basic line plot
	
	dtheta = 10
	
	ax.set_thetagrids(collect(0:dtheta:360-dtheta)) # Show grid lines from 0 to 360 in increments of dtheta
	ax.set_theta_zero_location("N") # Set 0 degrees to the top of the plot
	ax.set_theta_direction(-1) # Switch to clockwise
	
	fig
end

# ╔═╡ 27f204a2-eeac-47cc-8335-232e02c86808
#########################
##  Windrose Bar Plot  ##
#########################

let
	fig = plt.figure("pyplot_windrose_barplot",figsize=(10,10)) # Create a new figure
	ax = plt.axes(polar="true") # Create a polar axis
	ax.set_title("Wind Rose - Bar")
	ax.bar(theta,r,width=width) # Bar plot

	dtheta = 10
	ax.set_thetagrids(collect(0:dtheta:360-dtheta)) # Show grid lines from 0 to 360 in increments of dtheta
	ax.set_theta_zero_location("N") # Set 0 degrees to the top of the plot
	ax.set_theta_direction(-1) # Switch to clockwise
	
	fig
end

# ╔═╡ 28bd70eb-385a-40c4-8924-1fb28c18e90d
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═035788be-c207-11eb-1bef-bf3f4c61d70b
# ╠═d7d52aee-0474-4099-81f6-412debda859f
# ╠═18b20aef-af2d-4073-a0b0-124c7f7f7b83
# ╠═1c5c799b-e84d-4fd7-89cf-7a8b8941c0a9
# ╠═16fd84fa-69ad-43f6-ace1-b5d2042bc3bc
# ╠═27f204a2-eeac-47cc-8335-232e02c86808
# ╠═28bd70eb-385a-40c4-8924-1fb28c18e90d
# ╠═082dc2dd-ecb8-4109-9ddf-aa16758fa49d
