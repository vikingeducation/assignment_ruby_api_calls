require 'httparty'
require 'pp'
require 'octokit'
require 'pry'

class GitMirror
  include Octokit

  def initialize(user = "tgturner")
    @client = Octokit::Client.new(access_token: ENV['gh'])
    @user = user
  end

  def get_forked_repos
    repos=@client.repositories(@user, sort: "pushed", per_page: 100).select{ |repo| repo.fork == true }
    # list_commit_messages(repos)

  end

  def list_commit_messages(repos)
    repos.map do |repo|
      print "."
      sleep 0.5

      @client.commits(repo.id).map do |item| 
        begin
        if login = item[:author][:login] == @user
          item[:commit][:author][:date]
        else
          "Wrong!"
        end
        rescue
          binding.pry
        end
      end

    end
  end

end

gh = GitMirror.new
arr = gh.get_forked_repos
pp gh.list_commit_messages(arr)
