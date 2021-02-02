defmodule SpellpasteWeb.PageLive do
  use SpellpasteWeb, :live_view

  alias Phoenix.PubSub
  alias Spellpaste.Events
  alias Spellpaste.Pastes
  alias Spellpaste.Pastes.Bin
  alias SpellpasteWeb.BinLive

  @limit 5

  defp pubsub_channel, do: Application.get_env(:spellpaste, :pubsub_channel)

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(pubsub_channel(), Events.BinCreated.topic())
    PubSub.subscribe(pubsub_channel(), Events.StatsUpdated.topic())

    {:ok, assign(socket, bins: Pastes.last_bins(@limit), stats: nil)}
  end

  @impl true
  def handle_info(%Bin{} = bin, socket) do
    new_bins = [bin | Enum.take(socket.assigns[:bins], @limit - 1)]
    {:noreply, assign(socket, bins: new_bins)}
  end

  @impl true
  def handle_info(%Events.StatsUpdated{} = new_stats, socket) do
    {:noreply, assign(socket, stats: new_stats, stats_last_updated: NaiveDateTime.utc_now())}
  end

  @impl true
  def handle_event("view", %{"id" => id}, socket) do
    {:noreply, push_redirect(socket, to: Routes.bin_path(socket, :index, id))}
  end
end
