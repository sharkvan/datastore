use Mix.Config

# Configure your database
config :storage, Storage.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "storage_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
