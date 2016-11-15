require 'figaro'
require_relative 'weather_forecast'
require 'json'
require_relative 'github'


Figaro.application = Figaro::Application.new(
  path: File.expand_path("./config/application.yml")
)

Figaro.load

# forecaster = WeatherForecast.new(key: ENV["WEATHER_KEY"])

reader = GithubReader.new
reader.pretty_print
