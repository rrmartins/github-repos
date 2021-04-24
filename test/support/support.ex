defmodule GithubRepos.Support do
  import Plug.Conn

  alias GithubRepos.User
  alias GithubReposWeb.Auth.Guardian

  def put_bearer_auth(conn, token) do
    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  def puth_auth_header(conn, %User{} = user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    put_bearer_auth(conn, token)
  end
end
