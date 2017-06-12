require 'github_api'
require 'envyable'
require 'pry'

Envyable.load('config/env.yml')
Hashie.logger = Logger.new(nil)

USER_NAME = 'SeanLuckett'.freeze

g = Github.new oauth_token: ENV['GITHUB_API_KEY']

repos = g.repos.list[0..9].map { |repo| repo['name'] }

puts 'Repo names:'
puts repos

repos.each do |repo_name|
  puts "Last 10 commit messages for #{repo_name}:"
  commits = g.repos
              .commits
              .list(USER_NAME, repo_name)
              .map { |c| c['commit']['message'] }
  commit_num = commits.count
  puts commits[(commit_num - 10)..-1]
  puts "\n\n"
  sleep 0.5
end

