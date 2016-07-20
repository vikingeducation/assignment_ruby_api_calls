require 'github_api'
require 'httparty'

class GitHubApiProject
  attr_reader :latest_10

  def initialize(username)
    @username = username
    @agent = Github.new
  end

  def get_latest_10
    repos = @agent.repos.list user: @username, 
                              sort: 'created', 
                              direction: 'desc'
    @latest_10 = repos.first(10)
  end

  def display_latest_10
    @latest_10.each do |repo|
      puts [repo.name,repo.created_at]
    end
  end

  def display_latest_10_commits
    @latest_10_commits.each do |repo|
      puts repo
    end
  end

  def get_latest_10_commits
    @latest_10_commits = @latest_10.map do |repo|
      get_commits(repo)
    end
  end

  def get_commits(repo)
    repo_name = get_repo_name(repo)
    user_name = get_user_name(repo)
    repo.commits.gets user_name, repo_name, '73388fc10d264eafdb331364be9d9441129f8dbf'
  end

  def get_user_name(repo)
    repo.owner.login
  end

  def get_repo_name(repo)
    repo.name
  end

  def get_commit_url(repo)
    repo.commits_url
  end

  def get_commit_messages(repo)
    HTTParty. 
  end

end

gha = GitHubApiProject.new('cjvirtucio87')
gha.get_latest_10
p gha.latest_10[0].commits_url
# gha.get_latest_10_commits
# gha.display_latest_10_commits
# gha.display_latest_10