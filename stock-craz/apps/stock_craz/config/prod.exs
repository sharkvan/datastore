use Mix.Config

import_config "prod.secret.exs"
config :stock_craz, :dividend_event_producer, StockCraz.GenStage.Producers.DividendDeclaration
