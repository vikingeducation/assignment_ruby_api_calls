require 'github_api'
require 'pry-byebug'

class GithubPractice

  GITHUB_TOKEN = ENV['GITHUB_API_TOKEN']

  def initialize(username = 'leedu708')

    @username = username
    @github = Github.new oauth_token: GITHUB_TOKEN

  end

  def latest_repos(num = 10)

    # grab repository list
    repositories = @github.repos.list user: @username

    # sort repositories by creation date then reverse
    most_recent = repositories.sort_by { |repo| repo.created_at }.reverse

    puts num.to_s + " most recent repositores for #{@username}:"

    # prints most recent repositories
    0..(num - 1).times do |index|
      puts "\t" + (index + 1).to_s + ". " + most_recent[index]['name'].to_s
    end

  end

  def latest_commits(num = 10)

  end


end

test = GithubPractice.new
test.latest_repos