defmodule Neaty.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Neaty.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Neaty.PubSub},
      {Neat.InnovationTracker, 0}
      # Start a worker by calling: Neaty.Worker.start_link(arg)
      # {Neaty.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Neaty.Supervisor)
  end
end
