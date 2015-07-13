require 'github_api'

class NotGitHub


  def initialize(username)
    github = Github.new user: username, oauth_token: ENV["GITHUB"]
    responses = github.repos.list
    last_ten(responses)
  end


  def last_ten(responses)


    arr = responses.map {|repo| [repo.updated_at, repo.name]}
    arr = arr.sort_by{|x,y|x}.reverse[0..9]

    arr.each {|i| puts i[1]}
  end


end


gh = NotGitHub.new('joseph-lozano')