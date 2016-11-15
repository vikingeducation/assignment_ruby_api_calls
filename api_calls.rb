require 'json'
require 'pp'
require 'httparty'
require_relative './lib/weather_forecast'
require_relative './lib/parser'

weather = WeatherForecast.new
api_response = weather.get_forecast
pp forecast_data = Parser.new(api_response).hi_temps

# pp weather.get_forecast
