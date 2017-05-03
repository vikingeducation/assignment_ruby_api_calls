require 'date'
require 'httparty'
require 'pp'
require 'json'

class WeatherForecast
  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"

  API_KEY = ENV["API_KEY"]
  VALID_DAYS = (1..5)
  VALID_UNITS = ["imperial", "metric"]

  attr_reader :location,
              :days,
              :units,
              :raw_response,
              :weather_data

  def initialize(location = "Singapore", days = 1, units = nil)
    validate_time_period!(days)
    validate_units!(units)

    @location = location
    @days = days
    @units = units
    @raw_response = send_request(location, units)
    # @weather_data = trim_response(@raw_response, @days)

    # test code to avoid hitting the API all the time
    # while working on the public methods
    @weather_data = trim_response(JSON.parse(File.read('./sample.json')), @days)
  end

  # trim the response to only include weather data for the
  # specified number of days from today
  # TODO: make this method private
  def trim_response(response, days)
    weather_data = response['list']

    weather_data.select { |item| (Time.at(item['dt']).to_date - Time.now.to_date).round <= days }
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

  # forecast for today
  def today
    results = {}
    today_data = self.weather_data.select { |item| Time.parse(item['dt_txt']).day == Time.now.day }

    today_data.each { |item| results[item['dt_txt']] = item['main']['temp'] }

    results
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
  forecast = WeatherForecast.new("Singapore", 3, "metric")

  # pp forecast.hi_temps
  # pp forecast.lo_temps
  pp forecast.today
end
