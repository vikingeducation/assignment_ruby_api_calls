require 'json'
require 'pp'
require 'httparty'
require 'github_api'
require_relative 'weather_forecast'
require_relative 'parser'
require_relative 'github_reader'
require_relative 'github_parser'

weather = WeatherForecast.new

pp api_response = weather.get_forecast

# sample_response = File.read('sample_api_return.txt')

# parser = Parser.new(weather: sample_response)

# p parser.tomorrow

# pp weather.get_forecast
