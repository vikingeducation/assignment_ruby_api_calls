require 'httparty'
require 'awesome_print'
require 'json'
require 'pry'
require 'envyable'
require 'stamp'

Envyable.load('env.yml')

class WeatherForecast
  BASE_URI = 'http://api.openweathermap.org/data/2.5/forecast/daily?q='
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def initialize(location = 'New Orleans', days = 5)
    @days = days
    @location = location
    @forecast = send_request(location, days)
  end

  def hi_temps
    puts "High Temperatures for the next #{@days} days in #{@location} (Fahrenheit):"
    @forecast.each do |day|
      date = Time.at(day['dt']).stamp("Mon, Dec 3")
      high_temp = day['temp']['max']
      puts " - #{date}: #{high_temp}"
    end
  end

  def lo_temps
    puts "Low Temperatures for the next #{@days} days in #{@location} (Fahrenheit):"
    @forecast.each do |day|
      date = Time.at(day['dt']).stamp("Mon, Dec 3")
      low_temp = day['temp']['min']
      puts " - #{date}: #{low_temp}"
    end
  end

  private

  def send_request(location, days)
    uri_loc = location.gsub(' ', '%20')

    uri = "#{BASE_URI}#{uri_loc},USA&cnt=#{days}&units=imperial&APPID=#{API_KEY}"

    response = HTTParty.get(uri)

    response["list"]
  end
end

forecast = WeatherForecast.new
forecast.hi_temps
forecast.lo_temps