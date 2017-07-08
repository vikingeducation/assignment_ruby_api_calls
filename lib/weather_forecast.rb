# weatherforecast
require_relative 'environment'
require 'HTTParty'

class WeatherForecast
  API_KEY = WEATHER_KEY

  def initialize(location = "france", num_days = 5)
    @location = location
    @num_days = num_days

  end
  # high temperatures organized by date
  def hi_temps
    puts @location
    puts @num_days
    send_request
  end

  # low temperatures organized by date
  def lo_temps


  end

  # today's forecast
  def today

  end

  def tomorrow

  end

  # three more responses

  private
  def send_request
    response = HTTParty.get('api.openweathermap.org/data/2.5/forecast?id=524901&APPID=' + API_KEY)
    puts response
  end



end

w = WeatherForecast.new
w.hi_temps
