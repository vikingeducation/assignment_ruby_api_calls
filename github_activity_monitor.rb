require "github_api"

class GithubMonitor

  attr_accessor :git, :repo

  def initialize
    @git = Github.new(oauth_token: ENV["TOKEN"]) #obj
    @repo = "forkcommithistory"
  end

  def create_repo
    @git.repos.create(name: "forkcommithistory")
  end

  def add_commit
    contents = Github::Client::Repos::Contents.new
    contents.create( ENV['USERNAME'], g.repo.name, "README.md", path: "README.md", message: "create readme file", content: "testing")
  end
end