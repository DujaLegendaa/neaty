defmodule NN.Connection do
  @moduledoc """
  Neural Network Connection Gene
  """

  defstruct input: -1, output: -1, weight: 0.0, innovation: 1, enabled: true

  alias NN.Connection

  def new(input, output, weight \\ 0.1 * (2 * :rand.uniform - 1), innovation \\ 1, enabled \\ true) do
    %Connection{input: input, output: output, weight: weight, innovation: innovation, enabled: enabled}   
  end
  
end
