require 'github_api'
require 'awesome_print'

class GithubAPIWrapper
  TOKEN = ENV['GITHUB_TOKEN']

  def initialize
    @github = Github.new(oauth_token: TOKEN)
  end

  def render_recent_repo_names(user:, qty:)
    repos = get_recent_repos(user)
    repos = limit_repos(repos, qty)

    puts "The #{qty} Most Recent Repos for #{user}:"
    repos.each do |repo|
      puts "#{repo.name}: #{parse_date(repo.updated_at)}"
    end
  end

  private

  def get_recent_repos(user)
    response = @github.repos.list(user: user)
    response.body.sort_by { |repo| repo.updated_at }.reverse!
  end

  def limit_repos(repos, qty)
    repos.shift(qty)
  end

  def parse_date(date)
    Date.parse(date).strftime('%m-%d-%Y')
  end
end




github = GithubAPIWrapper.new

github.render_recent_repo_names(user: 'lortza', qty: 10)
# github.render_recent_repo_commits(user: 'lortza', qty: 10)
