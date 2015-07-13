require 'github_api'

class NotGitHub

  def initialize(username)
    @github = Github.new user: username, oauth_token: ENV["GITHUB"]
    @username = username
    responses = @github.repos.list
    last_ten(responses)
    # last_ten_messages(responses)
  end

  def last_ten(responses)
    arr = responses.map {|repo| [repo.updated_at, repo.name]}
    arr = arr.sort_by{|x,y|x}.reverse[0..9]
    arr.each {|i| puts i[1]}
  end

  def last_ten_messages_per_repo(responses)
    msg = @github.repos.commits.list @username, 'assignment_ruby_api_calls' #, sha: "32d74e2dcee2c8ca963fcf472d6006ea110fa692"
    msg.map do |m|
      p m["commit"]["message"]
    end
  end

  def last_ten_messages_for_10_repos(responses)
    arr.each ||
    msg = @github.repos.commits.list @username, 'assignment_ruby_api_calls'
  end


end

gh = NotGitHub.new('joseph-lozano')
# gh2 = NotGitHub.new('alokpradhan')

# github = Github.new
# github.repos.commits.list 'user-name', 'repo-name', sha: '...'
# github.repos.commits.list 'user-name', 'repo-name', sha: '...' { |commit| … }