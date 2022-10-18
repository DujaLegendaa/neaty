defmodule NN do
  @moduledoc """
    A Nerual Network implementation with Node and Connection Genes
  """
  defstruct inputs: [], hidden: [], outputs:  [], connections: %{} 

  alias NN.Connection
  def new(inputs, outputs, hidden \\ nil, connections \\ nil) do
    nn = %NN{inputs: inputs, outputs: outputs, hidden: hidden || [], connections: connections || %{}}
    if connections, do: nn, else: connect_all(nn) 
  end

  def from_json(json) do
    {:ok, map} = JSON.decode(json)
    new(map["inputs"], map["outputs"], map["hidden"], 
      Enum.reduce(map["connections"], %{}, fn conn, acc -> 
        Map.put(acc, conn["id"], Connection.new(conn["input"], conn["output"], conn["weight"]))
      end))
  end

  def connect_all(%NN{} = nn, weight_gen_f \\ fn -> :rand.normal(0, 0.05) end) do
    Map.put(nn, :connections, 
      Enum.reduce(nn.inputs, nn.connections, fn i_id, conns -> 
        Enum.reduce(nn.outputs, conns, fn o_id, conns -> 
          Map.put(conns, Utils.hash({i_id, o_id}), Connection.new(i_id, o_id, weight_gen_f.()))
        end)
      end)
    )
  end

  def to_json(%NN{} = nn) do
    {:ok, json} = JSON.encode(breakdown(nn))
    json
  end
  def breakdown(nn) do
    [inputs: nn.inputs, outputs: nn.outputs, hidden: nn.hidden,
      connections: Enum.map(nn.connections, fn {id, conn} -> 
        conn |> Map.delete(:__struct__) |> Map.put(:id, id)
      end)]
  end

  def to_graphviz(%NN{} = nn) do
    "digraph nn {\n" <>
      (nn.connections
        |> Enum.map(fn {_id, conn} -> conn end)
        |> Enum.filter(fn conn -> conn.enabled end)
        |> Enum.map_join("\n", fn conn -> 
          "\"#{inspect(conn.input)}\" -> \"#{inspect(conn.output)}\" [label=\" #{Float.round(conn.weight, 3)} \"];"
        end)
      ) <> "\n{ rank=same; #{Enum.join(nn.inputs, " ")} }" <> "\n{ rank=same; #{Enum.join(nn.outputs, " ")} }" <> "\n}"
  end

  def save_graph(nn, path) do
    save_data(to_graphviz(nn), path)
  end

  def save_data(binary, path) do
    {:ok, file} = File.open(path, [:write])
    :ok = IO.binwrite(file, binary)
    :ok = File.close(file)
  end
end
