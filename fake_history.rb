require 'github_api'
require 'byebug'
require 'pp'
require_relative 'github_figaro_setup'

class FakeHistory
  def initialize(username)
    @oauth_token = ENV["viking_github_api_key"]
    @github = Github.new(oauth_token: @oauth_token)
    @username = username
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
    begin
      @github.repos(user: @username, repo: 'mirror-repo').get
    rescue Github::Error::NotFound
      false
    end
  end


  def mirror_repo
    find_mirror_repo || create_repo
  end


  def get_commits(repo)
    @github.repos(user: @username, repo: repo).commits.list.map { |commit|
       {date: commit.commit.committer.date,
        name: commit.commit.message }
     }
  end


  def clone_mirror
    `git clone #{mirror_repo.ssh_url}`
  end


  def update_readme(date, repo)
    File.open('README', 'a+') do |file|
      file.write "#{date} Mirror commit msg for #{repo}\n"
    end
  end


  def fake_commit(date)
    `git add .`
    `GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m 'Mirrored commit'`
  end


  def push
    # set upstream version of mirror-repo
    Dir.chdir('mirror-repo') do
      `git push -u origin master`
    end
  end


  def select_forks
    selected_forks = forks.map do |fork|
      puts "Would you like to mirror #{fork}? (y/n)"
      answer = gets.chomp
      case answer
      when /^[Yy]/
        fork
      else
        nil
      end
    end.compact
    selected_forks
  end


  def remove_mirror_folder
    `rm -rf mirror-repo`
  end


  def mirror_history(repo)
    Dir.chdir('mirror-repo') do
      # loop through original commits
      get_commits(repo).reverse.each do |commit|
        date = commit[:date]
        update_readme(date, repo)
        fake_commit(date)
      end
    end
  end


  def forks
    forked_repos = @github.repos.list.select(&:fork).map(&:name)
  end


  def run
    selected_forks = select_forks
    clone_mirror
    selected_forks.each do |fork|
      mirror_history(fork)
    end
    push
    remove_mirror_folder
  end

  
end

fake = FakeHistory.new('cadyherron')
fake.run
