require "github/version"
require "pry"
require "pp"

module Github

  def initialize
    @github = Github.new oauth_token: 'new_token'
  end

  def get_repo_names
    byebug
    @repos = @github.repos.list(0..9)
    byebug
  end

  # def get_commits

  # end

end


a = Github.new
pp a
