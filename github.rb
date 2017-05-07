require 'envyable'
require 'github_api'
require 'pp'
require 'pry'

git = Github.new(oauth_token: ENV["GITHUB_API_KEY"])

repos = git.repos.list user: "chadl76"


1.upto(10) do |x|
	puts repos[x]
	end


