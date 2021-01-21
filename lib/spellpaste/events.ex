defmodule Spellpaste.Events do
  @moduledoc """
  Provides the interface to publish events in te pubsub and manages supported
  events
  """

  alias Phoenix.PubSub

  @events [
    Spellpaste.Events.TelegramMessage
  ]

  def publish!(event_module, input) when event_module in @events do
    PubSub.broadcast(
      pubsub_channel(),
      event_module.topic(),
      coerce!(event_module, input)
    )
  end

  defp coerce!(event_module, input) do
    case event_module.cast(input) do
      {:ok, data} ->
        data

      error ->
        raise ArgumentError, "invalid input given for #{event_module}, failed
        with error #{inspect(error)}"
    end
  end

  defp pubsub_channel, do: Application.get_env(:spellpaste, :pubsub_channel)
end
