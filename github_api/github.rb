require 'github_api'


github = Github.new oauth_token: ENV['GITHUB_TOKEN'] 

# p github.repos.list.first(1).first.class

# repos = github.repos #.list.first(10)
# puts repos.commits

commits = github.repos.commits.list 'user-name', 'repo-name'
puts commits

# repos.each do |repo|
#   puts repo.class
#   commits = repo.commits
#   puts commits
# end

