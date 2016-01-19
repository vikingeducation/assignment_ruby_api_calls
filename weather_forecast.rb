require 'httparty'
require 'json'

require 'pry-byebug'
require 'pp'

class WeatherForecast
  include HTTParty
  attr_reader :uri

  API_KEY = ENV["WEATHER_API"]

  BASE_URI = "http://api.openweathermap.org/data/2.5/"

  VALID_FORMATS = [:json]


  def initialize(location="London", day=nil, forecast="forecast/daily", units="imperial")
    @location = location
    @days = day.to_s
    @forecast_type = forecast
    @units = units
    @uri = nil
    create_uri
  end

  def weather
    response = HTTParty.get(@uri)
  end

  private

    def create_uri
      @uri = BASE_URI + @forecast_type + "?" + "&q=" + @location + "&cnt=" + @days + "&units=" + @unit + "&appid=" + "#{API_KEY}"
      #binding.pry
    end
end

wf = WeatherForecast.new("London", 7)
print wf.uri
pp wf.weather["day"]
