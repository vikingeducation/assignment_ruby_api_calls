require 'github_api'
require 'pry-byebug'
require 'figaro'
require 'pp'
require 'rainbow'

Figaro.application = Figaro::Application.new(
  environment: "development",
  path: "config/application.yml"
)
Figaro.load

class GithubAPI
  TOKEN = Figaro.env.GITHUB_API
  USERNAME = Figaro.env.USERNAME

  attr_accessor :client, :repos, :names

  def initialize
    @client = Github.new
    @client.current_options[:oauth_token] = TOKEN
  end

  def get_repos
    @repos = @client.repos.list(sort: "updated")
  end

  def get_commits
    commits = []
    @names.each do |name|
      #pp name
      commits << @client.repos.commits.list(USERNAME, name)
    end
    commits
  end

  def get_commit_messages
    get_commits.each_with_index do |repo,index|
      puts Rainbow("Repository: #{@names[index]}").cyan
      repo.each do |commit|
        puts Rainbow(commit['commit']['message']).green
      end
    end
  end

  def get_name
    @names = @repos.map{|repo| repo['name']}
  end

  def run
    get_repos
    get_name
    get_commit_messages
  end

end
