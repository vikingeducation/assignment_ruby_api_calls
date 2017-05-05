require 'github_api'
require 'envyable'

Envyable.load('config/env.yml')
github = Github.new oauth_token: ENV['OAUTHTOKEN']
all_repos =  github.repos.list
-1.downto(-10) do |n|
  sleep(1)
  puts "===================================================="
  puts all_repos[n]
  all_commits = github.repos.commits.list user: "annallan", repo: "#{all_repos[n]["name"]}", sha: "master"
  if all_commits.length > 10
    -1.downto(-10) do |m|
      sleep(1)
      puts "++++++++++++++++++++++++++++++++++++"
      puts all_commits[m]
    end
  else
    all_commits.each do |commit|
      puts "++++++++++++++++++++++++++++++++++++"
      puts commit
    end
  end
end
