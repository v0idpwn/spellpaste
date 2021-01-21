defmodule Spellpaste.Events.TelegramMessage do
  @moduledoc """
  Models a telegram message
  """

  @behaviour Spellpaste.Events.Event
  
  use Ecto.Schema

  alias Ecto.Changeset

  embedded_schema do
    field :text
  end

  @impl true
  def topic, do: "spellpaste:integration:telegram_message"

  @impl true
  def cast(params) do
    %__MODULE__{}
    |> Changeset.cast(params, [:text])
    |> Changeset.validate_required(:text)
    |> case do
      %{valid?: true} = changeset ->
        {:ok, Changeset.apply_changes(changeset)}

      changeset ->
        {:error, changeset}
    end
  end
end
