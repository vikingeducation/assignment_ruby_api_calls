require 'github_api'


github = Github.new oauth_token: ENV['GITHUB_TOKEN'] 

p github.repos.list.first(1).first.class