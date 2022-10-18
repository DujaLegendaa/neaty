defmodule Utils do
  @moduledoc """
    Utility functions 
  """
  def hash(term) do
    term
    |> :erlang.term_to_binary
    |> :xxh3.hash64(420) 
  end
  
end
