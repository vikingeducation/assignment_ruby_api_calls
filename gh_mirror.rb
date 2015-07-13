require 'github_api'
github = Github.new oauth_token: File.readlines('key.md')[1]
name = File.readlines('key.md')[2]
# Make repository with api?
options = {
  "user" => name,
  "name"=> "forkcommithistory",
  "description"=> "Mirror commits to forks",
  "homepage"=> "https://github.com",
  "private"=> false,
  "has_issues"=> true,
  "has_wiki"=> true,
  "has_downloads"=> true
}
#Repo created
# begin
#   github.repos.create(options)
# rescue
#   puts "Repo already exists...."
# end

# options_com = {
#   "message" => "Commit made via API"
# }
# #Post a commit
# github.repos("name"="forkcommithistory").commits.create(options_com)
# github.repos.commits.list(name, 'assignment_ruby_warmup').each do |c|p c['sha']
#   p c['commit']['author']['date']
# end

contents = Github::Client::Repos::Contents.new oauth_token: File.readlines('key.md')[1]

file = contents.find user: name, repo: "forkcommithistory", path: 'README.md'
contents.create name, "forkcommithistory", 'README.md',
path: 'README.md',
message: 'Commit made via API',
content: 'Olga & Donald assignment',
sha: file.sha,
commit: {author: {name: "Monica", email: "m@gmail.com", date: "2015-04-04"}}
#date: "2011-04-14T16:00:49Z"

github.repos.commits.list(user: name, repo: "forkcommithistory")

