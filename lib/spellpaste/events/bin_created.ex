defmodule Spellpaste.Events.BinCreated do
  @moduledoc """
  Reports a bin has been created
  """

  alias Spellpaste.Pastes.Bin

  @behaviour Spellpaste.Events.Event

  @impl true
  def topic, do: "spellpaste:pastes:bin_created"

  @impl true
  def cast(%Bin{} = bin), do: {:ok, bin}
  def cast(_), do: {:error, :cast_error}
end
