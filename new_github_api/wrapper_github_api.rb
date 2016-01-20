require "github_api"
require "pp"

class WrapperGithubAPI

  attr_reader :api, :repos

  def initialize
    @api = Github.new oauth_token: ENV['new_token']
  end

  def get_repo_names
    @repos = @api.repos.list(:user => 'samok13')

    @repos = @repos.body.first(10)

    @repos.each do |repo|
      puts repo['name']
    end
  end

  def get_commits
    @repos.each do |repo|
      
      counter = 1

      commit_list = @api.repos.commits.list("#{repo['owner']['login']}", "#{repo['name']}")
      puts "Repository: #{repo['name']}"
      commit_list[0..9].each do |commit|
        sleep(0.5)
        puts "Commit log number #{counter}"
        pp commit['commit']['message']
        counter += 1
      end
    end
  end
end


