require_relative 'lib/env_loader.rb'
require_relative 'lib/weather_forecast.rb'

env_loader = ENVLoader.new(:path => "#{File.dirname(__FILE__)}/env.yaml")
env_loader.load
key = env_loader.weather_forecast_api_key

weather_forecast = WeatherForecast.new(:key => key)

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