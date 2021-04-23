# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github_repos,
  ecto_repos: [GithubRepos.Repo]

# Configures the endpoint
config :github_repos, GithubReposWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fiwnJ9UWvRRtPtes98ezeOlxh7zAqCyLBbKI/mTCfcqbnWqvSIpLL8U9LHg/qaIf",
  render_errors: [view: GithubReposWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GithubRepos.PubSub,
  live_view: [signing_salt: "ZanXBpu/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
