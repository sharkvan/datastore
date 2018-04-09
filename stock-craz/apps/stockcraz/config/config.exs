use Mix.Config

config :stockcraz, ecto_repos: [StockCraz.Repo]

import_config "#{Mix.env}.exs"
