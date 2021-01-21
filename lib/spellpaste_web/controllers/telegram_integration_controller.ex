defmodule SpellpasteWeb.TelegramIntegrationController do
  use SpellpasteWeb, :controller

  require Logger

  def webhook(conn, %{"message" => message}) do
    Events.publish!(Events.TelegramMessage, message)

    send_resp(conn, 204, "")
  end
end
