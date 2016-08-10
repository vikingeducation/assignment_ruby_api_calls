require 'github_api'


class Ghub
  API_KEY = ENV["GITHUB_API_KEY"]
  def initialize
    @github = Github.new :oauth_token => API_KEY
  end

  def show_repos
    repos = @github.repos.list user: 'branliang'
    sorted = repos.sort { |b, a| a["created_at"] <=> b["created_at"] }
    # ten_latest_repos = sorted[0..9]
    sorted[0..9].each do |repo|
      puts repo["created_at"]
      puts repo["name"]
    end
    # return ten_latest_repos
  end

  def show_commits
    repos = show_repos
    repos.each do |repo|
      all_commits = @github.repos.commits.list "#{repo["owner"]["login"]}", "#{repo["name"]}"
      sorted = all_commits.sort { |b, a| a["commit"]["committer"]["date"] <=> b["commit"]["committer"]["date"] }
      ten_latest_commits = sorted[0..9]
      ten_latest_commits.each do |commit|
        puts commit["commit"]["committer"]["date"]
        puts commit["commit"]["message"]
      end
    end
  end

end

ghub = Ghub.new
# ghub.show_repos
ghub.show_commits
