require 'github_api'
require 'pry'
require 'pry-byebug'

github = Github.new(oauth_token: ENV["Github_API"])

user = 'luke-schleicher'

github.repos.list(per_page: 10) do |repo|

  puts repo.name
  github.repos.commits.list(user, repo.name, per_page: 10) do  |commit|
    sleep(0.1)
    message = commit.commit.message
    date = commit.commit.author.date

    puts "Date #{date}, Message #{message}"
  end
  puts

end
