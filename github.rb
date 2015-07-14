
require 'github_api'
github = Github.new oauth_token: File.readlines('key.md')[1]
name = File.readlines('key.md')[2].to_s
puts name
# github.repos.list(user: 'shadefinale').each{|r| puts r["updated_at"]}
repos=[]

#Sorted by date list of repos

repos = github.repos.list(user: name, sort: 'created')#.map{|r| r[:name]}
repos = repos[0..9]

#10 latest commits for 10 repos
# repos=github.repos.list(user: 'ayva', sort: 'created')
# repos.each do |repo| 
#   puts repo.commits.list(user: 'ayva', sort: 'created')[0]
# end
repos.each do |reponame|
  sleep(1)
  github.repos.commits.list(name, reponame[:name]).each_with_index do |c, index|
    break if index >= 10
    p c["commit"]["message"]
  end
  puts "Next repo:"
end
#[0].commits.list(user: 'ayva', sort: 'created')

# Date.parse("2015-06-29T16:54:21Z")
#github.repos.list {|repo| p repo["updated_at"]}