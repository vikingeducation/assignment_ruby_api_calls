require 'httparty'
require 'pp'
require 'date'

class Day
  attr_accessor :date, :min, :max, :humidity, :weather_description, :wind_speed, :wind_direction

  def initialize(opts = {})
    @date = opts.fetch(:date)
    @min = opts.fetch(:min)
    @max = opts.fetch(:max)
    @humidity = opts.fetch(:humidity)
    @weather_description = opts.fetch(:weather_description)
    @wind_speed = opts.fetch(:wind_speed)
    @wind_direction = opts.fetch(:wind_direction)
  end

  def self.from_json(json)
    options = {
      date: Time.at(json['dt']),
      min: json['temp']['min'],
      max: json['temp']['max'],
      humidity: json['humidity'],
      weather_description: json['weather'][0]['main'],
      wind_speed: json['speed'],
      wind_direction: json['deg']
    }
    new(options)
  end

  def date_string
    date.strftime("%D")
  end

  def today?
    date.to_date == Time.now.to_date
  end

  def tomorrow?
    date.to_date == Time.now.to_date+1
  end

  def rain?
    weather_description =~ /[rR]ain/
  end

  def to_kelvin
    (min + 459.67) * (5/9.0)
  end

end





class WeatherForecast
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5'

  API_KEY = ENV["WEATHER_API_KEY"]


  def initialize(location="New York", num_days=16)
    @options = { query: {q: location, cnt: num_days, units: "imperial", APPID: API_KEY} }
  end

  def forecast
    self.class.get("/forecast/daily", @options)['list'].map do |day_json|
      Day.from_json(day_json)
    end
  end

  def hi_temps
    forecast.map do |day|
      {day.date_string => day.max}
    end
  end

  def low_temps
    forecast.map do |day|
      {day.date_string => day.min}
    end
  end

  def today
    forecast.find(&:today?)
  end

  def tomorrow
    forecast.find(&:tomorrow?)
  end

  def rainy_days
    forecast.select(&:rain?)
  end

  def windiest_days
    forecast.max_by(&:wind_speed)
  end

  def absolute_worst_day
    if forecast.any? {|day| day.to_kelvin == 0 }
      puts "Atoms have stopped moving! Take cover! Bundle up!" 
    else 
      puts "You're safe, no days will be 0 Kelvin."
    end
  end

end

weather = WeatherForecast.new("New York", 16)
# pp weather.forecast
# pp weather.hi_temps
# pp weather.today
# pp weather.tomorrow
# pp weather.rainy_days
# pp weather.windiest_days
pp weather.absolute_worst_day