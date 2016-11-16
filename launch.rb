require_relative 'openweather'
require 'figaro'

Figaro.application = Figaro::Application.new(
  environment: 'developent',
  path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

weather_api = WeatherForecast.new

response = weather_api.get({
  location: "Cleveland",
  days: "2"
  })

weather_api.lo_temps(response)
