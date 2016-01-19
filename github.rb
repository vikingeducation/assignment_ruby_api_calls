require 'github_api'
require 'figaro'
require 'pp'

Figaro.application = Figaro::Application.new( {
  environment: "development",
  path:"./config/application.yml"} )
Figaro.load

github = Github.new(oauth_token: Figaro.env.github_key)

repo_list = github.repos.list user: 'jmazzy'
repo_list = repo_list
repo_names = repo_list.map { |repo| repo['name'] }

pp repo_names

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
