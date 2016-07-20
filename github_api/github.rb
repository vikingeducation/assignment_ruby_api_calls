require_relative 'env'
require 'github_api'
require 'pp'
require 'pry'


class GithubApi

  def initialize(user_name)
    @user_name = user_name
    send_request
  end


  def send_request
    @repos = Github.repos user: @user_name, sort: "created", oauth_token: API_KEY
    # binding.pry
  end

  def names
    @repos.list.sort_by{ |repo| repo.created_at }.reverse![0..9]
      .map { |repo| repo.name }
  end

  def commit_messages(names)
    messages = []
    # binding.pry
    names.map do |name|
      messages << (@repos.commits.all repo: name).map { |c| c["commit"]["message"]  }[0..9]
    end
    messages
  end

  def print_details
    repo_names = names
    messages = commit_messages(repo_names)
    output = ""
    repo_names.each_with_index do |name, index|
      output += "#{name}\n#{messages[index]}\n"
    end
    output
  end

end


g = GithubApi.new("leosaysger")
# pp g.commit_messages(g.names)
puts g.print_details
