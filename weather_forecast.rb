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

  def today
    puts "-" * (34 + @location.length)
    puts "Today in #{@location} (degrees in Fahrenheit):"
    puts "-" * (34 + @location.length)
    day = @forecast.first

    render_day(day)
  end

  def tomorrow
    puts "-" * (34 + @location.length)
    puts "Tomorrow in #{@location} (degrees in Fahrenheit):"
    puts "-" * (34 + @location.length)
    day = @forecast[1]

    render_day(day)
  end

  private

  def render_day(day)
    date = Time.at(day['dt']).stamp("Mon, Dec 3")
    high_temp = day['temp']['max']
    low_temp = day['temp']['min']
    humidity = day['humidity']
    conditions = day['weather'].first['description']

    puts "              Date: #{date}"
    puts " Low to High Temps: #{low_temp} to #{high_temp}"
    puts "          Humidity: #{humidity}%"
    puts "        Conditions: #{conditions}"
  end

  def send_request(location, days)
    uri_loc = location.gsub(' ', '%20')

    uri = "#{BASE_URI}#{uri_loc},USA&cnt=#{days}&units=imperial&APPID=#{API_KEY}"

    response = HTTParty.get(uri)

    response["list"]
  end
end

forecast = WeatherForecast.new
# forecast.hi_temps
# forecast.lo_temps
forecast.today
forecast.tomorrow