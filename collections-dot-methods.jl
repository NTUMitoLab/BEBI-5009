### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 43c7192c-aa56-4d45-9f47-40964f0e14b6
begin
	using PlutoUI
	PlutoUI.TableOfContents()
end

# ╔═╡ c9e98b87-7187-4a38-acab-1a93519160c2
md"""
# Collections, broadcasting, and Methods
Using built-in collections is the simplest way to group and organize data.

The values in a `immutable` collection cannot be updated after its creation, while in a `mutable` collection can.

The elements in `sequential` collections are accessed by integer indices, while those in `associative` collection are accessed by keys.
"""

# ╔═╡ e530e669-35e1-4314-a080-71c5faf8f348
md"""
# Sequential collections

General rules for sequential collections:

- 1-based indexing, as in R, MATLAB, and Fortran.
- Elements are accessed by an integer index `seq[i]` or an integer range `seq[1:2:end-1]`.
- `length(seq)` returns the total size
- Splat operator `...` passes the inner contents in the collection as positional function arguments.
- Dot syntax (e.g. a .+ b) performs element-wise  / broadcasting operations.
"""

# ╔═╡ 2be423ec-49c5-4e72-98df-494cd8270501
md"""
## Ranges

`start[:step]:end`

- Immuatable
- Sequencial
- Eheap
- Evenly-spaced numerical sequences
"""

# ╔═╡ 7197fe35-797d-401d-b05c-a8eefa3f9187
1:2:10

# ╔═╡ 09a51e04-df11-4158-819e-d5f908104ebb
length(1:2:10)

# ╔═╡ 273756ef-4bab-4963-b19f-d8077a6a5a6b
with_terminal() do
	dump(1:10)
end

# ╔═╡ 014958a2-b5a1-4d54-a6b9-3641d1e19f06
# linspace() equivalent
range(1, 10, length=10)

# ╔═╡ 18147773-faf2-409a-90a1-610c15b5f23a
# Another linspace() equivalent
LinRange(1.5, 5.5, 9)

# ╔═╡ 9959d91f-7edc-45ed-aaff-9c2492b8a4a3
(1:10)[3:end]

# ╔═╡ 0b76dbb0-b0c7-4556-bf61-1f9bc5839877
# Oftedn used with for loops
with_terminal() do
	for i in 1:10
		println(i)
	end
end

# ╔═╡ 1ed78b50-4f52-49d5-a936-5bc67ad63cf9
md"""
## Tuples

- immutable
- sequential collections.
- efficient for heterogenous data
- stack-allocated
"""

# ╔═╡ 32dc0e41-9819-46cd-ab7b-00b10c7c0c5c
tuple(1, 'a', 3.14)

# ╔═╡ 2669a9f0-edb3-47bd-94e6-0689d24bf5fc
(1, 'a', 3.14)

# ╔═╡ 706ad47a-a1ce-4bfd-901d-408518f69920
t1 = (1, 2, 3)

# ╔═╡ 0b8aa474-052b-4b96-8a31-ce5148b9758d
t1[1]

# ╔═╡ d069122d-9a09-43db-a3f0-adb61c5426bc
t2 = (1, 'a', 3.14)

# ╔═╡ 56f6008a-d4ad-483a-9e63-76b8689634c6
with_terminal() do 
	dump(t2)
end

# ╔═╡ 9e7f20b4-dadf-4708-a521-e9c4e28424fa
tuple(t1..., t2...)   # Merging multiple tuples using ... operator

# ╔═╡ f049f6bb-d8a7-4fcd-b352-d063fb6bf838
# Tuples are often used to swap elements
let x = 1, y = 2, z = 3
	x, y, z = z, x, y
	with_terminal() do 
		@show x, y, z
	end
end

# ╔═╡ 31595906-9558-49cc-9911-087c33e8359b
# Tuples are used for returning multiple values in a function
extrema([1, 5, 6, 7, -1, -3, 0])

# ╔═╡ 25be6939-069f-41fc-a50e-b6b9f15f5dcb
sincospi(1//2)

# ╔═╡ ddf4322e-0741-40c9-ba08-785c15683e6d
neighbors(x) = x+1, x-1

# ╔═╡ 7c8e8c0e-6400-4a36-8bba-9e377d6063e4
neighbors(0)

# ╔═╡ fd0da8c5-7941-4a0d-b056-290c6c3bc2fc
md"""
## Arrays

[Arrays | Julia docs](https://docs.julialang.org/en/v1/manual/arrays/)

`[seq...]` / `collect(seq)`

Arryas are the bread and butter for scientific computing, similar to numpy's ndarrays.

- Column-major (Fortran style) rather than row-major (C and numpy style)
- Assignments and updating may cuase unwanted editing due to memory sharing.

Some useful functions for arrays:

- `length(A)` the number of elements in A
- `ndims(A)` the number of dimensions of A
- `size(A)` a tuple containing the dimensions of A
- `size(A,n)` the size of A along dimension n
- `eachindex(A)` an efficient iterator for visiting each position in A
"""

# ╔═╡ b8ac6869-52f8-4407-8b31-61a2e67ce140
# 1D array (column vector)
x = [5, 6, 7]

# ╔═╡ c2091825-da38-44ee-bbc1-1fbffed7b058
# np.arange() equivalent
collect(1:10)

# ╔═╡ 0a884ee7-ea0b-483e-a830-c39de038ba6d
zeros(2, 5, 2)

# ╔═╡ 13ca7c56-7665-484e-8feb-566cddaaaec0
ones(2, 5)

# ╔═╡ 5bcd3655-7ea4-4541-8962-52d0defa0abb
# Uninitialized array with the same data type and dims as x
similar(x)

# ╔═╡ dd3eb3bc-ba9b-48e1-b118-2420088ea1ac
# np.zeros_like()
zero(x)

# ╔═╡ 69f9d623-6f2f-4d6e-8083-1dd53d1ce60c
rand(1:6, 10)

# ╔═╡ 23a392e1-6a69-4677-9550-9c7f227b8d02
reshape(1:12, 3, 4)

# ╔═╡ 2d45c850-f4db-47a8-a5e6-24182f06c5d8
# repeat 3x2 times
repeat([1 2; 3 4], 3, 2)

# ╔═╡ e7c74fe1-0cf5-48db-9833-7ec0d7dfabfc
# comprehension
[i^2 for i in 1:10 if i >= 5]

# ╔═╡ e8427218-1e30-4bbf-a0a0-516b35800a82
# a comprehension generating 2x3 array
[x * y for x in 1:2, y in 1:3]

# ╔═╡ 3ab98217-b14d-4292-8540-42c98bfbcd3c
# casting comprehension result element type to Float64
Float64[x^2 for x in 1:4] 

# ╔═╡ 0e7e8893-bf68-4cf6-800f-d02820d38d08
# a 1-element tuple containing a vector
tuple([1,2,3])

# ╔═╡ 6ce997e4-796f-4a8b-bae3-e9cd8995ae10
# convert ector to tuple
Tuple([1,2,3])

# ╔═╡ 1f695f9a-0cb2-4c81-9684-3c005413d36f
# 2D array (matrix)
# space is a shorthand for hcat()
# semicolone is a shorthand for vcat()
A = [1 2 3;
     4 5 6]

# ╔═╡ d73fc237-5cb6-4f80-8dd8-6c5dec1c40b2
A[1, 2]

# ╔═╡ 5d62c23a-22d8-4c54-818a-46b900daebcd
length(A)

# ╔═╡ d7d75522-a599-4473-b13b-5f490e10bb04
axes(A)

# ╔═╡ c77bf597-35d7-4045-aac0-4e4f36471f8c
size(A)

# ╔═╡ ea81441b-a7a6-44ec-8740-712046f99698
ndims(A)

# ╔═╡ 0ef49715-6933-4ff7-b01f-b546cbf6138f
transpose(A)

# ╔═╡ ad593149-5905-41d6-b01b-34bdbf73e6a5
A'

# ╔═╡ c6f01603-6444-4421-bcae-a7ba7c612f0e
# Matrix multiplication
with_terminal() do
	@show A x A*x
end

# ╔═╡ 47f22551-defe-4f5a-be80-e0cca177a493
b = A * x

# ╔═╡ 682ffe9f-4419-4bc8-869b-0d9ed78bd19e
# Find x for Ax = b, using left division operator `/`
A\b ≈ x

# ╔═╡ fafda1ec-d538-4c12-ba56-bbd9817da0a2
# Convert A to an (1D) vector, reuses memory
vec(A)

# ╔═╡ b5b39dfc-2944-45aa-9612-c76caafaa8da
# Arrays are mutable (i.e. you can update the contents)
begin 
	c = copy(x)  # Make a copy to keep the original
	c[1] = 0
	c
end

# ╔═╡ 2db6bf29-2c81-46ca-bae9-41e8f21c5be2
with_terminal() do
	@show x[1] c[1]
end

# ╔═╡ 10d89d76-b93a-4647-bc83-9be329d83761
md"""
# Associative collections

- `d[key]` accesses values by keys
- `d[key] = value` sets a key-value pair for a mutable dictionary.
- `delete!(d, key)` deletes the kay (and its partner) from a mutable dictionary.
- `keys(d)` returns a series of keys
- `values(d)` returns a series of values
- `pairs(d)` returns a series of (key => value) pairs
- `merge(d1, d2, ...)` return combinations of several dicts. `merge!(d1, d2, ...)` combine several dicts and update the first one.
- `get(d, key, default)` returns the value stored for the given key, or the given default value if no mapping for the key is present.
"""

# ╔═╡ ac0c1c30-2aab-4e50-a622-451b0d63847c
md"""
## Named tuples

`Namedtuples` are tuples with key-value pairs.
"""

# ╔═╡ 37134b88-13d2-4d50-8873-ee96b159c98c
nt = (a=1, b=2, c=4)

# ╔═╡ 94218c2f-1fee-445a-b29d-5f6447d4df82
nt.a == nt[:a] 

# ╔═╡ b361fcf7-2656-4dea-b2fd-8d51210da2c2
nt.a == nt[1]

# ╔═╡ 0d8c3b58-37f9-49fa-986f-57efcf62a196
nt[1]

# ╔═╡ 8b00db79-1127-4df4-af43-afabaf0e2ba6
md"""
## Dictionaries

[Dictionaries](https://docs.julialang.org/en/v1/base/collections/#Dictionaries) are mutable mappings of key => value.
"""

# ╔═╡ c81aa4bf-ec76-4c1b-80b8-dd80c12b0582
eng2sp = Dict("one" => "uno", "two" => "dos", "three" => "tres")

# ╔═╡ 0e0c298b-6d1a-4ba5-a4c9-ee9f84e4f160
with_terminal() do
	@show eng2sp["two"] keys(eng2sp) values(eng2sp) get(eng2sp, "one", "N/A") get(eng2sp, "four", "N/A") haskey(eng2sp, "one")
	
	println()
	
	for (k ,v) in eng2sp
    	println(k, " => ", v)
	end
end

# ╔═╡ f5f32721-5198-4166-bbe3-0b7f5b12c759
# Creating a dict from an arrya of tuples
Dict([('a', 1), ('c', 3), ('b', 2)])

# ╔═╡ 3f94e6b7-8106-432d-840c-b5398fa0e031
# Creating a Dict via a generator (similar to comprehensions)
Dict(i => i^2 for i = 1:10)

# ╔═╡ 77c3a713-f279-4fbd-91ad-47f85a24830f
Dict(zip("abc", 1:3))

# ╔═╡ 0adcc811-09c4-4566-a5e4-640e00a5ded7
md"""
# Broadcasting (Dot) syntax

[Broadcasting](https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting) turns scalar operations into vector ones.
"""

# ╔═╡ f330a6a1-5b29-456b-b936-421a4487ccea
[1, 2, 3] .+ [4, 5, 6]

# ╔═╡ 83e2b4c6-58d0-447f-b2a8-8484c04118c0
sinpi.([0.5, 1.0, 1.5, 2.0])

# ╔═╡ 16003328-ef05-4276-9fff-672789913bf0
let
	ks = (:a, :b, :c)
	vs = (1, 2, 3)
	Dict(ks .=> vs)
end

# ╔═╡ e49bd8bf-ea41-4e7a-a448-dbaa79a51888
# logspace in julia
exp10.(LinRange(-3.0, 3.0, 50))

# ╔═╡ 9f5ffe9b-0687-4925-8fcb-bf4873d8de87
# Make a 9*9 multiplication table
collect(1:9) .* transpose(collect(1:9))

# ╔═╡ df975e94-3dd2-447c-8e02-8bb25926d49c
md"""
# Custom structures
"""

# ╔═╡ fa79434d-8e3d-4acf-a1a7-2eb78d1bde35
begin
	struct Point  # struct or mutable struct
		x
		y
	end

	Point() = Point(0.0, 0.0)
end

# ╔═╡ 9d47fdb6-8fbf-4165-9bda-c65e65872774
p1 = Point(1.0, 2.0)

# ╔═╡ e0f3583a-4b3f-4010-bafa-964fa4fa8fe6
p2 = Point(-3.0, 2.0)

# ╔═╡ 7339f1ac-1ae6-4b96-9cce-b2750d7e82ca
add(a::Point, b::Point) = Point(a.x + b.x, a.y + b.y)

# ╔═╡ eaeddf29-da61-4651-8bf6-eee575a709ae
add(p1, p2)

# ╔═╡ adb15ef5-1a8e-43fc-bffc-4cb73481ab11
md"""
# Methods

[Julia docs | Methods](https://docs.julialang.org/en/v1/manual/methods/#Methods)

You can overload the same function with different argument types / numbers.
"""

# ╔═╡ 623117c3-3c61-496e-9a91-cd497c2d4d01
begin
	func(a::Int) = a + 2
	func(a::AbstractFloat) = a/2
	func(a::Rational) = a/11
	func(a::Complex) = sqrt(a) 
	func(a, b::String) = "$a, $b"
end

# ╔═╡ ad345b30-2ed7-4d92-91f8-576784d9fe00
func(1)

# ╔═╡ c0fab2cb-1477-421c-a7a9-353f886ac102
func(3.0)

# ╔═╡ 125a939f-e7a5-4db7-b94d-fdd143b7369b
func(33//4)

# ╔═╡ 6cd6ff60-2b42-4309-8832-35f9b8098827
func(-2 + 0im)

# ╔═╡ b06a9b9c-a1d0-414a-9ccd-320020f1edee
func(true, "it just works and compiles down to optimal code")

# ╔═╡ ae91d145-fc94-4935-970a-c887df151736
md"""
# Package management and dependencies

[Julia docs | Pkg](https://docs.julialang.org/en/v1/stdlib/Pkg/)

In Pluto notebooks it is recommended to use a standalone cell for dependency management. See **Appendix** for details.

In regular environments `Project.toml` and `Manifest.toml` describe the dependencies.

## Install packages

In the Julia script

```julia
using Pkg

# Function form
Pkg.add("Plots")

# Or use Pkg's special strings
pkg"add Plots"
```


In the Julia REPL:

```julia-repl
] add Plots
```

## See what are installed

```julia
using Pkg
Pkg.status()

# Or
pkg"st" # pkg"status"

```

In the Julia REPL:

```julia-repl
] st
```

## Remove packages

```julia
using Pkg
Pkg.remove("Plots")

# Or
pkg"rm Plots"
```

```julia-repl
] rm Plots
```

## Update installed packages

```julia
using Pkg
Pkg.update()

# Or
pkg"up" # pkg"update"
```

## Create / Use a environment

```julia

using Pkg

# Activate environment in the foldername directory
Pkg.activate("foldername")

# Or
pkg"activate foldername"

# Activate the current working directory
Pkg.activate(".")

# Or
pkg"activate ."


```
"""

# ╔═╡ 1cf811e0-cc58-11eb-2c48-33822012ebf2
md"""
# See also

- [Fall in love with Julia](https://nbviewer.jupyter.org/github/schlichtanders/fall-in-love-with-julia/blob/master/01%20introduction%20-%2001%20getting%20started.ipynb)
"""

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
# ╠═c9e98b87-7187-4a38-acab-1a93519160c2
# ╠═e530e669-35e1-4314-a080-71c5faf8f348
# ╠═2be423ec-49c5-4e72-98df-494cd8270501
# ╠═7197fe35-797d-401d-b05c-a8eefa3f9187
# ╠═09a51e04-df11-4158-819e-d5f908104ebb
# ╠═273756ef-4bab-4963-b19f-d8077a6a5a6b
# ╠═014958a2-b5a1-4d54-a6b9-3641d1e19f06
# ╠═18147773-faf2-409a-90a1-610c15b5f23a
# ╠═9959d91f-7edc-45ed-aaff-9c2492b8a4a3
# ╠═0b76dbb0-b0c7-4556-bf61-1f9bc5839877
# ╠═1ed78b50-4f52-49d5-a936-5bc67ad63cf9
# ╠═32dc0e41-9819-46cd-ab7b-00b10c7c0c5c
# ╠═2669a9f0-edb3-47bd-94e6-0689d24bf5fc
# ╠═706ad47a-a1ce-4bfd-901d-408518f69920
# ╠═0b8aa474-052b-4b96-8a31-ce5148b9758d
# ╠═d069122d-9a09-43db-a3f0-adb61c5426bc
# ╠═56f6008a-d4ad-483a-9e63-76b8689634c6
# ╠═9e7f20b4-dadf-4708-a521-e9c4e28424fa
# ╠═f049f6bb-d8a7-4fcd-b352-d063fb6bf838
# ╠═31595906-9558-49cc-9911-087c33e8359b
# ╠═25be6939-069f-41fc-a50e-b6b9f15f5dcb
# ╠═ddf4322e-0741-40c9-ba08-785c15683e6d
# ╠═7c8e8c0e-6400-4a36-8bba-9e377d6063e4
# ╠═fd0da8c5-7941-4a0d-b056-290c6c3bc2fc
# ╠═b8ac6869-52f8-4407-8b31-61a2e67ce140
# ╠═c2091825-da38-44ee-bbc1-1fbffed7b058
# ╠═0a884ee7-ea0b-483e-a830-c39de038ba6d
# ╠═13ca7c56-7665-484e-8feb-566cddaaaec0
# ╠═5bcd3655-7ea4-4541-8962-52d0defa0abb
# ╠═dd3eb3bc-ba9b-48e1-b118-2420088ea1ac
# ╠═69f9d623-6f2f-4d6e-8083-1dd53d1ce60c
# ╠═23a392e1-6a69-4677-9550-9c7f227b8d02
# ╠═2d45c850-f4db-47a8-a5e6-24182f06c5d8
# ╠═e7c74fe1-0cf5-48db-9833-7ec0d7dfabfc
# ╠═e8427218-1e30-4bbf-a0a0-516b35800a82
# ╠═3ab98217-b14d-4292-8540-42c98bfbcd3c
# ╠═0e7e8893-bf68-4cf6-800f-d02820d38d08
# ╠═6ce997e4-796f-4a8b-bae3-e9cd8995ae10
# ╠═1f695f9a-0cb2-4c81-9684-3c005413d36f
# ╠═d73fc237-5cb6-4f80-8dd8-6c5dec1c40b2
# ╠═5d62c23a-22d8-4c54-818a-46b900daebcd
# ╠═d7d75522-a599-4473-b13b-5f490e10bb04
# ╠═c77bf597-35d7-4045-aac0-4e4f36471f8c
# ╠═ea81441b-a7a6-44ec-8740-712046f99698
# ╠═0ef49715-6933-4ff7-b01f-b546cbf6138f
# ╠═ad593149-5905-41d6-b01b-34bdbf73e6a5
# ╠═c6f01603-6444-4421-bcae-a7ba7c612f0e
# ╠═47f22551-defe-4f5a-be80-e0cca177a493
# ╠═682ffe9f-4419-4bc8-869b-0d9ed78bd19e
# ╠═fafda1ec-d538-4c12-ba56-bbd9817da0a2
# ╠═b5b39dfc-2944-45aa-9612-c76caafaa8da
# ╠═2db6bf29-2c81-46ca-bae9-41e8f21c5be2
# ╠═10d89d76-b93a-4647-bc83-9be329d83761
# ╠═ac0c1c30-2aab-4e50-a622-451b0d63847c
# ╠═37134b88-13d2-4d50-8873-ee96b159c98c
# ╠═94218c2f-1fee-445a-b29d-5f6447d4df82
# ╠═b361fcf7-2656-4dea-b2fd-8d51210da2c2
# ╠═0d8c3b58-37f9-49fa-986f-57efcf62a196
# ╠═8b00db79-1127-4df4-af43-afabaf0e2ba6
# ╠═c81aa4bf-ec76-4c1b-80b8-dd80c12b0582
# ╠═0e0c298b-6d1a-4ba5-a4c9-ee9f84e4f160
# ╠═f5f32721-5198-4166-bbe3-0b7f5b12c759
# ╠═3f94e6b7-8106-432d-840c-b5398fa0e031
# ╠═77c3a713-f279-4fbd-91ad-47f85a24830f
# ╠═0adcc811-09c4-4566-a5e4-640e00a5ded7
# ╠═f330a6a1-5b29-456b-b936-421a4487ccea
# ╠═83e2b4c6-58d0-447f-b2a8-8484c04118c0
# ╠═16003328-ef05-4276-9fff-672789913bf0
# ╠═e49bd8bf-ea41-4e7a-a448-dbaa79a51888
# ╠═9f5ffe9b-0687-4925-8fcb-bf4873d8de87
# ╠═df975e94-3dd2-447c-8e02-8bb25926d49c
# ╠═fa79434d-8e3d-4acf-a1a7-2eb78d1bde35
# ╠═9d47fdb6-8fbf-4165-9bda-c65e65872774
# ╠═e0f3583a-4b3f-4010-bafa-964fa4fa8fe6
# ╠═7339f1ac-1ae6-4b96-9cce-b2750d7e82ca
# ╠═eaeddf29-da61-4651-8bf6-eee575a709ae
# ╠═adb15ef5-1a8e-43fc-bffc-4cb73481ab11
# ╠═623117c3-3c61-496e-9a91-cd497c2d4d01
# ╠═ad345b30-2ed7-4d92-91f8-576784d9fe00
# ╠═c0fab2cb-1477-421c-a7a9-353f886ac102
# ╠═125a939f-e7a5-4db7-b94d-fdd143b7369b
# ╠═6cd6ff60-2b42-4309-8832-35f9b8098827
# ╠═b06a9b9c-a1d0-414a-9ccd-320020f1edee
# ╠═ae91d145-fc94-4935-970a-c887df151736
# ╠═1cf811e0-cc58-11eb-2c48-33822012ebf2
# ╠═43c7192c-aa56-4d45-9f47-40964f0e14b6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
