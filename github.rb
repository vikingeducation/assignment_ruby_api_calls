
require 'github_api'

class GithubAuth
  attr_accessor :github_a

    def initialize
       @github_a = Github.new oauth_token: ENV['my_api']
    end
  
end