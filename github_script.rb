require 'time'

def committer(time)
  time.xmlschema.to_s

  `cd ~/Copy/Viking/web_scraping/private_commits_registry`

  readme = File.open("README.md", "a")
  readme.puts("I just did a private commit!")
  readme.close

  `git add -A`
  `git commit -m "private commit" --date #{time.xmlschema.to_s}`
  `git push origin master`
end

committer(Time.now)
