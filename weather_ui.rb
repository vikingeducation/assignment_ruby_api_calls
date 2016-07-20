require_relative './weather_forecast'
require 'httparty'
require 'uri'
require_relative './env'


class WeatherUI

  def initialize(location = "63376" , num_days = "1")
    @params = { q: location, days: num_days, key: APIXU_KEY }
    # submit_request(params)
  end

  def submit_request
    WeatherForecast.new(@params)
  end

end
