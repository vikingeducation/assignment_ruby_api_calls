require 'github_api'

class API

  def initialize(username)
    @github = Github.new user: username, oauth_token: ENV["GITHUB"]
    @username = username
    responses = last_ten
    #last_ten_messages_per_repo
    last_ten_messages_for_10_repos(responses)
  end

  def last_ten
    responses = @github.repos.list.map {|repo| [repo.updated_at, repo.name]}
    responses = responses.sort_by{|x,y|x}.reverse[0..9]
  end

  def last_ten_messages_per_repo
    msg = @github.repos.commits.list @username, 'assignment_ruby_api_calls' #, sha: "32d74e2dcee2c8ca963fcf472d6006ea110fa692"
    msg.map do |m|
      p m["commit"]["message"]
    end
  end

  def last_ten_messages_for_10_repos(responses)
    all_messages = []
    responses.each do |repos|
      msg_list = @github.repos.commits.list @username, repos[1]
      msg_list.map.with_index do |m, index|
        index == 10 ? break : all_messages << "#{repos[1]}: #{m["commit"]["message"]}"
      end
    end
    p all_messages
  end

end

class ReplicateRepo
  def initialize(username)
    @github = Github.new name: username, oauth_token: ENV["TOKEN"]
    @username = username
  end

  def create_repo(repo_name)
    @github.repos.create name: repo_name
  end

  def make_a_commit(repo_name, sha = nil)
    @github.repos.contents.create @username, repo_name, 'README.md',
    path: 'README.md', content: "Alok Pradhan", message: "First Commit", sha: sha
  end

  def get_repo_data(repo_name = 'assignment_ruby_api_calls', file_name = 'github.rb')
    commit = @github.repos.contents.find @username, repo_name, file_name
    result = @github.repos.commits.list @username, repo_name, commit.sha
    date_authored = result.first.commit.author.date
  end

end

# gh = NotGitHub.new('joseph-lozano')
# gh2 = NotGitHub.new('alokpradhan')

# github = Github.new
# github.repos.commits.list 'user-name', 'repo-name', sha: '...'
# github.repos.commits.list 'user-name', 'repo-name', sha: '...' { |commit| … }