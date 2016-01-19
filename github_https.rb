require 'github_api'
require 'json'
require 'pp'

class GithubHttps

  API_KEY = ENV["GITHUB_API_KEY"]

  attr_reader :github

  def initialize
    @github = Github.new oauth_token: API_KEY
  end

end
