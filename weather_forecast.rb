require 'httparty'
require 'json'

class WeatherForecast

  BASE_CURRENT_URI = "http://api.apixu.com/v1/current.json?"
  BASE_FORECAST_URI = "http://api.apixu.com/v1/forecast.json?"
  API_KEY = ENV["API_KEY"]

  attr_accessor :location, :days

  def initialize(location = "Paris", days = 1)
    @location = location
    @days = days
  end

  def forecast_for
    request = HTTParty.get("#{BASE_FORECAST_URI}key=#{API_KEY}&q=#{@location}&days=#{@days}")
  end

  def current_for
    request = HTTParty.get("#{BASE_URI}key=#{API_KEY}&q=#{@location}")
  end

  def hi_temps
    request = HTTParty.get("#{BASE_FORECAST_URI}key=#{API_KEY}&q=#{@location}&days=#{@days}")
    p date = request["forecast"]["forecastday"][0]["date"]
    p max_temp = request["forecast"]["forecastday"][0]["day"]["maxtemp_f"] 
  end

end

w = WeatherForecast.new()

#puts w.send_request
w.hi_temps