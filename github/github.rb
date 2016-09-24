# base https://api.github.com
require 'pry-byebug'

# https://api.github.com/?access_token=OAUTH-TOKEN

# User-Agent: jdbernardi
require 'github_api'


class Github_api


	def initialize

		@repos = nil

		@commits = {}

		@github = Github.new  oauth_token: ENV["GITHUB"],
													user_agent: 'jdbernardi',
													auto_pagination: true
													binding.pry
	end


	def get_repositories

		@repos = @github.repos.list user: 'jdbernardi'#, { |repo| repo.name } -- error
		@repos = @repos[1..10]

	end


	def pull_commits

		@repos.each do | r |

			commit = @github.repos.commits.list 'jdbernardi', r.name

			parse_commit( r.name, commit )

		end

	end


	def parse_commit( repo_name, commits )

		com_array = []

		commits.each { |s| s.each { |n| n.each { |p| com_array << p["message"] if p.is_a?(Hash)  && !p["message"].nil? } } }

		@commits[ repo_name ] = com_array
binding.pry
	end


	def inspect

		binding.pry

	end

end

git = Github_api.new
git.get_repositories
git.pull_commits
git.inspect
