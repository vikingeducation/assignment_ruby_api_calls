require 'octokit'
require 'pp'
require 'httparty'
require 'pry'



class GithubRepos

  def initialize()
    Octokit.auto_paginate = true
    @client = Octokit::Client.new(:access_token => ENV['GIT_API_KEY'])
    @user = @client.user
    @repos = Octokit.repos(@user.login).sort_by { |a| a[:created_at] }.reverse[0..9]
  end

  def get_last_ten_names
    @repos.each do |repo|
      repo[:full_name]
    end
  end

  def get_commit_messages
    @repos.map do |repo|

      Octokit.commits(repo[:full_name]).map { |commit| commit.commit.message }
    end
  end
end

gh = GithubRepos.new
p gh.get_commit_messages
#:commits_url].gsub('{/sha}', "/#{ENV['GIT_API_KEY']}")

