require_relative 'env'
require 'github_api'
require 'pp'
require 'pry'


class GithubApi

  def initialize(user_name)
    @user_name = user_name
    @repos = send_request
  end


  def send_request
    Github.repos.list user: @user_name, sort: "forks", per_page: 10
  end

  def names
    @repos.map { |repo| repo.name }
  end

  def commit_messages
    @repos.map do |repo|
      repo.commits.each { |commit| commit.message }
    end
  end


end


g = GithubApi.new("ChrisGoodson")
binding.pry
p g.names
# p g.commit_messages
