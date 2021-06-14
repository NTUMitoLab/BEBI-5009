### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 27fc63d1-c311-42fb-ad7a-f268df2c3db8
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using PlutoUI, Random
	import PyPlot as plt
	Random.seed!(2021)
	PlutoUI.TableOfContents()
end

# ╔═╡ 78db840e-fc43-4604-9bf5-514df68208b2
md"""

# Multiple axis

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_multiaxis.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ 4b28feb3-adfb-4440-a078-d8e7ddc81826
n = 15 # Number of values

# ╔═╡ cf5f12c0-172f-46cd-92ca-e49f1c704705
x = collect(1:n)

# ╔═╡ 7f1ca002-96bc-44f9-9381-adf35ef1298c
y1 = 10rand(n,1) .- 2

# ╔═╡ 6a508b1d-95d5-49d7-a346-99fdb1c80e65
y2 = 1000rand(n,1)

# ╔═╡ bdc7a7c6-3ef7-4493-b3d8-cad246f43c44
y3 = 30rand(n,1) .- 15

# ╔═╡ 4af5a87e-10cd-433e-bb79-932c9c4188b7
let
	fig, ax = plt.subplots(figsize=(10,10))
	
	ax.plot(x,y1,linestyle="-",marker="o",label="First") # Plot a basic line
	ax.set_title("Multi-axis Plot")
	ax.set_xlabel("X Axis")
	font1 = Dict("color"=>"blue")
	ax.set_ylabel("Left Axis",fontdict=font1)
	plt.setp(ax.get_yticklabels(),color="blue") # Y Axis font formatting
	
	################
	#  Other Axes  #
	################
	new_position = [0.06;0.06;0.77;0.91] # Position Method 2
	ax.set_position(new_position) # Position Method 2: Change the size and position of the axis
	#fig.subplots_adjust(right=0.85) # Position Method 1

	ax2 = ax.twinx() # Create another axis on top of the current axis
	font2 = Dict("color"=>"purple")
	ax2.set_ylabel("Right Axis",fontdict=font2)
	ax2.plot(x,y2,color="purple",linestyle="-",marker="o",label="Second") # Plot a basic line
	ax2.set_position(new_position) # Position Method 2
	plt.setp(ax2.get_yticklabels(),color="purple") # Y Axis font formatting

	ax3 = ax.twinx() # Create another axis on top of the current axis
	ax3.spines["right"].set_position(("axes",1.12)) # Offset the y-axis label from the axis itself so it doesn't overlap the second axis
	font3 = Dict("color"=>"green")
	ax3.set_ylabel("Far Right Axis",fontdict=font3)
	ax3.plot(x,y3,color="green",linestyle="-",marker="o",label="Third") # Plot a basic line
	ax3.set_position(new_position) # Position Method 2
	plt.setp(ax.get_yticklabels(),color="green") # Y Axis font formatting

	ax.axis("tight")

	# Enable just the right part of the frame
	ax3.set_frame_on(true) # Make the entire frame visible
	ax3.patch.set_visible(false) # Make the patch (background) invisible so it doesn't cover up the other axes' plots
	ax3.spines["top"].set_visible(false) # Hide the top edge of the axis
	ax3.spines["bottom"].set_visible(false) # Hide the bottom edge of the axis
	
	fig
end

# ╔═╡ 0e0f8050-c1f4-11eb-093a-b1fb30d6bf7e
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═78db840e-fc43-4604-9bf5-514df68208b2
# ╠═4b28feb3-adfb-4440-a078-d8e7ddc81826
# ╠═cf5f12c0-172f-46cd-92ca-e49f1c704705
# ╠═7f1ca002-96bc-44f9-9381-adf35ef1298c
# ╠═6a508b1d-95d5-49d7-a346-99fdb1c80e65
# ╠═bdc7a7c6-3ef7-4493-b3d8-cad246f43c44
# ╠═4af5a87e-10cd-433e-bb79-932c9c4188b7
# ╠═0e0f8050-c1f4-11eb-093a-b1fb30d6bf7e
# ╠═27fc63d1-c311-42fb-ad7a-f268df2c3db8
