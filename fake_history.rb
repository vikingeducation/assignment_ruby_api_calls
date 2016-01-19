require 'github_api'
require 'byebug'
require 'pp'
require_relative 'github_figaro_setup'

class FakeHistory

  def initialize(username)
    @oauth_token = ENV["viking_github_api_key"]
    @username = username
    @github = Github.new(oauth_token: @oauth_token, user: username)
  end

  def create_repo
    @github.repos.create "name": 'private-repo-name',
    "description": "This is your first repo",
      "homepage": "https://github.com",
      "private": true,
      "has_issues": true,
      "has_wiki": true,
      "has_downloads": true
  end

  def get_commits(repo)
    @github.repos(repo: repo).commits.list.map { |commit|
       {date: commit.commit.committer.date,
        name: commit.commit.message }
     }
  end
end

fake = FakeHistory.new('kitlangton')
pp fake.get_commits('Private-Test')[0]
