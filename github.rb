require 'github_api'
require 'pp'

class GitThing

  TOKEN = ENV["GITHUB_TOKEN"]

  def initialize
    @github = Github.new oauth_token: TOKEN
    @sorted_repo_array = []
  end

  def recent_repos
    @sorted_repo_array = @github.repos.list.sort_by {|item| item.created_at }
    (@sorted_repo_array.length-1..@sorted_repo_array.length-10).map {|i| @sorted_repo_array[i]}
  end

  def recent_commits
    recent_repos.each do |repo|
      commits = @github.repos.commits.list 'gweinert', repo.name
      puts "Repo: #{repo.name}"
      commits.each_with_index do |commit, commit_num|
        puts "      commit #{commit_num}: #{commit.commit.message}"
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
    @github = Github.new oauth_token: TOKEN
  end

  def create_new_repo(repo_name = "forkcommithistory")
    @github.repos.create name: "#{repo_name}"
  end

  def clone_git_repo(repo_name = "forkcommithistory")
    repo = @github.repos.get 'facingsouth', repo_name
    `git clone #{repo.html_url} ~/Desktop/VCS/#{repo_name}`
  end

  def commit_to_repo(repo_name = "forkcommithistory", 
                     file_name = "README.md", 
                     file_path = "README.md", 
                     new_content)
    file = contents.find 'facingsouth', repo_name, file_path
    contents.create 'facingsouth', repo_name, file_path, 
                path: file_path, 
                message: "New commit", 
                content: new_content, 
                sha: file.sha
  end

  def get_commit(repo_name = "project_dom_tree")
    commits = @github.repos.commits.list 'facingsouth', repo_name

  end

end






