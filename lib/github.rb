require "github_api"
require 'figaro'
require 'json'


Figaro.application = Figaro::Application.new(
  path: File.expand_path("./config/application.yml")
)
Figaro.load

github = Github.new  oauth_token: ENV['GITHUB_KEY']

 repos = github.repos.list.sort_by{ |k| k.created_at }.reverse

 repos[0..9].each do |repo|
   puts repo.name
   puts repo.created_at
 end
