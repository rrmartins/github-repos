defmodule GithubReposWeb.UsersView do
  use GithubReposWeb, :view

  alias GithubRepos.User

  def render("signin.json", %{token: token}), do: %{token: token}

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      user: user
    }
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
