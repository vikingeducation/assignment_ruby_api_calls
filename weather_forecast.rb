require 'httparty'
require 'uri'
require_relative 'env'

class WeatherForecast
  ENDPOINT = "http://api.apixu.com/v1/forecast.json?"

  def initialize(location = "98109", days = "5")
    @location = location
    @days = days
  end

  def get
    params = {"q" => @location, "days" => @days}
    url = build_url(params)
  end

  def build_url(params)
    query_string = "key=#{ENV["WEATHER_KEY"]}"
    query_string = build_query_string(params)

  end

  def build_query_string(params)
    params.map do |key, value|
      value = URI.encode(value)
      "#{key}=#{value}"
    end.join("&")
  end

end