use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :github_repos, GithubRepos.Repo,
  username: "postgres",
  password: "postgres",
  database: "github_repos_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :github_repos, GithubRepos.Client, adapter: GithubRepos.ClientMock

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :github_repos, GithubReposWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
