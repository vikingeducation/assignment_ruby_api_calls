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
    commits = gather_commits(repos)
    push_commits(commits)
  end

  def clone_repo
    `git clone git@github.com:#{reader.user}/#{r_name}.git #{folder_path}`
  end

  def compare_commits(main, commits)
    commits.select do |commit|
      main.none?{ |m_commit|
        p m_commit[:date]
        p commit[:date]
        m_commit[:date] == commit[:date] }
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
    File.open("#{folder_path}/README.md", File::TRUNC){}
  end

  def gather_commits(repos)
    repos.select { |repo| repo[:fork] == true }.map{|repo| repo[:commits] }.flatten
  end

  def push_commits(commits)

    repos = reader.fetch_repos
    main = repos.select{ |repo| repo[:name] == r_name }[0][:commits]
    uncommitted = compare_commits(main, commits)

    execute_commits(uncommitted)
  end

  def execute_commits(commits)
    working_dir = Dir.pwd

    puts "Moving to temp folder: #{folder_path}"

    Dir.chdir(folder_path)
    `git add -A`

    commits.each do |commit|
      write_to_readme(commit)
      puts "writing commit: #{commit[:date]}"
      `git commit --date="#{commit[:date]}" -am "Forked Repo Commit"`
    end

    puts "Pushing to github"

    `git push origin master`

    puts "returning to working dir: #{working_dir}"

    Dir.chdir(working_dir)

    puts "removing temp folder: #{folder_path}"

    `rm -rf #{folder_path}`
  end

  def write_to_readme(commit)
    File.open("#{folder_path}/README.md", "a+") do |file|
      file << "#{commit[:date]} \"Forked Repo Commit\"\n\n"
    end
  end

end

tracker = CommitTracker.new

# .execute_commits([{date: "2016-11-16T00:05:37Z"}, {date: "2016-01-16T00:05:37Z"}])
