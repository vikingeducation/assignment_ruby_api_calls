require_relative 'github_https.rb'
require_relative 'github_parser.rb'
require 'github_api'

result = GithubHttps.new
parser = GithubParser.new(result.github)
p parser.list
