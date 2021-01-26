defmodule Spellpaste.Pastes.Bin do
  @moduledoc """
  Simple datastructure that represents a bin that was pasted from somewhere
  """

  use Ecto.Schema

  import Ecto.Query

  alias Ecto.Changeset

  schema "bins" do
    field :text, :string
    field :author, :string
    field :sender, :string
    field :programming_language, :string
    field :identifier, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> Changeset.cast(params, [:text, :author, :sender])
    |> put_identifier()
  end

  @doc """
  Put a random identifier on a Bin changeset
  """
  def put_identifier(changeset),
    do: Changeset.put_change(changeset, :identifier, random_identifier())

  defp random_identifier(size \\ 8),
    do: size |> :crypto.strong_rand_bytes() |> Base.encode64(padding: false) |> url_safe()

  defp url_safe(base64), do: base64 |> String.replace("+", "-") |> String.replace("/", "_")

  @doc "Query for fetching last bins"
  def last_few_query(limit),
    do: from(b in __MODULE__, limit: ^limit, order_by: {:desc, b.id})

  @doc "Query for fetching a bin from identifier"
  def from_identifier_query(identifier),
    do: from(b in __MODULE__, where: b.identifier == ^identifier)
end
