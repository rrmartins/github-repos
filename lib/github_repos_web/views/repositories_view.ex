defmodule GithubReposWeb.RepositoriesView do
  use GithubReposWeb, :view

  alias GithubRepos.Repository

  def render("repositories.json", %{repos: [%Repository{} | _] = repos}) do
    %{"repositories" => repos}
  end
end
