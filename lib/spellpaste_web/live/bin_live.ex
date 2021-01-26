defmodule SpellpasteWeb.BinLive do
  use SpellpasteWeb, :live_view

  alias Spellpaste.Pastes

  @impl true
  def mount(%{"identifier" => identifier}, _session, socket) do
    case Pastes.get_bin_from_identifier(identifier) do
      {:ok, bin} ->
        {:ok, assign(socket, bin: bin, not_found: false)}

      {:error, :not_found} ->
        {:ok, assign(socket, not_found: true)}
    end
  end
end
