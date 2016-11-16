require 'github_api'
require 'httparty'
require 'pry'
require 'pry-byebug'

github = Github.new(oauth_token: ENV["Github_API"])

user = 'sawyermerchant'

github.repos.list(per_page: 10) do |repo|
  # binding.pry
  puts repo.name
  github.repos.commits.list(user, repo.name) do  |commit|
    message = commit.commit.message
    date = commit.commit.author.date

    puts "Date #{date}, Message #{message}"
  end

end




# commits = commits.each do |commit|
#           message = commit.commit.message,
#           date = commit.commit.author.date
