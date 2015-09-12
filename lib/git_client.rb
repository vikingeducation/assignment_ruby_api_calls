require 'github_api'

class GitClient
	def initialize(options={})
		@user = options[:user]
		@token = options[:token]
		@api = Github.new(:oauth_token => @token)
	end

	def repo_names(limit=10)
		@repos = @api.repos.list(:user => @user)
		names = []
		limit.times do |i|
			names << @repos[i].name if @repos[i]
		end
		names
	end

	def commit_messages_for(repos, limit=10)
		messages = {}
		repos.each do |repo|
			commits = @api.repos.commits.list(@user, repo)
			messages[repo.to_sym] = []
			limit.times do |i|
				messages[repo.to_sym] << commits[i][:commit][:message] if commits[i]
			end
			sleep(1)
		end
		messages
	end
end