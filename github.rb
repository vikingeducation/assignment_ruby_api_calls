require 'octokit'
require 'pp'
require 'httparty'

Octokit.auto_paginate = true
client = Octokit::Client.new(:access_token => ENV['GIT_API_KEY'])


user = client.user

username = user.login


repos = Octokit.repos(username).sort_by { |a| a[:created_at] }.reverse[0..9]
repos.each do |repo|
  # p repo[:commits_url]
  p url = repo[:commits_url].gsub('{/sha}', "/#{ENV['GIT_API_KEY']}")
  # p HTTParty.get(url).body
end

