require 'github_api'
require 'pry-byebug'
require 'figaro'
require 'pp'
require 'rainbow'

Figaro.application = Figaro::Application.new(
  environment: "development",
  path: "config/application.yml"
)
Figaro.load

class GithubAPI
  TOKEN = Figaro.env.GITHUB_API
  USERNAME = Figaro.env.USERNAME
  NAME = Figaro.env.NAME

  attr_accessor :client, :repos, :names

  def initialize
    @client = Github.new
    @client.current_options[:oauth_token] = TOKEN
  end

  def get_repos
    #binding.pry
    @repos = @client.repos.list(sort: "updated").first(10)
  end

  def get_commits(names)
    commits = []
    names.each do |name|
      next if name.nil?
      commit_list = @client.repos.commits.list(USERNAME, name)
      # commit_list.each_with_index do |commit|
      # # binding.pry
      #   commits << commit_list if commit['commit']['committer']['name'] == NAME
      # end
      commits << commit_list.select {|commit| commit if commit['commit']['committer']['name'] == NAME}
    end
    # binding.pry
    commits
  end

  def get_commit_messages
    get_commits.each_with_index do |repo,index|
      puts Rainbow("Repository: #{@names[index]}").cyan
      repo.each do |commit|
        puts Rainbow(commit['commit']['message']).green
      end
    end
  end

  def get_name
    @names = @repos.map{|repo| repo['name']}
  end

  def get_fork_names
    @forkname = @repos.map{|repo| repo['name'] if repo['fork'] == true}
  end

  def create_fork_hash
    @hash = {}

    get_commits(@forkname).each_with_index do |repo,index|

      @hash[@forkname[index]] = {:date => [], :message => []}

      repo.each do |commit|
        #binding.pry
        @hash[@forkname[index]][:date] << commit['commit']['author']['date']
        @hash[@forkname[index]][:message] << commit['commit']['message']
      end
    end
    @hash
  end

  def create_repo
    @client.repos.create(name: NAME, description: 'Fork Commit', homepage: 'https://github.com', private: false, has_issues: false, has_wiki: false, auto_init: true)
  end

  def get_repo_link

  end

  def run
    get_repos
    get_name
    # get_commit_messages
    get_fork_names
    pp create_fork_hash
    create_repo
  end

end

