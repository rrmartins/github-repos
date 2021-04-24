defmodule GithubReposWeb.Plugs.RefreshToken do
  import Plug.Conn

  alias Plug.Conn
  alias GithubReposWeb.Auth.Guardian

  def init(options), do: options

  def call(%Conn{} = conn, _options) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, new_token} <- Guardian.refresh_token(token) do
      put_resp_header(conn, "token", new_token)
    else
      _ -> conn
    end
  end

  def call(conn, _options), do: conn
end
