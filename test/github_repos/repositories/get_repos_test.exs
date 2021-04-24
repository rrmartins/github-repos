defmodule GithubRepos.Repositories.GetReposTest do
  use ExUnit.Case, async: true

  import Mox
  import GithubRepos.Factory

  alias GithubRepos.ClientMock
  alias GithubRepos.Repositories.Get

  describe "call/1" do
    test "returns repos" do
      username = "rrmartins"

      repos = build_list(3, :repo)

      expect(ClientMock, :get_repos, fn _username ->
        {:ok, repos}
      end)

      response = Get.from_user(username)

      expected_response = {:ok, repos}

      assert expected_response == response
    end
  end
end
