
require 'github_api'
github = Github.new oauth_token: File.readlines('key.md')[1]

# github.repos.list(user: 'shadefinale').each{|r| puts r["updated_at"]}
repos = github.repos.list(user: 'shadefinale', sort: 'created').map{|r| r[:name]}
p repos[0..9]
# Date.parse("2015-06-29T16:54:21Z")
#github.repos.list {|repo| p repo["updated_at"]}