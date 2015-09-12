# ruby_api_calls
Simple Ruby API Call Assignment

## Bideo Wego

## Installation

Make sure to run `bundle install` before using to install the dependencies.

```shell
$ cd to/this/directory
$ bundle install
```

# WeatherForecast

Generates weather forecast data from a public API at [Open Weather Map][weather].

## Usage

1. If you prefer API key security use a YAML file and the ENVLoader class

	```yaml
	---

	weather_forecast_api_key: YOUR_API_KEY_HERE
	```

1. Require the ENVLoader and WeatherForecast classes

	```ruby
	require_relative 'lib/env_loader.rb'
	require_relative 'lib/weather_forecast.rb'
	```

1. Load your environment variables into an instance of ENVLoader for easy access
	- ENVLoader accepts the path to a YAML file
	- It will create accessor methods on the instance for each key
	- Or you could hard code your API key into the next step

	```ruby
	env_loader = ENVLoader.new(:path => "#{File.dirname(__FILE__)}/env.yaml")
	env_loader.load
	key = env_loader.weather_forecast_api_key
	```

1. Create a new WeatherForecast instance with your API key

	```ruby
	weather_forecast = WeatherForecast.new(
		:key => key,
		:days => 5,
		:location => 'Philadelphia'
	)
	```

1. Get your 5 day forecast

	```ruby
	puts "Today"
	p weather_forecast.today

	puts "Tomorrow"
	p weather_forecast.tomorrow

	puts "Precipitation"
	p weather_forecast.precipitation

	puts "Wind"
	p weather_forecast.wind

	puts "Clouds"
	p weather_forecast.clouds

	puts "Highs"
	p weather_forecast.highs

	puts "Lows"
	p weather_forecast.lows
	```

## Run Examples
- NOTE: to run the examples without modification you must create a `env.yaml` file with `weather_forecast_api_key: YOUR_KEY` in the root of this directory
- If you need a key, sign up [here][weather_signup].

	```shell
	$ cd to/this/directory
	$ ruby weather.rb
	```
# ----

# Git Client

Retrieves repository names and commit messages using the [Ruby the Github API][github].

## Usage

1. If you prefer API token security use a YAML file and the ENVLoader class

	```yaml
	---

	github_api_token: YOUR_API_KEY_HERE
	```

1. Require the ENVLoader and GitClient classes

	```ruby
	require_relative 'lib/env_loader.rb'
	require_relative 'lib/git_client.rb'
	```

1. Load your environment variables into an instance of ENVLoader for easy access
	- ENVLoader accepts the path to a YAML file
	- It will create accessor methods on the instance for each key
	- Or you could hard code your API token into the next step

	```ruby
	env_loader = ENVLoader.new(:path => "#{File.dirname(__FILE__)}/env.yaml")
	env_loader.load
	token = env_loader.github_api_token
	```

1. Create a new GitClient instance with username and token

	```ruby
	git_client = GitClient.new(
		:user => 'BideoWego',
		:token => token
	)
	```

1. Get an array of repository names, limit defaults to 10

	```ruby
	puts "Repo Names"
	repo_names = git_client.repo_names
	repo_names.each_with_index do |name, i|
		puts "#{i + 1}. #{name}"
	end
	```

1. Get the last commit messages for an array of repo names, limit defaults to 10 messages per repo
	- NOTE: this method takes time, it sleeps inbetween API calls to avoid sending too many requests too fast!

	```ruby
	puts "Commit Messages"
	commit_messages = git_client.commit_messages_for(repo_names)
	commit_messages.each do |repo_name, messages|
		puts "#{repo_name}"
		messages.each_with_index do |message, i|
			puts "#{i + 1}. #{message}"
		end
	end
	```

## Run Examples
- NOTE: to run the examples without modification you must create a `env.yaml` file with `github_api_token: YOUR_TOKEN` in the root of this directory
- If you need a token, you must have a Github account and generate a token [here][github_token].

	```shell
	$ cd to/this/directory
	$ ruby github.rb
	```

[weather]: http://openweathermap.org/api
[weather_signup]: http://home.openweathermap.org/users/sign_up
[github]: https://github.com/peter-murach/github
[github_token]: https://github.com/settings/tokens
