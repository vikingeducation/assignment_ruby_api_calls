require "github_api"
require "httparty"
require "figaro"

Figaro.application = Figaro::Application.new(
  environment: 'developent',
  path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

github = Github.new({oauth_token: ENV["github_key"]})

response = github.repos.list
sorted_response = response.sort_by{|repo| repo.created_at}
sorted_response.each do |key, value|
  p "The hash key is #{key} and the value is #{value}"
end
#
# File.open('gh_temp.txt', 'w') do |f|
#   json = JSON.pretty_generate(response)
#   f.write(json)
# end
