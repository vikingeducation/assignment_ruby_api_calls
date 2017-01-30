require 'github_api'

github = Github.new(oauth_token: ENV['GH'], per_page: 10)

repos = github.repos.list(user: 'yxlau', sort: 'updated')

puts "Latest Repos:"
repos.each do |r|
  puts r.name.upcase
  sleep 1
  commits = github.repos.commits.list('yxlau', r.name)
  counter = 0
  commits.each do |c|
    break unless c
    break if counter == 10
    puts "  Date: #{c['commit']['author']['date']}"
    puts "    #{c['commit']['message']}"
    counter += 1
  end
  puts
end
