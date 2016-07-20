require 'github_api'
require 'pry'


class GitHubApiProject

  def initialize(username)
    @username = username
    @github = Github.new o_auth_token: '18a089a07367243efef49fdff6c98d87f15870ea'
  end

  def get_latest_10
    repos = @github.repos.list user: @username ,sort: 'created'

    binding.pry
    repos.body
   
  end

  def get_latest_10_messages
    agent = Github.new o_auth_token: '18a089a07367243efef49fdff6c98d87f15870ea'
    repos = agent.commits.list  'adrianmui', 'assignment_web_scraper'
     binding.pry

     repos
  end

end

g = GitHubApiProject.new('adrianmui')
p g.get_latest_10