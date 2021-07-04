### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 863e00bb-4e97-4919-95ac-b95b1817a415
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
    using Plots, PlutoUI
	
	Plots.gr(fmt=:png, lw=2)
	
	PlutoUI.TableOfContents()
end

# ╔═╡ 29ee78b2-42fe-4978-bc27-98f965e5116a
md"""
# Figure 4.22 Tangent line
"""

# ╔═╡ e87b119e-e8af-4a61-8b58-c1981245dc3f
curve(t) = 3 / (t-2)

# ╔═╡ 7dc6af33-6b4d-444d-addb-542851aec071
tange(t) = 1.5 - (t - 4) * 0.75

# ╔═╡ 6dc27c4c-f1c0-4010-aba8-eaad6f92f469
begin
	plot(curve, 2.2, 8.0, lab="Curve")
	plot!(tange, 2.7, 5.3, lab="Tangent line")
	plot!(title="Fig 4.22", xlabel="Reaction rate", ylabel="Inhibitor concentration", 
		  xlims=(2.0, 8.0), ylims=(0.0, 4.0))
end

# ╔═╡ 2d106f50-bdee-11eb-1426-412156422750
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═29ee78b2-42fe-4978-bc27-98f965e5116a
# ╠═e87b119e-e8af-4a61-8b58-c1981245dc3f
# ╠═7dc6af33-6b4d-444d-addb-542851aec071
# ╠═6dc27c4c-f1c0-4010-aba8-eaad6f92f469
# ╠═2d106f50-bdee-11eb-1426-412156422750
# ╠═863e00bb-4e97-4919-95ac-b95b1817a415
