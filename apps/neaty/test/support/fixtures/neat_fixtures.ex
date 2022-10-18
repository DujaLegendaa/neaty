defmodule Neaty.NeatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Neaty.Neat` context.
  """

  @doc """
  Generate a neural_network.
  """
  def neural_network_fixture(attrs \\ %{}) do
    {:ok, neural_network} =
      attrs
      |> Enum.into(%{
        bin: "some bin",
        json: "some json"
      })
      |> Neaty.Neat.create_neural_network()

    neural_network
  end
end
