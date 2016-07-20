require 'github_api'


class GitHubApiProject

  def initialize(username)
    @username = username
  end

  def get_latest_10
    repos = github.repos.list user: @username
    repos.body
  end

end
