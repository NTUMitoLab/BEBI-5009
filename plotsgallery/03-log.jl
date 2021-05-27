### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ a799de0b-ad23-4417-98fc-09f31d0384d3
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

# ╔═╡ 422ed96f-59ca-4220-aaf0-8ea9bd04386c
md"""
# Log scale
"""

# ╔═╡ 38c6415b-ac56-4f40-86ce-12dfeb8796f8
md"""
## Semilog y

[Source](https://goropikari.github.io/PlotsGallery.jl/src/semilogy.html)

Using `yscale=:log10`
"""

# ╔═╡ 4e619708-a106-4f4f-974b-b8f310f72c8f
plot(exp, -5, 5, yscale=:log10, title="semilogy", legend=nothing)

# ╔═╡ b22cc17f-0949-4c1b-a09c-063b89852b9e
md"""
## Semilog x

[Source](https://goropikari.github.io/PlotsGallery.jl/src/semilogx.html)

Using `xscale=:log10`
"""

# ╔═╡ d7c30f33-b026-4b08-b302-ea1871e7247d
plot(log, 1e-5, 10, xscale=:log10, title="semilogx", legend=nothing)

# ╔═╡ c91b0f96-eed2-46fa-b4ce-e53e03d8a612
md"""
## log-log

[Source](https://goropikari.github.io/PlotsGallery.jl/src/loglog.html)

Using `scale=:log10`.
"""

# ╔═╡ 7a159f3a-2b4a-43ef-bad8-0bdedfed86c1
plot(x->x^1.7, 1e-3, 3, scale=:log10, title="log-log")

# ╔═╡ bfd64ab0-becc-11eb-1373-051df62f6c19
md"""
# Packages
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═422ed96f-59ca-4220-aaf0-8ea9bd04386c
# ╠═38c6415b-ac56-4f40-86ce-12dfeb8796f8
# ╠═4e619708-a106-4f4f-974b-b8f310f72c8f
# ╠═b22cc17f-0949-4c1b-a09c-063b89852b9e
# ╠═d7c30f33-b026-4b08-b302-ea1871e7247d
# ╠═c91b0f96-eed2-46fa-b4ce-e53e03d8a612
# ╠═7a159f3a-2b4a-43ef-bad8-0bdedfed86c1
# ╠═bfd64ab0-becc-11eb-1373-051df62f6c19
# ╠═a799de0b-ad23-4417-98fc-09f31d0384d3
