require_relative 'github_printer'

gp = GithubPrinter.new(ENV["VIKING_GITHUB_API_KEY"], 'cadyherron')
gp.print_repo_commit_history