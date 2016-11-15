require 'figaro'
require_relative 'weather_forecast'
require 'json'


Figaro.application = Figaro::Application.new(
  path: File.expand_path("./config/application.yml")
)

Figaro.load

# forecaster = WeatherForecast.new(key: ENV["WEATHER_KEY"])
