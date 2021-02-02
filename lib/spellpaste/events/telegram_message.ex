defmodule Spellpaste.Events.TelegramMessage do
  @moduledoc """
  Models a telegram message
  """

  alias SpellpasteIntegration.Telegram.Message

  @behaviour Spellpaste.Events.Event

  @impl true
  def topic(_ \\ nil), do: "spellpaste:integration:telegram_message"

  @impl true
  def cast(%Message{} = message), do: {:ok, message}

  def cast(params) do
    params
    |> Message.cast()
    |> case do
      %{valid?: true} = changeset ->
        {:ok, Ecto.Changeset.apply_changes(changeset)}

      changeset ->
        {:error, changeset}
    end
  end
end
