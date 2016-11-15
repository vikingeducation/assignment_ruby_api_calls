require 'json'
require 'pp'
require 'httparty'
require_relative 'weather_forecast'
require_relative 'parser'

#weather = WeatherForecast.new

#api_response = weather.get_forecast

sample_response = File.read('sample_api_return.txt')

parser = Parser.new(weather: sample_response)

parser.days.each do |key, value|
  p key
  p value
end

# pp weather.get_forecast
