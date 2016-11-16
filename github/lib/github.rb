require 'github_api'
require 'httparty'
require 'pry'
require 'pry-byebug'


class GithubReader

  attr_reader :github, :user

  def initialize
    @github = Github.new(oauth_token: ENV["Github_API"])
    @user = 'sawyermerchant'
  end

  def get_repos
    @github.repos.list(per_page: 10) do |repo|
      sleep(0.1)
      # binding.pry
      puts repo.name
      github.repos.commits.list(user, repo.name) do  |commit|
        message = commit.commit.message
        date = commit.commit.author.date

        puts "Date #{date}, Message #{message}"
      end
    end
  end

end


g = GithubReader.new

g.get_repos