### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ c1438f00-53a6-4ffb-8b9d-fd62f96871b2
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
    ])
	using PlutoUI
	using Plots
	PlutoUI.TableOfContents()
end

# ╔═╡ f7875550-bfa6-11eb-1549-411aaa13acc2
md"""
# Quiver Plots

[Source](https://goropikari.github.io/PlotsGallery.jl/src/quiver.html)
"""

# ╔═╡ 4f58c7e4-9f8c-428b-9beb-6c966d6e4c0a
n = 7

# ╔═╡ f4ad0eba-d08f-41c6-a687-6f938fdf08da
f(x,y) = 1 / hypot(x, y)

# ╔═╡ 59ed1cfe-4e91-410b-8a83-aa1fe817da36
x = repeat(-3:(2*3)/n:3, 1, n) |> vec

# ╔═╡ 00c14298-0c4b-4b2b-a829-b95ba6f3644b
y = repeat(-3:(2*3)/n:3, 1, n)' |> vec

# ╔═╡ c0ce504c-3af3-4911-859e-f13262fb25b5
vx = f.(x,y) .* cos.(atan.(y,x)) |> vec

# ╔═╡ 6c9a5cb4-ecc8-4b17-8ed9-eac1971ffd5b
vy = f.(x,y) .* sin.(atan.(y,x)) |> vec

# ╔═╡ d77454fc-e0e1-4a16-9098-3f4a3c27be28
quiver(x, y, quiver=(vx, vy), aspect_ratio=:equal)

# ╔═╡ a56128f9-f70d-4e8c-8294-31f91b615ea1
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═f7875550-bfa6-11eb-1549-411aaa13acc2
# ╠═4f58c7e4-9f8c-428b-9beb-6c966d6e4c0a
# ╠═f4ad0eba-d08f-41c6-a687-6f938fdf08da
# ╠═59ed1cfe-4e91-410b-8a83-aa1fe817da36
# ╠═00c14298-0c4b-4b2b-a829-b95ba6f3644b
# ╠═c0ce504c-3af3-4911-859e-f13262fb25b5
# ╠═6c9a5cb4-ecc8-4b17-8ed9-eac1971ffd5b
# ╠═d77454fc-e0e1-4a16-9098-3f4a3c27be28
# ╠═a56128f9-f70d-4e8c-8294-31f91b615ea1
# ╠═c1438f00-53a6-4ffb-8b9d-fd62f96871b2
