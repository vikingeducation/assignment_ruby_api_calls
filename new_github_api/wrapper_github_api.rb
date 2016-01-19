require "github_api"
require "pp"



class WrapperGithubAPI

  attr_reader :api, :repos

  def initialize
    @api = Github.new oauth_token: ENV['new_token']
  end

  def get_repo_names
    @repos = Github.repos.list(:user => 'samok13')
  end
  # def get_commits
  # end
end


