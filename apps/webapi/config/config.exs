# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :webapi, Webapi.Endpoint,
  http: [port: 80],
  url: [host: "localhost"],
  secret_key_base: "ULrNr2knsHZhY7q3ODJBLd3Hr6bbdBMk8sKA44gLK/2ge2QNbMnn9FXKkam64C7/",
  render_errors: [view: Webapi.ErrorView, accepts: ~w(json)],
  pubsub: [name: Webapi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"