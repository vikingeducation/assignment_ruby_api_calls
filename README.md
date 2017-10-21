#  Weather & GitHub API calls


- `weather_forecast.rb` - a simple wrapper for the [OpenWeatherMap API](http://openweathermap.org)  which outputs forecast data to the command line. High and Low Temperatures, forecats for today and tomorrow, wind humidyty.
- `github_repos.rb` -  using GitHub API Gem, the class GitHubRepo grabs a list of the 10 latest repos of my account(if you change 'client_id:' to a different GitHub login, it will generate data for that login. For each one of those 10 repos, CLI will print out a list of the last 10 commit messages.


## Getting Started

If you want to quick run some the examples to see the code in action, and you have installed Ruby and Rails, run
```
ie.
$ ruby github_repos.rb
```


## Authors

* **Dariusz Biskupski** - *Initial work* - https://dariuszbiskupski.com


## Acknowledgments

It is the assignment created for [Viking Code School](https://www.vikingcodeschool.com/)
