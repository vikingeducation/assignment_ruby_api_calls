require 'github-api'
require 'httparty'
require 'pp'

class GHExtractor

  def initialize(owner,oauth_token=ENV['GIT_KEY'])
    @oauth_token = oauth_token
    @root_url = "http://api.github.com"
    @owner = owner
  end

  def get_private_repos # private repos
    url = @root_url + "/user/repos?visiblity=private&sort=created&access_token=#{@oauth_token}"
    HTTParty.get(url)
  end

  def get_forks_repos # un pr'd forked repos
    url = @root_url + "/user/repos?sort=created&access_token=#{@oauth_token}"
    child_repos = HTTParty.get(url)
    forked_array = []
    child_repos.each do |repo|
      pp repo
      parent = repo["parent"]
      pp HTTParty.get(parent["pulls_url"])
      break
    end
  end


  def output_repos # generate list of commits  #######STOPPED HERE
    commit_dates = []
    repo_list = get_private_repos
    repo_list.each do |repo|
      commits = get_commits(repo["name"])
      commits.each do |commit|
        commit_dates << commit["commit"]["author"]["date"]
      end
    end
    commit_dates
  end

  def get_commits(name)
    sleep(1)
    url = @root_url + "/repos/#{@owner}/#{name}/commits?sort=updated&access_token=#{@oauth_token}"
    HTTParty.get(url)
  end


end