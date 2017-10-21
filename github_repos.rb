
require 'httparty'
require 'github_api'
require 'pp'
require 'pry'

class GitHubRepo

  include HTTParty

  BASE_URI = "https://api.github.com/users/whatever"
  API_KEY = ENV["OAuth"]


  def initialize
    @options = {query:{client_id: "Visiona", client_secret: API_KEY}}
  end

  def get_raw_response
    HTTParty.get(BASE_URI, @options)
  end

  def date_format(json_date)
    Date.iso8601(json_date).strftime('%Y %m %d')
  end

  def get_repos
    github = Github.new
    github.repos.list( {user: 'Visiona'} ) { |repo| repo }
  end

  def sort_repos
    repo_list = get_repos
    repo_list.sort_by!{|hash| hash['created_at']}
    repo_list
  end

  def print_10_latest_repos
    sorted_repos = sort_repos
    (sorted_repos.length-1).downto(sorted_repos.length - 11) {|idx| puts "#{date_format(sorted_repos[idx]['created_at'])} - #{sorted_repos[idx]['name']}" }
  end

  def get_commits
    github = Github.new 
    sorted_repos = sort_repos
    (sorted_repos.length-1).downto(sorted_repos.length - 11) do |idx|
      puts "******#{date_format(sorted_repos[idx]['created_at'])} - #{sorted_repos[idx]['name']}"
      github.repos.commits.list( "Visiona", sorted_repos[idx]['name'], get_sha(sorted_repos[idx]['name'])) { |commit|  puts commit["commit"]["message"] } 
    end 
  end

  # binding.pry 

  def get_sha(repo_name)
    github = Github.new
    s = github.git_data.references.list 'Visiona', repo_name
    s.body[0]["object"]["sha"]
  end

end

g = GitHubRepo.new
# pp g.get_repos
# g.get_repos
# pp g.print_10_latest_repos
pp g.get_commits