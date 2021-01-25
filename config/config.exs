# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :spellpaste,
  ecto_repos: [Spellpaste.Repo]

# Configures the endpoint
config :spellpaste, SpellpasteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ruO99tCuywyw9xOJOn0sl/wtoQHYJyyZDq6ZIVn4LB3k8h8a5WtHoO7yZqygRnEg",
  render_errors: [view: SpellpasteWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Spellpaste.PubSub,
  live_view: [signing_salt: "UV1zwHGC"]

config :spellpaste, public_url: "http://localhost:4000"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :tesla, adapter: Tesla.Adapter.Hackney

config :spellpaste, pubsub_channel: Spellpaste.PubSub

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
