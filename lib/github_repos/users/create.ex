defmodule GithubRepos.Users.Create do
  alias GithubRepos.{Error, Repo, User}

  def call(params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, reason} -> {:error, Error.build_bad_request(reason)}
    end
  end
end
