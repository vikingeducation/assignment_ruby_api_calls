require 'httparty'
require 'envyable'
Envyable.load('config/env.yml', 'development')

class WeatherForecast
  include HTTParty

  attr_accessor :response

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/"
  API_KEY = ENV['WEATHER_API_KEY']

  def initialize(location='Eugene,us', days=5)
    @response = HTTParty.get(BASE_URI + "daily?q=" + location + "&cnt=" + days.to_s + '&units=imperial' + "&appid=" + API_KEY)
  end

  def hi_temps
    hi_temp = []
    @response['list'].each do |day|
      hi_temp << day['temp']['max']
    end
    hi_temp
  end

  def low_temps
    low_temp = []
    @response['list'].each do |day|
      low_temp << day['temp']['min']
    end
    low_temp
  end

  def today
    @response['list'][0]
  end

  def tomorrow
    @response['list'][1]
  end

  def average
    average = []
    @response['list'].each do |day|
      average << day['temp']['day']
    end
    average
  end

  def hourly
  end

  def next_3_days
  end

end

weather = WeatherForecast.new
puts "Highs" + weather.hi_temps.to_s
puts "Lows" + weather.low_temps.to_s
puts "Today" + weather.today.to_s
puts "Tomorrow" + weather.tomorrow.to_s
puts "Average" + weather.average.to_s