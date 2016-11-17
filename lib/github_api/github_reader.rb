
class GithubReader
  GITHUB_TOKEN = ENV['GITHUB']

  def initialize
    @github = Github::Client::Repos.new oauth_token: GITHUB_TOKEN
  end

  def repos(user)
    @github.list(user: "#{ user }", per_page: 100).body
  end

  def repos_with_commits(user)
    repos = {}
    @github.list(user: "#{ user }") do |repo|
      repo_name = repo.name
      repos[repo_name] = commit_messages(user, repo_name)
      pause
    end
    repos
  end

  def commit_messages(user, repo_name)
    commit_messages = []
    commits = @github.commits.list(user, repo_name).body
    -1.downto(-10) do | index |# commits.each do | commit |
      commit = commits[index]
      break unless commit
      commit_messages << commit.commit.message
    end
    commit_messages
  end

  def forks(user)
    repos(user).select do |repo|
      pause
      repo['fork']
    end
  end

  private

    def pause(time = 0.5)
      sleep(time)
    end
end
