require 'github_api'
require 'envyable'

Envyable.load('config/env.yml')

class GenerateHistory < Github::Client

  
  def initialize(from_repo)
    super oauth_token: ENV["github_key"]
    @from_repo = from_repo
  end


  def get_timestamps
    timestamps = []

    commits = self.repos.commits.list 'nonadmin', @from_repo
    commits.each do |commit|
      if commit.author.login == "nonadmin"
        timestamps << commit.commit.author.date
      end
    end

    timestamps
  end


  def append_timestamps
    %x(git clone git@github.com:nonadmin/forkcommithistory.git /tmp/forkcommithistory)
    get_timestamps.each do |timestamp|

      File.open('/tmp/forkcommithistory/README.md', 'a') do |file|
        file.write("#{timestamp} - Fork Repo Commit\r\n")
      end

      %x(git commit --date="#{timestamp}" -am="Forked Repo Commit")
    end
  end


  
end