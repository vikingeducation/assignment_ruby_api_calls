require 'github_api'
require 'pry'


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
    
    g = Github.new
    g.repos.commits.get user_name, repo_name, '18a089a07367243efef49fdff6c98d87f15870ea'

    binding.pry
  end

  def get_user_name(repo)
    repo.owner.login
  end

  def get_repo_name(repo)
    repo.name
  end

end

gha = GitHubApiProject.new('adrianmui')
gha.get_latest_10

repo =  gha.latest_10

#working
#gha.get_latest_10
#gha.display_latest_10

p repo[1].commits_url

#p gha.get_commits()

# gha.get_latest_10_commits
# gha.display_latest_10_commits
# gha.display_latest_10
