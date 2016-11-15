require_relative 'lib/get_weather_forecast'
require_relative 'lib/parse_forecast'

Figaro.application = Figaro::Application.new(
    environment: 'development',
    path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

weather_api = GetWeatherForecast.new( 33603, 3, ENV['weather_api'])


forecast = weather_api.get


# File.open('data/forecast.json', 'w') do |f|
#   json = JSON.pretty_generate(forecast)
#   f.write(json)
# end


p = ParseForecast.new('data/forecast.json')
p.high_temps

File.open('data/trimmed.json', 'w') do |f|
  json = JSON.pretty_generate(trimmed)
  f.write(json)
end