# ruby_api_calls
Simple Ruby API Call Assignment

## Bideo Wego

# WeatherForecast

Generates weather forecast data from a public API at [Open Weather Map][weather].

## Usage (WeatherForecast)

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

## Run Examples (WeatherForecast)

	```shell
	$ cd to/this/directory
	$ ruby weather.rb
	```




[weather]: http://openweathermap.org/api
