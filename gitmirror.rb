require 'httparty'
require 'pp'
require 'octokit'

class GitMirror
  include Octokit

  def initialize
    @client = Octokit::Client.new(access_token: ENV['gh'])

  end

  def get_forked_repos
    repos = @client.repositories("tgturner", sort: "pushed")
    repos.select{ |repo| repo[:owner][:fork] == true }
    # list_commit_messages(repos)

  end

  def list_commit_messages(repos)
    repos.map do |repo|
      sleep 0.5
      @client.commits(repo.id, per_page: 10).map { |item| item[:commit][:message] }
    end
  end

end

gh = GitMirror.new
pp arr = gh.get_forked_repos
# pp arr[1].length
