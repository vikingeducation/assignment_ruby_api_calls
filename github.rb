github = Github.new oauthtoken
github.repos.list
github.repos.list {|list| 10.times puts list}
