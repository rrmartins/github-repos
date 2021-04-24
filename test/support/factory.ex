defmodule GithubRepos.Factory do
  use ExMachina.Ecto, repo: GithubRepos.Repo

  alias GithubRepos.{Repository, User}

  def repo_factory do
    %Repository{
      description: "Project using Rails 4 and Ruby 2",
      html_url: "https://github.com/rrmartins/account_manager",
      id: 8_385_036,
      name: "rrmartins/account_manager",
      stargazers_count: 0
    }
  end

  def user_factory do
    %User{
      id: "4d7341aa-6672-4c93-b639-e83526c806fd",
      password: "123456"
    }
  end
end
