require 'httparty'
require 'pp'

class WeatherForecast
  include HTTParty
  API_KEY = ENV['API_WEATHER_KEY']

  def initialize(location = 'Glen Cove', days = 5)

    raise 'invalid number of days' if days < 1 || days > 16
    @location = location.strip
    @days = days
    
  end

end