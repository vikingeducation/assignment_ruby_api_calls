require "github_api"

class GithubMonitor

  def initialize
    @git = Github.new(oauth_token: ENV["TOKEN"])
    @repo = create_repo
  end

  def create_repo
    @git.repos.create(name: "forkcommithistory")
  end

  def add_commit
    
  end
end