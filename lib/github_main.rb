require_relative 'github'

github = GithubAPIWrapper.new

github.render_recent_repo_names(user: 'lortza', qty: 10)

github.render_recent_repo_commits(user: 'lortza', qty: 3)