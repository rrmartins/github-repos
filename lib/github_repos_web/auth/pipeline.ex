defmodule GithubReposWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :github_repos

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
