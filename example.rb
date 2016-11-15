require_relative 'lib/weather_forcast'

Figaro.application = Figaro::Application.new(
    environment: 'development',
    path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

# puts ENV['weather_api']

weather_api = WeatherForcast.new( 33603, 3, ENV['weather_api'])
weather_api.get


#api.openweathermap.org/data/2.5/weather?zip=33603,us&APPID=1fd1b847e28c0ed4b796b1ba04ece9cc