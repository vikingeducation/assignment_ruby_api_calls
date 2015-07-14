require 'github_api'
require 'time'
github = Github.new oauth_token: File.readlines('key.md')[1]
token = File.readlines('key.md')[1]
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
#Post a commit
# github.repos("name"="forkcommithistory").commits.create(options_com)

# github.repos.commits.list(name, 'assignment_ruby_warmup').each do |c|p c['sha']
#   p c['commit']['author']['date']
# end

commits = github.repos.commits.list(name, 'forkcommithistory')
target_dates = commits.map {|c| c['commit']['author']['date']}


script = ""
target_dates.each do |target_date|
  new_date = (Time.parse(target_date) - 8000000).utc.iso8601.to_s

  script += "echo #{new_date}>> README.md\ngit add .\ngit commit --date=\"#{new_date}\" -m=\"Spoof\"\n"
end
file = File.open("script.sh", "w")
file.write(script)
file.close


# binding.pry

# contents = Github::Client::Repos::Contents.new oauth_token: File.readlines('key.md')[1]

# file = contents.find user: name, repo: "forkcommithistory", path: 'README.md'

# #github.repos.list(name, "forkcommithistory")

# #opts = {"tree" => file.sha, "author" => {"name" => name, "email" => "shadefinale@gmail.com", "date" => "2015-04-04"}}

# contents.update name, "forkcommithistory", 'README.md',
# path: 'README.md',
# message: first_commit['commit']['message'],
# content: 'Olga & Donald assignment test',
# sha: file.sha,
# author: {name: name, email: "shadefinale@gmail.com", date: "2011-04-14T16:00:49Z"},
# commit: {committer: {name: name, email: "shadefinale@gmail.com", date: "2011-04-14T16:00:49Z"}},
# date: "2011-04-14T16:00:49Z"

# # github.repos.commits.list(user: name, repo: "forkcommithistory")

