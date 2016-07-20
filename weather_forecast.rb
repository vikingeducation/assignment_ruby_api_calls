require 'httparty'
require 'uri'
require_relative './env'

class WeatherForecast

  END_POINT = 'http://api.apixu.com/v1/forecast.json?'

  def initialize(params)
    binding.pry
    url = build_query(params)
    get(url)
  end

  def build_query(params)
    "#{END_POINT}#{query_string(params)}"
  end

  def query_string(params)
    params.map do |key, value|
      value = URI.encode(value)
      "#{key}=#{value}"
    end.join('&')
  end

  def get(url)
    response = HTTParty.get(url)
    puts response.body
  end

end
