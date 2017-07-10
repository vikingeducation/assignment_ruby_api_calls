require_relative "githubapi/version"
# contains access token
require_relative "githubapi/access_token"


class GithubClient

  # module that contains access token
  include AccessToken


  def initialize(delay=rand(0..5), user_name='MariahAcacia', token=TOKEN, repo_array=[], number_of_entries=10)
    @delay = delay
    @user_name = user_name
    @token = token
    @repo_array = repo_array
    @num = number_of_entries
    @github = Github::Client.new oauth_token: @token
    @repos_and_commits = {}
  end


  # finds repos
  def find_repos
    repos_list = @github.repos.list user: @user_name, sort: "created"
    repos_response = repos_list.body
    repos_response.take(@num).each do |hash|
      @repo_array << hash["name"]
      sleep @delay
    end
  end


  # find commit messages based on repos found or can pass in array of repo names you want commit messages for
  def find_commits(repos=@repo_array)
   repos.each do |repo|
     commit_list = @github.repos.commits.list user: @user_name, repo: repo
     @repos_and_commits[repo] = commit_list.body.to_s.scan(/message="([^"]*)"/)
     sleep @delay
   end
  end


  # prints repo name and the commit messages
  def print(hash=@repos_and_commits)
    hash.each do |repo, commits|
      puts "REPO NAME: #{repo}"
      puts "COMMITS MESSAGE:"
      commits.each do |commit|
        puts commit
      end
    end
  end


end


n = GithubClient.new
n.find_repos
n.find_commits
n.print
