require 'rubygems'
require 'github_api'
require 'pry'

github = Github.new oauth_token: ENV["GHTOKEN"]
repohash = {}
date = []
github.repos.list {|repo| 
    repohash[repo.pushed_at] = repo.full_name
    date << repo.pushed_at
}
date.sort!{|moment1, moment2| Date.parse(moment1) <=> Date.parse(moment2) }.reverse!

0.upto(9) do |moment|
   print date[moment]+"  "
   puts repohash[date[moment]]
   a = github.repos.commits.all 'yushch', /\/.*/.match(repohash[date[moment]])
   0.upto(9) do |index|
      puts a[index]["commit"]["message"] if a[index] != nil 
  end
end

=begin
date.each do |moment|
   puts repohash[moment]
   a = github.repos.commits.all 'yushch', /\/.*/.match(repohash[moment])
   a.each do |item|
      puts item["commit"]["message"] 
      puts "end"
  end
end
=end


