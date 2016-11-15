require 'figaro'
require 'weather_forecaster'

Figaro.application = Figaro::Application.new(
  environment: development,
  path: File.expand_path("../config/application.yml", __FILE__)
)

Figaro.load

WeatherForecaster.new(key: ENV["API_KEY"])