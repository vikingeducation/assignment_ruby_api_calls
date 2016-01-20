require 'github_api'
require 'figaro'
require 'pp'

Repo = Struct.new( :name, :push_time, :messages )

class GithubRepoParser
  TIME_STAMP_REGEX = /(\d\d\d\d)-0?(\d*)-(\d*)T0?(\d*):0?(\d*):0?(\d*)/
  USER_NAME = 'jmazzy'
  NUM_REPOS = 10
  NUM_COMMITS = 10

  def initialize
    Figaro.application = Figaro::Application.new( {
      environment: "development",
      path:"./config/application.yml"} )
    Figaro.load

    @github = Github.new(oauth_token: Figaro.env.github_key)

    get_repo_results
  end

  def get_repo_results
    repo_results = get_repos
    repo_names = repo_results.map { |repo| repo['name'] }

    @repo_list = repo_results.map do | repo |
      push_string = repo["pushed_at"]
      tm = push_string.match(TIME_STAMP_REGEX)
      push_time = Time.new(tm[1], tm[2], tm[3], tm[4], tm[5], tm[6])
      new_repo = Repo.new( )
      new_repo.name = repo["name"]
      new_repo.push_time = push_time
      new_repo
    end

    @repo_list.sort! { |a, b| b.push_time <=> a.push_time }
  end

  def print_repos
    @repo_list[0...NUM_REPOS].each do |repo|
      puts
      pp repo["name"]
      commits = get_commits(repo)
      commits.each do |commit|
        print "    "
        puts commit["commit"]["message"]
      end
    end
  end

  def get_repos
    sleep(0.5)
    @github.repos.list( user: USER_NAME )
  end

  def get_commits(repo)
    sleep(0.5)

    @github.repos.commits.list(USER_NAME, repo["name"], '...')[0...NUM_COMMITS]
  end
end

gh = GithubRepoParser.new
gh.print_repos
