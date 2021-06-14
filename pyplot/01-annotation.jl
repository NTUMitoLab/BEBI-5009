### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 94771b33-b4d7-4655-99bb-9cbfabe1ecea
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="LaTeXStrings", version="1"),
    ])
    using PlutoUI, Dates, LaTeXStrings
	import PyPlot as plt
	PlutoUI.TableOfContents()
end

# ╔═╡ 4c88fa9e-5cc2-48ec-aff5-2bba5904f775
md"""

# Plot annotations

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_annotation.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 6506425d-f31b-4e75-a2ad-4eb19f4aec12
md"""
## Data

Generate an hour of data at 10Hz.
"""

# ╔═╡ 36691a05-f549-44f9-9723-6cfc205dcd23
begin
	x = collect(DateTime(2013,10,4):Dates.Millisecond(100):DateTime(2013,10,4,1)) # Generate time array
	x = Dates.value.(x)/1000/60/60/24 # Convert time from milliseconds from day 0 to days from day 0
end

# ╔═╡ 94cd4a48-206e-4774-8ce9-077e1bfd9c12
y = sin.(2*pi*collect(0:2*pi/(length(x)+1):2*pi-(2*pi/length(x))))

# ╔═╡ 2e1d7ff7-e7f0-49ff-945e-9194207aac07
dx = maximum(x) - minimum(x)

# ╔═╡ d367c033-79ec-4313-9dba-0c617e45cd8f
dy = maximum(y) - minimum(y)

# ╔═╡ 103bdb97-7677-4d20-bc6b-06af21cde988
begin
	y2 = 30.0*(1.0 .+ sin.(2.0*pi*collect(pi:2.0*pi/length(x):3*pi-(2*pi/length(x))))) .- 10.0
	y2 = 10rand(21) .- 3
end

# ╔═╡ 570ba8d3-e3cf-4382-bc3f-bb8a12ab4986
x2 = collect(minimum(x):dx/20:maximum(x))

# ╔═╡ 192e82f2-25ec-4d0d-b873-86bcb1b17cd7
x3 = collect(minimum(x):dx/20:maximum(x))

# ╔═╡ b069dd61-7467-478f-956a-fbc2f37a8c2e
y3 = 10rand(21) .- 3;

# ╔═╡ d601ca88-888b-4bc0-8bdd-2f9a726d7f69
md"""
## Plot

In Pluto notebooks it is recommended to wrap plotting commands into a let block oir a function to maintain its reactivity.
"""

# ╔═╡ 81d1feb5-c123-4d15-a0ce-8c60543f6f08
let
	fig, ax = plt.subplots(figsize=(10, 10))
	
	ax.plot_date(x,y, linestyle="-", marker="None", label="Test Plot") # Plot a basic line
	ax.axis("tight") # Fit the axis tightly to the plot
	ax.set_title("U Component of Wind")
	ax.grid("on")
	ax.legend(loc="upper right",fancybox="true")
	
	##################
	#  Text Styling  #
	##################
	
	font1 = Dict("family"=>"serif",
    			 "color"=>"darkred",
    			 "weight"=>"normal",
    			 "size"=>16)
	ax.set_xlabel("Time", fontdict=font1)        # X Axis font formatting
	ax.set_ylabel("Velocity (m/s)")
	plt.setp(ax.get_yticklabels(),fontsize=24,color="blue") # Y Axis font formatting

	
	#################
	#  Arrow Tests  #
	#################
	
	# This arrows orient toward the x-axis, the more horizontal they are the more skewed they look

	ax.arrow(x[convert(Int64,floor(length(x)/2))],
			0.4,
			0.0009,
			0.4,
			head_width=0.001,
			width=0.00015,
			head_length=0.07,
			overhang=0.5,
			head_starts_at_zero="true",
			facecolor="red")
	
	ax.arrow(x[convert(Int64,floor(0.3length(x)))]-0.25dx,
			y[convert(Int64,floor(0.3length(y)))]+0.25dy,
			0.25dx,
			-0.25dy,
			head_width=0.001,
			width=0.00015,
			head_length=0.07,
			overhang=0.5,
			head_starts_at_zero="true",
			facecolor="red",
			length_includes_head="true")
	
	###########################
	#  Text Annotation Tests  #
	###########################
	
	ax.annotate("Look, data!",
		xy=[x[convert(Int64,floor(length(x)/4.1))];y[convert(Int64,floor(length(y)/4.1))]],
		xytext=[x[convert(Int64,floor(length(x)/4.1))]+0.1dx;y[convert(Int64,floor(length(y)/4.1))]+0.1dy],
		xycoords="data",
		arrowprops=Dict("facecolor"=>"black")) # Julia dictionary objects are automatically converted to Python object when they pass into a PyPlot function
	ax.annotate("Figure Top Right",
		xy=[1;1],
		xycoords="figure fraction",
		xytext=[0,0],
		textcoords="offset points",
		ha="right",
		va="top")
	ax.annotate(L"$\int x = \frac{x^2}{2} + C$",
		xy=[1;0],
		xycoords="axes fraction",
		xytext=[-10,10],
		textcoords="offset points",
		fontsize=30.0,
		ha="right",
		va="bottom")
	
	fig.autofmt_xdate(bottom=0.2,rotation=30,ha="right")
	fig
end

# ╔═╡ 7f10b050-c11b-11eb-2c5f-4fdd7ccd8307
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═4c88fa9e-5cc2-48ec-aff5-2bba5904f775
# ╠═6506425d-f31b-4e75-a2ad-4eb19f4aec12
# ╠═36691a05-f549-44f9-9723-6cfc205dcd23
# ╠═94cd4a48-206e-4774-8ce9-077e1bfd9c12
# ╠═2e1d7ff7-e7f0-49ff-945e-9194207aac07
# ╠═d367c033-79ec-4313-9dba-0c617e45cd8f
# ╠═103bdb97-7677-4d20-bc6b-06af21cde988
# ╠═570ba8d3-e3cf-4382-bc3f-bb8a12ab4986
# ╠═192e82f2-25ec-4d0d-b873-86bcb1b17cd7
# ╠═b069dd61-7467-478f-956a-fbc2f37a8c2e
# ╠═d601ca88-888b-4bc0-8bdd-2f9a726d7f69
# ╠═81d1feb5-c123-4d15-a0ce-8c60543f6f08
# ╠═7f10b050-c11b-11eb-2c5f-4fdd7ccd8307
# ╠═94771b33-b4d7-4655-99bb-9cbfabe1ecea
