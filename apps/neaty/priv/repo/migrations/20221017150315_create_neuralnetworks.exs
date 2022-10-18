defmodule Neaty.Repo.Migrations.CreateNeuralnetworks do
  use Ecto.Migration

  def change do
    create table(:neuralnetworks) do
      add :json, :string
      add :bin, :binary

      timestamps()
    end
  end
end
