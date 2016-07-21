# api.openweathermap.org/data/2.5/forecast?q={city name},{country code}
# base_uriq=Flagstaff,us&units=imperial&APPID={APIKEY}

require 'httparty'
require 'rubygems'
require 'pp'

class Forecast
  include HTTParty
#  base_uri 'api.openweathermap.org/data/2.5/forecast?'
  attr_accessor :doc
  def initialize(location="Flagstaff,AZ", days=5)
    @location = location.delete(" ")
    @days = days.to_s
    @options = {:query => {:q => @location, :cnt => @days, :units => "imperial", :APPID => ENV['WEAAPIKEY']}}
    @doc = nil
  end

  def get_weather
    @doc = self.class.get('http://api.openweathermap.org/data/2.5/forecast/daily', @options)
  end

  def display(i)
      print day(@doc["list"][i], i)
      print "Temps: Max => #{hi_temps[i]} Min => #{lo_temps[i]}"
      puts wind(i)
  end

  def wind(i)
    puts ", Wind: #{@doc["list"][i]["speed"]} mph"
  end

  def today
    display(0)
  end

  def tomorrow
    display(1)
  end

  def all
    puts
    @doc["list"].each_with_index do |day, i|
      display(i)
    end
  end

  def rain?
    @doc["list"].each_with_index do |day, i|
      puts day(day, i) if day["weather"][0]["description"].include?("rain")
    end
  end


  def day(day, i)
    return "Today:" if i ==0
    return "Tomorrow:" if i == 1
    return Time.at(day["dt"]).strftime('%a')+" "+Time.at(day["dt"]).strftime('%v')+":"
  end

  def hi_temps
    temps = []
    @doc["list"].each do |day|
      temps << day["temp"]["max"]
    end
    temps
  end

  def lo_temps
    temps = []
    @doc["list"].each do |day|
      temps << day["temp"]["min"]
    end
    temps
  end

end

# forecast = Forecast.new
#
# doc = forecast.weather

  # date -d @126507600
