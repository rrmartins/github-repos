defmodule GithubRepos.Repo do
  use Ecto.Repo,
    otp_app: :github_repos,
    adapter: Ecto.Adapters.Postgres
end
