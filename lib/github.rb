require 'github_api'
require 'awesome_print'
require 'pry'

class GithubAPIWrapper
  TOKEN = ENV['GITHUB_TOKEN']

  def initialize
    @github = Github.new(oauth_token: TOKEN)
  end

  def render_recent_repo_names(user:, qty:)
    repos = get_repos(user)
    repos = limit_by_qty(repos, qty)

    puts "The #{qty} Most Recent Repos for #{user}:"
    repos.each do |repo|
      puts "#{repo.name}: #{parse_date(repo.updated_at)}"
    end
  end

  def render_recent_repo_commits(user:, qty:)
    repos = get_repos(user)
    repos = limit_by_qty(repos, qty)

    repos.each do |repo|
      puts "","Commits for #{repo.name}"

      commits = get_commits(user, repo)
      commits = limit_by_qty(commits, qty)

      commits.each do |commit|
        puts " - #{commit.commit.message}"
      end
      sleep(1)
    end
  end

  private

  def get_repos(user)
    response = @github.repos.list(user: user)
    response.body.sort_by { |repo| repo.updated_at }.reverse!
  end

  def get_commits(user, repo)
    response = @github.repos.commits.list(user, repo.name)
    response.body
  end

  def limit_by_qty(collection, qty)
    collection.shift(qty)
  end

  def parse_date(date)
    Date.parse(date).strftime('%m-%d-%Y')
  end
end


github = GithubAPIWrapper.new

github.render_recent_repo_names(user: 'lortza', qty: 10)
github.render_recent_repo_commits(user: 'lortza', qty: 3)
