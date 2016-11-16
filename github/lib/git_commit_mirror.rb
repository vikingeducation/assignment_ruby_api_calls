require 'github_api'
require 'pry'
require 'pry-byebug'

# github = Github.new(oauth_token: ENV["Github_API"])

# github.repos.create "name": 'commit-mirror-repo',
#   "description": "commit mirror message",
#   "homepage": "https://github.com",
#   "private": false,
#   "has_issues": true,
#   "has_wiki": true,
#   "has_downloads": true

# `git clone https://github.com/luke-schleicher/commit-mirror-repo`

`touch README.md`
`git add -A`
`git commit -m "initial commit"`
`git push origin master`