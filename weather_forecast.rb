require 'httparty'

class WeatherForecast

  BASE_URI = 'http://api.apixu.com/v1/forecast.json'

  def initialize(location = "San Francisco", days = 7)
    @location = location
    @days = days
  end

  def get
    puts ENV['WEATHER_KEY']
    end_point = BASE_URI + '?' + 'key=' + ENV['WEATHER_KEY'] + 'q=' + @location
    response = HTTParty.get(end_point)
    puts end_point
    puts response
  end



end



#  http://api.apixu.com/v1/current.json?key=<YOUR_API_KEY>&q=San Francisco&days=7
WeatherForecast.new.get
