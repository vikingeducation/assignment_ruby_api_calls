require "httparty"

class WeatherForecast
  include HTTParty
  base_uri "http://api.openweathermap.org"
  API_KEY = ENV["API_KEY"]

  attr_reader :forecast

  def initialize(location = "mountain view", days = 5)
    @days = days > 16 ? 16 : days
    @options = { query: { q: location, APPID: API_KEY, cnt: @days } }
    @forecast = self.class.get("/data/2.5/forecast/daily", @options)
  end

  def get_temps(type)
    days = @forecast["list"]
    temps = days.map { |day| kelvin_to_f(day["temp"][type]).round(2) }
  end

  def get_date(i)
    Time.now + i * 86400
  end

  def hi_temps
    temps = get_temps("max")
    temps.length.times do |i|
      date = get_date(i)
      puts "#{date.month}/#{date.day}/#{date.year}: #{temps[i]}"
    end
  end

  def lo_temps
    temps = get_temps("min")
    temps.length.times do |i|
      date = get_date(i)
      puts "#{date.month}/#{date.day}/#{date.year}: #{temps[i]}"
    end
  end

  def tomorrow
    high = get_temps("max")[1]
    low = get_temps("min")[1]
    puts "Tomorrow's highs: #{high}"
    puts "Tomororw's lows: #{low}"
  end

  def today
    temp_data = self.class.get("/data/2.5/weather", @options)
    puts "Current_Temperature: #{kelvin_to_f(temp_data["main"]["temp"]).round(2)}"
    highs = get_temps("max")[0]
    lows = get_temps("min")[0]
    puts "Highs: #{highs}"
    puts "Lows: #{lows}"    
  end

  def description(day)
    conditions = @forecast["list"][day]["weather"][0]["description"]
    date = get_date(day)
    puts "#{date.month}/#{date.day}/#{date.year}'s conditions : #{conditions}"
  end

  def humidity(day)
    humidity_level = @forecast["list"][day]["humidity"]
    date = get_date(day)
    puts "#{date.month}/#{date.day}/#{date.year}'s humidity level: #{humidity_level}"
  end

  def wind(day)
    wind_speed = @forecast["list"][day]["speed"]
    date = get_date(day)
    to_mph = wind_speed * 2.23694
    puts "#{date.month}/#{date.day}/#{date.day}'s wind speed: #{to_mph} mph"
  end

  def kelvin_to_f(kelvin)
    kelvin * 9/5 - 459.67
  end

end

