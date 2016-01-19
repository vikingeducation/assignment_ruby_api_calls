require 'github_api'
require 'rainbow'
require 'pp'
require_relative 'github_figaro_setup'


class GithubPrinter


  def initialize(username)
    @oauth_token = ENV["viking_github_api_key"]
    @username = username
    @github = Github.new(oauth_token: @oauth_token, user: username)
  end


  def repo_names
    @repo_names ||= @github.repos.list(sort: 'updated').first(10).map { |repo| repo.name }
  end

  def print_repo_commit_history
    repo_names.map do |repo_name|
      puts Rainbow(repo_name).white
      commit_names_for_repo(repo_name).each do |msg|

        puts Rainbow(msg).cyan
      end
    end
  end


  def commit_names_for_repo(repo_name)
    sleep(0.5)
    @github.repos.commits.list(@username, repo_name).first(10).map {|commit| commit.commit.message}
  end

end

