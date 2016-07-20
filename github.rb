#MY_KEY =  b38f1a770afe6558407d5d99bc2d73ec75fba9df

require 'github_api'
require 'pp'

class GH_Api

  def initialize(options = {})
    @key = options[:key]
  end

  def list_repos
    github = Github.new oauth_token: @key
    github.repos.list
  end

end