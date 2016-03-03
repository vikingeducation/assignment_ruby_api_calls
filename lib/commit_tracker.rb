require_relative 'github'

class CommitTracker
  # create fork tracker repo if doesn't exist
  # clone fork tracker repo
  # get all fork repos
  # get commits for each repo
  # add line to readme if ! yet commited
    # commit at --date

  attr_reader :reader, :r_name, :github, :folder_path, :readme

  def initialize
    @reader = GithubReader.new
    @github = @reader.github
    @r_name = "fork_commit_history"
    timestamp = Time.now.strftime("%Y_%m_%d_%H%M%S")
    @folder_path = File.expand_path("~/fork_commit_history_#{timestamp}")
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
    `git clone https://github.com/#{reader.user}/#{r_name} #{folder_path}`
  end

  def compare_commits(main, commits)
    commits.select do |commit|
      main.none?{ |m_commit| m_commit[:date] == commit[:date] }
    end
  end

  def create_repo
    repos = reader.fetch_repos
    unless repos.any? {|repo| repo[:name] == r_name }
      github.repos.create(name: r_name)
    end
    repos
  end

  def create_readme
    File.open("#{folder_path}/README.md", "w+")
  end

  def gather_commits(repos)
    repos.select { |repo| repo[:fork] == true }.map{|repo| repo[:commits] }.flatten
  end

  def push_commits(commits)
    repos = reader.fetch_repos
    main = repos.select{ |repo| repo[:name] == r_name }[0][:commits]
    sleep(0.5)

    uncommitted = compare_commits(main, commits)

    execute_commits(uncommitted)
  end

  def execute_commits(commits)
    working_dir = Dir.pwd

    `cd #{folder_path}`
    `git add -A`

    commits.each do |commit|
      `git commit --date="#{commit[:date]}" -m="Forked Repo Commit"`
    end

    `git push origin master`
    `cd #{working_dir}`
  end

  def write_to_readme(commits)
    commits.each do |commit|
      p "#{commit[:date]} \"Forked Repo Commit\"\n\n"
      @readme << "#{commit[:date]} \"Forked Repo Commit\"\n\n"
    end
    readme.close
  end

end

tracker = CommitTracker.new
