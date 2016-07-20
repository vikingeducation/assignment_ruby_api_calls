require 'httparty'
require 'pp'


class WeatherForecast
  include HTTParty

  BASE_URI = 'http://api.apixu.com/v1/forecast.json?'

  def initialize (location = 27607, days = 5)
    @days = days
    @key = ENV['apixu']
  end

  def forecast_for(location:)
    path = "#{BASE_URI}q=#{location}&key=#{@key}&days=#{@days}"
    @response = HTTParty.get(path)
  end

  def high_temp
    @response["forecast"]["forecastday"].map { |day| day["day"]["maxtemp_f"] }
  end

  def low_temp
    @response["forecast"]["forecastday"].map { |day| day["day"]["mintemp_f"] }
  end

  def today
    day = @response["forecast"]["forecastday"][0]["day"]
    {
      date:                 @response["forecast"]["forecastday"][0]["date"], 
      high:                 day["maxtemp_f"],
      low:                  day["mintemp_f"],
      average:              day["avgtemp_f"], 
      max_win_speed:        day["maxwind_mph"], 
      total_precipitation:  day["totalprecip_in"],
      condition:            day["condition"]["text"]
    }
  end

  def tomorrow
    day = @response["forecast"]["forecastday"][1]["day"]
    {
      date:                 @response["forecast"]["forecastday"][1]["date"],
      high:                 day["maxtemp_f"],
      low:                  day["mintemp_f"],
      average:              day["avgtemp_f"], 
      max_win_speed:        day["maxwind_mph"], 
      total_precipitation:  day["totalprecip_in"],
      condition:            day["condition"]["text"]
    }
  end

  def temp_by_hour(day:, hour:)
end

w = WeatherForecast.new
w.forecast_for(location: 92706)
pp w.high_temp
pp w.low_temp
pp w.today
pp w.tomorrow