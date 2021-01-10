defmodule Spellpaste.Repo do
  use Ecto.Repo,
    otp_app: :spellpaste,
    adapter: Ecto.Adapters.Postgres
end
