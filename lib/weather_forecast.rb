require 'httparty'
require 'pp'
require 'date'
require_relative 'day'

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

  def windiest_day
    forecast.max_by(&:wind_speed)
  end

  def absolute_worst_day
    if forecast.any? {|day| day.to_kelvin == 0 }
      puts "Atoms have stopped moving! Take cover! Bundle up!" 
      true
    else 
      puts "You're safe, no days will be 0 Kelvin."
      false
    end
  end

end

