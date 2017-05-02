require 'httparty'

class WeatherForecast
  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"

  API_KEY = ENV["API_KEY"]

  VALID_DAYS = (1..5)

  def initialize(location = "Singapore", days = 1)
    validate_time_period!(days)

    @location = location
    @days = days
  end

  private

  def validate_time_period!(days)
    raise "Invalid number of days." unless VALID_DAYS.include?(days)
  end
end
