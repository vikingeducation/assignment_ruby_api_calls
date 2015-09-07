require 'github_api'
require 'envyable'

Envyable.load('config/env.yml')

class VikingGithub < Github::Client

  
  def initialize
    super oauth_token: ENV["github_key"]
  end


  def recent_commits
    commits_list = {}

    repos = recent_repos

    repos.each do |repo|
      name = repo["name"]
      sleep(0.2)
      commits = self.repos.commits.list 'nonadmin', name, sort: "updated",
                                        per_page: 10
      commits_list[name.to_sym] = []
      commits.each do |commit|
        commits_list[name.to_sym] << commit["commit"]["message"]
      end

    end

    commits_list
  end


  def recent_repos
    self.repos.list 'nonadmin', sort: "updated", per_page: 10
    # repos.each do |repo|
    #   puts repo["name"]
    # end
  end
  
  
end