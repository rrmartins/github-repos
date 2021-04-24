ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubRepos.Repo, :manual)
Mox.defmock(GithubRepos.ClientMock, for: GithubRepos.Client.Behaviour)
