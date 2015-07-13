require "github_api"

github_obj = Github.new(oauth_token: ENV["GITHUB_VCS_API"])
repo_list = repos(user: ENV["USERNAME"], sort: "created").list
#repo_list is an array, but not sorted by "created"

