require_relative 'github'

github = GH_Api.new({:key => ENV['GITHUB_KEY']}, "alexglach")

github.list_repos
github.get_latest_repos(10)
puts github.get_commit_messages