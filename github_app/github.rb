require 'envyable'
require 'github_api'
require 'stamp'
require 'httparty'
require 'pry'
require 'json'

Envyable.load('env.yml')

class GitHubRepos

  def initialize
    @github = Github.new(oauth_token: ENV['GITHUB_API_KEY'], per_page: 10)
  end

  # Lists latest 10 repos
  def repos
    repos = @github.repos.list(user: 'siakaramalegos', sort: 'updated', direction: 'desc', page: 1, per_page: 10).body

    repos.each_with_index do |repo, index|
      puts '-' * 80
      date_string = repo.updated_at
      date = DateTime.parse(date_string).to_date
      puts "(#{index + 1}) #{repo.name}: #{repo.description} (updated: #{date.stamp('12/30/15')})"
    end
    puts '-' * 80
    repos
  end
end

g = GitHubRepos.new
# binding.pry
g.repos