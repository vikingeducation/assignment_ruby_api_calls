require "github_api"

class GithubMonitor

  attr_accessor :git, :repo

  def initialize
    @git = Github.new(oauth_token: ENV["TOKEN"]) #obj
    @repo = create_repo
  end

  def create_repo
    @git.repos.create(name: "forkcommithistory")
  end

  def add_commit
    contents = Github::Client::Repos::Contents.new
    @git.repos.contents.create( ENV['USERNAME'], @repo, 'README.md')
  end
end