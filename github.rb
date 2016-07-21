require 'github_api'
require_relative './env2'
require 'pry'


class GithubScrape
  NAP = Proc.new { sleep 0.4 }

  def initialize(user = 'jsteenb2', num_repos = 10, num_commits =  10)
    @repo_info = {}
    github = Github.new oauth_token: GITHUB_API_KEY
    repos = repo_scrape(github, num_repos)
    commit_scrape(github, repos,
                  'jsteenb2', num_commits)
  end

  def repo_scrape(g_object, num_repos)
    g_object.repos.list sort: 'created', per_page: "#{num_repos}".to_i
  end

  def print_commits
    (0..@repo_info.keys.length - 1).each do |index|
      puts "Repo: #{@repo_info[index][0]}"
      (1..(@repo_info[index].length - 1)).each do |idx|
        puts "#{@repo_info[index][idx][0]}: "
        puts "#{@repo_info[index][idx][1]}"
      end
    end
  end

  def commit_scrape(g_object, repo_object, user, num_commits)
    repo_object.each_with_index do |repo, index|
      @repo_info[index] = [repo.name]
      NAP.call
      commits = g_object.repos.commits.list(user, repo.name, :per_page => 100)
      commit_grab(index, commits, num_commits)
      NAP.call
    end
  end

  def commit_grab(repo_index, commit_obj, num_commits)
    commit_obj[0..[(num_commits - 1), commit_obj.length - 1].min].each_with_index do |commit, idx|
      NAP.call
      @repo_info[repo_index] << ["Commit ##{commit_obj.length - idx - 1}",  commit['commit']['message']]
    end
  end

end

gs = GithubScrape.new

gs.print_commits
