defmodule SpawnInventory.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        SpawnSdk.System.Supervisor,
        system: "inventory-system",
        actors: [
          SpawnInventory.Actors.Product,
          SpawnInventory.Actors.Inventory
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: SpawnInventory.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
