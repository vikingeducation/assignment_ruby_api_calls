require 'octokit'
require 'pp'


client = Octokit::Client.new(:access_token => ENV['GIT_API_KEY'])


user = client.user
user.login


# pp user.all_repositories
user.rels[:next].get.data.each do |repo|
  pp repo[:full_name]
end
