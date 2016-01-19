require 'github_api'
require 'figaro'
require 'pp'

Repo = Struct.new( :name, :push_time, :messages )

Figaro.application = Figaro::Application.new( {
  environment: "development",
  path:"./config/application.yml"} )
Figaro.load

github = Github.new(oauth_token: Figaro.env.github_key)

repo_list = github.repos.list user: 'koziscool'
repo_names = repo_list.map { |repo| repo['name'] }


our_list = repo_list.map do | repo |
  push_string = repo["pushed_at"]
  push_time = Time.new( push_string[0..3].to_i, push_string[5..6].to_i, push_string[8..9].to_i )

  new_repo = Repo.new( )
  new_repo.name = repo["name"]
  new_repo.push_time = push_time
  new_repo
end

our_list.sort! { |a, b| b.push_time <=> a.push_time }

our_list[0...10].each do |repo|
  puts
  pp repo["name"]
  commits = github.repos.commits.list 'koziscool', repo["name"], '...'
  commits.each do |commit|
    print "    "
    puts commit["commit"]["message"]
  end
end

