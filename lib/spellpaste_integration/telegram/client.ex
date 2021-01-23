defmodule SpellpasteIntegration.Telegram.Client do
  @moduledoc """
  Client for the telegram API
  """

  use Tesla

  alias SpellpasteIntegration.Telegram.ClientInputs

  defp token, do: Application.get_env(:spellpaste, :telegram_api_token)

  plug Tesla.Middleware.BaseUrl, "https://api.telegram.org/bot#{token()}"
  plug Tesla.Middleware.Headers
  plug Tesla.Middleware.JSON

  @doc """
  Calls the sendMessage method in the telegram api
  """
  def send_message(params) do
    build_and_send(&post/2, "/send_message", ClientInputs.SendMessage, params)
  end

  defp build_and_send(fun, route, module, params) do
    with {:ok, input} <- module.build(params) do
      fun.(route, input)
    end
  end
end
