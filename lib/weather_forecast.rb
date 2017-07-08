# weatherforecast
require_relative 'environment'
require 'HTTParty'

class WeatherForecast
  API_KEY = WEATHER_KEY
  attr_reader :location, :num_days, :response_hash

  def initialize(location = "france", num_days = 5)
    @location = location
    @num_days = num_days
    @raw_response = String.new
    @response_hash = Hash.new

  end
  # high temperatures organized by date
  def hi_temps
    puts send_request
  end

  # low temperatures organized by date
  def lo_temps


  end

  # today's forecast
  def today

  end

 # tomorrow's forecast
  def tomorrow

  end

  # three more responses

#  private
  def send_request
    return "you fail"
  #  @raw_response = HTTParty.get('api.openweathermap.org/data/2.5/forecast?id=524901&APPID=' + API_KEY)
  end

  def parse_response(response)
    @response_hash = JSON.parse(response)
  end

# converts temperature to celcius
  def convert_temp(temp)
    return temp + -273.15
  end

  def convert_date(date)
  end


end
