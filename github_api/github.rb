require 'github_api'
require 'pry'

github = Github.new oauth_token: ENV['GITHUB_TOKEN'] 

# p github.repos.list.first(1).first.class

repos = github.repos.list.sort_by {|repo| repo['created_at']}

# repos_commits = github.repos.list.first(10).each_with_object({}) do |repo, object|
   
#    name = repo['name']

#    sha = repo['sha']
#    commits = github.repos.commits.list('essian', name)
#    object[name] = commits
#    binding.pry
# end

# puts github.repos.commits.list 'essian', 'project_dom_tree'

# commits = github.repos.commits.list 'user-name', 'repo-name'
# puts commits

# repos.each do |repo|
#   puts repo.class
#   commits = repo.commits
#   puts commits
# end

