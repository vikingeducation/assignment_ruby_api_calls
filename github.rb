require "github_api"

class GithubRepos
  
  attr_reader :github

  def initialize(user_name, opt = {})
    opt.empty? ? @github = Github.new : @github = Github.new(opt)
    @response = @github.repos.list user: user_name
    @user_name = user_name
  end

  def get_pages
    page_num = 2
    pages = @response.body
    current_page = pages
    until current_page.empty?
      current_page = @response.page page_num
      pages += current_page.body
      page_num += 1
      sleep(0.5)
    end
    pages
  end

  def sort_pages
    most_recent = get_pages.sort_by { |repo| repo["pushed_at"] }.reverse
  end

  def display_names(num = 10)
    num.times { |i| puts sort_pages[i]["name"] }
  end

  def get_commits(num = 10)
    messages = []
    num.times do |i|
      response = @github.repos.commits.list @user_name, sort_pages[i]["name"]
      response_arr = response.body
      messages += response_arr
      sleep(0.5)
    end
    messages
  end

  def commit_messages
    get_commits.each { |commit| puts commit["commit"]["message"] }
    nil
  end
end 



