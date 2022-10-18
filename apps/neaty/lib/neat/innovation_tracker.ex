defmodule Neat.InnovationTracker do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> 1 end, name: __MODULE__)
  end

  def innovate do
    Agent.update(__MODULE__, &(&1 + 1))
    Agent.get(__MODULE__, & &1)
  end
  
end
