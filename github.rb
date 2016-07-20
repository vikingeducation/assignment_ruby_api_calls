#MY_KEY = b38f1a770afe6558407d5d99bc2d73ec75fba9df
#KEY_2 = 1fefbd975bf4d10e1a3353d0f28def1ec606ef05
require 'github_api'
require 'pp'

class GH_Api

  def initialize(options = {})
    @key = options[:key]
  end

  def list_repos
    github = Github.new oauth_token: @key
    @repos = github.repos.list sort:"created_at"
  end

  def get_latest_repos(number)
    number.times do |i|
      puts @repos[i]["name"]
    end 
  end


end

# name = repos[2][:name]
# time_created = repos[2][:created_at]
#"2016-07-13T16:04:28Z"
# sorted by date: test = github_test.repos.list sort:"created_at"