require 'dotenv/load'

require 'httparty'
require 'pp'
require "awesome_print"
require 'json'

class WeatherForecast
  attr_accessor :raw_response
  def initialize(location: 70115, days: 1)
    @location = location
    @days = days
    @raw_response = {}
  end

  API_KEY = ENV['API_KEY']

  BASE_URI = "http://api.openweathermap.org"

  # url = "api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}"


  def send_request
    url = "#{BASE_URI}/data/2.5/forecast?zip=#{@location}&APPID=#{API_KEY}"
    response = HTTParty.get(url)
  end







end

forecast = WeatherForecast.new(location: 15601, days: 5)
# forecast.retrieve_response
# pp forecast.raw_response
forecast.high_temps