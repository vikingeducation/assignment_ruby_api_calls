require 'github_api'
github = Github.new oauth_token: File.readlines('key.md')[1]

# Make repository with api?
options = {
  "user" => "shadefinale",
  "name"=> "forkcommithistory",
  "description"=> "Mirror commits to forks",
  "homepage"=> "https://github.com",
  "private"=> false,
  "has_issues"=> true,
  "has_wiki"=> true,
  "has_downloads"=> true
}

begin
  github.repos.create(options)
rescue
  puts "Repo already exists...."
end

