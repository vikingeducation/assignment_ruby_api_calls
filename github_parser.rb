require 'github_api'
require 'json'
require 'pp'

class GithubParser

  attr_reader :github

  def initialize(github)
    @github = github
    @user = nil
  end

  def list_repos(user=nil)
    @user = user
    repos = @github.repos.list(sort: "updated", user: @user).first(10)
    list = repos.map { |repo| repo["name"] }
  end

  def list_commits
    recent_commits = []
    list_repos.each do |repo_name|
      sleep(1)
      recent_commits << ["#{repo_name}", @github.repos.commits.list("strychemi", "#{repo_name}").first(10)]
    end
    recent_commits
  end
end
