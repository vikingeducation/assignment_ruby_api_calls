require 'httparty'
require 'json'

require 'pry-byebug'
require 'pp'

class WeatherForecast
  include HTTParty
  
  attr_accessor :response

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
    @response = HTTParty.get(@uri)
  end

  def hi_temp
    hi_temp = []
    @response['list'].each do |day|
      hi_temp << day['temp']['max']
    end
    hi_temp
  end

  def low_temp
    low_temp = []
    @response['list'].each do |day|
      low_temp << day['temp']['min']
    end
    low_temp
  end

  def today
    @response['list'][0]
  end

  def tomorrow
    @response['list'][1]
  end

  

  private

    def create_uri
      @uri = BASE_URI + @forecast_type + "?" + "&q=" + @location + "&cnt=" + @days + "&units=" + @units + "&appid=" + "#{API_KEY}"
    end
end

# binding.pry

wf = WeatherForecast.new("London", 7)
wf.weather
pp wf.low_temp
pp wf.today
