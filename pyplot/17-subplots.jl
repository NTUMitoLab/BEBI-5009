### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 2aadd4e3-3060-46da-a4d0-4b1b25a1b7b5
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

# ╔═╡ 88b71320-c200-11eb-31a4-ef860ad1b32f
md"""
# Subplots

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_subplot.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 074d8a39-a7fa-418d-aa91-96136e16abcd
let
	fig = plt.figure("pyplot_subplot_mixed",figsize=(10,10)) # Create a new blank figure
	#fig.set_figheight(7) # Doesn't work
	#fig.set_figwidth(3) # Doesn't work
	plt.subplot(221) # Create the 1st axis of a 2x2 arrax of axes
	plt.grid("on") # Create a grid on the axis
	plt.title("221") # Give the most recent axis a title
	plt.subplot(222,polar="true") # Create a plot and make it a polar plot, 2nd axis of 2x2 axis grid
	plt.title("222")
	ax = plt.subplot(223,polar="true") # Create a plot and make it a polar plot, 3rd axis of 2x2 axis grid
	ax.set_theta_zero_location("N") # Set 0 degrees to the top of the plot
	ax.set_theta_direction(-1) # Switch the polar plot to clockwise
	plt.title("223")
	plt.subplot(224) # Create the 4th axis of a 2x2 arrax of axes
	plt.xlabel("This is an X axis")
	plt.ylabel("This is a y axis")
	plt.title("224")
	fig.suptitle("2x2 Subplot")
	
	fig
end

# ╔═╡ 494a660e-d9ab-467b-957b-ce9c4c79d852
let 
	###################
	##  Column Plot  ##
	###################
	fig = plt.figure("pyplot_subplot_column",figsize=(10,10))
	plt.subplot(311) # Create the 1st axis of a 3x1 array of axes
	plt.title("311")
	plt.subplot(312) # Create the 2nd axis of a 3x1 arrax of axes
	ax = plt.gca() # Get the handle of the current axis
	ax.set_yscale("log") # Set the y axis to a logarithmic scale
	plt.grid("on")
	plt.ylabel("Log Scale")
	plt.title("312")
	plt.subplot(313) # Create the 3rd axis of a 3x1 array of axes
	ax = plt.gca()
	ax.set_xscale("log") # Set the x axis to a logarithmic scale
	plt.xlabel("Log Scale")
	plt.title("313")
	fig.suptitle("3x1 Subplot")
	
	fig
end

# ╔═╡ 5673da17-5e08-42ec-b7ec-1fd8abefc4d8
let
	###################
	##  Shared Axis  ##
	###################
	fig = plt.figure("pyplot_subplot_touching",figsize=(10,10))
	plt.subplots_adjust(hspace=0.0) # Set the vertical spacing between axes
	plt.subplot(311) # Create the 1st axis of a 3x1 array of axes
	ax1 = plt.gca()
	ax1.set_xscale("log") # Set the x axis to a logarithmic scale
	plt.setp(ax1.get_xticklabels(),visible=false) # Disable x tick labels
	plt.grid("on")
	plt.title("Title")
	plt.yticks(0.1:0.2:0.9) # Set the y-tick range and step size, 0.1 to 0.9 in increments of 0.2
	plt.ylim(0.0,1.0) # Set the y-limits from 0.0 to 1.0
	plt.subplot(312,sharex=ax1) # Create the 2nd axis of a 3x1 array of axes
	ax2 = plt.gca()
	ax2.set_xscale("log") # Set the x axis to a logarithmic scale
	plt.setp(ax2.get_xticklabels(),visible=false) # Disable x tick labels
	plt.grid("on")
	plt.ylabel("Log Scale")
	plt.yticks(0.1:0.2:0.9)
	plt.ylim(0.0,1.0)
	plt.subplot(313,sharex=ax2) # Create the 3rd axis of a 3x1 array of axes
	ax3 = plt.gca()
	ax3.set_xscale("log") # Set the x axis to a logarithmic scale
	plt.grid("on")
	plt.xlabel("Log Scale")
	plt.yticks(0.1:0.2:0.9)
	plt.ylim(0.0,1.0)
	plt.suptitle("3x1 Shared Axis")
	
	fig
end

# ╔═╡ 4baa3ac2-1ec5-4f9b-ad9a-d37e6b31108c
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═88b71320-c200-11eb-31a4-ef860ad1b32f
# ╠═074d8a39-a7fa-418d-aa91-96136e16abcd
# ╠═494a660e-d9ab-467b-957b-ce9c4c79d852
# ╠═5673da17-5e08-42ec-b7ec-1fd8abefc4d8
# ╠═4baa3ac2-1ec5-4f9b-ad9a-d37e6b31108c
# ╠═2aadd4e3-3060-46da-a4d0-4b1b25a1b7b5
