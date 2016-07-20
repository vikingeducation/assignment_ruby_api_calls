require 'github_api'
require 'pp'
require 'pry'

class GithubAPI

  GITHUB_API_KEY = ENV["GITHUB_API_KEY"]

  def initialize
    @github = Github.new(oauth_token: GITHUB_API_KEY)
  end

  def user_repos(name)
    @github.repos.list user: name
  end

  def ten_latest_repos(name)
    array = []
    response = user_repos(name)
    response.each_page do |page|
      page.each do |repo|
        array << [repo.created_at, repo.name, repo.html_url]
      end
    end
    array.sort.reverse[0..9]
  end

  def ten_latest_repo_commits(name)
    hash = {}
    response = ten_latest_repos(name)
    response.each do |repo|
      hash[repo[1]] = commits(name, repo[1])
    end
    hash.each do |k,v| 
      puts k +  ":#{v}"
      puts
    end
  end

  def commits(name, repo)
    array = []
    response = @github.repos.commits.list name, repo, sha: ''
    response.each_page do |page|
      page.each do |repo|
         array << "#{repo.commit.committer.date} : #{repo.commit.message}"
      end
    end
    array.sort.reverse[0..9]
  end


end



g = GithubAPI.new
# g.ten_latest_repos_display("asackofwheat")
# pp g.user_repos("asackofwheat")
# p g.commits("asackofwheat", "assignment_web_scraper")
g.ten_latest_repo_commits("asackofwheat")