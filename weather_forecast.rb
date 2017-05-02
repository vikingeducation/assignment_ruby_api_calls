require 'httparty'
require 'pp'

class WeatherForecast
  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"

  API_KEY = ENV["API_KEY"]
  VALID_DAYS = (1..5)
  VALID_UNITS = ["imperial", "metric"]

  def initialize(location = "Singapore", days = 1, units = nil)
    validate_time_period!(days)
    validate_units!(units)

    @location = location
    @days = days
    @units = units
    @raw_response = send_request(location, units)
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

  def validate_units!(units)
    return if units.nil?

    raise "Invalid units." unless VALID_UNITS.include?(units)
  end

  def send_request(location, units = nil)
    return unless location

    # set URL parameters
    params = { "APPID" => API_KEY, "q" => location }
    params["units"] = units unless units.nil?

    @raw_response = HTTParty.get(BASE_URI, :query => params)
  end
end

if $0 == __FILE__
  forecast = WeatherForecast.new("Singapore", 5, "metric")
end
