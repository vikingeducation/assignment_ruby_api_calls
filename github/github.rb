# base https://api.github.com
require 'pry-byebug'

# https://api.github.com/?access_token=OAUTH-TOKEN

# User-Agent: jdbernardi
require 'github_api'


class Github_api


	def initialize

		@repos = nil

		@github = Github.new  oauth_token: ENV["GITHUB"],
													user_agent: 'jdbernardi',
													auto_pagination: true
													binding.pry
	end


	def get_repositories

		@repos = @github.repos.list user: 'jdbernardi'#, { |repo| repo.name } -- error
		@repos = @repos[1..10]
		binding.pry
	end


	def get_commits
binding.pry
		@repos.each do | r |

			@commits = @github.repos.commits.list 'jdbernardi', r.name

		end
binding.pry
	end


end

git = Github_api.new
git.get_repositories
git.get_commits
