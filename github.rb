require 'github_api'
require 'pry'

class GithubAuth

  def initialize
    @github_user = Github.new oauth_token: ENV['my_api']
    binding.pry
  end

  def print_names

    for index in (0...10) # First 10 repos

      # Gets and prints the name of the repositories
      puts @github_user.repos.list[index].name
      sleep 0.5
    end

  end

  def print_commits

    commits_info = []

    10.times do |i| # First 10 repos

      # Gets your username and the name of the repositories for which you want to print commits

      commits_info << [
                  @github_user.repos.list[i]["owner"]["login"],
                  @github_user.repos.list[i].name
      ]

      puts "Grabbing repo names... Please wait"

    end

    for index in (0...10)

      commits = @github_user.repos.commits.list commits_info[index][0], commits_info[index][1]
      puts "-" * 30
      puts "Current Repo: #{commits_info[index][1]}"
      sleep 0.5
      for idx2 in (0...10)
        puts commits[idx2]["commit"]["message"]
        break if commits[idx2+1].nil?
        #binding.pry
      end
    end

  end

end

g1 = GithubAuth.new

#g1.print_names
# g1.print_commits
