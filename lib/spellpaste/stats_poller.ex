defmodule Spellpaste.StatsPoller do
  @moduledoc """
  Polls stats from the database and updates them in a pubsub topic
  """

  use GenServer

  require Logger

  import Ecto.Query

  alias Spellpaste.Pastes.Bin
  alias Spellpaste.Events
  alias Spellpaste.Repo

  @interval 2000

  def start_link(_), do: GenServer.start_link(__MODULE__, nil)

  @impl true
  def init(_) do
    Logger.info("Starting #{__MODULE__}")

    {:ok, %{last_updated: nil}, {:continue, :schedule_poll}}
  end

  @impl true
  def handle_continue(:schedule_poll, state) do
    Process.send_after(self(), :poll, @interval)
    {:noreply, state}
  end

  @impl true
  def handle_info(:poll, _state) do
    stats = get_stats()

    Events.publish!(Events.StatsUpdated, stats)

    {:noreply, %{last_updated: NaiveDateTime.utc_now()}, {:continue, :schedule_poll}}
  end

  defp get_stats() do
    [
      Task.async(&pastes_count/0),
      Task.async(&pastes_in_this_month/0),
      Task.async(&authors_count/0),
      Task.async(&senders_count/0)
    ]
    |> Task.await_many()
    |> Map.new()
  end

  defp pastes_count, do: {:pastes_count, Repo.aggregate(Bin, :count)}

  defp pastes_in_this_month do
    {:pastes_in_this_month,
     Repo.aggregate(
       from(b in Bin, where: b.inserted_at > fragment("CURRENT_DATE - interval '30' day")),
       :count
     )}
  end

  defp authors_count do
    {:authors_count, Repo.one(from(b in Bin, select: fragment("count(distinct(?))", b.author)))}
  end

  defp senders_count do
    {:senders_count, Repo.one(from(b in Bin, select: fragment("count(distinct(?))", b.sender)))}
  end
end
