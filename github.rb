require 'github_api'
require 'pp'
require 'pry'

class GithubAPI

  GITHUB_API_KEY = ENV["GITHUB_API_KEY"]

  def initialize
    @github = Github.new
  end

  def user_repos(name)
    @github.repos.list user: name
  end


  def ten_latest_repos_display(name)
    array = []
    ten_latest_repos(name).each do |repo|
         array << ["#{repo.created_at}: #{repo.name} : #{repo.html_url}"]
      end
    p array.sort.reverse[0..9]
  end

  def ten_latest_repos(name)
    array = []
    response = user_repos(name)
    response.each_page do |page|
      sleep 0.5
      page.each do |repo|
        array << repo
      end
    end
    p array
  end

  def ten_latest_repo_commits(name)
    hash = {}
    response = user_repos(name)
    response.each_page do |page|
      sleep 0.5
      page.each do |repo|
        hash[repo.name] = commits(name, repo.name)
      end
    end
    p hash
  end

  def commits(name, repo)
    array = []
    response = @github.repos.commits.list name, repo, sha: ''
    response.each_page do |page|
      sleep 0.5
      page.each do |repo|
         array << ["#{repo.commit.message}"]
      end
    end
    array.sort.reverse[0..9]
  end


end



g = GithubAPI.new
# g.ten_latest_repos("asackofwheat")
# pp g.user_repos("asackofwheat")
g.commits("asackofwheat", "assignment_web_scraper")
g.ten_latest_repo_commits("lynchd2")