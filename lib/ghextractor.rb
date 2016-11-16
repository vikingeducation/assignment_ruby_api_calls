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
    fork_events = get_user_events
    url = @root_url + "/user/repos?sort=created&access_token=#{@oauth_token}"
    sleep(1)
    all_repos = HTTParty.get(url)
    all_repos.select do |repo|
      fork_events.any? do |event|
        event["repo"]["url"] == repo["url"]
      end
    end
  end

  def get_user_events
    url = @root_url + "/users/#{@owner}/events?access_token=#{@oauth_token}"
    forked = HTTParty.get(url)
    sleep(0.5)
    pullevents = HTTParty.get(url)
    
    forked = forked.select do |event|
      event["type"] = "ForkEvent"
    end
    pullevents = pullevents.select do |event|
      event["type"] = "PullRequestEvent"
    end
    #returns an array of forked but not pulled objects
    final = forked.select do |repo|
      pullevents.any? do |pull|
        !(repo["repo"]["url"] == pull["repo"]["url"])
      end
    end
    final 
  end


  def output_repos # generate list of commits  #######STOPPED HERE
    commit_dates = []
    repo_list = get_private_repos
    repo_list += get_forks_repos
    repo_list.each do |repo|
      commits = get_commits(repo["name"])
      commits.each do |commit|
        commit_dates << commit["commit"]["author"]["date"]
      end
    end
    commit_dates
  end

  def get_commits(name)
    url = @root_url + "/repos/#{@owner}/#{name}/commits?sort=updated&access_token=#{@oauth_token}"
    HTTParty.get(url)
    sleep(0.5)
  end


end