#MY_KEY =  b38f1a770afe6558407d5d99bc2d73ec75fba9df

require 'github_api'
require 'pp'

class GH_Api

  def initialize(options = {})
    @key = options[:key]
  end

  def list_repos
    github = Github.new oauth_token: @key
    @repos = github.repos.list
  end

  def 


end

name = repos[2][:name]
time_created = repos[2][:created_at]