require 'figaro'
require_relative 'weather_forecast'
require 'json'

Figaro.application = Figaro::Application.new(
  path: File.expand_path("./config/application.yml")
)

Figaro.load

forcaster = WeatherForecast.new(key: ENV["API_KEY"])

response = forcaster.get_forecast
puts  JSON.pretty_generate response
