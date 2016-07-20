require_relative 'env'
require 'github_api'
require 'pp'
require 'pry'


class GithubApi

  def initialize(user_name)
    @user_name = user_name
    send_request
  end


  def send_request
    @repos = Github.repos user: @user_name, sort: "forks", per_page: 10
  end

  def names
    @repos.list.map { |repo| repo.name }
  end

  def commit_messages
    @repos.commits.map { |repo| commits.list}
  end


end


g = GithubApi.new("ChrisGoodson")
p g.names
# p g.commit_messages
