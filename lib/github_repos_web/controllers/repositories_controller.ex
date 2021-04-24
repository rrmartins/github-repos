defmodule GithubReposWeb.RepositoriesController do
  use GithubReposWeb, :controller

  alias GithubReposWeb.FallbackController

  action_fallback(FallbackController)

  def index(conn, %{"username" => username}) do
    with {:ok, repos} <- GithubRepos.get_repos_from_user(username) do
      conn
      |> put_status(:ok)
      |> render("repositories.json", repos: repos)
    end
  end
end
