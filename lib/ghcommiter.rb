require 'httparty'
require 'pp'

class GHCommiter
  def initialize(owner,oauth_token=ENV['GIT_KEY'])
    @oauth_token = oauth_token
    @root_url = "http://api.github.com"
    @owner = owner
  end

  def commit
  params = {"message": "my commit message",
    "author": {
    "name": "Scott Chacon",
    "email": "schacon@gmail.com",
    },
    "parents": ['f93e3a1a1525fb5b91020da86e44810c87a2d7bc'
    ],
    "tree": "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"}
    url = @root_url + "/repos/#{@owner}/git_private_tracker/commits?access_token=#{@oauth_token}"
    pp HTTParty.post(url, params)
  end

  # f93e3a1a1525fb5b91020da86e44810c87a2d7bc

  # /repos/:owner/:repo/git/commits
  #id: 73865844
end
GHCommiter.new("thecog19").commit
