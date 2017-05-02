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

  # collection of highest temperatures we get, organized by date
  def hi_temps
  end

  # collection of lowest temperatures we get, organized by date
  def lo_temps
  end

  # forecast for today
  def today
  end

  # forecast for tomorrow
  def tomorrow
  end

  # rainfall
  def rainfall
  end

  # wind speed (in m/s), and direction (in degrees)
  def wind
  end

  # cloudiness in %
  def cloudiness
  end

  private

  def validate_time_period!(days)
    raise "Invalid number of days." unless VALID_DAYS.include?(days)
  end
end
