defmodule SpawnInventory.Actors.ProductActor do
  use SpawnSdk.Actor,
    kind: :abstract,
    snapshot_timeout: 3_000,
    deactivate_timeout: 15_000,
    state_type: Io.Eigr.Spawn.Inventory.Product

  require Logger

  alias Io.Eigr.Spawn.Inventory.{
    IncRequest,
    IncResponse,
    ProductProjection,
    SumRequest,
    SumResponse
  }

  defact increment(%IncRequest{} = data, %Context{state: state} = ctx) do
    Logger.info(
      "[Product] Received Increment Request: #{inspect(data)}. Context: #{inspect(ctx)}"
    )

    resp = IncResponse.new()
    event = ProductProjection.new()

    Value.of()
    |> Value.value(resp)
    |> Value.state(state)
    |> Value.broadcast(Broadcast.to("inventory-projection", "transform", event))
    |> Value.reply!()
  end

  defact sum(%SumRequest{} = data, %Context{state: state} = ctx) do
    Logger.info("[Product] Received Sum Request: #{inspect(data)}. Context: #{inspect(ctx)}")

    resp = SumResponse.new()
    event = ProductProjection.new()

    Value.of()
    |> Value.value(resp)
    |> Value.state(state)
    |> Value.broadcast(Broadcast.to("inventory-projection", "transform", event))
    |> Value.reply!()
  end
end
