defmodule SpawnInventory.Actors.InventoryActor do
  use SpawnSdk.Actor,
    kind: :abstract,
    channel: "inventory-projection",
    snapshot_timeout: 5_000,
    deactivate_timeout: 120_000,
    state_type: Io.Eigr.Spawn.Inventory.Inventory

  alias Io.Eigr.Spawn.Inventory.{
    Inventory,
    ProductProjection,
    ProductView
  }

  @item_channel "items"

  defact transform(%ProductProjection{} = data, %Context{state: state} = ctx) do
    state = Inventory.new()
    view = ProductView.new()

    Value.of()
    |> Value.state(state)
    |> Value.broadcast(Broadcast.to(@item_channel, view))
    |> Value.noreply!()
  end
end
