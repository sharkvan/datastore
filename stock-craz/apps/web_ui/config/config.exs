# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :web_ui,
  namespace: WebUi,
  ecto_repos: [StockCraz.Repo]

# Configures the endpoint
config :web_ui, WebUi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5ij8/li+FoI9NQzSujBi05GK9mMM5WQCcy3mkkU9IXMSq6x+d9r8OVnF/7itd2qr",
  render_errors: [view: WebUi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebUi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :web_ui, :generators,
  context_app: :stockcraz

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
