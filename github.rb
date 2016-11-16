require 'github-api'
require 'httparty'
require 'pp'


class Github

  def initialize(owner,oauth_token=ENV['GIT_KEY'])
    @oauth_token = oauth_token
    @root_url = "http://api.github.com"
    @owner = owner
  end

  def get_own_repos
    url = @root_url + "/user/repos?sort=created&access_token=#{@oauth_token}"
    list = HTTParty.get(url)
    list[0..10]
  end

  def output_repos
    repo_list = get_own_repos
    repo_list.each do |repo|
      puts "\n\nThis is the #{repo["name"]}"
      commits = get_commits(repo["name"])
      10.times do |times|
        current_commit = commits[times]
        break unless !!current_commit
        puts "\nThis is commit number #{times + 1}"
        puts "Comment was: #{current_commit["commit"]["message"]}"
      end
    end
  end

  def get_commits(name)
    sleep(1)
    url = @root_url + "/repos/#{@owner}/#{name}/commits?sort=updated&access_token=#{@oauth_token}"
    HTTParty.get(url)
  end
end