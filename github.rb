require 'github_api'
require 'rainbow'
require 'pp'

github = Github.new(oauth_token: ENV["VIKING_GITHUB_API_KEY"], user: 'kitlangton')

repo_names =  github.repos.list(sort: 'updated').first(10).map { |repo| repo.name }

repos =  repo_names.map do |repo_name|
  commits = github.repos.commits.list('kitlangton', repo_name)
  puts Rainbow(repo_name).white
  commits.first(10).each do |commit|
    puts "--#{commit.commit.message}"
  end
end
