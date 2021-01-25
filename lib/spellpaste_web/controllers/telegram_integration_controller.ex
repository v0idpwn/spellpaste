defmodule SpellpasteWeb.TelegramIntegrationController do
  use SpellpasteWeb, :controller

  require Logger

  alias SpellpasteIntegration.Telegram

  # we only match messages that start with a /, so we don't waste computer
  # power for messages that don't matter
  def webhook(conn, %{"message" => %{"text" => "/" <> _} = params}) do
    with {:ok, message} <- Telegram.build_message(params),
         :ok <- Telegram.enqueue_processing!(message) do
      Logger.info("Message enqueued for later processing")
      send_resp(conn, 204, "")
    end
  end

  def webhook(conn, _params), do: send_resp(conn, 204, "")
end
