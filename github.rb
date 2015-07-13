
require 'github_api'


  

github = Github.new oauth_token: File.readlines('key.md')[1]

puts github.repos.list