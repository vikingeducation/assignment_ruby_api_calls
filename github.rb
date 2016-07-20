require 'github_api'
require 'pp'

class GithubAPI

  def initialize
    @github = Github.new
  end

  def user_repositories(name)
    @github.repos.list user: name
  end


  def ten_latest_repos(name)
    array = []
    response = user_repositories(name)
    response.each_page do |page|
      page.each do |repo|
         array << ["#{repo.updated_at}: #{repo.name} : #{repo.base_url}"]
      end
    end
    p array.sort.reverse[0..9]
  end


end



g = GithubAPI.new
g.ten_latest_repos("lynchd2")