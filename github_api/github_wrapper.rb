require 'github_api'
require 'pp'

require_relative 'example' 

class GitHubWrapper

  def initialize
    @github = Github.new(oauth_token: ENV["GIT_KEY"])
    @latest_repos = get_latest_repos
    @latest_repos.each do |repo|
      pp repo
    end
  end

  def get_latest_repos # 10 latest repos
    latest_repos = []
    counter = 0
    @github.repos.list do |repo|
      latest_repos << repo
      counter += 1
      break if counter == 10
    end
    latest_repos
  end

end

t = GitHubWrapper.new