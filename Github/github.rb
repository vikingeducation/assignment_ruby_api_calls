require 'github_api'

class GithubScanner
  def initialize( username )
    @oauth_token = ENV["git_api_key"]
    @username = username
    @github = Github.new( oauth_token: @oauth_token)
    @repos = nil
    @commits = {}
  end

  def request_repos
    @repos = ( @github.repos.list user: @username, sort: "updated" ).first(3).map { |repo| repo.name }
  end

  def request_commits
    @repos.each do |name|
      repo_commits = ( @github.repos.commits.list @username, name ).first(2)

      @commits[name] = repo_commits.map { |commit| commit.commit.message }
    end
    @commits
  end

end 

github = GithubScanner.new( "JeremyVe")
puts github.request_repos
puts github.request_commits