require 'github_api'
require 'httparty'
require 'pry'
require 'pry-byebug'

github = Github.new(oauth_token: ENV["Github_API"])


github.repos.list(per_page: 10) do |repo|
  # binding.pry
  puts repo.name
  p repo.commit    #.message
  # repo.commits.list do |e|
  #   put repo.commits
  # end
end




# commits = commits.each do |commit|
#           message = commit.commit.message,
#           date = commit.commit.author.date
