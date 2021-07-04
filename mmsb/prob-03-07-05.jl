### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 2f761b20-bde2-11eb-190f-077bd9e0c638
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
	    Pkg.PackageSpec(name="DifferentialEquations", version="6"),
	    Pkg.PackageSpec(name="Parameters", version="0.12"),
        Pkg.PackageSpec(name="LabelledArrays", version="1"),
        Pkg.PackageSpec(name="Setfield", version="0.7"),
    ])
    using Plots, PlutoUI, LinearAlgebra, DifferentialEquations, Parameters, LabelledArrays, Setfield
	
	Plots.gr(fmt=:png, lw=2)
	
	PlutoUI.TableOfContents()
end

# ╔═╡ 11f28aab-79d2-4fa3-a9f8-34df3e581c0c
md"""
# Problem 3.7.5 Reduced Michaelis-Menten
"""

# ╔═╡ 708d922b-5c70-42b1-b065-4e47c3fba282
function model!(du, u, p, t)
	@unpack V0, VM1, VM2, VM3, KM1, KM2, KM3, _mm = p
	@unpack s1, s2, s3 = u
	v1 = VM1 * _mm(s1, KM1)
	v2 = VM2 * _mm(s2, KM2)
	v3 = VM3 * _mm(s3, KM3)
	du.s1 = V0 - v1
	du.s2 = v1 - v2
	du.s3 = v2 - v3
	return du
end

# ╔═╡ 14836120-7d01-4e59-8869-3b387fccf461
u0 = LVector(s1=0.3, s2=0.2, s3=0.1)

# ╔═╡ 89ce6bbb-ec25-454a-90f0-c45d4ec8b217
tend = 2.0

# ╔═╡ 0e967887-f222-4aa0-8874-1900b5aa69a4
# second set of ICs
u02 = LVector(s1=6.0, s2=4.0, s3=4.0)

# ╔═╡ bd13dc0b-929e-4270-a010-0da4a6e7b8ea
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ ebc7e456-ff70-4c51-ac5a-81daff88e287
begin
	# Convenience functions
    hill(x, k) = x / (x + k)
    hill(x, k, n) = hill(x^n, k^n)
    exprel(x) = ifelse(x≈zero(x), one(x), x / expm1(x))
	reducedmm(x, k) = x / k
end

# ╔═╡ b04b6578-c363-4c03-bc26-b8c608676fee
p = (V0 = 2.0,
	VM1 = 9.0,
	VM2 = 12.0,
	VM3 = 15.0,
	KM1 = 1.0,
	KM2 = 0.4,
	KM3 = 3.0,
	_mm = hill)

# ╔═╡ 52f29c2e-45ad-4d1e-820b-0103d80248a9
sol1 = solve(ODEProblem(model!, u0, tend, p));

# ╔═╡ cb3f07ea-a0a4-40f0-83d4-6ffc5cb5ddf6
plot(sol1, ylims=(0.0, 0.8),
     title="Problem 3.7.5 (1)",
     xlabel="Time (arbitrary units)",
     ylabel="Concentration (arbitrary units)")

# ╔═╡ e0081e60-2cd0-48fa-9049-e816666293b6
sol2 = solve(ODEProblem(model!, u02, 4.0, p));

# ╔═╡ b1883077-bbc2-409f-9f10-40d8c7b84868
plot(sol2, ylims=(0.0, 6.0),
     title="Problem 3.7.5 (2)",
     xlabel="Time (arbitrary units)",
     ylabel="Concentration (arbitrary units)")

# ╔═╡ 66444666-0be1-4104-8974-2133aca8e6d0
# Reduced model
param2 = @set p._mm = reducedmm

# ╔═╡ df7fc593-93a6-46fb-9a1a-0e7e488d7caa
sol3 = solve(ODEProblem(model!, u0, tend, param2));

# ╔═╡ 8ff61c0e-b725-48f4-88b1-ad06432105a9
begin
p3 = plot(sol1, ylims=(0.0, 0.8),
     title="Problem 3.7.5 (1) (full vs reduced)",
     xlabel="Time (arbitrary units)",
     ylabel="Concentration (arbitrary units)",
     labels=["S1 " "S2 " "S3 "], ls=:dash)
	plot!(p3, sol3, labels=["S1 (reduced)" "S2 (reduced)" "S3 (reduced)"] )
	p3
end

# ╔═╡ dad7528c-f6d0-4ace-b4e0-eb4c0f9ff6d1
sol4 = solve(ODEProblem(model!, u02, 4.0, param2));

# ╔═╡ b1e5b71d-7150-4cc5-981a-bb0f5910c584
begin
p4 = plot(sol2, ylims=(0.0, 8.0),
     title="Problem 3.7.5 (2) (full vs reduced)",
     xlabel="Time (arbitrary units)",
     ylabel="Concentration (arbitrary units)",
     labels=["S1 " "S2 " "S3 "], ls=:dash)
	plot!(p4, sol4, labels=["S1 (reduced)" "S2 (reduced)" "S3 (reduced)"] )
	
	p4
end

# ╔═╡ Cell order:
# ╠═11f28aab-79d2-4fa3-a9f8-34df3e581c0c
# ╠═708d922b-5c70-42b1-b065-4e47c3fba282
# ╠═14836120-7d01-4e59-8869-3b387fccf461
# ╠═89ce6bbb-ec25-454a-90f0-c45d4ec8b217
# ╠═b04b6578-c363-4c03-bc26-b8c608676fee
# ╠═52f29c2e-45ad-4d1e-820b-0103d80248a9
# ╠═cb3f07ea-a0a4-40f0-83d4-6ffc5cb5ddf6
# ╠═0e967887-f222-4aa0-8874-1900b5aa69a4
# ╠═e0081e60-2cd0-48fa-9049-e816666293b6
# ╠═b1883077-bbc2-409f-9f10-40d8c7b84868
# ╠═66444666-0be1-4104-8974-2133aca8e6d0
# ╠═df7fc593-93a6-46fb-9a1a-0e7e488d7caa
# ╠═8ff61c0e-b725-48f4-88b1-ad06432105a9
# ╠═dad7528c-f6d0-4ace-b4e0-eb4c0f9ff6d1
# ╠═b1e5b71d-7150-4cc5-981a-bb0f5910c584
# ╠═bd13dc0b-929e-4270-a010-0da4a6e7b8ea
# ╠═ebc7e456-ff70-4c51-ac5a-81daff88e287
# ╠═2f761b20-bde2-11eb-190f-077bd9e0c638
