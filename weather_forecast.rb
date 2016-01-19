require 'httparty'
require 'json'

# require 'pry-byebug'
require 'pp'

class WeatherForecast
  include HTTParty

  API_KEY = ENV["WEATHER_API"]

  BASE_URI = "http://api.openweathermap.org/data/2.5/#{@forecast}&#{@location}&APPID=#{API_KEY}"

  VALID_FORMATS = [:json]


  def initialize(location="London", day=nil)
    @location = location
    @days = day
  end

  def weather
    response = HTTParty.get(BASE_URI)
  end

  private

    def send_request(location, days)

      URI = BASE_URI + "&" + @location + "&" + @days + "&APPID=" + API_KEY
    end
end

wf = WeatherForecast.new
pp wf.weather
