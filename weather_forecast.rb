#weather forecast 
#openweathermap.org api wrapper

require 'httparty'
require 'pp'
require 'json'
require 'pry-byebug'

class WeatherForecast
  # setting constants
  URI = "http://api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&mode=json&units=metric&cnt={cnt}"
  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/"
  API_KEY = ENV["API_KEY"]
  MODE = "json"

  def initialize(location={:city=>"Calgary", :country=>"Canada"}, num_days=5)
    @location = location#.downcase
    @num_days = num_days
  end

  def send_request(location = @location, num_days = @num_days)
    request_uri = BASE_URI + "daily?q=#{location[:city]},#{location[:country]}&mode=#{MODE}&units=metric&cnt=#{num_days}&APPID=#{API_KEY}"
    @response = HTTParty.get(request_uri)
  end

  def hi_temps
    temps = []
    temperatures.each do |day|
      datetime = day["dt"]
      hi_temp = day["temp"].values.max
      temps << hi_temp
    end
    temps
  end

  def lo_temps
    temps = []
    temperatures.each do |day|
      #datetime = day["dt"]
      lo_temp = day["temp"].values.min
      temps << lo_temp
    end
    temps
  end

  def today
    puts "TODAY:"
    day = @response["list"][0]
    day.each do |key, val|
      puts "#{key}: #{val}"
    end
  end

  def tomorrow
    puts "TOMORROW:"
    day = @response["list"][1]
    day.each do |key, val|
      puts "#{key}: #{val}"
    end
  end

  #returns temps sorted by date
  def temperatures
    @response["list"]
  end
end
puts "-----------------\nWEATHER FORECAST (METRIC)\n-----------------"
forecast = WeatherForecast.new
params = {:city => "San Francisco", :country => "USA"}
forecast.send_request(params, 10)

#hitemp
puts "HIGH TEMPERATURES: "
forecast.hi_temps.each_with_index do |temp, day|
  puts "Day #{day}: #{temp}"
end
#lotemp
puts "HIGH TEMPERATURES: "
forecast.lo_temps.each_with_index do |temp, day|
  puts "Day #{day}: #{temp}"
end
#today/tomorrow
forecast.today
forecast.tomorrow