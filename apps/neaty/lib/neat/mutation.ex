defmodule Neat.Mutation do
  @moduledoc """
    Module responsible for mutations
  """

  alias Neat.InnovationTracker

  def mutate(nn, opts) do
    rand = :rand.uniform()
    cond do
      rand < opts.new_node_chance -> 
        mutate_new_node(nn, opts)
      rand < opts.new_node_chance + opts.new_link_chance -> 
        mutate_new_connection(nn, opts)
      true -> 
        mutate_weights(nn, opts)
    end
  end


  def mutate_new_connection(nn, opts) do
    possible_outs = [nn.outputs | nn.hidden] |> List.flatten()    
    possible_ins = [nn.inputs | nn.hidden] |> List.flatten()
    new_conn = rand_search(possible_ins, fn in_node -> 
      rand_search(possible_outs, fn out_node -> 
        new_conn = {in_node, out_node}
        if in_node != out_node && not Map.has_key?(nn.connections, Utils.hash(new_conn)) do
          new_conn
        else
          nil
        end
      end)
    end)
    if new_conn do
      {in_node, out_node} = new_conn
      Map.put(nn, :connections, 
        Map.put(nn.connections, Utils.hash(new_conn), NN.Connection.new(in_node, out_node, new_weight(opts), InnovationTracker.innovate()))
      )
    else
      mutate_new_node(nn, opts)
    end
  end

  def rand_search([], _), do: nil
  def rand_search(list, func) do
    {h, t} = pop_rand(list)
    func.(h) || rand_search(t, func)
  end
  def pop_rand(list) do
    i = :rand.uniform(length(list)) - 1
    {Enum.at(list, i), List.delete_at(list, i)}
  end
  
  def mutate_new_node(nn, opts) do
    enabled = Enum.filter(nn.connections, fn {_, conn} -> conn.enabled end)
    if Enum.empty?(enabled) do
      mutate_random_enable(nn, opts)
    else
      {conn_id, conn} = Enum.at(enabled, :rand.uniform(length(enabled)) - 1)
      node_id = Utils.hash {conn.input, conn.output}
      conn1_id = Utils.hash {conn.input, node_id}
      conn2_id = Utils.hash {node_id, conn.output}
      nn 
      |> Map.update!(:hidden, & [node_id | &1])
      |> Map.put(:connections, 
        nn.connections
        |> Map.put(conn_id, %{conn | enabled: false})
        |> Map.put(conn1_id, %{conn | output: node_id, innovation: InnovationTracker.innovate()})
        |> Map.put(conn2_id, %{conn | input: node_id, weight: 1.0, innovation: InnovationTracker.innovate()})
      )
    end
  end

  def mutate_weights(nn, opts) do
    Map.put(nn, :connections, 
      Enum.reduce(nn.connection, %{}, fn {id, conn}, acc -> 
        Map.put(acc, id,
        cond do
          :rand.uniform() < opts.new_weight_chance ->
            %{conn | weight: new_weight(opts)}
          true -> 
            %{conn | weight: conn.weight + :rand.normal() * opts.weight_mutation_power}
        end
        )
      end)
    )
  end

  def mutate_random_enable(nn, opts) do
    disabled = Enum.filter(nn.connections, fn {_, conn} -> conn.enabled end) 
    if Enum.empty?(disabled) do
      mutate_new_connection(nn, opts)
    else
      {conn_id, conn} = Enum.random(nn.connections)
      Map.put(nn, :connections, Map.put(nn.connections, conn_id, %{conn | enabled: true}))
    end
  end

  def new_weight(opts) do
    :rand.uniform() * (opts.weight_range_max - opts.weight_range_min) + opts.weight_range_min
  end
end
