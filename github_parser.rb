require 'github_api'
require 'json'
require 'pp'

class GithubParser
  
  attr_reader :github 

  def initialize(github)
    @github = github
  end

  def list(user=nil,repo=nil)
    @github.repo.list
  end
  

end
