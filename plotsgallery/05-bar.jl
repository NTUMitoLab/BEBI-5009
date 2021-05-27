### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ c3602d9d-b599-43e0-b2c4-aecb336c95c0
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="StatsBase", version="0.33"),
		Pkg.PackageSpec(name="StatsPlots", version="0.14"),
    ])
    using Plots, PlutoUI, StatsPlots, StatsBase, Random
	Random.seed!(2018)
	PlutoUI.TableOfContents()
end

# ╔═╡ 1d99dd32-bed0-11eb-3ea8-497ce1ada720
md"""
# Bar plots
"""

# ╔═╡ fc792910-131c-4788-a8ad-ed2d83ed9b64
# Data
begin
	measles = [38556, 24472, 14556, 18060, 19549, 8122, 28541, 7880, 3283, 4135, 7953, 1884]
	mumps = [20178, 23536, 34561, 37395, 36072, 32237, 18597, 9408, 6005, 6268, 8963, 13882]
	chickenPox = [37140, 32169, 37533, 39103, 33244, 23269, 16737, 5411, 3435, 6052, 12825, 23332]
end

# ╔═╡ 5fbdcd68-db01-4abc-84e9-bef53bf43288
ticklabel = string.(collect('A':'L'))

# ╔═╡ f78255d1-341e-4ee0-a7d1-55578e8faed6
md"""
## Grouped vertical bar plots

[Source](https://goropikari.github.io/PlotsGallery.jl/src/vertical_bar_plot.html)

Requires `StatsPlots`

Uses `groupedbar(data, bar_position = :dodge)`
"""

# ╔═╡ 1fb094a6-9ece-4b1a-91c5-59a21ea86b8d
groupedbar([measles mumps chickenPox], bar_position = :dodge, bar_width=0.7, xticks=(1:12, ticklabel), label=["measles" "mumps" "chickenPox"])

# ╔═╡ b8ba310a-f478-4ed1-a999-0eebfba974d2
md"""
## Stacked vertical bar plots

[Source](https://goropikari.github.io/PlotsGallery.jl/src/stacked_bar_plot.html)

Requires `StatsPlots`

Uses `groupedbar(data, bar_position = :stack)`
"""

# ╔═╡ 19a315c5-d95b-4724-969f-71400533d5a4
groupedbar([measles mumps chickenPox],
        bar_position = :stack,
        bar_width=0.7,
        xticks=(1:12, ticklabel),
        label=["measles" "mumps" "chickenPox"])

# ╔═╡ fdc40063-5eb2-42ec-bb39-be1f8e69ea3e
md"""
## Horizontal Bar Plot

`bar(data, orientation=:h)`
"""

# ╔═╡ 122135b4-07c3-40b1-9569-54cf45ed0a66
bar(1:12, orientation=:h, yticks=(1:12, ticklabel), yflip=true)

# ╔═╡ 078c9fac-5e62-4007-a0bc-00de57e4cf05
md"""

## Categorical Histogram Plot

[Source](https://goropikari.github.io/PlotsGallery.jl/src/categorical_histogram_plot.html)

I put it into the bar plot category since categorical histogram plots use `bar()`.
"""

# ╔═╡ 49dc5a4c-3825-49f2-a17c-002c68be910b
status = ["Poor", "Fair", "Good", "Excellent"]

# ╔═╡ 2a6a8534-0b80-4599-b771-0b02d682b5f8
data = sample(status, Weights([1,1,2,2]), 100)

# ╔═╡ 137d5a45-50f0-45fa-9cf1-5f864cd90799
datamap = countmap(data)

# ╔═╡ 91a5be7c-6105-41b4-a795-1178d268fa19
bar((x -> datamap[x]).(status), xticks=(1:4, status), legend=nothing)

# ╔═╡ 5e585f0a-fc0b-44d0-97cd-a9c6672bb412
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═1d99dd32-bed0-11eb-3ea8-497ce1ada720
# ╠═fc792910-131c-4788-a8ad-ed2d83ed9b64
# ╠═5fbdcd68-db01-4abc-84e9-bef53bf43288
# ╠═f78255d1-341e-4ee0-a7d1-55578e8faed6
# ╠═1fb094a6-9ece-4b1a-91c5-59a21ea86b8d
# ╠═b8ba310a-f478-4ed1-a999-0eebfba974d2
# ╠═19a315c5-d95b-4724-969f-71400533d5a4
# ╠═fdc40063-5eb2-42ec-bb39-be1f8e69ea3e
# ╠═122135b4-07c3-40b1-9569-54cf45ed0a66
# ╠═078c9fac-5e62-4007-a0bc-00de57e4cf05
# ╠═49dc5a4c-3825-49f2-a17c-002c68be910b
# ╠═2a6a8534-0b80-4599-b771-0b02d682b5f8
# ╠═137d5a45-50f0-45fa-9cf1-5f864cd90799
# ╠═91a5be7c-6105-41b4-a795-1178d268fa19
# ╠═5e585f0a-fc0b-44d0-97cd-a9c6672bb412
# ╠═c3602d9d-b599-43e0-b2c4-aecb336c95c0
