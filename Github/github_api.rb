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

  attr_accessor :client, :repos

  def initialize
    @client = Github.new
    @client.current_options[:oauth_token] = TOKEN
  end

  def get_repos(num)
    @repos = @client.repos.list[-num..-1]
  end

  def get_commits
    @repos[0].commits.get
  end

end

git = GithubAPI.new
# binding.pry
# pp git.client.repos.list[0]
git.get_repos(3)
pp git.get_commits
# pp git.repos