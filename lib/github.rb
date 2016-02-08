=begin
  Part II: GitHub API Warmup

  The GitHub API is very extensive, and for what we're looking to do with it, you can get away with a basic API token. Unlike your first time around, you're going to use the GitHub API Gem and see what a professional-quality API wrapper looks like.

  *** Hint about the docs: all the direct API hitting methods are nested under the docs for the Client object.

  1. (DONE)
  Generate a Token - Like usual, you're going to need to generate an API token that your gem can grab onto. For this one in particular, you only have one shot to see the token, so copy it down as soon as you get it.

  2. (DONE)
  Login to GitHub and go to your settings page (the gear icon in your navbar).

  3. (DONE)
  On the left side, click the "Personal access tokens" tab.

  4. (DONE)
  Generate a new access token with permissions for "public repo", "repo status", and "notifications".

  5. (DONE)
  Copy down that token on the one screen where you see it.

  6. (DONE)
  Set Up Your Gem

  7. (DONE)
  Require the GitHub API gem in a new Ruby script, github.rb, using a Gemfile and Bundler.

  8. (DONE)
  Create a new Github object with the optional parameter oauth_token: "THE_TOKEN_YOU_GOT"

  9. (DONE)
  Get Some Info

  10. (DONE)
  As always when parsing new response objects, you're going to want to spend some serious time in Pry playing around with these things.

  11. (DONE)
  Do your best to make a reasonable object that wraps the functionality you want; you've done it enough times now that we're not giving you hints.

  12. 
  Check out the docs for listing repo names and grab a list of the 10 latest repos for your account.
  *** Remember, you can pass a user-name parameter, and pay close attention to the examples.

  13.
  Print out the names of those repos so you can prove it worked.

  14.
  For each one of those 10 repos, print out a list of the last 10 commit messages. You're probably going to want the docs for listing commit messages on a single repo.

  15.
  Make sure to be careful with rate limits by adding a small sleep between each call to the API.
  *** This is usually unnecessary with APIs (which are meant to be fast) but good in development.
=end

require 'github_api'
require 'pp'
require 'httparty'

class MyGit

  attr_reader :github

  API_KEY = ENV["API_KEY"]

  def initialize
    @github = Github.new
  end

  def latest_ten(user_name)
    # Designed to heal break out of the each loop once count reaches 10
    count = 1
    # Printing out our sorted and reversed hash but stopping once 10 items are printed.
    puts "Latest 10 Repositories Created by #{user_name}"
    created_date_and_name(user_name).sort.reverse.each do |key, value|
      puts "#{count}. #{value}"
      count += 1
      break if count == 11
    end
  end

  def created_date_and_name(user_name)
    # Dictionary to hold repo created at and it's corresponding name.
    created_date_and_name = {}

    # Setting those values from the repos from account.
    @github.repos.list user: user_name do |repo|
      created_date_and_name[repo.created_at] = repo.name
    end
    created_date_and_name
  end

  def ten_for_ten(user_name)
    # Things I want to test
    # can you only get a request if the name of that repo matches one of the names of values in the created_date_and_name's top ten?
    # Could do this by separating the code for getting list of names and their created_by dates, make that bit modular
    # Could make that method return just the top ten in a dictionary as well, make it even more modular. That way this method can call that method, get the hash and then print the commits off each one, easy peasy. I need to get ready for work.... FUCK
    count = 1
    created_date_and_name(user_name).sort.reverse.each do |key, value|
      puts "#{count}. #{value}"
      request = HTTParty.get("https://api.github.com/repos/#{user_name}/#{value}/commits")
      count_two = 1
      request.each do |commit|
        puts "#{count_two}. #{commit["commit"]["message"]}"
        count_two += 1
        break if count_two == 11
      end
      count += 1
      break if count == 11
    end
  end

end

# HOW DO U RATE LIMIT WITH THIS?
MyGit.new.ten_for_ten('Steven-Chang')
# MyGit.new.ten_for_ten('Steven-Chang', 'demo_ruby_tdd', )