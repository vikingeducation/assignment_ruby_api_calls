
require 'github_api'
require_relative 'github_reader'
require 'pp'

# pp GithubReader.new.repos_with_commits('anthonyfuentes')

pp GithubReader.new.forks('anthonyfuentes').length
