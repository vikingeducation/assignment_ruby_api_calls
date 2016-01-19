require 'github_api'
require 'byebug'
require 'pp'
require_relative 'github_figaro_setup'

class FakeHistory

  def initialize
    @oauth_token = ENV["viking_github_api_key"]
    @github = Github.new(oauth_token: @oauth_token)
  end

  def create_repo
    @github.repos.create "name": 'mirror-repo',
    "description": "This is your mirror repo",
      "homepage": "https://github.com",
      "private": false,
      "has_issues": true,
      "has_wiki": true,
      "has_downloads": true
  end

  def find_mirror_repo
      return @github.repos(user: 'kitlangton', repo: 'mirror-repo').get
    rescue
      false
  end

  def mirror_repo
    find_mirror_repo || create_repo
  end


  def get_commits(repo)
    @github.repos(user: 'kitlangton', repo: repo).commits.list.map { |commit|
       {date: commit.commit.committer.date,
        name: commit.commit.message }
     }
  end

  def clone_mirror
    `git clone #{mirror_repo.clone_url}`
  end

  def update_readme(date)
    File.open('README', 'a+') do |file|
      file.write "#{date} Mirror commit msg\n"
    end
  end

  def fake_commit(date)
    `git add .`
    `GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m 'Mirrored commit'`
  end

  def push
    # set upstream version of mirror-repo
    `git push -u origin master`
  end


  def mirror_history(repo)
    Dir.chdir('mirror-repo') do 
      # loop through original commits
      get_commits(repo).reverse.each do |commit|
        date = commit[:date]
        update_readme(date)
        fake_commit(date)
      end
      # push
    end
  end


end

fake = FakeHistory.new
# pp fake.mirror_repo
pp fake.mirror_history('assignment_ruby_api_calls')
# pp fake.get_commits('Private-Test')[0]
