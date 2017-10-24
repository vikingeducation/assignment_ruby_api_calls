require 'github_api'
require 'awesome_print'

class GithubAPIWrapper
  TOKEN = ENV['GITHUB_TOKEN']

  def initialize
    @github = Github.new(oauth_token: TOKEN)
  end

  def get_recent_repos(qty)
    repos = @github.repos.list(user: 'lortza')
    p repos.body.first
  end

  def render_recent_repo_names(qty)
    get_recent_repos(qty)
  end

  def render_recent_repo_commits(qty)
    get_recent_repos(qty)
  end
end




github = GithubAPIWrapper.new

github.get_recent_repos(10)
