defmodule GithubReposWeb.RepositoriesControllerTest do
  use GithubReposWeb.ConnCase, async: true

  import GithubRepos.{Factory, Support}
  import Mox

  alias GithubRepos.{ClientMock, Error}

  describe "index/2" do
    setup %{conn: conn} do
      user = insert(:user)

      conn = puth_auth_header(conn, user)

      {:ok, conn: conn}
    end

    test "when user exits and has repositories, returns the repositories", %{conn: conn} do
      username = "rrmartins"

      repos = build_list(2, :repo)

      expect(ClientMock, :get_repos, fn _username ->
        {:ok, repos}
      end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :index, username))
        |> json_response(:ok)

      expected_response = %{
        "repositories" => [
          %{
            "description" => "Project using Rails 4 and Ruby 2",
            "html_url" => "https://github.com/rrmartins/account_manager",
            "id" => 8_385_036,
            "name" => "rrmartins/account_manager",
            "stargazers_count" => 0
          },
          %{
            "description" => "Project using Rails 4 and Ruby 2",
            "html_url" => "https://github.com/rrmartins/account_manager",
            "id" => 8_385_036,
            "name" => "rrmartins/account_manager",
            "stargazers_count" => 0
          }
        ]
      }

      assert expected_response == response
    end

    test "when user not exits, returns an error", %{conn: conn} do
      username = "rrmartins"

      expect(ClientMock, :get_repos, fn _username ->
        {:error, Error.build_not_found("User not found")}
      end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :index, username))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert expected_response == response
    end
  end
end
