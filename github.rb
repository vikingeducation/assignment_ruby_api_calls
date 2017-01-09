require 'github_api'


the_repos = Hash.new

github = Github.new oauth_token: ENV["GITHUB_API_TOKEN"]

all_repos = github.repos.list user: 'banalui'
all_repos.body.each do |repo|
	year = repo["created_at"][0..3].to_i
	month = repo["created_at"][5..6].to_i
	day = repo["created_at"][8..9].to_i
	hour = repo["created_at"][11..12].to_i
	min = repo["created_at"][14..15].to_i
	t = Time.mktime(year, month, day, hour, min)
	the_repos[t] = repo["name"]
end

sorted_repos = the_repos.sort_by { |date, name| date }.reverse

i = 0
sorted_repos.each do |key, value|
	p "#{key.to_s[0..15]} => #{value}"
	all_commits = github.repos.commits.list 'banalui', value
	the_commits = Hash.new
	all_commits.body.each do |commit|
		full_date = commit["commit"]["author"]["date"]
		year = full_date[0..3].to_i
		month = full_date[5..6].to_i
		day = full_date[8..9].to_i
		hour = full_date[11..12].to_i
		min = full_date[14..15].to_i
		t = Time.mktime(year, month, day, hour, min)
		the_commits[t] = commit["commit"]["message"]
	end
	sorted_commits = the_commits.sort_by { |date, message| date }.reverse
	j = 0
	sorted_commits.each do |time, commit_message|
		puts "\t#{time.to_s[0..15]} => #{commit_message}"
		j += 1
		break if j == 10
	end
	i += 1
	break if i == 10
end