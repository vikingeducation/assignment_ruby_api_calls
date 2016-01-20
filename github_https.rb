require 'github_api'
require './github_parser.rb'

class GithubHttps
  include GithubParser

  API_KEY = ENV["GITHUB_API_KEY"]

  attr_reader :github

  def initialize
    @github = Github.new oauth_token: API_KEY
  end

  #obtains 10 recent repo's for particular user (Github returns raw JSON)
  def list_repos(user=nil)
    @github.repos.list(sort: "updated", user: user).first(10)
  end

  def list_commits
    recent_commits = []
    # iterate through array of [usernames, repos]
    parsed_repository_list = parse_repos(list_repos)
    parsed_repository_list.each do |names|
      puts "Currently processing repo: #{names[1]}..."
      # sleep 1s between requests to prevent ban from API
      sleep(1)
      # saving a last 10 commits per repo name [ repo_name, commit_list ]
      recent_commits << [names[1], @github.repos.commits.list(names[0], names[1]).first(10)]
    end
    recent_commits
  end
end
