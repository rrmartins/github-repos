defmodule GithubRepos.ClientTest do
  use ExUnit.Case, async: true

  alias GithubRepos.{Client, Error, Repository}
  alias Plug.Conn

  describe "get_repos/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when user exists and has repositories, returns the repositories", %{bypass: bypass} do
      username = "rrmartins"

      body = File.read!("test/resources/repositories/rrmartins.json")

      url = build_localhost_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repos(url, username)

      expected_response = {
        :ok,
        [
          %Repository{
            description: "Project using Rails 4 and Ruby 2",
            html_url: "https://github.com/rrmartins/account_manager",
            id: 8_385_036,
            name: "account_manager",
            stargazers_count: 0
          },
          %Repository{
            description: "Collection of ActiveModel/ActiveRecord validators",
            html_url: "https://github.com/rrmartins/activevalidators",
            id: 15_614_104,
            name: "activevalidators",
            stargazers_count: 0
          },
          %Repository{
            description: "The administration framework for Ruby on Rails applications.",
            html_url: "https://github.com/rrmartins/active_admin",
            id: 13_962_331,
            name: "active_admin",
            stargazers_count: 0
          },
          %Repository{
            description: "app ar-condicionado",
            html_url: "https://github.com/rrmartins/Air",
            id: 3_008_972,
            name: "Air",
            stargazers_count: 1
          },
          %Repository{
            description: "A collection of Alfred 2 workflows that will rock your world",
            html_url: "https://github.com/rrmartins/alfred-workflows",
            id: 15_031_799,
            name: "alfred-workflows",
            stargazers_count: 0
          }
        ]
      }

      assert expected_response == response
    end

    test "when user not exists, returns an error", %{bypass: bypass} do
      username = "rmartins"

      url = build_localhost_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, "")
      end)

      response = Client.get_repos(url, username)

      expected_response = {
        :error,
        %Error{
          message: "User not found",
          status: :not_found
        }
      }

      assert expected_response == response
    end

    test "when returns bad request getting the repositories, returns an error", %{bypass: bypass} do
      username = "rrmartins"

      url = build_localhost_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(400, "")
      end)

      response = Client.get_repos(url, username)

      expected_response = {
        :error,
        %Error{
          message: "Bad request getting repos",
          status: :bad_request
        }
      }

      assert expected_response == response
    end
  end

  defp build_localhost_url(port), do: "http://localhost:#{port}/"
end
