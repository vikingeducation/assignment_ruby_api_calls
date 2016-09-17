require 'github_api'

class GitHubRepos
  def initialize
    @github = Github.new
  end

  def show_repos
    @github.repos.list(user: 'ufarruh')[0..9].each do |repo|
      puts repo["created_at"]
      puts repo["name"]
    end
  end

  def show_commits
    @github.repos.commits.list(:user 'ufarruh', 'ustagram').each do |commit|
      puts commit["commit"]["committer"]["date"]
      puts commit["commit"]["message"]
    end
  end

end

github = GitHubReposhub.new
puts github.show_commits
puts github.show_repos
