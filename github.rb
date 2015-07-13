require "github_api"



def last_10_repo(repo_list)
  arr = []
  0.upto(9).each {|i| arr << repo_list[i]["name"]}
  arr
end

def last_10_commits(github_obj, repo_list)
  c_hash = Hash.new
  repo_list.each do |name|
    c_hash[name] = []
    commit_list = github_obj.repos.commits.list(user: ENV["USERNAME"], repo: "#{name}")[0..9]
    commit_list.each do |commit|
      c_hash[name] << commit["commit"]["message"]
    end
  end
  c_hash
end

github_obj = Github.new(oauth_token: ENV["GITHUB_VCS_API"])
repo_list = github_obj.repos.list(user: ENV["USERNAME"], sort: "created", direction: "desc")

array_r = last_10_repo(repo_list)
puts array_r

commit_hash = last_10_commits(github_obj, array_r)
puts commit_hash




