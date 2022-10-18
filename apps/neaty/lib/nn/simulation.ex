defmodule NN.Simulation do
  defstruct nn: nil,  data: %{}, deps: nil, weight_map: nil, sigmoid: nil

  alias NN.Simulation

  def new(nn, sigmoid \\ fn x -> :math.tanh(2 * x) end) do
    deps = 
      nn.connections
      |> Enum.filter(fn {_id, conn} -> conn.enabled end)
      |> Enum.reduce(%{},
        fn {conn_id, conn}, deps -> 
          input_id = {conn.input, conn_id}
          Map.update(deps, conn.output, [input_id], &[input_id | &1])
      end)

    weight_map = 
      nn.connections
      |> Enum.filter(fn {_id, conn} -> conn.enabled end)
      |> Enum.reduce(%{},
        fn {conn_id, conn}, weight_map -> 
          Map.put(weight_map, conn_id, conn.weight)
      end)

    %Simulation{nn: nn, deps: deps, weight_map: weight_map, sigmoid: sigmoid}
  end

  def step_helper(%Simulation{} = sim, inputs, current) do
    if current in Map.keys(inputs) do
      inputs[current]
    else
      sim.sigmoid.(
        Enum.reduce(sim.deps[current], 0, fn {in_id, conn_id}, sum -> 
          sum + step_helper(sim, inputs, in_id) * sim.weight_map[conn_id]
        end)
      )
    end
  end
  
  def step(%Simulation{} = sim, inputs) do
    Enum.reduce(sim.nn.outputs, %{}, fn out_id, acc -> 
      Map.put(acc, out_id, step_helper(sim, inputs, out_id))
    end)
  end

end
