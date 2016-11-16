require "github_api"
require "httparty"
require "figaro"

Figaro.application = Figaro::Application.new(
  environment: 'developent',
  path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

github = Github.new({oauth_token: ENV["github_key"]})

response_hash = {}
response = github.repos.list do |repo|
  repo_date = repo.created_at
  response_hash[repo_date] = repo.name
  p "The hash key is #{repo_date} and the value is #{response_hash[repo_date]}"
end

p response_hash.sort


#sorted_response = response.sort_by{|repo| repo.created_at}
# sorted_response.each do |key, value|
#   p "The hash key is #{key} and the value is #{value}"
# end
#
# File.open('gh_temp.txt', 'w') do |f|
#   json = JSON.pretty_generate(response)
#   f.write(json)
# end
