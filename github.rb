require 'octokit'
require 'pp'

Octokit.auto_paginate = true
client = Octokit::Client.new(:access_token => ENV['GIT_API_KEY'])


user = client.user

username = user.login

# pp user.all_repositories
count = 0
Octokit.repos(username).sort_by { |a| a[:created_at] }.each do |repo|

  pp repo[:full_name]

end

