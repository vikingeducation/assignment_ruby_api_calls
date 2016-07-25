require 'github_api'
require 'pry'

class MyGithub
  attr_accessor :github
  def initialize
    @github = Github.new({oauth_token: ENV["GITHUB_OAUTH"], per_page: 60 })
  end

  def last_10
    repo_list = github.repos(user: 'grcdeepak1').list.to_a
    repos = repo_list.sort_by! { |item| item["created_at"] }.reverse![0..9]
    commits_hash = {}
    repos.each do |repo|
      name = repo["name"]
      commits = github.repos.commits.list('grcdeepak1', name)
      arr = []
      commits.each do |commit|
        arr << commit['commit']['message']
      end
      commits_hash[name] = arr
    end
    return repos, commits_hash
  end
end


# repos, commits_hash = MyGithub.new.last_10
# binding.pry
# puts