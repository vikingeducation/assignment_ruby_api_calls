require 'github_api'

class GithubExplorer

  def initialize
    @github = Github.new oauth_token: "d09e7a9e346740eb4b8bd26626dab2176fae36e5"
  end


  def latest_ten_repos(username = 'kinsona')
    all_repos = @github.repos.list user: username

    latest_ten = all_repos.sort_by { |repo| repo.created_at }.reverse[0..9]

    latest_ten.each do |repo|
      puts "#{repo.name}: #{repo.created_at}"
    end

    return true
  end

  def first_repo
    (@github.repos.list user: 'kinsona').first
  end


  def latest_ten_commits(repo)
    all_commits = @github.repos.commits.list repo.owner.login, repo.name
    latest_commits = all_commits.sort_by { |commit_object| commit_object.commit.author.date }.reverse[0..9]

    latest_commits.each do |commit_object|
      puts "#{commit_object.commit.author.date}: #{commit_object.commit.message}"
    end

    return true
  end

end
