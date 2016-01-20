require_relative 'github_https.rb'
require_relative 'github_parser.rb'
require 'pp'

response = GithubHttps.new
raw_repo_list = response.list_repos
raw_commit_history = response.list_commits

puts "Last 10 Repositories:\n"
pp response.parse_repos(raw_repo_list)

puts "Up to last 10 commits for 10 recent repos:\n"
pp response.parse_commits(raw_commit_history)
