require_relative 'lib/get_weather_forecast'
require_relative 'lib/parse_forecast'
require 'yaml'

Figaro.application = Figaro::Application.new(
    environment: 'development',
    path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

weather_api = ENV['weather_api']





p = ParseForecast.new('33613', 3, weather_api)
# p.high_temps

# File.open('data/trimmed.json', 'w') do |f|
#   json = JSON.pretty_generate(trimmed)
#   f.write(json)
# end