require 'github_api'
require 'pry'

class GithubAPI

  attr_reader :username

  def initialize(options = {})
    @github_token = options.fetch(:oauth_token, ENV['GITHUB_TOKEN'])
    @username = options.fetch(:username, ENV['USERNAME'])
    @github = Github.new oauth_token: @github_token
  end

  def repos(n = 10)
    @github
      .repos
      .list
      .sort_by { |repo| repo['created_at'] }
      .first(n)
  end

  def commits(n = 10)
    repo_commits = {}
    repos.each do |repo|
      repo_name =  repo['name']
      commit_messages = []
      commits = @github.repos.commits.list(ENV['USERNAME'], repo_name).first(10)
      commits.each do |commit|
        commit_messages << commit['commit']['message']
      end
      repo_commits[repo_name] = commit_messages
    end
    repo_commits
  end

  def display_repo_commits
    commits.each do |repo_name, commits_arr|
      puts repo_name
      puts "-" * repo_name.length
      puts commits_arr
      puts
    end
  end

end

# Run program
github = GithubAPI.new({})
github.display_repo_commits

