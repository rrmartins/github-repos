defmodule GithubReposWeb.FallbackController do
  use GithubReposWeb, :controller

  alias Ecto.Changeset
  alias GithubRepos.Error
  alias GithubReposWeb.ErrorView

  def call(conn, {:error, %Error{status: status, message: message}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", message: changeset)
  end
end
