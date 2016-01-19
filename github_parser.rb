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
    #pp repos[0]
    list = repos.map { |repo| [repo["owner"]["login"],repo["name"]] }
  end

  def list_commits
    recent_commits = []
    
    list_repos.each do |user_repo|
      sleep(1)
      recent_commits << [user_repo[1], @github.repos.commits.list(user_repo[0], user_repo[1]).first(10)]
    end

    recent_commits.each do |item|
      clean_commits = []
      item[1].each do |commit|
        clean_commits << [commit["commit"]["committer"],commit["commit"]["message"]]
      end 
      item[1] = clean_commits
    end  
    recent_commits
  end

end
