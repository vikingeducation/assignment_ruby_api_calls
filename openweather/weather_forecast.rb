require 'date'
require 'httparty'
require 'pp'

class WeatherForecast
  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"

  API_KEY = ENV["API_KEY"]
  VALID_DAYS = (1..5)
  VALID_UNITS = ["imperial", "metric", nil]

  attr_reader :location,
              :days,
              :units,
              :raw_response,
              :weather_data

  def initialize(location = "Singapore", days = 3, units = "metric")
    validate_time_period!(days)
    validate_units!(units)

    @location = location
    @days = days
    @units = units
    @raw_response = send_request(@location, @units)
    @weather_data = trim_response(@raw_response, @days)
  end

  # collection of highest temperatures we get, organized by date
  def hi_temps
    results = {}

    self.weather_data.each { |item| results[item['dt_txt']] = item['main']['temp_max'] }

    results
  end

  # collection of lowest temperatures we get, organized by date
  def lo_temps
    results = {}

    self.weather_data.each { |item| results[item['dt_txt']] = item['main']['temp_min'] }

    results
  end

  # temperature forecast for today
  def today
    results = {}
    today_data = self.weather_data.select { |item| Time.parse(item['dt_txt']).day == Time.now.day }

    today_data.each { |item| results[item['dt_txt']] = item['main']['temp'] }

    results
  end

  # temperature forecast for tomorrow
  def tomorrow
    results = {}
    tomorrow = Time.at(Time.now + 86400).day

    tomorrow_data = self.weather_data.select { |item| Time.parse(item['dt_txt']).day == tomorrow }

    tomorrow_data.each { |item| results[item['dt_txt']] = item['main']['temp'] }

    results
  end

  # rainfall for last 3 hours in mm, rounded to two decimal places
  def rainfall
    results = {}

    self.weather_data.each do |item|
      if item['rain']['3h'].nil?
        results[item['dt_txt']] = 0.00
      else
        results[item['dt_txt']] = item['rain']['3h'].round(2)
      end
    end

    results
  end

  # wind speed (in m/s), and direction (in degrees)
  def wind
    results = {}

    self.weather_data.each { |item| results[item['dt_txt']] = [item['wind']['speed'], item['wind']['deg']] }

    results
  end

  # cloudiness in %
  def cloudiness
    results = {}

    self.weather_data.each { |item| results[item['dt_txt']] = item['clouds']['all'] }

    results
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

  # trim the response to only include weather data for the
  # specified number of days from today
  def trim_response(response, days)
    weather_data = response['list']

    weather_data.select { |item| (Time.at(item['dt']).to_date - Time.now.to_date).round < days }
  end
end

if $0 == __FILE__
  forecast = WeatherForecast.new

  pp forecast.today
end
