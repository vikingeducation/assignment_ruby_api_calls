require 'httparty'
require 'pp'

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
end

weather = WeatherForecast.new("New York", 3)
pp weather.hi_temps
