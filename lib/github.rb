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

repos[0..9].each do |repo|
  puts
  puts "------------------------------------"
  puts repo.name
  puts "------------------------------------"
  puts
  commits = github.repos.commits.list(users.login, repo.name)
  commits = commits.map do |commit|
              { message: commit.commit.message,
                date: commit.commit.created_at }
            end.sort_by{ |k| k[:date] }.reverse

  commits[0..9].each do |commit|
    puts "\t" + commit[:message]
  end
end
