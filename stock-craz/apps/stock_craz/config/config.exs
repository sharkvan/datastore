use Mix.Config

config :stock_craz, ecto_repos: [StockCraz.Repo]

import_config "#{Mix.env}.exs"
