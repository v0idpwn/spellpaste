defmodule SpellpasteWeb.PageLive do
  use SpellpasteWeb, :live_view

  alias Phoenix.PubSub
  alias Spellpaste.Events.TelegramMessage

  defp pubsub_channel, do: Application.get_env(:spellpaste, :pubsub_channel)

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(pubsub_channel(), TelegramMessage.topic())

    {:ok, assign(socket, messages: [])}
  end

  @impl true
  def handle_info(%TelegramMessage{} = message, socket) do
    {:noreply, assign(socket, messages: [message | socket.assigns[:messages]])}
  end
end
