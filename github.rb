require 'github_api'

class GitHubScanner

  def initialize(username="StephenMayeux")
    @github = Github.new { |config| config.oauth_token = ENV["GITHUB_API_TOKEN"] }
    @username = username
    @repos = nil
    @commits = {}
  end

  def get_repos
    @repos = (@github.repos.list user: @username, sort: "updated").first(10).map do |repo|
      repo.name
    end
  end

  def get_commits
    get_repos
    @repos.each do |repo|
      commits = (@github.repos.commits.list(@username, repo)).first(10)
      @commits[repo] = commits.map do |commit|
        commit.commit.message
      end
    end
    puts "Here are #{@username}'s last 10 message on their last 10 repos."
    puts @commits
  end

end

test = GitHubScanner.new
test.get_commits
