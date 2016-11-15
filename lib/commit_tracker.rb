require_relative 'github'

class CommitTracker
  # create fork tracker repo if doesn't exist
  # clone fork tracker repo
  # get all fork repos
  # get commits for each repo
  # add line to readme if ! yet commited
    # commit at --date

  attr_reader :reader, :r_name, :github, :timestamp, :readme

  def initialize
    @reader = GithubReader.new
    @github = @reader.github
    @r_name = "fork_commit_history"
    @timestamp = Time.now.strftime("%Y_%m_%d_%H%M%S")
    set_up
  end

  def set_up
    create_repo
    clone_repo
    @readme = create_readme
  end

  def create_repo
    repos = reader.fetch_repos
    unless repos.any? {|repo| repo[:name] == r_name }
      github.repos.create(name: r_name)
    end
  end

  def clone_repo
    `git clone https://github.com/#{reader.user}/#{r_name} #{timestamp}`
  end

  def create_readme
    File.open("#{timestamp}/README.md", "w+")
  end


end

tracker = CommitTracker.new
