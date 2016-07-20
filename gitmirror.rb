require 'httparty'
require 'pp'
require 'octokit'
require 'pry'

class GitMirror
  include Octokit

  def initialize(user = "tgturner")
    @client = Octokit::Client.new(access_token: ENV['gh'])
    puts "What email address to you use with github?"
    @user_email = gets.strip
    @user = user
  end

  def get_forked_repos
    repos = @client.repositories(@user, sort: "pushed", per_page: 100).select{ |repo| repo.fork == true }
    times = list_commit_messages(repos)
    fake_commits(times)
  end

  def list_commit_messages(repos)
    repos.map do |repo|
      print "."
      sleep 0.5
      @client.commits(repo.id).map { |item| item[:commit][:author][:date] if item[:commit][:author][:email] == @user_email }.compact
    end
  end

  def fake_commits(times)
    times.each do |repo|
      repo.each do |commit_time|
        File.open("README.md", "a") { |f| f << "Private Commit: #{commit_time}" }
        %x(git add .)
        %x(GIT_COMMITTER_DATE='#{commit_time}' git commit --date='#{commit_time}' -m="Private Commit")
      end
    end
    %x(git push origin master)
  end

end

gh = GitMirror.new
pp gh.get_forked_repos
