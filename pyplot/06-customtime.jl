### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 78ed41b0-ea68-4832-bc8d-1b9907aa8987
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PyPlot", version="2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="PyCall", version="1"),
    ])
    using PlutoUI, Dates, PyCall
	import PyPlot as plt
	matplotlib = pyimport("matplotlib")
	PlutoUI.TableOfContents()
end

# ╔═╡ c396fb00-c123-11eb-3b36-9fcb231982ee
md"""
# Custom Time

[Source](https://nbviewer.jupyter.org/github/gizmaa/Julia_Examples/blob/master/pyplot_customtime.ipynb) : gizmaa (<https://gist.github.com/gizmaa/7214002>)
"""

# ╔═╡ a1b8f2fd-5590-4c02-a36e-aa42e3c8dcf3
md"""
## Data
"""

# ╔═╡ 26f09e3b-0519-41d9-88b6-a54c24c30e8a
dt = Dates.Hour(1)

# ╔═╡ cacd79b5-ba9d-4cf0-a551-1e7bc47bcea1
time = collect(DateTime(2014,11,20):dt:DateTime(2014,11,22))

# ╔═╡ 00fdc8fe-4709-44ec-b7f6-3f5d5b46d37e
y = 10rand(length(time))

# ╔═╡ 61c9fe38-9b4c-4852-80be-2bab5661b04e
dfmt = Dates.DateFormat("yyyy-mm-dd HH:MM:SS")

# ╔═╡ 108fe59e-93c7-4328-a66d-64aa47d1d9b7
font1 = Dict("fontname"=>"Sans","style"=>"normal")

# ╔═╡ b646a948-91b1-47a6-b7c4-1a1626bd543a
time2 = Dates.value.(time)/1000/60/60/24 # Convert time from milliseconds from day 0 to days from day 0

# ╔═╡ 6de0771a-da7c-4da3-ab06-197c88bf72ca
timespan = "\n" * Dates.format(minimum(time),dfmt) * " - " * Dates.format(maximum(time),dfmt)

# ╔═╡ db1868e6-073a-4222-8065-9af4699a2ba4
majorformatter = matplotlib.dates.DateFormatter("%d.%m.%Y")

# ╔═╡ 3650c4cc-a6e8-44b9-a430-010eb4e13729
minorformatter = matplotlib.dates.DateFormatter("%H:%M")

# ╔═╡ 484c2571-a528-4373-8037-0915629ad2b0
majorlocator = matplotlib.dates.DayLocator(interval=1)

# ╔═╡ 773b9b86-e116-4c7c-be11-38a896df1cad
minorlocator = matplotlib.dates.HourLocator(byhour=(8, 16))

# ╔═╡ b7f1d8cb-bbad-4df8-81f2-b5ce1e901dd4
md"""
## Plot
"""

# ╔═╡ f2c429e0-a7bb-42f1-b033-92fdb50a9f62
let
	fig, ax = plt.subplots(figsize=(12,12))
	ax.plot_date(time2,y,linestyle="-",marker="None",label="test")
	ax.axis("tight")
	ax.set_title("Random Data Against Time\n" * timespan)
	
	ax.grid("on")
	ax.set_xlabel("Time")
	ax.set_ylabel("Stuff",fontdict=font1)
	
	ax.xaxis.set_major_formatter(majorformatter)
	ax.xaxis.set_minor_formatter(minorformatter)
	ax.xaxis.set_major_locator(majorlocator)
	ax.xaxis.set_minor_locator(minorlocator)
	
	fig.autofmt_xdate(bottom=0.2,rotation=30,ha="right")
	plt.tight_layout()
	
	fig
end

# ╔═╡ 8a88c7dd-6452-4850-aa78-30c4f57a756c
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═c396fb00-c123-11eb-3b36-9fcb231982ee
# ╠═a1b8f2fd-5590-4c02-a36e-aa42e3c8dcf3
# ╠═26f09e3b-0519-41d9-88b6-a54c24c30e8a
# ╠═cacd79b5-ba9d-4cf0-a551-1e7bc47bcea1
# ╠═00fdc8fe-4709-44ec-b7f6-3f5d5b46d37e
# ╠═61c9fe38-9b4c-4852-80be-2bab5661b04e
# ╠═108fe59e-93c7-4328-a66d-64aa47d1d9b7
# ╠═b646a948-91b1-47a6-b7c4-1a1626bd543a
# ╠═6de0771a-da7c-4da3-ab06-197c88bf72ca
# ╠═db1868e6-073a-4222-8065-9af4699a2ba4
# ╠═3650c4cc-a6e8-44b9-a430-010eb4e13729
# ╠═484c2571-a528-4373-8037-0915629ad2b0
# ╠═773b9b86-e116-4c7c-be11-38a896df1cad
# ╠═b7f1d8cb-bbad-4df8-81f2-b5ce1e901dd4
# ╠═f2c429e0-a7bb-42f1-b033-92fdb50a9f62
# ╠═8a88c7dd-6452-4850-aa78-30c4f57a756c
# ╠═78ed41b0-ea68-4832-bc8d-1b9907aa8987
