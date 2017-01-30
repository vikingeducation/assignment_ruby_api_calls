require 'github_api'

class GithubRepos

  def initialize(token=ENV['GH'], per_page=10)
    @github = Github.new(oauth_token: token, per_page: per_page)
    @repos = @github.repos.list(user: 'yxlau', sort: 'updated')
  end

  def latest_repos
    puts "Latest Repos:"
    @repos.each do |r|
      puts r.name.upcase
      commits = @github.repos.commits.list('yxlau', r.name)
      counter = 0
      commits.each do |c|
        break unless c
        break if counter == 10
        puts "  Date: #{c['commit']['author']['date']}"
        puts "    #{c['commit']['message']}"
        counter += 1
      end
      puts
      sleep 1
    end
  end

end
