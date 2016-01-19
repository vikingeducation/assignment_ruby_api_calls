require 'httparty'
require 'json'

require 'pry-byebug'
require 'pp'

class WeatherForecast
  include HTTParty

  API_KEY = ENV["WEATHER_API"]

  BASE_URI = "http://api.openweathermap.org/data/2.5/"

  VALID_FORMATS = [:json]


  def initialize(location="London", day=nil, forecast="forecast/daily")
    @location = location
    @days = day.to_s
    @forecast_type = forecast
    @uri = nil
    create_uri
  end

  def weather
    response = HTTParty.get(@uri)
  end

  private

    def create_uri
      @uri = BASE_URI + @forecast_type + "&q=" + @location + "&cnt=" + @days + "&APPID=" + "#{API_KEY}"
      binding.pry
    end
end

wf = WeatherForecast.new("London", 7)
pp wf.weather
