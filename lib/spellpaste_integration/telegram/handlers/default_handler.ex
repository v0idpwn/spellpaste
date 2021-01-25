defmodule SpellpasteIntegration.Telegram.Handlers.DefaultHandler do
  @moduledoc """
  Just logs the message
  """

  require Logger

  alias SpellpasteIntegration.Telegram.Message

  @behaviour SpellpasteIntegration.Telegram.Handlers

  @impl true
  def handle(%Message{message_id: id}) do
    Logger.info("Received and ignored message #{id}")

    {:ok, nil}
  end
end
