defmodule Spellpaste.Events.BinViewCountIncreased do
  @moduledoc """
  Reports a bin had its count increased
  """

  alias Spellpaste.Pastes.Bin

  @behaviour Spellpaste.Events.Event

  @impl true
  def topic(%Bin{id: id}), do: "spellpaste:pastes:bin:#{inspect(id)}:count_increased"

  @impl true
  def cast(%Bin{} = bin), do: {:ok, bin}
  def cast(_), do: {:error, :cast_error}
end
