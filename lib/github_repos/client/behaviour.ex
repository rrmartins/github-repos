defmodule GithubRepos.Client.Behaviour do
  alias GithubRepos.{Error, Repository}

  @typep repository_result :: {:ok, list(Repository.t())} | {:error, Error.t()}

  @callback get_repos(String.t()) :: repository_result
  @callback get_repos(String.t(), String.t()) :: repository_result
end
