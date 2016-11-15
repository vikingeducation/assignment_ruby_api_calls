require 'github-api'
require 'httparty'
require 'pp'


class Githubb
  token = ENV['GIT_KEY']

  def initialize(oauth_token=ENV['GIT_KEY'])
    @oauth_token = oauth_token
    @root_url = "https://api.github.com"
  end

  def get_results(opts = {})
    opts["access_token"] = @oauth_token
    puts HTTParty.get(@root_url, opts)
  end
end

Githubb.new.get_results