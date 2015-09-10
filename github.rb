require 'github_api'
require 'pry-byebug'

class GithubPractice

  GITHUB_TOKEN = ENV['GITHUB_API_TOKEN']

  def initialize(username = 'leedu708')

    @username = username
    @github = Github.new oauth_token: GITHUB_TOKEN

  end

  # prints and returns latest repositories
  def latest_repos(print_bool = true, num = 10)

    # grab repository list
    repositories = @github.repos.list user: @username

    # sort repositories by creation date then reverse
    most_recent_repos = repositories.sort_by { |repo| repo.created_at }.reverse

    # if print is true, print the necessary number of repos
    # should be separate method
    if print_bool

      puts num.to_s + " most recent repositores for #{@username}:"

      # prints most recent repositories
      0..(num - 1).times do |index|
        puts "\t" + (index + 1).to_s + ". " + most_recent_repos[index]['name'].to_s
      end

    end

    most_recent_repos[0..(num - 1)]

  end

  def latest_commits(repository, max = 10)

    # grab the commits
    commits = @github.repos.commits.list repository.owner.login, repository.name

    # sort most recent commits
    most_recent_commits = commits.sort_by { |item| item.commit.author.date }.reverse

    # shorten most_recent_commits if length is greater than max
    most_recent_commits.pop until most_recent_commits.length <= (max + 1)

    # print most_recent_commits
    0..(most_recent_commits.length - 1).times do |index|
      puts "\t" + (index + 1).to_s + ". " + most_recent_commits[index].commit.message.to_s
    end

  end

  def repos_with_commit(num = 10)

    repositories = latest_repos(false, num)

    repositories.each do |repository|

      puts repository['name']
      latest_commits(repository)

    end

  end


end

test = GithubPractice.new
test.repos_with_commit