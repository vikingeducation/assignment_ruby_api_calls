require "github_api"

class GitStats
  attr_reader :gh

  def initialize
    @gh = Github.new(oauth_token: ENV["GITHUB_API"])
  end

  def str_to_timestamp(s)
    date, time = s.split("T")
    date = date.split("-")
    time = time.split(":")
    Time.new(date[0], date[1], date[2], time[0], time[1])
  end

  def latest_repos_(lst)
    sorted_repos = lst.sort_by{ |i| str_to_timestamp(i.created_at) }
    sorted_repos[-10..-1]
  end

  def latest_repos
    latest_repos_(gh.repos.list)
  end

  def commits_for(user, repo_name)
    gh.repos.commits.list(user, repo_name)
  end

  def latest_commits_for(repos)
    repos.map do |repo|
      sleep(0.5)
      sorted_commits = commits_for(repo.owner.login, repo.name).sort_by do |c|
        str_to_timestamp(c.commit.author.date)
      end
      {repo.name => sorted_commits[-10..-1]}
    end
  end

end
