require 'httparty'
require 'time'

class WeatherForecast
  include HTTParty

  attr_reader :url, :response

  def initialize(location="San Francisco", days=7)
    @url = "http://api.openweathermap.org/data/2.5/forecast/daily?q=#{location}&units=imperial&cnt=#{days.to_s}&appid=#{ENV["WEATHERAPI"]}"
    @response = self.class.get(@url)
  end

  def hi_temps
    @response["list"].each do |day|
      date = DateTime.strptime(day["dt"].to_s, "%s").strftime("%A, %B %e")
      high = day["temp"]["max"]
      puts "The high temperature on #{date} is #{high}"
    end
  end

  def lo_temps
    @response["list"].each do |day|
      date = DateTime.strptime(day["dt"].to_s, "%s").strftime("%A, %B %e")
      low = day["temp"]["min"]
      puts "The low temperature on #{date} is #{low}"
    end
  end

  def today
    today = @response["list"][0]["weather"][0]["main"].downcase
    puts "Today's weather is going to be #{today}."
  end

  def tomorrow
    tomorrow = @response["list"][1]["weather"][0]["main"].downcase
    puts "Tomorrow's weather is going to be #{tomorrow}."
  end

  def hottest_day
    temps = {}
    @response["list"].each do |day|
      date = DateTime.strptime(day["dt"].to_s, "%s").strftime("%A, %B %e")
      temp = day["temp"]["max"]
      temps[date] = temp
    end
    highest = temps.max_by { |date, temp| temp }
    puts "#{highest[0]} is the hottest day."
  end

  def coldest_day
    temps = {}
    @response["list"].each do |day|
      date = DateTime.strptime(day["dt"].to_s, "%s").strftime("%A, %B %e")
      temp = day["temp"]["min"]
      temps[date] = temp
    end
    highest = temps.min_by { |date, temp| temp }
    puts "#{highest[0]} is the coldest day."
  end

  def coordinates
    lat = @response["city"]["coord"]["lat"]
    lon = @response["city"]["coord"]["lon"]
    city = @response["city"]["name"]
    puts "The coordinates for #{city} are #{lon},#{lat}"
  end

end
