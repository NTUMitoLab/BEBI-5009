### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ d7ff772c-9d33-42e7-9df1-3e02ceee79c5
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
    ])
	using PlutoUI
	PlutoUI.TableOfContents()
end

# ╔═╡ 7553b887-a16d-4f3b-a91b-043f89e963d7
md"""
# Control flow

- [Julia docs | control flow](https://docs.julialang.org/en/v1/manual/control-flow/)
- [Julia docs | functions](https://docs.julialang.org/en/v1/manual/functions/)


Julia code is able to run in a nonlinear manner.
"""

# ╔═╡ 383e7736-dd64-44ce-ac21-60a9a5a7c0db
md"""
## Conditional statements

Compound expressions are already covered in the previous chapter: [intro to Julia](intro-to-julia.html)

### `if`/`else` block:

```julia
result = if cond1
	run_if_cond1_is_true()
elseif cond2
	run_if_cond2_is_true_and_cond1_is_false()
else
	run_if_neither_is_true()
end
```

- The `elseif` and `else` blocks are optional. `if` and `end` are mandatory.
- `if` blocks return a value. Capturing the value is optional.
- `if` blocks are "leaky", i.e. they do not introduce a local scope. (The same as Python)
- Only boolean (true / false) could be evaluated in `if` blocks. Using other types (e.g. Int) will generate an error.

### Ternary operator

`cond ? tvalue : fvalue` is eqialent to:

```julia
if cond 
	tvalue
else
	fvalue
end
```

### ifelse function

All the arguments are evaluated first in `ifelse(cond, tvalue, fvalue)`.


### short cicuit evaluation

`&&` (logical and) and `||` (logical or) operators support [short circuit evaluation](
Short-circuit evaluation - Wikipedia
https://en.wikipedia.org › wiki › Short-circuit_evaluation).

- In the expression `a && b`, the subexpression `b` is only evaluated if `a` evaluates to true.
- In the expression `a || b`, the subexpression `b` is only evaluated if `a` evaluates to false.
"""

# ╔═╡ ce2cbdb6-637d-4f07-bb91-580621485b66
score = 10

# ╔═╡ 648e6be1-5e8b-4406-bee5-708a93ea20f3
response = if 80 < score <= 100
  "Good"
elseif 60 < score <= 80
  "Okay"
else
  "Uh-Oh"
end

# ╔═╡ 2732609d-86f3-4594-8f02-4f8066d41720
md"""
## Loops

Loops are repeated evaluations.

- `while` loops are often controlled by evaluated conditions.
- `for` loops are often controlled by sequence length.


- `break`: exit the loop immediately.
- `continue`: move on to the next item / evaluation immediately.
"""

# ╔═╡ af291389-2e9c-41fc-880b-28fe1fe70e49
## Hailstone sequence (3n+1 problem) in a while loop
let n = 27
    step = 0
    while n != 1
        if iseven(n)
            n ÷= 2
        else
            n = 3n + 1
        end
        step += 1
    end
    step
end

# ╔═╡ 4bb1e57d-ab16-4c97-ad4b-3db6a76b7e11
let sum = 0, n = 100
	for i in 1:n
		sum += i
	end
	sum
end

# ╔═╡ 0117590e-213b-4a70-a9c8-f44075c58854
with_terminal() do 
	for x in 1:9
		if x == 5
			continue # jump to line #2
		elseif x >=8
			break    # jump to line #9
		end
		println(x, "^2 = ", x^2)
	end
end

# ╔═╡ d52dfdce-cd96-4d1b-8aa6-f1137758221b
with_terminal() do
	# Use enumerate(seq) to get a pair of one idx and one element
	for (i, x) in enumerate(10:-1:1)
		println("xs[", i, "] = ", x)
	end
end

# ╔═╡ 81194437-5b15-4ab9-af47-33108dde7751
md"""
Multiple nested for loops can be combined into a single outer loop, forming the cartesian product of its iterables.
"""

# ╔═╡ 21c53be2-3d98-4fb5-87b5-dd53bac7dd76
with_terminal() do
	# Multiple nested for loops can be combined into a single outer loop, forming the cartesian product of its iterables
	for i = 'x':'z', j = '1':'3'
		println(i, j)
	end
end

# ╔═╡ bd4a9500-5b35-4f0a-bd1c-4e42a650308b
md"""
# Functions

> In Julia, a function is an object that maps a tuple of argument values to a return value. 
> [Julia docs](https://docs.julialang.org/en/v1/manual/functions/)


Functions facilitate:
- Code reuse and encapsulation.
- Specializations ([Methods](https://docs.julialang.org/en/v1/manual/methods/))

- Functions are first-class objects and can be passed into a higher-order function.
- The arguments are "passed-by-sharing". Modifications to mutable argument values (such as `Arrays`) will be reflected to the caller. (Similar to Python)
- Functions that will update the arguments are named with a bang `!` by convention. (e.g. sort(arr) vs sort!(arr))
- Often only the scalar version of a function is required; for vector element-wise operations, there are broadcast (dot) syntax.
- You can write multiple function with the same name provided they have different parameter lists. Julia will choose the most apporpriate one for you.
"""

# ╔═╡ 0d1252a0-3ce8-4b96-ba08-a6f1895cc0dc
md"""
## Standard form
"""

# ╔═╡ 5d26cdd5-9a6d-4307-89b7-6629997b9132
"Mechaelis-Menton function"  # Function documentations
function mm(x, k)            # function name and parameter list
  result = x / (x +k)
  return result              # return statement is optional
end

# ╔═╡ ce413514-bf5c-4dc8-b2af-42e9f663fa87
md"""
## One-liner form
"""

# ╔═╡ b87e79d8-91b0-4ecb-85b8-e2e8d01da426
# One-liner function
mm(x) = mm(x, one(x))

# ╔═╡ 5d2c7cdc-d34a-4e97-82c4-ac58a9196fd8
mm(0.5, 2)

# ╔═╡ d137d92d-f629-41cf-824c-516391f26f11
mm(1)

# ╔═╡ 65de3953-6a86-4e3f-ba00-b6c352678284
md"""
## Anonymous functions

Often used with high-order functions e.g. `map()`
"""

# ╔═╡ f14ab8cb-db2e-47f7-adaa-d932ed25bb1b
map(x->x^2, 1:3)

# ╔═╡ 26ba95b5-1d1c-4bed-b6dd-e17eba8136e3
md"""
Use [`do` block](https://docs.julialang.org/en/v1/manual/functions/#Do-Block-Syntax-for-Function-Arguments) for long anonymous functions.

`do` block are also useful in opening files.

```julia
open("outfile", "w") do io
    write(io, data)
end
```
"""

# ╔═╡ e2801350-24b7-4453-af27-ee63afbb4087
val = rand(-6:6, 10)

# ╔═╡ 2f07f81c-346a-4f17-872c-f174adf6ff1d
map(val) do x
    if x < 0 && iseven(x)
        return 0
    elseif x == 0
        return 1
    else
        return x
    end
end

# ╔═╡ ea04a83f-74a1-46b0-b686-f125e0972ca2
md"""
## Optional arguments

[Optional (positional) arguments](https://docs.julialang.org/en/v1/manual/functions/#Optional-Arguments) are listed after mandatory ones.

```julia
function func(a, b, c=1)
# content
end
```

And they are called with `func(a, b)` or `func(a, b, 3)`

## Keyword arguments

[Keyword arguments](https://docs.julialang.org/en/v1/manual/functions/#Keyword-Arguments) are listed after `;`

```julia
function plot(x, y; style="solid", width=1, color="black")
    ###
end
```

And they are called with `plot(x, y, width=2)` or `plot(x, y; width=2)`
"""

# ╔═╡ a8129dcc-c291-4e2c-bde1-4f77b007fc6b
md"""
## See also

- [Compositing functions and pipes](https://docs.julialang.org/en/v1/manual/functions/#Function-composition-and-piping)
- [Variable argument (vararg) functions](https://docs.julialang.org/en/v1/manual/functions/#Varargs-Functions)
- [Argument destructuring](https://docs.julialang.org/en/v1/manual/functions/#Argument-destructuring)
"""

# ╔═╡ 33a48540-cb59-11eb-0602-8da0ecdcbe4c
md"""
# Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═7553b887-a16d-4f3b-a91b-043f89e963d7
# ╠═383e7736-dd64-44ce-ac21-60a9a5a7c0db
# ╠═ce2cbdb6-637d-4f07-bb91-580621485b66
# ╠═648e6be1-5e8b-4406-bee5-708a93ea20f3
# ╠═2732609d-86f3-4594-8f02-4f8066d41720
# ╠═af291389-2e9c-41fc-880b-28fe1fe70e49
# ╠═4bb1e57d-ab16-4c97-ad4b-3db6a76b7e11
# ╠═0117590e-213b-4a70-a9c8-f44075c58854
# ╠═d52dfdce-cd96-4d1b-8aa6-f1137758221b
# ╠═81194437-5b15-4ab9-af47-33108dde7751
# ╠═21c53be2-3d98-4fb5-87b5-dd53bac7dd76
# ╠═bd4a9500-5b35-4f0a-bd1c-4e42a650308b
# ╠═0d1252a0-3ce8-4b96-ba08-a6f1895cc0dc
# ╠═5d26cdd5-9a6d-4307-89b7-6629997b9132
# ╠═ce413514-bf5c-4dc8-b2af-42e9f663fa87
# ╠═b87e79d8-91b0-4ecb-85b8-e2e8d01da426
# ╠═5d2c7cdc-d34a-4e97-82c4-ac58a9196fd8
# ╠═d137d92d-f629-41cf-824c-516391f26f11
# ╠═65de3953-6a86-4e3f-ba00-b6c352678284
# ╠═f14ab8cb-db2e-47f7-adaa-d932ed25bb1b
# ╠═26ba95b5-1d1c-4bed-b6dd-e17eba8136e3
# ╠═e2801350-24b7-4453-af27-ee63afbb4087
# ╠═2f07f81c-346a-4f17-872c-f174adf6ff1d
# ╠═ea04a83f-74a1-46b0-b686-f125e0972ca2
# ╠═a8129dcc-c291-4e2c-bde1-4f77b007fc6b
# ╠═33a48540-cb59-11eb-0602-8da0ecdcbe4c
# ╠═d7ff772c-9d33-42e7-9df1-3e02ceee79c5
