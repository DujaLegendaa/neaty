defmodule Neaty.NeatTest do
  use Neaty.DataCase

  alias Neaty.Neat

  describe "neuralnetworks" do
    alias Neaty.Neat.NeuralNetwork

    import Neaty.NeatFixtures

    @invalid_attrs %{bin: nil, json: nil}

    test "list_neuralnetworks/0 returns all neuralnetworks" do
      neural_network = neural_network_fixture()
      assert Neat.list_neuralnetworks() == [neural_network]
    end

    test "get_neural_network!/1 returns the neural_network with given id" do
      neural_network = neural_network_fixture()
      assert Neat.get_neural_network!(neural_network.id) == neural_network
    end

    test "create_neural_network/1 with valid data creates a neural_network" do
      valid_attrs = %{bin: "some bin", json: "some json"}

      assert {:ok, %NeuralNetwork{} = neural_network} = Neat.create_neural_network(valid_attrs)
      assert neural_network.bin == "some bin"
      assert neural_network.json == "some json"
    end

    test "create_neural_network/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Neat.create_neural_network(@invalid_attrs)
    end

    test "update_neural_network/2 with valid data updates the neural_network" do
      neural_network = neural_network_fixture()
      update_attrs = %{bin: "some updated bin", json: "some updated json"}

      assert {:ok, %NeuralNetwork{} = neural_network} = Neat.update_neural_network(neural_network, update_attrs)
      assert neural_network.bin == "some updated bin"
      assert neural_network.json == "some updated json"
    end

    test "update_neural_network/2 with invalid data returns error changeset" do
      neural_network = neural_network_fixture()
      assert {:error, %Ecto.Changeset{}} = Neat.update_neural_network(neural_network, @invalid_attrs)
      assert neural_network == Neat.get_neural_network!(neural_network.id)
    end

    test "delete_neural_network/1 deletes the neural_network" do
      neural_network = neural_network_fixture()
      assert {:ok, %NeuralNetwork{}} = Neat.delete_neural_network(neural_network)
      assert_raise Ecto.NoResultsError, fn -> Neat.get_neural_network!(neural_network.id) end
    end

    test "change_neural_network/1 returns a neural_network changeset" do
      neural_network = neural_network_fixture()
      assert %Ecto.Changeset{} = Neat.change_neural_network(neural_network)
    end
  end
end
