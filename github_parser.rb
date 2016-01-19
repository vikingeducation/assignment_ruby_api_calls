require 'github_api'
require 'json'
require 'pp'

class GithubParser

  attr_reader :github

  def initialize(github)
    @github = github
  end

  def list(user=nil)
    #user_name = user ? user : nil
    @github.repos.list
  end

end
