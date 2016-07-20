require 'github_api'
require 'pp'
require 'pry'
require_relative 'env.rb'



class GitMirrorMaker


  def send_request(user_name)
    Github.new user: user_name, oauth_token: API_KEY
  end

  def create_mirror(git)
    git.repos.create "name": 'git_mirror',
      "description": "This is a mirror of commits",
      "auto_init": true
  end

  def clone_mirror(user)
    url = "https://github.com/#{user}/git_mirror"
    %x( git clone "#{url}" )
  end


  # commit object
  def find_commit(git, repo_name, sha)
    repo_name = "assignment_ruby_api_calls"
    git.repos.commits.get repo: repo_name, sha: sha
  end

  def get_commit_date(target)
  # pull date from commit
    target.commit.author.date
  end

  def write_to_readme(commit_date)
    File.open("./git_mirror/README.md", 'a') do |file|
      file.write(commit_date)
    end
  end

  def set_env_dates(date)
    %x( export GIT_COMMITER_DATE=#{date}'\n' )
    %x( export GIT_AUTHOR_DATE=#{date}'\n' )
    puts %x( echo #{date} )
  end

  def git_add
    %x( git add -A)
  end
  # --date specifies the author date
  def git_commit(message="")
    %x( git commit -m=#{message} )
  end

  def git_push
    %x( git push origin master )
  end

end


repo_name = "assignment_ruby_api_calls"
sha = "a55d50cc1806c797957aaac761804ac1f0445a65"
gm = GitMirrorMaker.new
git_api = gm.send_request("leosaysger")
# gm.create_mirror(git)
# gm.clone_mirror('leosaysger')
commit = gm.find_commit(git_api, repo_name, sha)
date = gm.get_commit_date(commit)
# gm.write_to_readme(date)
gm.set_env_dates(date)
# gm.git_add
# gm.git_commit("this is a message")
