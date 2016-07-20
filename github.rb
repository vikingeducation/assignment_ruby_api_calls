require 'github_api'
require_relative './env2'

github = Github.new oauth_token: GITHUB_API_KEY

repos = github.repos.list sort: 'created' 

nap = Proc.new { sleep 0.4 }


repos[0..9].each do |repo| 
  puts repo.name
  nap.call
  commits = github.repos.commits.list('mnd-dsgn', repo.name)
  commits[0..9].each_with_index do |commit, idx|
    puts "Commit ##{commits.length - idx - 1}: #{commit['commit']['message']}"
  end
  nap.call
end