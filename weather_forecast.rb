require_relative 'env'
require 'httparty'
require 'json'
require 'pp'

class WeatherForecast

# days 1-10, location city ST or zipcode
  def initialize(location = '22180', days = 1)
    @days = days.to_s
    @location = location.to_s
    @base_uri = "http://api.apixu.com/v1/forecast.json?"
  end

  def build_uri
    uri = [@base_uri] << "key=#{API_KEY}" << "q=#{@location} " << "days=#{@days}"
    uri.join('&')
  end


  def hi_temps
    # forecast.forecastday.day.maxtemp_f
  end

  def low_temps
    # forecast.forecastday.day.mintemp_f
  end

  def today

  end

  def tomorrow
  end




end


w_api = WeatherForecast.new('bloomington in', 3)
uri = w_api.build_uri
h = HTTParty.get(uri)
pp h
