defmodule Neaty.Neat.NeuralNetwork do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neuralnetworks" do
    field :bin, :binary
    field :json, :string

    timestamps()
  end

  @doc false
  def changeset(neural_network, attrs) do
    neural_network
    |> cast(attrs, [:json, :bin])
    |> validate_required([:json, :bin])
  end
end
