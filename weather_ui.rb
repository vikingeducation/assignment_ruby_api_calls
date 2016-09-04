require_relative './weather_forecast'
require 'httparty'
require 'uri'
require_relative './env'


class WeatherUI

  def initialize(location = "63376" , num_days = "1")
    @params = { key: APIXU_KEY, q: location.to_s, days: num_days.to_s.downcase }
    # submit_request(params)
  end

  def submit_request
    WeatherForecast.new(@params)
  end

end

ui = WeatherUI.new("63376", "3").submit_request

bar = WeatherUI.new("Fairbanks", "tomorrow").submit_request
