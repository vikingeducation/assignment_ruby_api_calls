require 'github_api'
require 'pp'

class GithubAPIWrapper
  TOKEN = ENV["TOKEN"]

  attr_reader :github

  def initialize
    @github = Github.new(oauth_token: TOKEN)
  end
end

if $0 == __FILE__
  wrapper = GithubAPIWrapper.new
  pp wrapper.github
end
