defmodule Spellpaste.Pastes do
  @moduledoc """
  Manages paste creation
  """

  alias Spellpaste.Events
  alias Spellpaste.Pastes.Bin
  alias Spellpaste.Repo

  @retry_limit 10

  def create_bin(text, author \\ nil, sender \\ nil) do
    %{text: text, author: author, sender: sender}
    |> Bin.changeset()
    |> insert_with_retry()
    |> publish_bin_created_event()
  end

  defp insert_with_retry(changeset, count \\ 0)

  defp insert_with_retry(changeset, count) when count < @retry_limit do
    case Repo.insert(changeset) do
      {:ok, _} = result ->
        result

      {:error, %Ecto.Changeset{}} = result ->
        result

      _constraint_error ->
        insert_with_retry(changeset, count + 1)
    end
  end

  defp insert_with_retry(_, _), do: {:error, :too_many_attempts}

  defp publish_bin_created_event({:ok, bin}) do
    Events.publish!(Events.BinCreated, bin)
    {:ok, bin}
  end

  defp publish_bin_created_event(err), do: err
end
