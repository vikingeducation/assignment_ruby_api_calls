require 'json'
require 'pp'
require_relative './lib/weather_forecast'

weather = WeatherForecast.new

pp weather.get_forecast