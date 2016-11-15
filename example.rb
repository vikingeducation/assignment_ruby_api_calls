require_relative 'lib/get_weather_forecast'
require_relative 'lib/parse_forecast'
require 'yaml'

Figaro.application = Figaro::Application.new(
    environment: 'development',
    path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

# puts ENV['weather_api']

weather_api = GetWeatherForecast.new( 33603, 3, ENV['weather_api'])


forecast = weather_api.get


File.open('data/forecast.yaml', 'w') do |f|
  dump = forecast.to_yaml
  f.write(dump)
end

# File.open('data/forecast.json', 'w') do |f|
#   json = JSON.pretty_generate(forecast)
#   f.write(json)
# end


# ParseForecast.new('data/forecast.json')


