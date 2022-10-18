defmodule Neaty.Neat do
  @moduledoc """
  The Neat context.
  """

  import Ecto.Query, warn: false
  alias Neaty.Repo

  alias Neaty.Neat.NeuralNetwork

  @doc """
  Returns the list of neuralnetworks.

  ## Examples

      iex> list_neuralnetworks()
      [%NeuralNetwork{}, ...]

  """
  def list_neuralnetworks do
    Repo.all(NeuralNetwork)
  end

  @doc """
  Gets a single neural_network.

  Raises `Ecto.NoResultsError` if the Neural network does not exist.

  ## Examples

      iex> get_neural_network!(123)
      %NeuralNetwork{}

      iex> get_neural_network!(456)
      ** (Ecto.NoResultsError)

  """
  def get_neural_network!(id), do: Repo.get!(NeuralNetwork, id)

  @doc """
  Creates a neural_network.

  ## Examples

      iex> create_neural_network(%{field: value})
      {:ok, %NeuralNetwork{}}

      iex> create_neural_network(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_neural_network(attrs \\ %{}) do
    %NeuralNetwork{}
    |> NeuralNetwork.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a neural_network.

  ## Examples

      iex> update_neural_network(neural_network, %{field: new_value})
      {:ok, %NeuralNetwork{}}

      iex> update_neural_network(neural_network, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_neural_network(%NeuralNetwork{} = neural_network, attrs) do
    neural_network
    |> NeuralNetwork.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a neural_network.

  ## Examples

      iex> delete_neural_network(neural_network)
      {:ok, %NeuralNetwork{}}

      iex> delete_neural_network(neural_network)
      {:error, %Ecto.Changeset{}}

  """
  def delete_neural_network(%NeuralNetwork{} = neural_network) do
    Repo.delete(neural_network)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking neural_network changes.

  ## Examples

      iex> change_neural_network(neural_network)
      %Ecto.Changeset{data: %NeuralNetwork{}}

  """
  def change_neural_network(%NeuralNetwork{} = neural_network, attrs \\ %{}) do
    NeuralNetwork.changeset(neural_network, attrs)
  end
end
