defmodule SpellpasteIntegration.Telegram do
  @moduledoc """
  Telegram message helpers
  """

  alias SpellpasteIntegration.Telegram.Message

  @doc """
  Builds a message from a telegram message representation
  """
  def build_message(params) do
    params
    |> Message.cast()
    |> case do
      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, Ecto.Changeset.apply_changes(changeset)}

      changeset ->
        {:error, changeset}
    end
  end
end
