require 'github_api'
require 'httparty'


github = Github.new(oauth_token: ENV["Github_API"])


p github.repos.list