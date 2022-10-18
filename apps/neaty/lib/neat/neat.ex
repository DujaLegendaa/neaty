defmodule Neat do
  defstruct opts: nil, species: [], generation: 0, best: {nil, 0}

  def new(opts) when is_map(opts) do
    %Neat{opts: opts}
  end

  def new_single_fitness(seed, fitess_func, opts \\ []) when is_function(fitess_func) do
    new(Neat.Options.new(seed, fitess_func, true, opts))
  end

  def new_multi_fitness(seed, fitess_func, opts \\ []) when is_function(fitess_func) do
    new(Neat.Options.new(seed, fitess_func, false, opts))
  end
end
