
require 'github_api'
require_relative 'github_reader'
require_relative 'github_parser'
require 'pp'

GithubReader.new.repos_with_commits('anthonyfuentes')
