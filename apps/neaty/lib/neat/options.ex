defmodule Neat.Options do
  @moduledoc """
    Below are the options that can be configured the Neat evolution process.

    | Paramater                   | Default    | Description |
    | --------------------------- | ---------- | ----------- |
    | :seed                       | *Required* | The seed ANN used to generate the initial population. This is used for specifying the input/output neurons that all ANNs should have, as well as any priliminary topology ANNs should start with. |
    | :fitness_function           | *Required* | The function used to evaluate the fitness of ANNs. |
    | :single_fitness_function    | *Required* | Should equal true or false. If true, fitness function is given a single neural network to evaluate, and it should return a positive fitness value (where greater numbers are better). The call looks like `fitness_function(ann)`. If false, the fitness function is given the entire population to evaluate. The call looks like `fitness_function([{species_rep1, [ann1, {ann2, old_fitness}, ann3, ...]}, ...])`. Note, the species_rep should be left alone. Also, some ann's in the population (such as ann2 in this example) will already have assigned fitnesses, and can either be re-evaluated, or left with the same fitness. All ann's should be replaced by {ann, fitness} tuples, and the entire structure should be returned. Single-fitness functions are far easier to implement, but multi-fitness functions provide more flexibility. |
    | :population_size            | 150        | The number of ANNs in any given generation. |
    | :target_species_number      | 15         | The ideal number of species to exist. |
    | :structure_diff_coefficient | 2.0        | Coefficient for how much structure differences matter in speciation. |
    | :weight_diff_coefficient    | 1.0        | Coefficient for how much weight differences matter in speciation. |
    | :compatibility_threshold    | 6.0        | Initial threshold used for speciation, changes quickly.  |
    | :compatibility_modifier     | 0.3        | Value used to change :compatibility_threshold. |
    | :dropoff_age                | 15         | If a species does not progress for this many generations, it dies. |
    | :survival_ratio             | 0.2        | Ratio of the population that persists each generation. |
    | :weight_range_min           | -1.0       | Minimum for initial weight creation. |
    | :weight_range_max           | 1.0        | Maximum for initial weight creation. |
    | :weight_mutation_power      | 1/6        | Standard deviation for the random modifiers used to mutate weights. |
    | :new_weight_chance          | 0.1        | Ratio of weight mutations that get assigned totally new values. |
    | :child_from_mutation_chance | 0.25       | Ratio of children that result from mutation (not mating). |
    | :interspecies_mating_chance | 0.01       | Ratio of children that result from interspecies mating. |
    | :new_node_chance            | 0.03       | Ratio of mutations that add a new node (the rest mutate weights). |
    | :new_link_chance            | 0.05       | Ratio of mutations that add a new link (the rest mutate weights). |
  """

  defstruct seed: nil,
    fitness_function: nil,
    single_fitness_function: true,
    population_size: 150,
    target_species_number: 15,
    structure_difference_coefficient: 2.0,
    weight_difference_coefficient: 1.0,
    compatibility_threshold: 6.0,
    compatibility_modifier: 0.3,
    dropoff_age: 15.0,
    survival_ratio: 0.2,
    weight_range_min: -1.0,
    weight_range_max: 1.0,
    weight_mutation_power: 1 / 6,
    new_weight_chance: 0.1,
    child_from_mutation_chance: 0.25,
    interspecies_mating_chance: 0.01,
    new_node_chance: 0.13,
    new_link_chance: 0.05

  def new(seed, fitness_function, single_fitness_function, opts \\ []) do
    opts = opts
      |> Keyword.put(:seed, seed)
      |> Keyword.put(:fitness_function, fitness_function)
      |> Keyword.put(:single_fitness_function, single_fitness_function)

    opts = case Keyword.has_key?(opts, :population_size) && !Keyword.has_key?(opts, :target_species_number) do
      true ->
        Keyword.put(opts, :target_species_number, opts[:population_size] / 10)
      false ->
        opts
    end

    struct!(%Neat.Options{}, opts)
  end

end
