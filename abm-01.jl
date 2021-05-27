### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 49674784-f070-488d-b53b-9cebf0ce101e
begin
    import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Agents", version="4"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="DataFrames", version="1"),
        Pkg.PackageSpec(name="LightGraphs", version="1"),
        Pkg.PackageSpec(name="Distributions", version="0.25"),
		Pkg.PackageSpec(name="GraphRecipes", version="0.5"),
    ])
    using Agents
	using PlutoUI
	using Plots
	using Random
	using DataFrames
	using LightGraphs
	using Distributions
	using GraphRecipes
	using LinearAlgebra: diagind
	PlutoUI.TableOfContents()
end

# ╔═╡ e5f4abe0-be15-11eb-038f-5da4c19a690d
md"""

# ABM Example 2: The spread of SARS-CoV-2 (Graph model)

[Source](https://juliadynamics.github.io/Agents.jl/stable/examples/sir/)

Here we add one more category of individuals: those who are infected, but do not know it. Transmission rate for infected and diagnosed individuals is lower than infected and undetected. 
"""

# ╔═╡ 07c4c6aa-c7bb-4543-868d-975de9f37ba9
mutable struct PoorSoul <: AbstractAgent
    id::Int
    pos::Int            # Which city
    days_infected::Int  # number of days since is infected
    status::Symbol      # 1: S, 2: I, 3:R
end

# ╔═╡ 99c0bed6-a533-4058-bf85-c81fac0f5976
function make_SIRgraph(;
    Ns,
    migration_rates,
    β_und,
    β_det,
    infection_period = 30,
    reinfection_probability = 0.05,
    detection_time = 14,
    death_rate = 0.02,
    Is = [zeros(Int, length(Ns) - 1)..., 1],
    seed = 0,
)

    rng = MersenneTwister(seed)
    @assert length(Ns) ==
    length(Is) ==
    length(β_und) ==
    length(β_det) ==
    size(migration_rates, 1) "length of Ns, Is, and B, and number of rows/columns in migration_rates should be the same "
    @assert size(migration_rates, 1) == size(migration_rates, 2) "migration_rates rates should be a square matrix"

    C = length(Ns) # Number of cities
	
    # normalize migration_rates
    migration_rates_sum = sum(migration_rates, dims = 2)
    for c in 1:C
        migration_rates[c, :] ./= migration_rates_sum[c]
    end

    properties = (;
        Ns,
        Is,
        β_und,
        β_det,
        migration_rates,
        infection_period,
        reinfection_probability,
        detection_time,
        C,
        death_rate
    )
	
	
    space = GraphSpace(complete_digraph(C))
    model = ABM(PoorSoul, space; properties, rng)

    # Add initial individuals
    for city in 1:C, n in 1:Ns[city]
        ind = add_agent!(city, model, 0, :S) # Susceptible
    end
    # add infected individuals
    for city in 1:C
        inds = ids_in_position(city, model)
        for n in 1:Is[city]
            agent = model[inds[n]]
            agent.status = :I # Infected
            agent.days_infected = 1
        end
    end
    return model
end

# ╔═╡ 867f455d-39c0-458f-a374-72de9a95076e
function make_SIRgraphParams(;
	C,
    max_travel_rate,
    infection_period = 30,
    reinfection_probability = 0.05,
    detection_time = 14,
    death_rate = 0.02,
    Is = [zeros(Int, C - 1)..., 1],
    seed = 19,
)
	# For reproducibility
	Random.seed!(seed)
	
	# City population
    Ns = rand(50:5000, C)
	
	# Undetected transmission
    β_und = rand(0.3:0.02:0.6, C)
	
	# Detected transmission (10% of undetected)
    β_det = β_und ./ 10
	
	# Migrate from city i to city j
	# People in small cities tend to migrate to bigger cities
	migration_rates = zeros(C, C)
    for c in 1:C, c2 in 1:C
        migration_rates[c, c2] = (Ns[c] + Ns[c2]) / Ns[c]
    end
	
	# Normalize migration rates
	maxM = maximum(migration_rates)
    migration_rates = (migration_rates .* max_travel_rate) ./ maxM
	
	# Migrate to self = 1
    migration_rates[diagind(migration_rates)] .= 1.0
	
	return (; Ns,
        β_und,
        β_det,
        migration_rates,
        infection_period,
        reinfection_probability,
        detection_time,
        death_rate,
        Is)
end

# ╔═╡ a6471587-2890-4d4d-bb94-168993d021a1
SIRgraphparams = make_SIRgraphParams(C = 8, max_travel_rate = 0.01)

# ╔═╡ 340a98fc-05e0-4094-8944-9ef1d20bdc70
function migrate!(agent, model)
    pid = agent.pos
    d = DiscreteNonParametric(1:(model.C), model.migration_rates[pid, :])
    m = rand(model.rng, d)
    if m ≠ pid
        move_agent!(agent, m, model)
    end
end

# ╔═╡ 538e400e-5832-474b-aa32-7fc4d311577b
function transmit!(agent, model)
    agent.status == :S && return
    rate = if agent.days_infected < model.detection_time
        model.β_und[agent.pos]
    else
        model.β_det[agent.pos]
    end

    d = Poisson(rate)
    n = rand(model.rng, d)
    n == 0 && return

    for contactID in ids_in_position(agent, model)
        contact = model[contactID]
        if contact.status == :S ||
           (contact.status == :R && rand(model.rng) ≤ model.reinfection_probability)
            contact.status = :I
            n -= 1
            n == 0 && return
        end
    end
end

# ╔═╡ 1b2e2fb0-d5f1-4e47-a593-fddf9c10c8b8
update!(agent, model) = agent.status == :I && (agent.days_infected += 1)

# ╔═╡ 44745a79-2f35-4b2d-881c-8fbf07c918d7
function recover_or_die!(agent, model)
    if agent.days_infected ≥ model.infection_period
        if rand(model.rng) ≤ model.death_rate
            kill_agent!(agent, model)
        else
            agent.status = :R
            agent.days_infected = 0
        end
    end
end

# ╔═╡ 557f060c-a9ac-4aee-85a5-b6ad48065489
function agent_step!(agent::PoorSoul, model)
    migrate!(agent, model)
    transmit!(agent, model)
    update!(agent, model)
    recover_or_die!(agent, model)
end

# ╔═╡ 0a003441-169a-4e2f-9c27-3c074d9606a2
let model = make_SIRgraph(; SIRgraphparams...)
	anim = @animate for i in 1:40
		Agents.step!(model, agent_step!, 1)
		
		
		cityPops = length.(model.space.s)
		xs = 1:length(cityPops)
		infected = map(x -> count(model[id].status == :I for id in x), model.space.s)
		infectedTotal = sum(infected)
		
		
		pl = bar(xs, cityPops, label="Total")
		bar!(pl, xs, infected, label="Infected", 
			 xlabel="City", ylabel="Population",
			 title = "Step $i: $infectedTotal infected"
		)
	end
	
	mp4(anim, fps = 5)
end

# ╔═╡ 7ad1fc2b-d4d6-4431-a06a-e8fda045bee6
md"""
## Appendix
Running environment and some auxillary functions.
	
**You can use [this helper tool](https://fonsp.com/article-test-3/pkghelper.html) to generate these commands!**
"""

# ╔═╡ 77180529-5223-4a0e-933b-447a3e9f56ae


# ╔═╡ Cell order:
# ╠═e5f4abe0-be15-11eb-038f-5da4c19a690d
# ╠═07c4c6aa-c7bb-4543-868d-975de9f37ba9
# ╠═99c0bed6-a533-4058-bf85-c81fac0f5976
# ╠═867f455d-39c0-458f-a374-72de9a95076e
# ╠═a6471587-2890-4d4d-bb94-168993d021a1
# ╠═557f060c-a9ac-4aee-85a5-b6ad48065489
# ╠═340a98fc-05e0-4094-8944-9ef1d20bdc70
# ╠═538e400e-5832-474b-aa32-7fc4d311577b
# ╠═1b2e2fb0-d5f1-4e47-a593-fddf9c10c8b8
# ╠═44745a79-2f35-4b2d-881c-8fbf07c918d7
# ╠═0a003441-169a-4e2f-9c27-3c074d9606a2
# ╠═7ad1fc2b-d4d6-4431-a06a-e8fda045bee6
# ╠═49674784-f070-488d-b53b-9cebf0ce101e
# ╠═77180529-5223-4a0e-933b-447a3e9f56ae
