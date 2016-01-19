require 'github_api'
require 'figaro'
require 'pp'

Figaro.application = Figaro::Application.new( {
  environment: "development",
  path:"./config/application.yml"} )
Figaro.load

github = Github.new(oauth_token: Figaro.env.github_key)

repo_list = github.repos.list user: 'koziscool'
repo_names = repo_list.map { |repo| repo['name'] }

repo_list.each do | repo |
  pp repo["name"], repo["pushed_at"]
end

test_time = Time.new(repo_list[0]["pushed_at"])
pp test_time
# pp repo_names
# a_repo = repo_list[0]

# commits = github.repos.commits.list 'koziscool', '134141414kjkjfksjafsakfjl', '...'

# commits.each do |commit|
#   puts commit["commit"]["message"]
# end



# commit_msgs = []
# repo_names.each do |name|
#   commit_list = github.repos.commits.get('jmazzy', name, '...')
#   commit_list = commit_list[0..9]
#   commit_msgs << commit_list.map { |commit| commit['message']}
# end
#
# pp commit_msgs
#
# # commit_list = github.repos.commits.list('jmazzy', 'assignment_ruby_api_calls')
# # pp commit_list
