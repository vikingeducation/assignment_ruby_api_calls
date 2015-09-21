require 'github_api'

token = ENV["API_KEY"]
username = ENV["USERNAME"].downcase
password = ENV["PASSWORD"]

def repo_names(repos, num=-1)
  names = []
  repos.each_with_index do |repo, i|
    break if i==num
    names << repo.name
  end
  names
end
#how to sort by date
#repos.sort_by {|attribute, value| }

def repo_commits(username, repo_name)
  Github.repos.commits.list(username, repo_name)
end

# setting up github_api instance
github = Github.new oauth_token: token
repos = github.repos.list user: username
names = repo_names(repos, 10)

# printing repo names
puts "REPOS: "
names.each do |name|
  print "#{name}\n"
end

# printing commit messages
puts "COMMITS: "
names.each do |name|
  puts name
  commits = repo_commits(username, name)
  commits.each do |commit|
    message = commit[:commit][:message]
    puts message
  end
  puts "-------------"
end