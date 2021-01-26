defmodule Spellpaste.Events.StatsUpdated do
  @moduledoc """
  New stats to be put in the stats page
  """

  @behaviour Spellpaste.Events.Event

  use Ecto.Schema

  alias Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :pastes_count, :integer
    field :pastes_in_this_month, :integer
    field :authors_count, :integer
    field :senders_count, :integer
  end

  @impl true
  def topic, do: "spellpaste:stats_updated"

  @impl true
  def cast(params) do
    %__MODULE__{}
    |> Changeset.cast(params, __schema__(:fields))
    |> Changeset.validate_required(__schema__(:fields))
    |> case do
      %Changeset{valid?: true} = changeset ->
        {:ok, Changeset.apply_changes(changeset)}

      invalid_changeset ->
        {:error, invalid_changeset}
    end
  end
end
