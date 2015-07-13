
require 'github_api'
github = Github.new oauth_token: File.readlines('key.md')[1]

# github.repos.list(user: 'shadefinale').each{|r| puts r["updated_at"]}
repos=[]

#Sorted by date list of repos
#repos=github.repos.list(user: 'shadefinale', sort: 'created').map{|r| r[:name]}
#p repos[0..9]

#10 latest commits for 10 repos
# repos=github.repos.list(user: 'ayva', sort: 'created')
# repos.each do |repo| 
#   puts repo.commits.list(user: 'ayva', sort: 'created')[0]
# end
puts github.repos.commits.list('ayva', 'assignment_ruby_api_calls')[0]['commit']['message']
#[0].commits.list(user: 'ayva', sort: 'created')

# Date.parse("2015-06-29T16:54:21Z")
#github.repos.list {|repo| p repo["updated_at"]}