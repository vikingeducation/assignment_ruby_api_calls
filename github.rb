require_relative 'lib/env_loader.rb'
require_relative 'lib/git_client.rb'

env_loader = ENVLoader.new(:path => "#{File.dirname(__FILE__)}/env.yaml")
env_loader.load
token = env_loader.github_api_token

git_client = GitClient.new(
	:user => 'BideoWego',
	:token => token
)

puts "Repo Names"
repo_names = git_client.repo_names
repo_names.each_with_index do |name, i|
	puts "#{i + 1}. #{name}"
end

puts "Commit Messages"
commit_messages = git_client.commit_messages_for(repo_names)
commit_messages.each do |repo_name, messages|
	puts "#{repo_name}"
	messages.each_with_index do |message, i|
		puts "#{i + 1}. #{message}"
	end
end