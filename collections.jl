### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 43c7192c-aa56-4d45-9f47-40964f0e14b6
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
	using PlutoUI
	PlutoUI.TableOfContents()
end

# ╔═╡ c9e98b87-7187-4a38-acab-1a93519160c2
md"""
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
"""

# ╔═╡ 10d89d76-b93a-4647-bc83-9be329d83761
md"""
# Associative collections

- `d[key]` accesses values by keys
- `d[key] = value` sets a key-value pair for a mutable dictionary.
- delete!(d, key) deletes the kay (and its partner) from a mutable dictionary.
- keys(d) returns a series of keys
- values(d) returns a series of values
- pairs(d) returns a series of (key => value) pairs
- merge(d1, d2, ...) return combinations of several dicts. merge!(d1, d2, ...) combine several dicts and update the first one.
- get(d, key, default) returns the value stored for the given key, or the given default value if no mapping for the key is present.
"""

# ╔═╡ ac0c1c30-2aab-4e50-a622-451b0d63847c
md"""
## Namedtuples

`Namedtuples` are tuples with key-value pairs.
"""

# ╔═╡ 8b00db79-1127-4df4-af43-afabaf0e2ba6
md"""
## Dictionaries
"""

# ╔═╡ 088c5a4a-07c1-40fb-b931-b281d14fd46d
md"""
# Comprehensions
"""

# ╔═╡ 0adcc811-09c4-4566-a5e4-640e00a5ded7
md"""
# Broadcasting (Dot) syntax
"""

# ╔═╡ 1cf811e0-cc58-11eb-2c48-33822012ebf2
md"""
# Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
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
# ╠═10d89d76-b93a-4647-bc83-9be329d83761
# ╠═ac0c1c30-2aab-4e50-a622-451b0d63847c
# ╠═8b00db79-1127-4df4-af43-afabaf0e2ba6
# ╠═088c5a4a-07c1-40fb-b931-b281d14fd46d
# ╠═0adcc811-09c4-4566-a5e4-640e00a5ded7
# ╠═1cf811e0-cc58-11eb-2c48-33822012ebf2
# ╠═43c7192c-aa56-4d45-9f47-40964f0e14b6
