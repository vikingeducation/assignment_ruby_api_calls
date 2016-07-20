require 'octokit'
require 'pp'
require 'httparty'
require 'pry'



class GithubRepos

  def initialize()
    Octokit.auto_paginate = true
    @client = Octokit::Client.new(login: ENV['USERNAME'], password: ENV['PASSWORD'])
    p ENV['GIT_API_KEY']
    @user = @client.user
    @repos = Octokit.repos(@user.login).sort_by { |a| a[:created_at] }.reverse[0..9]
  end

  def print_commits
    last_ten_names = get_last_ten_names
    get_commit_messages.each_with_index do |repo, index|
      puts "Last few #{last_ten_names[index]} commits:"
      repo.each do |message|
        puts message
      end
    end
  end

  def get_last_ten_names
    names = []
    @repos.each do |repo|
      names << repo[:full_name]
    end
    names
  end

  def get_commit_messages
    @repos.map do |repo|
      commits = Octokit.commits(repo[:full_name]).map { |commit| commit.commit.message }
    end
  end
end

gh = GithubRepos.new
# p gh.get_commit_messages
gh.print_commits
#:commits_url].gsub('{/sha}', "/#{ENV['GIT_API_KEY']}")

