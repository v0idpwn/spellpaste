defmodule SpellpasteIntegration.Telegram.Handlers.SpellpasteHandler do
  @moduledoc """
  Creates a bin and answers the link for it
  """

  alias Spellpaste.Pastes
  alias SpellpasteIntegration.Telegram.{Client, Message}

  @behaviour SpellpasteIntegration.Telegram.Handlers

  def handle(%Message{
        chat_id: c_id,
        message_id: m_id,
        from: %{username: sender},
        reply_to_message: %{text: text, from: %{username: author}}
      }) do
    with {:ok, bin} <- Pastes.create_bin(text, author, sender),
         uri <- uri_for_bin(bin),
         response <- build_response(c_id, m_id, uri) do
      Client.send_message(response)
    end
  end

  defp uri_for_bin(bin) do
    :spellpaste
    |> Application.get_env(:public_url)
    |> URI.parse()
    |> URI.merge("/b/")
    |> URI.merge(bin.identifier)
    |> URI.to_string()
  end

  defp build_response(chat_id, message_id, uri) do
    %{
      chat_id: chat_id,
      reply_to_message_id: message_id,
      text: uri
    }
  end
end
