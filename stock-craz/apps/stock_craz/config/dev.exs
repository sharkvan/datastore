use Mix.Config

# Configure your database
config :stock_craz, StockCraz.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "stockcraz_dev",
  hostname: "postgres",
  pool_size: 10

config :stock_craz, :dividend_event_producer, StockCraz.GenStage.Producers.DividendDeclaration
