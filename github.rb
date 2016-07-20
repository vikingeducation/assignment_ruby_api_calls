require_relative './env2'
require 'github_api'

github = Github.new oauth_token: GITHUB_API_KEY

repos = github.repos.list
p repos[0]['blobs_url']
