require 'github_api'
require 'pp'

class GitThing

  TOKEN = ENV["GIT_TOKEN"]

  def initialize
    @github = Github.new oauth_token: TOKEN
    @sorted_repo_array = []
    @short_repo_arr =[]
    recent_repos
  end

  def recent_repos
    @sorted_repo_array = @github.repos.list.sort_by {|item| item.created_at }
    i = @sorted_repo_array.length - 1 
    10.times do 
      # puts @sorted_repo_array[i].name
      @short_repo_arr << @sorted_repo_array[i]
      i -= 1
    end
  end

  def recent_commits
    commit_num = 1
    commits = @github.repos.commits.list 'gweinert', 'assignment_ruby_api_calls'
    # print "@short_repo_arr.inspect"
    @short_repo_arr.each do |repo|
      commit_num = 1
      sleep(2)
      commits = @github.repos.commits.list 'gweinert', repo.name
      print "Repo: #{repo.name}\n"
      commits.each do |commit|
        print "      commit #{commit_num}: #{commit.commit.message}\n" 
        commit_num += 1
      end
    end
  end

end