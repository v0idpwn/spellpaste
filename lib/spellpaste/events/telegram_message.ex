defmodule Spellpaste.Events.TelegramMessage do
  @moduledoc """
  Models a telegram message
  """

  @behaviour Spellpaste.Events.Event

  use Ecto.Schema

  alias Ecto.Changeset

  # maybe move this soon?
  defmodule From do
    use Ecto.Schema

    embedded_schema do
      field :username, :string
    end
  end

  embedded_schema do
    field :message_id, :integer
    field :text, :string
    embeds_one :from, From

    embeds_one :reply_to_message, ReplyToMessage do
      field :message_id, :integer
      field :text, :string
      embeds_one :from, From
    end
  end

  @impl true
  def topic, do: "spellpaste:integration:telegram_message"

  @impl true
  def cast(params) do
    %__MODULE__{}
    |> Changeset.cast(params, [:text, :message_id])
    |> Changeset.validate_required([:text, :message_id])
    |> Changeset.cast_embed(:from, with: &from_changeset/2)
    |> Changeset.cast_embed(:reply_to_message, with: &reply_to_message_changeset/2)
    |> case do
      %{valid?: true} = changeset ->
        {:ok, Changeset.apply_changes(changeset)}

      changeset ->
        {:error, changeset}
    end
  end

  defp reply_to_message_changeset(schema, params) do
    schema
    |> Changeset.cast(params, [:text, :message_id])
    |> Changeset.validate_required([:text, :message_id])
    |> Changeset.cast_embed(:from)
  end

  defp from_changeset(schema, params), do: Changeset.cast(schema, params, [:username])
end
