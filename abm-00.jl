### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 0d5cd670-bdf4-11eb-3dfd-b36df6a45072
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Agents", version="4"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="DataFrames", version="1"),

    ])
    using Agents
	using PlutoUI
	using Plots
	using Random
	using DataFrames
	PlutoUI.TableOfContents()
end

# ╔═╡ af61b274-831b-4fac-bc84-ab365867ddb3
md"""

# Agent-based Modeling

Agent-based Modeling (ABM) is a simulation method where the autonomous agents interacting with the environment (space) and/or each other by a set of rules.


The most obvious example of ABM is non-player characters (NPCs) in computer games (e.g. GTA V).


ABM is able to model heterogeneously, i.e. it does not require the environment to be well stirred (as opposed to ODEs), continuous (as opposed to to PDEs), nor need the characteristics of each kind of agents to be identical (as opposed to SSAs). 

This makes ABM more flexible to model individual behaviors. (e.g. traffic jam, disease spread, molecular interactions)
"""

# ╔═╡ 529ac59e-5cdc-42f9-a2c3-8a36c3ef551d
md"""
## Elements of ABM

To use `Agents.jl`, we need to define:

- The [**space**](https://juliadynamics.github.io/Agents.jl/stable/api/#Available-spaces) where the agents live
- The **agents** with self-defined properties. See [`@agents`](https://juliadynamics.github.io/Agents.jl/stable/api/#@agent-macro)
- The **model** to hold the `space`, the `agent`s, and other parameters (called `properties`)
- The stepping function `step!()` to tell how the model evolve.
"""

# ╔═╡ eac86881-943f-41e9-a085-64ef2ad1554b
md"""
⚠️ *WARNING*

Currently (2021-05-26) `abm_plot()` and `abm_video()` [do not work](https://discourse.julialang.org/t/error-no-backend-available-glmakie-cairomakie-wglmakie-when-calling-abm-video-in-interactivedynamics-jl/61626). There might be something wrong between `Agents.jl` and `Makie.jl`.
"""

# ╔═╡ 9668dd2f-42a0-4a1a-80f5-152af1074154
md"""
## Could I do ABM from scratch?
"""

# ╔═╡ 21a958a2-b535-4735-8b90-27ff2580858a
md"""
## Resources

- [Documentation](https://juliadynamics.github.io/Agents.jl/stable/) of `Agents.jl`.
- [sir-julia](https://github.com/epirecipes/sir-julia) : Various implementations of the classical SIR model in Julia.

"""

# ╔═╡ 0d4fd70d-892f-45d9-97a8-5e31e516ae9f
md"""

## Example 1 : Schelling's segregation model

Taken from `Agents.jl` [tutorial](https://juliadynamics.github.io/Agents.jl/stable/examples/schelling/).

- Space  : 2D grid space with a Chebyshev metric. This leads to 8 neighboring positions per position (except at the edges of the grid).
- Agents : They belong to one of two groups (0 or 1).
- Model : Each position of the grid can be occupied by at most one agent.
- For each step
  - If an agent has at least 3 neighbors belonging to the same group, then it is happy.
  - If an agent is unhappy, it keeps moving to new locations until it is happy.

"""

# ╔═╡ 51ce431e-8edf-4caa-8454-03f46bf4d9c3
md"""
To define an agent type, we should make a mutable struct derived from `AbstractAgent`

With 2 mandatory fields
- `id::Int` . The identifier number of the agent.
- `pos` . For agents on a 2D grid, the position field should be a tuple of 2 integers.

On top of that, we could define other properties for the agents.

Alternatively, we can use [`@agent`](https://juliadynamics.github.io/Agents.jl/stable/api/#@agent-macro) macro to let `Agents.jl` set up the mandatory fields for us.

```julia
@agent SchellingAgent GridAgent{2} begin
    mood::Bool
    group::Int
end
```
"""

# ╔═╡ 27dc679f-863e-45e5-b159-0135b3666463
mutable struct SchellingAgent <: AbstractAgent
    id::Int             # The identifier number of the agent
    pos::NTuple{2, Int} # The x, y location of the agent on a 2D grid
    mood::Bool          # whether the agent is happy in its position. (true = happy)
    group::Int          # The group of the agent, determines mood as it interacts with neighbors
end

# ╔═╡ 2c3940e7-7f2d-46bf-a8df-1f4ee9af25fe
md"""
It is recommeded to write a function to make ABMs so that it will be easy to recreate the model and change its parameters.
"""

# ╔═╡ 144bf87e-aac4-419f-b385-6ae853bc64ea
function make_schelling(; numagents = 320, 
					  griddims = (20, 20), 
		  		      min_to_be_happy = 3, 
				      seed = 125)
    space = GridSpace(griddims, periodic = false)
    properties = (min_to_be_happy = 3, )
	
	# For demos to be reproducible
	# You don't need this in production code
    rng = Random.MersenneTwister(seed)
	
    model = ABM(
        SchellingAgent, space;
        properties, rng, scheduler = Schedulers.randomly
    )

    # populate the model with agents, adding equal amount of the two types of agents
    # at random positions in the model
    for n in 1:numagents
        agent = SchellingAgent(n, (1, 1), false, n < numagents / 2 ? 1 : 2)
        add_agent_single!(agent, model)
    end
    return model
end

# ╔═╡ d2d1fc91-d5b3-45f0-8237-f7acb9cbe8e4
md"""
And we define a stepping function in the format

`agent_step!(agent, model)`
"""

# ╔═╡ dc52f1f4-ac80-40c0-a3fa-afeaf11352f3
function agent_step!(agent::SchellingAgent, model)
    minhappy = model.min_to_be_happy
    count_neighbors_same_group = 0
    # For each neighbor, get group and compare to current agent's group
    # and increment count_neighbors_same_group as appropriately.
    # Here `nearby_agents` (with default arguments) will provide an iterator
    # over the nearby agents one grid point away, which are at most 8.
    for neighbor in nearby_agents(agent, model)
        if agent.group == neighbor.group
            count_neighbors_same_group += 1
        end
    end
    # After counting the neighbors, decide whether or not to move the agent.
    # If count_neighbors_same_group is at least the min_to_be_happy, set the
    # mood to true. Otherwise, move the agent to a random position.
    if count_neighbors_same_group ≥ minhappy
        agent.mood = true
    else
        move_agent_single!(agent, model)
    end
    return
end

# ╔═╡ d1282e3d-3dd4-4bae-83d5-4c29d27f6c97
begin
	groupcolor(a) = a.group == 1 ? :blue : :orange
	groupmarker(a) = a.group == 1 ? :circle : :rect
	model = make_schelling(griddims = (50, 50), numagents = 1800)

	anim = @animate for i in 1:25
		step!(model, agent_step!)
		plotabm(model; ac = groupcolor, am = groupmarker, as = 5, aspect_ratio=:equal, xlims=(0.0, 50.5), ylims = (0.0, 50.5), title = "Schelling Step $i", size=(600, 600))
	end
	
	mp4(anim, fps = 5)
end

# ╔═╡ 02a2223b-904b-4980-bb28-35ece350c6d2
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ Cell order:
# ╠═af61b274-831b-4fac-bc84-ab365867ddb3
# ╟─529ac59e-5cdc-42f9-a2c3-8a36c3ef551d
# ╟─eac86881-943f-41e9-a085-64ef2ad1554b
# ╠═9668dd2f-42a0-4a1a-80f5-152af1074154
# ╠═21a958a2-b535-4735-8b90-27ff2580858a
# ╠═0d4fd70d-892f-45d9-97a8-5e31e516ae9f
# ╠═51ce431e-8edf-4caa-8454-03f46bf4d9c3
# ╠═27dc679f-863e-45e5-b159-0135b3666463
# ╟─2c3940e7-7f2d-46bf-a8df-1f4ee9af25fe
# ╠═144bf87e-aac4-419f-b385-6ae853bc64ea
# ╠═d2d1fc91-d5b3-45f0-8237-f7acb9cbe8e4
# ╠═dc52f1f4-ac80-40c0-a3fa-afeaf11352f3
# ╠═d1282e3d-3dd4-4bae-83d5-4c29d27f6c97
# ╠═02a2223b-904b-4980-bb28-35ece350c6d2
# ╠═0d5cd670-bdf4-11eb-3dfd-b36df6a45072
