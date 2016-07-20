require 'httparty'
require 'pp'
require 'github_api'
require 'octokit'

class GitHubAPI
  attr_reader :client

  def initialize
    @client = Octokit::Client.new(:access_token => ENV['gh'])
  end
end