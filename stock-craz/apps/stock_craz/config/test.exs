use Mix.Config

# Configure your database
config :stock_craz, StockCraz.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "stockcraz_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
