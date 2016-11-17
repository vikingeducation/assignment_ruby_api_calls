require 'httparty'
require 'pp'

class GHCommiter
  def initialize(owner,oauth_token=ENV['GIT_KEY'])
    @oauth_token = oauth_token
    @root_url = "http://api.github.com"
    @owner = owner
  end

  def commit
    params = {
      "message": "Private commit",
      "parents": 
    }
    url = @url + "repos/#{@owner}/git_private_tracker/git/commits?api_key=#{@oauth_token}&date="
    HTTParty.get()
  end

  # f93e3a1a1525fb5b91020da86e44810c87a2d7bc
  # /repos/:owner/:repo/git/commits
end