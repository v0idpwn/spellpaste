defmodule SpellpasteIntegration.Telegram.Handlers.HelpHandler do
  @moduledoc """
  Sends a simple help message
  """

  alias SpellpasteIntegration.Telegram.Message
  @behaviour SpellpasteIntegration.Telegram.Handlers

  def handle(%Message{chat_id: c_id, message_id: m_id}) do
    %{
      chat_id: c_id,
      reply_to_message_id: m_id,
      text: "Send /spellpaste in reply to a message to send it to our spellpaste servers"
    }
  end
end
