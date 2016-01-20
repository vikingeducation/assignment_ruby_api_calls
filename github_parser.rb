module GithubParser

  # parses for repo owner name, and the repo name
  # returns an array of [usernames, repos]
  def parse_repos(repo_list)
    list = repo_list.map { |repo| [ repo["owner"]["login"], repo["name"] ] }
  end

  def parse_commits(commit_history)
    # iterate through array of commit_history
    # [ [repo1, commit_list1], [repo2, commit_list2], ...]
    commit_history.each do |repo| # repo = [current_repo, current_commit_list]
      clean_commits = []
      # for each repo, iterate through it's commit_history
      # and parse out the relevant info
      # in this case, we are obtaining committer info, and commit message
      # repo[1] represents commit history/list
      repo[1].each do |commit| # commit = current commit
        # parsing out relevant info into clean commits array
        clean_commits << [commit["commit"]["committer"],commit["commit"]["message"]]
      end
      # repo[1] is raw json github output for commit history
      # replace it with our array of clean parsed commit info
      repo[1] = clean_commits
    end
    # return it
    commit_history
  end

end
