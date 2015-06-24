require 'github_api'

TOKEN = ENV["GITHUB_API_OAUTH"]


class GithubExplorer

  def initialize
    @github = Github.new oauth_token: TOKEN
  end


  def latest_ten_repos(username = 'kinsona')
    all_repos = @github.repos.list user: username

    latest_ten = all_repos.sort_by { |repo| repo.created_at }.reverse[0..9]

    # Using print to test
    #latest_ten.each do |repo|
    #  puts "#{repo.name}: #{repo.created_at}"
    #end

    latest_ten
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


  def latest_repos_with_commits
    repos = latest_ten_repos

    repos.each do |repo|
      puts "\t#{repo.name.upcase}"
      latest_ten_commits(repo)
      print "\n"
      sleep 1.0
    end

    return nil
  end


  def latest_notifications(repo)
    all_notifications = @github.activity.notifications.list user: 'peter-murach', repo: 'github'

    #latest_notes = all_notifications.sort_by { |note| note.updated_at }.reverse[0..9]

    #latest_notes.each do |note|
    #  puts "#{note.updated_at}: #{note.subject}"
    #end
  end


  def github_repo_notifications
    repo = @github.repos.get user: 'peter-murach', repo: 'github'
    latest_notifications(repo)
  end

end
