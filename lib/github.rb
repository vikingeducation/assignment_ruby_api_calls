require "github_api"
require 'figaro'
require 'json'


Figaro.application = Figaro::Application.new(
  path: File.expand_path("./config/application.yml")
)
Figaro.load


github = Github.new oauth_token: ENV['GITHUB_KEY']
sleep(1)
repos = github.repos.list.sort_by{ |k| k.created_at }.reverse
users = github.users.get
username = ''
users.each do |user|
  username = user[1]
  break
end
p username

repos[0..9].each do |repo|
  puts repo.name
  commits = github.repos.commits.list(github.user, repo.name)
  commits
end
