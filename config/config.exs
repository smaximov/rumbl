# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rumbl,
  ecto_repos: [Rumbl.Repo]

# Configures the endpoint
config :rumbl, RumblWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UifBuLXgGCObI4Xyil0N2xF6MKjr5rv4w32vdELhsv7n+PRREy5Wddl4t2C/aSlO",
  render_errors: [view: RumblWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rumbl.PubSub, adapter: Phoenix.PubSub.PG2]

proxy_dispatch = [
  _: [
    {
      "/socket/websocket",
      RumblProxy.WSReverseProxy,
      callback_module: RumblProxy.WSReverseProxy.AAA
    },
    {:_, Phoenix.Endpoint.Cowboy2Handler, {RumblProxy.Endpoint, []}}
  ]
]

config :rumbl, RumblProxy.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UifBuLXgGCObI4Xyil0N2xF6MKjr5rv4w32vdELhsv7n+PRREy5Wddl4t2C/aSlO",
  render_errors: [view: RumblProxy.ErrorView, accepts: ~w(json)],
  http: [dispatch: proxy_dispatch]

# pubsub: [name: Rumbl.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
