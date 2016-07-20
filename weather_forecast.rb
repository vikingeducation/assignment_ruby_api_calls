require 'httparty'
require 'json'
require 'pp'

class WeatherForecast

  BASE_CURRENT_URI = "http://api.apixu.com/v1/current.json?"
  BASE_FORECAST_URI = "http://api.apixu.com/v1/forecast.json?"
  API_KEY = ENV["API_KEY"]

  attr_accessor :location, :days

  def initialize(location = "Paris", days = 2)
    @location = location
    @days = days
  end

  def forecast_for
    request = HTTParty.get("#{BASE_FORECAST_URI}key=#{API_KEY}&q=#{@location}&days=#{@days}")
  end

  def current_for
    request = HTTParty.get("#{BASE_CURRENT_URI}key=#{API_KEY}&q=#{@location}")
  end

  def hi_temps
    request = HTTParty.get("#{BASE_FORECAST_URI}key=#{API_KEY}&q=#{@location}&days=#{@days}")
    counter = 0
    while counter < @days
      p date = request["forecast"]["forecastday"][counter]["date"]
      p max_temp = request["forecast"]["forecastday"][counter]["day"]["maxtemp_f"]
      counter += 1
    end
  end

  def lo_temps
    request = HTTParty.get("#{BASE_FORECAST_URI}key=#{API_KEY}&q=#{@location}&days=#{@days}")
    counter = 0
    while counter < @days
      p date = request["forecast"]["forecastday"][counter]["date"]
      p max_temp = request["forecast"]["forecastday"][counter]["day"]["mintemp_f"]
      counter += 1
    end
  end

  def today
    request = current_for
    puts "Location: #{request["location"]["name"]}"
    puts "Last Updated: #{request["current"]["last_updated"]}"
    puts "Temperature: #{request["current"]["temp_f"]}"
    puts "Condition: #{request["current"]["condition"]["text"]}"
    puts "Wind: #{request["current"]["wind_mph"]}"
    puts "Humidity: #{request["current"]["humidity"]}"
  end

  def tomorrow(day)
    request = forecast_for
    puts request["forecast"]["forecastday"][day]["date"]
    puts request["forecast"]["forecastday"][day]["day"]["maxtemp_f"]
    puts request["forecast"]["forecastday"][day]["day"]["mintemp_f"]
  end

end

w = WeatherForecast.new()

# pp w.forecast_for
# w.lo_temps
# pp w.current_for
w.tomorrow(1)