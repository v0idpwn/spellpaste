defmodule SpellpasteIntegration.Telegram.Handlers do
  @moduledoc """
  Behaviour for telegram message handlers.

  Also matches messages with handlers through get_handler/1
  """

  alias SpellpasteIntegration.Telegram.Message
  alias SpellpasteIntegration.Telegram.Handlers.{DefaultHandler, HelpHandler, SpellpasteHandler}

  @callback handle(Message.t()) :: {:ok, term()} | {:error, term()}

  @doc """
  Matches a message with its handler module
  """
  def get_handler(%Message{text: "/spellpaste" <> ""}), do: {:ok, SpellpasteHandler}
  def get_handler(%Message{text: "/help" <> ""}), do: {:ok, HelpHandler}
  def get_handler(_), do: {:ok, DefaultHandler}
end
