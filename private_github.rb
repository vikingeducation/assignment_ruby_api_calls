require 'github_api'
require 'pp'
require 'pry'

class GithubAPI

  GITHUB_API_KEY = ENV["GITHUB_API_KEY"]

  def initialize
    @github = Github.new(oauth_token: GITHUB_API_KEY)
  end


  def user_repos(name)
    @github.repos.list user: name
  end

end



g = GithubAPI.new
p g.user_repos("lynchd2")