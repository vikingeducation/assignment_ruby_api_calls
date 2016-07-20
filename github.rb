require 'github_api'
require 'pp'

class GithubAPI

  def initialize
    @github = Github.new
  end

  def user_repositories(name)
    @github.repos.list user: name
  end

end



g = GithubAPI.new
puts g.user_repositories("")