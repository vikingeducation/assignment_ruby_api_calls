require 'httparty'


class WeatherForecast
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5'

  API_KEY = ENV["WEATHER_API_KEY"]


  def initialize(location="New York", num_days=16)
    @options = { query: {q: location, cnt: num_days, APPID: API_KEY}}
  end

  def forecast
    self.class.get("/forecast/daily", @options)
  end

end


b = WeatherForecast.new
# p WeatherForecast::API_KEY
puts b.forecast