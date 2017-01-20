require 'github_api'

github = Github.new oauth_token: ENV['GITHUB_API_KEY']
user = 'ats89'

all_repos = []
github.repos.list user do |repo|
  all_repos << [Time.strptime(repo.pushed_at, "%Y-%m-%dT%H:%M:%SZ"), repo]
end
sorted_repos = all_repos.sort_by { |time, repo| time }.reverse

# 10 latest repos
puts "#{'repo name:'.ljust(30)}Last push:"
sorted_repos[0..9].each do |repo_array|
  puts "#{repo_array[1].name.ljust(30)}#{repo_array[0]}"
end
puts 

# display 10 latest commits for those repos
sorted_repos[0..9].each do |repo_array|
  puts "Commits for #{repo_array[1].name}:"
  commits = github.repos.commits.list user, repo_array[1].name 
  commits.body.each_with_index do |c, index|
    puts "> #{c.commit.message} (#{c.commit.committer.date})" if index < 10
  end
  puts
  sleep(rand(3))
end