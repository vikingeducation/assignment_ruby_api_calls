require 'github_api'
require 'envyable'
Envyable.load('config/env.yml', 'development')

class Ghub

  API_KEY = ENV['GITHUB_PAT']

  def initialize
    @github = Github.new :oauth_token => API_KEY
  end

  def show_repos
    repos = @github.repos.list(user: 'triedman99')[0..9].each do |repo|
      puts repo['name']
      #puts repo['created_at']
    end
    repos
  end

  def show_commits
    repos = show_repos
    repos.each do |repo|
      name = repo['name']
      commits = @github.repos.commits.list('triedman99', name)
      commit_arr = []
      commits.each do |commit|
        commit_arr << commit['commit']['message']
      end
      puts commit_arr
    end
  end

end

ghub = Ghub.new
ghub.show_repos
ghub.show_commits

