defmodule SpellpasteWeb.TelegramIntegrationController do
  use SpellpasteWeb, :controller

  require Logger

  # we only match messages that start with a /, so we don't waste computer
  # power for messages that don't matter
  def webhook(conn, %{"message" => %{"text" => "/" <> _} = message}) do
    Events.publish!(Events.TelegramMessage, message)

    send_resp(conn, 204, "")
  end

  def webhook(conn, _params), do: send_resp(conn, 204, "")
end
