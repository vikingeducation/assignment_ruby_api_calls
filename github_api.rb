require 'httparty'
require 'pp'
require 'octokit'

class GitHubAPI
  include Octokit

  def initialize
  end

  def list_ten_repos
    repos = Octokit.repositories("tgturner", per_page: 10, sort: "pushed")
    list_commit_messages(repos)
  end

  def list_commit_messages(repos)
    repos.map do |repo|
      sleep 0.5
      Octokit.commits(repo.id, per_page: 10).map { |item| item[:commit][:message] }
    end
  end

end

gh = GitHubAPI.new
pp arr = gh.list_ten_repos
pp arr[1].length
