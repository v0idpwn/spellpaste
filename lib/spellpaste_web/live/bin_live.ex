defmodule SpellpasteWeb.BinLive do
  use SpellpasteWeb, :live_view

  alias Phoenix.PubSub
  alias Spellpaste.{Events, Pastes}

  defp pubsub_channel, do: Application.get_env(:spellpaste, :pubsub_channel)

  @impl true
  def mount(%{"identifier" => identifier}, _session, socket) do
    case Pastes.get_bin_from_identifier(identifier) do
      {:ok, bin} ->
        PubSub.subscribe(pubsub_channel(), Events.BinViewCountIncreased.topic(bin))
        
        {:ok, assign(socket, bin: bin, not_found: false)}

      {:error, :not_found} ->
        {:ok, assign(socket, not_found: true)}
    end
  end

  @impl true
  def handle_info(bin, socket), do: {:noreply, assign(socket, bin: bin)}
end
