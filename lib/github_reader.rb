class GithubReader
  GITHUB_TOKEN = ENV['GITHUB']

  def initialize
    @github = Github::Client::Repos.new oauth_token: GITHUB_TOKEN
  end

  def repos(user)
    @github.list(user: "#{user}").body[-10..-1]
  end

  def repos_with_commits(user)
    @github.list(user:)
  end

end
GithubReader.new.repos
