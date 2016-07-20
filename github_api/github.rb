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
    @repos = Github.repos user: @user_name, sort: "created"
    # binding.pry
  end

  def names
    @repos.list.sort_by{ |repo| repo.created_at }.reverse![0..9]
      .map { |repo| repo.name }
  end

  def commit_messages(names)
    names.map do |name|
      # binding.pry
      @repos.commits.all repo: name
    end
  end

  # def get_ids
  #   @repos.a
  # end


end


g = GithubApi.new("ChrisGoodson")
p g.commit_messages(g.names)
# p g.commit_messages
