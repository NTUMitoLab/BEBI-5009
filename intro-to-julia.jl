### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ fca3485c-552a-4bf2-8cfd-bf7f548a6d1a
begin
	using PlutoUI
	PlutoUI.TableOfContents()
end

# ╔═╡ 9f0ba450-ca8a-11eb-2d40-594936524dda
md"""
# First steps to Julia
"""

# ╔═╡ 8972e6cf-5abd-4e34-9016-d316d3b94fd7
md"""
# Comments
"""

# ╔═╡ 183e7365-5aa3-4ebe-8757-ff4ca66da186
# You can leave comments on a single line using the pound/hash key

#=

For multi-line comments, 
use the '#= =#' sequence.

=#

# ╔═╡ ff7496bc-5dd8-4b31-a8e2-910f4df257fb
md"""
# Variables and expressions

The assignment operator `=` binds a variable name to the data.

To see the content in the data:

- `@show exp` to show the expression and its result
- [`println(stuff)`](https://docs.julialang.org/en/v1/base/io-network/#Base.println) for regular print
- [`@printf`](https://docs.julialang.org/en/v1/stdlib/Printf/) for C-like formatted output.
- Inline display for the last expression
- A semicolon `;` at the end will suppress the output


There are some differences and limitations in `Pluto` notebooks:

- The results are on the top of the code cells instead at the bottom (in Jupyter notebooks)
- It does not allow *reassignment* nor *multiple expression per cell*.
- [Standard output](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_(stdout)) is not displayed in the Pluto notebook.
- `Distributed.jl` (multiprocessing) is not avialable since Pluto notebooks run on worker processes.

If you really want `println()` output in Pluto notebooks, use `with_terminal()` in the `PlutoUI.jl` package.
"""

# ╔═╡ fb3654b2-a35e-4db8-8b8f-d8c8e337d14d
# Integer, 64 bit
x = 1

# ╔═╡ 6bde72a8-e159-4415-85de-c08bc186cff6
# Floating-point, 64-bit
y = 1.0

# ╔═╡ dedfaa4d-859a-41c0-b92f-de63e02bcf7a
# Complex number
z = 3 + 5im

# ╔═╡ 22a0a72f-d5e3-440a-b1ea-a8d667f12863
α = 3.74 # Unicode variable names — type it by "\alpha<tab>"

# ╔═╡ d32b9ce8-8aed-46f6-bdf8-22868710cfd7
# Strings (Text) are surrounded by double quotes
s = "Julia"

# ╔═╡ 764b4d0a-f643-4f59-9060-bda0be7a6afe
# Rational type
station = 9 + 3//4

# ╔═╡ 3b832f33-a264-4b10-ba4a-14b9f8a3e212
# Characters are surrounded by single quotes
c = ' '

# ╔═╡ bb231574-ce25-4396-a32b-e5ace12937ec
# Constants will emit a warning / error if you try to change it
const theUltimateAnswer = 42

# ╔═╡ a2d2a8c2-6afd-43fb-bb41-7a605f4c6d74
# Use with_terminal() to capture println() outputs
with_terminal() do 
	println("Hello World")
	println("Hello ", s)
	println(1, 2, 3)
end

# ╔═╡ 2d1eeab7-93ae-412f-a7f1-96f3c023094a
with_terminal() do 
	# @show will print x = val
	@show x	1+1 2-2 3*3
end

# ╔═╡ 7a35ab55-173c-4468-8ca0-0e510d96e0d4
md"""
# Data types
"""

# ╔═╡ 73c1c8ce-c227-42be-b5a3-d88745a3e60e
with_terminal() do 
	# `typeof(val)` shows the data type.
	@show typeof(x)
	@show typeof(y)
	@show typeof(c)
	@show typeof(s)
	@show typeof(z)
	@show typeof(1//2)
end

# ╔═╡ 48793eaf-cc99-4fac-99d8-d59e2c07b335
# convert(T,x) to concert x to type T
typeof(convert(Float64, x))

# ╔═╡ 24a0d4ac-4f72-4127-8afa-87bcbb16c876
# Often you can use Type(x)
typeof(Float64(x))

# ╔═╡ 0bd93bdc-901d-438b-965e-416032f8dd88
# Or even shorthand function
typeof(float(x))

# ╔═╡ 6539f01d-0b1a-42b9-ac03-882ce9f419f6
md"""
# Compound expressions

- A [begin block](https://docs.julialang.org/en/v1/base/base/#begin) `begin` ... `end` squashes a multiline expressions into one.
- A [let block](https://docs.julialang.org/en/v1/manual/variables-and-scoping/#Let-Blocks) `let` ... `end` is similar to a begin block but Variables in the let block will be discarded outside the block.
"""

# ╔═╡ aaa4115e-4dd9-4f48-9a79-27f209970dce
# Compound expression: begin ... end
# Variables in the begin block will be kept outside the block
begin
	a1 = 2
	a2 = 35
	a1 = a1 * a2
end

# ╔═╡ 966de6c6-c941-4493-a3eb-51ee7064e538
with_terminal() do
	@show a1 a2
end

# ╔═╡ 56b16f1b-6809-48f5-85dd-72cf86e7d416
# Compound expression: let ... end. 
# Variables in the let block will be discarded outside the block
let
	x = 1
	y = 2
	z = 3
	
	x + y * z
end

# ╔═╡ b7af6203-833c-4526-bf40-5635a1aac795
md"""
# Math expressions

Julia supports basic arithmatic operations and essentail math functions by default.

## Basic arithmetic
"""

# ╔═╡ 1b2e41b0-3e5e-4e1b-ae4b-820f27c1cc70
a = 2

# ╔═╡ 3636e2ba-f034-4b73-ba78-48fd65198e7a
b = 3

# ╔═╡ 3929c584-f12b-47f6-913b-4b0ab2c06994
a + b

# ╔═╡ 5478fc76-c2b6-41ca-8648-b8437caacce4
a - b 

# ╔═╡ 8551ddbe-096d-4c14-bf81-9a2a4e648116
a * b

# ╔═╡ bfa38d3f-e655-4b13-be22-88fab5fbdfc7
b / a

# ╔═╡ de20682a-1410-40c5-b115-5b5470de870e
typeof(b / a)

# ╔═╡ 5a80edaf-bbd0-45b0-af9d-c135749318cc
b // a

# ╔═╡ b04a59ff-9def-4799-b47e-1e1e948b2e3f
typeof(b // a)

# ╔═╡ e5e519d3-1d44-4490-a97b-6fb397741a21
# integer division: \div<tab>`, the same as div(a, b)`
a÷b

# ╔═╡ 3d4846ab-b537-416b-bf7e-364215e7bd7e
typeof(a÷b)

# ╔═╡ 826c913c-a88b-4e4b-8e0a-83888c8df767
b % a

# ╔═╡ 63dda274-30f3-489d-b7fd-eae5266f097c
a^a

# ╔═╡ 05f68beb-d349-4d01-aa0d-6e879da8b14e
md"""
## Comparison

Returns a Boolean value (true / false)
"""

# ╔═╡ 968bad8a-6df8-4b92-9eff-f808e0220bef
a < 1

# ╔═╡ be6283eb-1265-42f6-9eae-df35edaf9306
b > 4

# ╔═╡ c5db3a91-0fba-4abd-9fb7-3d7b4b7f53e8
a <= b

# ╔═╡ 6b354bd0-1e53-45f6-a783-6b560019e8d7
a != b

# ╔═╡ 116c21df-d466-4723-9513-ee83a73fc4bf
a == b + 1

# ╔═╡ a63d784c-71e5-4f74-8186-c6887f829900
# Chained comparisons are supported
1 < a <= b

# ╔═╡ 5f949ee8-3694-459f-be29-63e1b4371d30
# Approximation operator `\approx` for floating point number equivalence
1e10 + 1.0 ≈ 1e10

# ╔═╡ 9644b2e4-b270-488b-a6d0-a4ab4c8aa73a
isapprox(1e10 + 1.0, 1e10)

# ╔═╡ f53e2490-f4b0-44dd-9ac9-907e60458faf
md"""
## Math functions


"""

# ╔═╡ 51bc09d3-a05c-46be-ab94-319ede805291
sin(0.5*π)

# ╔═╡ 7e9cecbe-8669-44c8-80f0-2b70a3739cc3
cos(0.5*π)

# ╔═╡ c026471c-3b69-4089-bdd1-44d2b4c19d6c
cospi(1//2)  # More accurate version to cos(0.5*π)

# ╔═╡ 5844f1f0-bcb9-4b2d-97cd-3e221e4edd17
sqrt(π) ≈ √π

# ╔═╡ fb567d8c-e27f-4ca9-87c4-782f8ab0a8e2
log(10)   # Natual log

# ╔═╡ e6d3cc69-39e4-4da7-86ec-000a8ad24cb9
log10(10) # Common log

# ╔═╡ 0d1863ac-ada5-456c-acce-9ffc5028670b
exp(-5)

# ╔═╡ e9008f32-904f-4b6b-bdf6-b04b15e9bc73
# expm1(x) is more accurate that exp(x) - 1 when x is very small
exp(1e-12)-1, expm1(1e-12)

# ╔═╡ 52f5238a-e018-4612-baa0-3c63165f348e
md"""
# Strings

- [Think Julia ch8](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap08)
- [Introduction_to_Julia_tutorials](https://nbviewer.jupyter.org/github/xorJane/Introduction_to_Julia_tutorials/blob/master/02.Strings.ipynb)

A `string` is a sequence of characters.

- `" ... "` for one line strings.
- Three double quotes to surround multiline string.
- `str1*str2*...` to concatenate strings
- `string(str1, str2, ...)` to convert the data (if neede) and make a string.
- `^` to repeat a string: `str^3` to repeat `str` three times.
- `[idx]` to access an individual character.
- `$` to insert (or interpolate) a value into a string.


Although `string(x, y)` looks less streamlined, it is generally faster than interpolation `$` or concatenation `*` and is most recommended.
"""

# ╔═╡ db06884a-7a79-4972-bd80-7f5bd7410461
"I am a string."

# ╔═╡ 9237e760-8aa5-4b1d-bcca-9f911f6542a8
"""I am also a string."""

# ╔═╡ 8b888ee5-b5ca-48e5-932b-95faf87912b7
'a' == "a"

# ╔═╡ 675dd38b-8ca3-4742-a635-7b74534333d8
str1 = "BEBI"

# ╔═╡ 513552fb-8e07-460c-a2c8-93bbd522beba
str2 = "5009"

# ╔═╡ c0687e61-9c09-42af-a081-4daa7cd5f9a5
string("The class is ", str1, '-', str2, ".")

# ╔═╡ 11ef8f09-a560-4599-b274-2263ea69c854
"The class is $str1-$str2."

# ╔═╡ 0350508e-3c8b-4e21-81c8-61a2d38f8331
str2^5

# ╔═╡ ef124768-6486-4a4b-b06c-74dd966d0569
str1*"-"*str2

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.9"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═fca3485c-552a-4bf2-8cfd-bf7f548a6d1a
# ╠═9f0ba450-ca8a-11eb-2d40-594936524dda
# ╠═8972e6cf-5abd-4e34-9016-d316d3b94fd7
# ╠═183e7365-5aa3-4ebe-8757-ff4ca66da186
# ╠═ff7496bc-5dd8-4b31-a8e2-910f4df257fb
# ╠═fb3654b2-a35e-4db8-8b8f-d8c8e337d14d
# ╠═6bde72a8-e159-4415-85de-c08bc186cff6
# ╠═dedfaa4d-859a-41c0-b92f-de63e02bcf7a
# ╠═22a0a72f-d5e3-440a-b1ea-a8d667f12863
# ╠═d32b9ce8-8aed-46f6-bdf8-22868710cfd7
# ╠═764b4d0a-f643-4f59-9060-bda0be7a6afe
# ╠═3b832f33-a264-4b10-ba4a-14b9f8a3e212
# ╠═bb231574-ce25-4396-a32b-e5ace12937ec
# ╠═a2d2a8c2-6afd-43fb-bb41-7a605f4c6d74
# ╠═2d1eeab7-93ae-412f-a7f1-96f3c023094a
# ╠═7a35ab55-173c-4468-8ca0-0e510d96e0d4
# ╠═73c1c8ce-c227-42be-b5a3-d88745a3e60e
# ╠═48793eaf-cc99-4fac-99d8-d59e2c07b335
# ╠═24a0d4ac-4f72-4127-8afa-87bcbb16c876
# ╠═0bd93bdc-901d-438b-965e-416032f8dd88
# ╠═6539f01d-0b1a-42b9-ac03-882ce9f419f6
# ╠═aaa4115e-4dd9-4f48-9a79-27f209970dce
# ╠═966de6c6-c941-4493-a3eb-51ee7064e538
# ╠═56b16f1b-6809-48f5-85dd-72cf86e7d416
# ╠═b7af6203-833c-4526-bf40-5635a1aac795
# ╠═1b2e41b0-3e5e-4e1b-ae4b-820f27c1cc70
# ╠═3636e2ba-f034-4b73-ba78-48fd65198e7a
# ╠═3929c584-f12b-47f6-913b-4b0ab2c06994
# ╠═5478fc76-c2b6-41ca-8648-b8437caacce4
# ╠═8551ddbe-096d-4c14-bf81-9a2a4e648116
# ╠═bfa38d3f-e655-4b13-be22-88fab5fbdfc7
# ╠═de20682a-1410-40c5-b115-5b5470de870e
# ╠═5a80edaf-bbd0-45b0-af9d-c135749318cc
# ╠═b04a59ff-9def-4799-b47e-1e1e948b2e3f
# ╠═e5e519d3-1d44-4490-a97b-6fb397741a21
# ╠═3d4846ab-b537-416b-bf7e-364215e7bd7e
# ╠═826c913c-a88b-4e4b-8e0a-83888c8df767
# ╠═63dda274-30f3-489d-b7fd-eae5266f097c
# ╠═05f68beb-d349-4d01-aa0d-6e879da8b14e
# ╠═968bad8a-6df8-4b92-9eff-f808e0220bef
# ╠═be6283eb-1265-42f6-9eae-df35edaf9306
# ╠═c5db3a91-0fba-4abd-9fb7-3d7b4b7f53e8
# ╠═6b354bd0-1e53-45f6-a783-6b560019e8d7
# ╠═116c21df-d466-4723-9513-ee83a73fc4bf
# ╠═a63d784c-71e5-4f74-8186-c6887f829900
# ╠═5f949ee8-3694-459f-be29-63e1b4371d30
# ╠═9644b2e4-b270-488b-a6d0-a4ab4c8aa73a
# ╠═f53e2490-f4b0-44dd-9ac9-907e60458faf
# ╠═51bc09d3-a05c-46be-ab94-319ede805291
# ╠═7e9cecbe-8669-44c8-80f0-2b70a3739cc3
# ╠═c026471c-3b69-4089-bdd1-44d2b4c19d6c
# ╠═5844f1f0-bcb9-4b2d-97cd-3e221e4edd17
# ╠═fb567d8c-e27f-4ca9-87c4-782f8ab0a8e2
# ╠═e6d3cc69-39e4-4da7-86ec-000a8ad24cb9
# ╠═0d1863ac-ada5-456c-acce-9ffc5028670b
# ╠═e9008f32-904f-4b6b-bdf6-b04b15e9bc73
# ╠═52f5238a-e018-4612-baa0-3c63165f348e
# ╠═db06884a-7a79-4972-bd80-7f5bd7410461
# ╠═9237e760-8aa5-4b1d-bcca-9f911f6542a8
# ╠═8b888ee5-b5ca-48e5-932b-95faf87912b7
# ╠═675dd38b-8ca3-4742-a635-7b74534333d8
# ╠═513552fb-8e07-460c-a2c8-93bbd522beba
# ╠═c0687e61-9c09-42af-a081-4daa7cd5f9a5
# ╠═11ef8f09-a560-4599-b274-2263ea69c854
# ╠═0350508e-3c8b-4e21-81c8-61a2d38f8331
# ╠═ef124768-6486-4a4b-b06c-74dd966d0569
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
