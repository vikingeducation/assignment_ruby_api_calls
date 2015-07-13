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

  def add_readme
    @contents = Github::Client::Repos::Contents.new(oauth_token: ENV["TOKEN"])
    @contents.create( ENV['USERNAME'], @repo, "README.md", path: "README.md", message: "create readme file", content: "testing")
  end

  def get_commit(repo)
    # Git::Repos::Commits(user, repo)
    commit = @git.repos.commits.list(ENV["USERNAME"], repo).keys
  end

  def add_last_commit(repo)
    # commits[0]["commit"]["author"]["date"]
    msg = @git.repos.commits.list(ENV["USERNAME"], repo)[0]["commit"]["author"]["date"]
    file = @git.repos.contents.find(user: ENV["USERNAME"], repo: @repo, path: "README.md")
    @git.repos.contents.update( ENV['USERNAME'], @repo, "README.md", path: "README.md", message: msg, content: "testing", sha: file.sha)
  end

end