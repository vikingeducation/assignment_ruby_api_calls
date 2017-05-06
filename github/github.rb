require 'github_api'
require 'pp'

class GithubAPIWrapper
  TOKEN = ENV["TOKEN"]

  attr_reader :github

  def initialize
    @github = Github.new(oauth_token: TOKEN)
  end

  # returns the names of the ten most recently created public repos
  def most_recently_created_repos(username = 'roychen25', num = 10)
    repo_list = github.repos.list(user: username).sort_by { |repo| Time.parse(repo['created_at']) }.reverse[0..num - 1]

    sleep 0.5

    repo_names = []
    repo_list.each { |repo| repo_names << repo['name'] }

    repo_names
  end

  # returns the names of the ten most recently modified public repos
  def most_recently_updated_repos(username = 'roychen25', num = 10)
    repo_list = github.repos.list(user: username).sort_by { |repo| Time.parse(repo['updated_at']) }.reverse[0..num - 1]

    sleep 0.5

    repo_names = []
    repo_list.each { |repo| repo_names << repo['name'] }

    repo_names
  end

  # returns the most recent commit messages for a specific repo
  def last_commit_messages(num = 10, username = 'roychen25', repo_name)
    commit_messages = []

    commits = github.repos.commits.list(username, repo_name).sort_by { |commit| commit['date'] }.reverse[0..num - 1]

    sleep 0.5

    commits.each { |commit| commit_messages << commit['commit']['message'] }

    commit_messages
  end
end

if $0 == __FILE__
  wrapper = GithubAPIWrapper.new

  # pp wrapper.most_recently_created_repos
  pp wrapper.most_recently_updated_repos

  pp wrapper.last_commit_messages(10, 'roychen25', 'assignment_bootstrap_sprint')
end
