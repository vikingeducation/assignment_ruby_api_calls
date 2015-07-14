require 'github_api'
require 'pry'

class GithubAuth

  attr_reader :github_user, :user_name

  def initialize
    @github_user = Github.new oauth_token: ENV['my_api']
    @user_name = @github_user.repos.list.first["owner"]["login"]
    #binding.pry
  end

  def print_names

    for index in (0...10) # First 10 repos

      # Gets and prints the name of the repositories
      puts @github_user.repos.list[index].name
      sleep 0.5
    end

  end

  def print_commits

    repo_names = []

    # Gets your username and the name of the repositories for which you want to print commits
    @github_user.repos.all.each { |repo| repo_names << repo["name"] }

    repo_names.each_with_index do |repo_name, index|

      all_commits = @github_user.repos.commits.list @user_name, repo_name
      puts "-" * 30
      puts "Current Repo: #{repo_names[index]}"
      sleep 0.5
      all_commits.each do |commit|
        commit_date = commit["commit"]["author"]["date"]
        puts "Commit message on: #{commit_date[0..9]}"
        puts ".................. #{commit["commit"]["message"]}"
        #binding.pry
      end
    end

  end

  def create_repo(name = 'forkcommithistory')

    @github_user.repos.create(name: 'forkcommithistory')

  end

  def create_file(repo = 'forkcommithistory', name = 'README.md')

    @github_user.repos.contents.create(user: @user_name, repo: repo, path: name)

  end

  def to_terminal(message)
    %x( message )
  end

end

g1 = GithubAuth.new

# g1.print_names
# g1.print_commits
# g1.github_user.repos.create(name: 'forkcommithistory')


