require 'github_api'
require 'pry-byebug'
require 'figaro'
require 'pp'

Figaro.application = Figaro::Application.new(
  environment: "development",
  path: "config/application.yml"
)
Figaro.load

class GithubAPI
  TOKEN = Figaro.env.GITHUB_API

  attr_accessor :client

  def initialize
    @client = Github.new
    @client.current_options[:oauth_token] = TOKEN
  end

end

git = GithubAPI.new
binding.pry
pp git.client.repos.list[0]