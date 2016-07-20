require 'httparty'
require 'uri'
require_relative './env'
require 'date'

class WeatherForecast

  END_POINT = 'http://api.apixu.com/v1/forecast.json?'

  def initialize(params)
    # binding.pry
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
    response = JSON.parse(response.body)
    # puts response
    days_doc(response)
  end

  def days_doc(response)
    days = days(response)
    dates(days)
    hi_temps(days)
    lo_temps(days)
  end

  def days(json_responce)
    json_responce["forecast"]["forecastday"]
  end

  def dates(days)
    dates = days.map do |day| 
      date = day["date"]
      date = Date.parse(date)
      date.strftime('%a, %b %d')
    end
    p dates
  end

  def hi_temps(days)
    temps = days.map { |day| day["day"]["maxtemp_f"] }
    p temps
  end

  def lo_temps(days)
    temps = days.map { |day| day["day"]["mintemp_f"] }
    p temps
  end

end
