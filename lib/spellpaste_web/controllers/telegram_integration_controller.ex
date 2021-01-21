defmodule SpellpasteWeb.TelegramIntegrationController do
  use SpellpasteWeb, :controller

  require Logger

  def webhook(conn, %{"message" => message}) do
    Logger.warn("Received #{inspect(message, limit: :infinity)}")
    conn
    |> put_status(200)
  end
end
