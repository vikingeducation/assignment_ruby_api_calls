
require 'httparty'
require 'github_api'
require 'pp'

# OAuth=885ca77261fdefe88780fabf24e651a41ba53c98

class GitHubRepo

  include HTTParty

  BASE_URI = "https://api.github.com/users/whatever"
  # https://api.github.com/users/whatever?client_id=xxxx&client_secret=yyyy
  API_KEY = ENV["OAuth"]


  def initialize
    @options = {query:{client_id: "Visiona", client_secret: API_KEY}}
  end

  def get_raw_response
    puts "DBG: HTTParty.get(BASE_URI, @options) = #{HTTParty.get(BASE_URI, @options).inspect}"
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
    # github = Proc.new { sleep 0.5 }
    sorted_repos = sort_repos
    (sorted_repos.length-1).downto(sorted_repos.length - 11) do |idx|
      z = sorted_repos[idx]['commits_url']
      puts "DBG: sorted_repos[idx]['name'] = #{sorted_repos[idx]['name'].inspect}"
      puts "DBG: z = #{z}.inspect}"
      github.repos.commits.list( "Visiona", sorted_repos[idx]['name'], sha: sorted_repos[idx]["commits_url"].match(/sha/)[0]) { |commit|  puts "DBG: commit = #{commit.inspect}" }
    end
  end

end

g = GitHubRepo.new
# pp g.get_repos
# g.get_repos
# pp g.print_10_latest_repos
pp g.get_commits