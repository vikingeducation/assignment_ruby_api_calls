require "github_api"

class GithubMonitor

  token = ENV["TOKEN"]

  @git = Github.new(oauth_token: token)

  def create_repo

    @git.repos.create(name: "forkcommithistory")

  end

end