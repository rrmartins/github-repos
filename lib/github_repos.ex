defmodule GithubRepos do
  alias GithubRepos.Repositories.Get, as: GetRepos

  alias GithubRepos.Users.Create, as: CreateUser
  alias GithubRepos.Users.Get, as: GetUser

  defdelegate get_repos_from_user(username), to: GetRepos, as: :from_user

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
end
