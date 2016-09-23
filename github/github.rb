# base https://api.github.com


# https://api.github.com/?access_token=OAUTH-TOKEN

# User-Agent: jdbernardi
require 'github_api'


class Github


	def initialize

		@github = Github.new  oauth_token: ENV["GITHUB"],
													user_agent: 'jdbernardi'
													binding.pry
	end


	def get_repositories

		repos = @github.repos.list user: 'jdbernardi'
binding.pry
	end


end

git = Github.new
git.get_repositories
