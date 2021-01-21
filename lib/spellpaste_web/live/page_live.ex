defmodule SpellpasteWeb.PageLive do
  use SpellpasteWeb, :live_view

  alias Phoenix.PubSub
  alias Spellpaste.Events
  alias Spellpaste.Pastes
  alias Spellpaste.Pastes.Bin

  defp pubsub_channel, do: Application.get_env(:spellpaste, :pubsub_channel)

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(pubsub_channel(), Events.BinCreated.topic())

    {:ok, assign(socket, bins: Pastes.last_bins(5))}
  end

  @impl true
  def handle_info(%Bin{} = bin, socket) do
    {:noreply, assign(socket, bins: [bin | socket.assigns[:bins]])}
  end
end
