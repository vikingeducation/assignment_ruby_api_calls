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
    repos = create_repo
    clone_repo
    @readme = create_readme
    commits = gather_commits(repos)
    write_to_readme(commits)
    push_commits(commits)
  end

  def clone_repo
    `git clone https://github.com/#{reader.user}/#{r_name} #{timestamp}`
  end

  def compare_commits(main, commits)

  end

  def create_repo
    repos = reader.fetch_repos
    unless repos.any? {|repo| repo[:name] == r_name }
      github.repos.create(name: r_name)
    end
    repos
  end

  def create_readme
    File.open("#{timestamp}/README.md", "w+")
  end

  def gather_commits(repos)
    repos.select { |repo| repo[:fork] == true }.map{|repo| repo[:commits] }.flatten
  end

  def push_commits(commits)
    repos = reader.fetch_repos
    main = repos.select{ |repo| repo[:name] == r_name }[0][:commits]
    sleep(0.5)
    compare_commits(main, commits)
  end

  def write_to_readme(commits)
    commits.each do |commit|
      p "#{commit[:date]} \"Forked Repo Commit\"\n"
      @readme << "#{commit[:date]} \"Forked Repo Commit\"\n"
    end
    readme.close
  end

end

tracker = CommitTracker.new
