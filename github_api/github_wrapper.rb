require 'github_api'
require 'pp'

require_relative 'example' 

class GitHubWrapper

  def initialize
    @github = Github.new(oauth_token: ENV["GIT_KEY"])
    @latest_repos = []
    @latest_repos_names = []
    @latest_commits = {}

    get_latest_repos
    get_latest_commits
    display_results
  end

  def get_latest_repos # 10 latest repos
    @github.repos.list user: "kotten1", per_page: 10, page: 1, sort: "created"  do |repo|
      @latest_repos << repo
      @latest_repos_names << repo["name"]
    end

  end

  def get_latest_commits
    @latest_repos_names.each do |repo_name|
      @github.repos.commits.list "kotten1", repo_name, sort: "created" do |commit|
        if @latest_commits[repo_name] 
          next unless @latest_commits[repo_name].length < 10 
          @latest_commits[repo_name] << commit["commit"]["message"] 
        else
          @latest_commits[repo_name] = [ commit["commit"]["message"] ] 
        end      
      end
      sleep 0.5
    end
  end

  def display_results
    @latest_commits.each do |key, value| 
      puts key
      puts value.inspect
      puts "------------"
    end
  end

end

t = GitHubWrapper.new