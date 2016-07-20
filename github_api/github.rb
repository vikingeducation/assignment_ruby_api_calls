require_relative 'env'
require 'github_api'


class GithubApi

  def initialize(user_name)
    @user_name = user_name

  end


  def send_request
    Github.repos.list user: @user_name

  end





end


g = GithubApi.new("ChrisGoodson")
pp g.send_request
 