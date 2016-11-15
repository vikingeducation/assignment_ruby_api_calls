
class GithubReader
  GITHUB_TOKEN = ENV['GITHUB']

  def initialize
    @github = Github::Client::Repos.new oauth_token: GITHUB_TOKEN
  end

  def repos(user)
    @github.list(user: "#{ user }").body[-10..-1]
  end

  def repos_with_commits(user)
    repos = {}
    @github.list(user: "#{ user }") do |repo|
      repo_name = repo.name
      repos[repo_name] = @github.commits.list(user, repo_name).body
      pause
    end
    repos
  end

  private

    def pause(time = 0.5)
      sleep(time)
    end
end
