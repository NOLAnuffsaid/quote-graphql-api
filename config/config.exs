# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :elixir_quotes,
  namespace: Quotes,
  ecto_repos: [Quotes.Repo]

config :elixir_quotes_web,
  namespace: QuotesWeb,
  ecto_repos: [Quotes.Repo],
  generators: [context_app: :elixir_quotes]

# Configures the endpoint
config :elixir_quotes_web, QuotesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nUJFbTjQ9E97JRigM0twUqgyA5H9ngXBm7+0pHEZwJ85jvqICeObr5laYV+Nkm9o",
  render_errors: [view: QuotesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: QuotesWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
