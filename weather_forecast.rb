require 'httparty'
require 'json'

class WeatherForecast

  BASE_URI = "http://api.apixu.com/v1/current.json?"

  API_KEY = ENV["API_KEY"]

  attr_accessor :location

  def initialize(location = "Paris", days = 7)
    @location = location
    @days = days
  end

  def forecast_for(location)
  end

  def send_request
    request = HTTParty.get("#{BASE_URI}key=#{API_KEY}&q=#{@location}")
  end

end

# w = WeatherForecast.new("Tarpon_Springs")

# puts w.send_request