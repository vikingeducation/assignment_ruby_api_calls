require_relative 'github'

class CommitTracker
  # create fork tracker repo if doesn't exist
  # clone fork tracker repo
  # get all fork repos
  # get commits for each repo
  # add line to readme if ! yet commited
    # commit at --date

  attr_reader :reader, :r_name, :github

  def initialize
    @reader = GithubReader.new
    @github = @reader.github
    @r_name = "fork_commit_history"
  end

  def create_repo
    repos = reader.fetch_repos
    unless repos.any? {|repo| repo[:name] == r_name }
      github.repos.create(name: r_name)
    end
    clone_repo
  end

  def clone_repo
  end


end

tracker = CommitTracker.new

tracker.create_repo