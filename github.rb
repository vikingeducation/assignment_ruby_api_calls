require 'envyable'
require 'github_api'
require 'pp'
require 'pry'

git = Github.new(oauth_token: ENV["GITHUB_API_KEY"])

repos = git.repos.list user: "chadl76"

(0..9).each do 
 repos.body.each do |repo|
 	puts repo
 end
end
