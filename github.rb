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


# contents = Github::Client::Repos::Contents.new oauth_token:TOKEN
# create new file in the repo
# contents.create 'facingsouth', 'forkcommithistory', 'forkcommithistory/README.md', path: 'forkcommithistory/README.md', message: 'commit from github gem', content: "# forkcommithistory\nThis is my fork commmit history!\nsomething new!!"

# update file in a repo
# find the file
# file = contents.find 'facingsouth', 'forkcommithistory', 'README.md'
# update it
# contents.create 'facingsouth', 'forkcommithistory', 'README.md', 
                # path: 'forkcommithistory/README.md', 
                # message: 'commit from github gem, change README', 
                # content: "# forkcommithistory\nThis is my fork commmit history!\nsomething new!!", 
                # sha: file.sha



class MakeGitRepo

  def initialize
    @github = Github.new oauth_token: "396a1c70604556a4bbdad7e226abe00be65a4c8e"
  end

  def create_new_repo(repo_name = "forkcommithistory")
    @github.repos.create name: "#{repo_name}"
  end

  def clone_git_repo(repo_name = "forkcommithistory")
    repo = @github.repos.get 'facingsouth', repo_name
    `git clone #{repo.html_url} ~/Desktop/VCS/#{repo_name}`
  end

end

m = MakeGitRepo.new
m.clone_git_repo






