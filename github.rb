require 'github_api'
require 'pp'

class GH_Api

  attr_reader :names, :repos, :commits

  def initialize(options = {}, username)
    @key = options[:key]
    @username = username
    @commits = {}
    @commit_messages = {}
  end

  def list_repos
    @github = Github.new oauth_token: @key
    @repos = @github.repos.list sort:"created_at"
  end

  def get_latest_repos(number)
    @names = []
    number.times do |i|
      @names << @repos[i]["name"]
    end
    @names 
  end

  def get_latest_commits
    @names.each do |name|
      @commits[name] = @github.repos.commits.list "#{@username}", "#{name}"
    end
  end

  def get_commit_messages
    get_latest_commits
    @commits.each do |name, commits|
      @commit_messages[name] = []
      commits[0..9].each do |commit|
        @commit_messages[name] << commit["commit"]["message"]
      end
    end
    @commit_messages
  end
    

end

#date format: "2016-07-20T21:45:21Z"
#github.commits["assignment_ruby_api_calls"][0]["commit"]["author"]["date"]