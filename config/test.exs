use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :spellpaste, Spellpaste.Repo,
  username: "postgres",
  password: "postgres",
  database: "spellpaste_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spellpaste, SpellpasteWeb.Endpoint,
  http: [port: 4002],
  server: false

# enable tesla mocking
config :tesla, adapter: Tesla.Mock

# Print only warnings and errors during test
config :logger, level: :warn
