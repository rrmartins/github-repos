defmodule GithubRepos.Repositories.Get do
  import GithubRepos.Client, only: [get_client: 0]

  def from_user(username), do: get_client().get_repos(username)
end
